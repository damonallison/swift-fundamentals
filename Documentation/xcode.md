# Xcode

```bash

# xcode-select
#
# xcode-select manages the active developer dir for Xcode and BSD tools. It
# allows you to switch between different versions of Xcode tools or to update
# the path to Xcode tools if the directory has been moved.
#
# Set the command line tools to use those found in /Applications/Xcode.app

$ sudo xcode-select --switch /Applications/Xcode.app

# Find out what command line tools path is being used.

$ sudo xcode-select --print-path

# ---
#
# Install the command line developer tools.
# Command line tools are installed to /Library/Developer/CommandLineTools

$ sudo xcode-select --install

# ---
#
# xcrun ses the Xcode development environment to find and execute the given
# command.
#
$ xcrun [-v] --find <tool name>
```
