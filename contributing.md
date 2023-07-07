# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test protoc-gen-validate https://github.com/adongguo/asdf-protoc-gen-validate.git "protoc-gen-validate --help"
```

Tests are automatically run in GitHub Actions on push and PR.
