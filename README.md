# Overview



# Installation (Windows)

1. Clone this repository into $HOME (use `--recurse-submodules` in order to initialize and update the submodules in one command, and skip step 2)
2. If you're like me (forgetful and hate yourself) and you didn't use the `--recurse-submodules` flag, the you should execute `git submodule update --init --recursive` at the root of the repository in order to clone the submodules
3. Soft-link (symmlink) the repository folder into "$HOME/vimfiles", this is in order to let VIM automatically find it

Done!

# Installation (Unix)

1. Clone this repository into $HOME (use `--recurse-submodules` in order to initialize and update the submodules in one command, and skip step 2)
2. If you're like me (forgetful and hate yourself) and you didn't use the `--recurse-submodules` flag, the you should execute `git submodule update --init --recursive` at the root of the repository in order to clone the submodules
3. Soft-link (symmlink) the repository folder into "$HOME/.vim", this is in order to let VIM automatically find it
