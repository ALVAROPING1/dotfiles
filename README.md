# ALVAROPING1 config files

Repository to save my config files, so they can be easily accesible.

## Installing

This uses [GNU stow](https://www.gnu.org/software/stow/). In order to install each
application's config, use `stow <app>`. To install all applications' config, use
`stow */`

The current supported apps are:

- `bash`: [GNU Bash](https://www.gnu.org/software/bash/) configuration  
  Requires:
  - [fzf](https://github.com/junegunn/fzf)

  Depends-on:
  - `starship`
  - `shell`
- `bat`: [bat](https://github.com/sharkdp/bat) configuration
- `clangd`: [clangd](https://clangd.llvm.org/) configuration
- `shell`: generic shell configuration (environment variables/aliases)  
  Requires (coreutils replacements):
  - [batcat](https://github.com/sharkdp/bat)
  - [delta](https://github.com/dandavison/delta)
  - [eza](https://github.com/eza-community/eza)
  - [dust](https://github.com/bootandy/dust)
  - [dysk](https://github.com/Canop/dysk)
- `starship`: [starship](https://starship.rs/) configuration
- `zsh`: [Z-shell](https://www.zsh.org/) configuration  
  Requires:
  - [fzf](https://github.com/junegunn/fzf)
  - [eza](https://github.com/eza-community/eza)

  Depends-on:
  - `starship`
  - `shell`
