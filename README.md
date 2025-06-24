# ALVAROPING1 config files

Repository to save my config files, so they can be easily accesible.

## Installing

This uses [GNU stow](https://www.gnu.org/software/stow/). In order to install each
application's config, use `stow <app>`. To install all applications' config, use
`stow */`

The current supported apps are:

- `zsh`: [Z-shell](https://www.zsh.org/) configuration  
  Requires:
  - [fzf](https://github.com/junegunn/fzf)
  - [eza](https://github.com/eza-community/eza)

  Depends-on:
  - `starship`
  - `shell`
