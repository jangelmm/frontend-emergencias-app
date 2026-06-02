import os
import argparse

# Directorios a ignorar (Ocultamos cachés, compilaciones y código nativo autogenerado)
IGNORE_DIRS = {
    '.git', '.idea', '.dart_tool', 'build', 
    'android', 'ios', 'linux', 'macos', 'windows', 'web',
    'node_modules', '__pycache__'
}

# Extensiones de archivo permitidas (El core de Flutter/Dart)
ALLOWED_EXTS = {
    '.dart', '.yaml', '.json', '.md'
}

# Archivos específicos a incluir siempre (Archivos raíz de configuración)
INCLUDED_FILES = {
    'pubspec.yaml', 'pubspec.lock', 'analysis_options.yaml', '.gitignore', 'README.md'
}

# Prefijos para el tree
TREE_PREFIXES = {
    'branch': '├── ',
    'last':   '└── ',
    'indent': '    ',
    'pipe':   '│   '
}


def build_tree(root_path):
    """
    Genera una lista de líneas representando la estructura de directorios,
    ignorando IGNORE_DIRS, pero incluyendo archivos en INCLUDED_FILES.
    """
    tree_lines = []

    def _tree(dir_path, prefix=''):
        entries = sorted(os.listdir(dir_path))
        # Filtrar: ignora los directorios deseados; oculta dot-files salvo INCLUDED_FILES
        entries = [
            e for e in entries
            if e not in IGNORE_DIRS
               and (not e.startswith('.') or e in INCLUDED_FILES)
        ]

        dirs = [e for e in entries if os.path.isdir(os.path.join(dir_path, e))]
        files = [e for e in entries if os.path.isfile(os.path.join(dir_path, e))]
        total = len(dirs) + len(files)

        for idx, name in enumerate(dirs + files):
            path = os.path.join(dir_path, name)
            connector = TREE_PREFIXES['last'] if idx == total - 1 else TREE_PREFIXES['branch']
            tree_lines.append(f"{prefix}{connector}{name}")
            if os.path.isdir(path):
                extension = TREE_PREFIXES['indent'] if idx == total - 1 else TREE_PREFIXES['pipe']
                _tree(path, prefix + extension)

    tree_lines.append(os.path.basename(root_path) or root_path)
    _tree(root_path)
    return tree_lines


def collect_files(root_path):
    """
    Recorre el árbol e incluye:
    - Archivos con extensiones en ALLOWED_EXTS
    - Archivos listados en INCLUDED_FILES (en cualquier carpeta)
    """
    paths = []
    for dirpath, dirnames, filenames in os.walk(root_path):
        # Excluir carpetas no deseadas
        dirnames[:] = [d for d in dirnames if d not in IGNORE_DIRS]

        for fname in sorted(filenames):
            rel = os.path.relpath(os.path.join(dirpath, fname), root_path)
            ext = os.path.splitext(fname)[1]
            if ext in ALLOWED_EXTS or fname in INCLUDED_FILES:
                paths.append(os.path.join(dirpath, fname))

    return paths


def ext_to_lang(ext):
    """Mapea extensión de archivo a lenguaje para el coloreado de Markdown."""
    return {
        '.dart': 'dart',
        '.yaml': 'yaml',
        '.yml': 'yaml',
        '.json': 'json',
        '.md': 'markdown',
        '': 'text' 
    }.get(ext, 'text')


def main():
    parser = argparse.ArgumentParser(
        description="Genera un Markdown con la estructura tipo tree y el código fuente para Flutter.")
    parser.add_argument(
        'output', nargs='?', default='flutter_context.md',
        help='Nombre del archivo Markdown de salida. (default: flutter_context.md)')
    args = parser.parse_args()

    root = os.getcwd()
    tree_lines = build_tree(root)
    code_files = collect_files(root)

    with open(args.output, 'w', encoding='utf-8') as md:
        # Título
        md.write("# Estructura del proyecto Flutter (Dashboard de Emergencias)\n\n")

        # Árbol de directorios
        md.write("```text\n")
        md.write("\n".join(tree_lines))
        md.write("\n```\n\n")

        # Contenido de cada archivo
        for path in code_files:
            rel_path = os.path.relpath(path, root)
            ext = os.path.splitext(path)[1]
            lang = ext_to_lang(ext)
            md.write(f"## `{rel_path}`\n\n")
            md.write(f"```{lang}\n")
            try:
                with open(path, 'r', encoding='utf-8') as f:
                    md.write(f.read())
            except Exception as e:
                md.write(f"# Error al leer el archivo: {e}\n")
            md.write("\n```\n\n")

    print(f"Archivo Markdown generado con éxito: {args.output}")


if __name__ == '__main__':
    main()
