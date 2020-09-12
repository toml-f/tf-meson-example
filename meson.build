project(
  'tf-example',
  'fortran',
  version: '0.1',
  license: 'MIT',
)
install = not (meson.is_subproject() and get_option('default_library') == 'static')

# General configuation information
lib_deps = []
subdir('config')

# Collect source of the project
srcs = []
subdir('src')

# Example library target
tfex_lib = library(
  meson.project_name(),
  sources: srcs,
  version: meson.project_version(),
  dependencies: lib_deps,
  install: install,
)

# Export dependency for other projects
tfex_inc = tfex_lib.private_dir_include()
tfex_dep = declare_dependency(
  link_with: tfex_lib,
  include_directories: tfex_inc,
  dependencies: lib_deps,
)

# Package the license file
tfex_lic = files(
  'LICENSE',
)

if install
  # Package the license file
  install_data(
    tfex_lic,
    install_dir: get_option('datadir')/'licenses'/meson.project_name(),
  )
  # Distribute the license files of toml-f along with this project
  install_data(
    tomlf_prj.get_variable('tomlf_lic'),
    install_dir: get_option('datadir')/'licenses'/meson.project_name()/'toml-f',
  )

  pkg = import('pkgconfig')
  pkg.generate(
    tfex_lib,
    description: 'An example library using the TOML Fortran library',
  )
endif

# Collect source of the application
prog = []
subdir('app')

# Example application target
tfex_app = executable(
  meson.project_name(),
  sources: prog,
  dependencies: tfex_dep,
  install: install,
)
