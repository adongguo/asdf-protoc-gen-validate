<div align="center">

# asdf-protoc-gen-validate [![Build](https://github.com/adongguo/asdf-protoc-gen-validate/actions/workflows/build.yml/badge.svg)](https://github.com/adongguo/asdf-protoc-gen-validate/actions/workflows/build.yml) [![Lint](https://github.com/adongguo/asdf-protoc-gen-validate/actions/workflows/lint.yml/badge.svg)](https://github.com/adongguo/asdf-protoc-gen-validate/actions/workflows/lint.yml)

[protoc-gen-validate](https://github.com/bufbuild/protoc-gen-validate) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `proto`: protoc buffer compiler.

# Install

Plugin:

```shell
asdf plugin add protoc-gen-validate
# or
asdf plugin add protoc-gen-validate https://github.com/adongguo/asdf-protoc-gen-validate.git
```

protoc-gen-validate:

```shell
# Show all installable versions
asdf list-all protoc-gen-validate

# Install specific version
asdf install protoc-gen-validate latest

# Set a version globally (on your ~/.tool-versions file)
asdf global protoc-gen-validate latest

# Now protoc-gen-validate commands are available
protoc-gen-validate --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/adongguo/asdf-protoc-gen-validate/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [zhuoyue.gxd](https://github.com/adongguo/)
