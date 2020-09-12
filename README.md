# Usage example for the TOML-Fortran library

[*Use this template*](https://github.com/toml-f/tf-meson-example/generate).

- the [TOML Fortran project](https://github.com/toml-f/toml-f)
- the [meson build system](https://mesonbuild.com)


## Getting Started

Create a new meson project and include `toml-f` either as git-submodule in your subprojects directory or create a wrap file to fetch it from upstream:

```ini
[wrap-git]
directory = toml-f
url = https://github.com/toml-f/toml-f
revision = head
```

To load the project the necessary boilerplate code for subprojects is just

```meson
tomlf_prj = subproject(
  'toml-f',
  version: '>=0.2',
  default_options: [
    'default_library=static',
  ],
)
tomlf_dep = tomlf_prj.get_variable('tomlf_dep')
```

Now you can add `tomlf_dep` to your dependencies and access the public API by the `tomlf` module.

We recommend to set the default library type of `toml-f` to static when linking your applications or library against it.
Note for library type both and shared `toml-f` will install itself along with your project.

For more fine-tuned control you can access:
- the library target with `tomlf_lib`
- the private include dir of this target, containing the Fortran module files, with `tomlf_inc`
- the license files of `toml-f` with `tomlf_lic`

If you are linking your application statically against `toml-f` and still want to distribute the license files of `toml-f` (thank you), just use

```meson
install_data(
  tomlf_prj.get_variable('tomlf_lic'),
  install_dir: get_option('datadir')/'licenses'/meson.project_name()/'toml-f',
)
```
