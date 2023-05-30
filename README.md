## zyy

The way we create the website: [fangling.uk](https://fangling.uk).

## Building zyy

### Build Requirements

#### macOS

  - [Homebrew](https://brew.sh): The Missing Package Manager for macOS (or Linux)
  - Install `cmark-gfm`

```shell
brew install cmark-gfm
```

### Build Procedure

```shell
cd zyy
swift build -c release

# Run built-in tests
swift test
```

## Credits

This repo relies on the following third-party projects:

  - [sqlite/sqlite](https://github.com/sqlite/sqlite)
  - [github/cmark-gfm](https://github.com/github/cmark-gfm)
  - [swift-argument-parser](https://github.com/apple/swift-argument-parser)
