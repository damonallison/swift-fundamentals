# Swift Commands

## swift

* Print the current swift version
`$ swift -version`

## xcode-select

`xcode-select` allows you to set the active developer directory. The active developer directory is where all the command line tools are found.

* Print the current developer directory
`$ xcode-select --print-path`

* Switch the active developer directory
`$ xcode-select --switch /Applications/Xcode.app`

* Open a UI dialog to request automatic installation of the developer tools.
`$ xcode-select --install`

## xcrun

`xcrun` is used to find and run developer commands from the active developer directory.
