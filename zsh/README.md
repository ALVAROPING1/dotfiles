# Zsh setup

My preferred shell is [Zsh](https://www.zsh.org/).

Special thanks to [dreamsofautonomy](https://github.com/dreamsofautonomy) and [rajayonin](https://github.com/rajayonin)

## Prompt

The prompt theme is [Starship](https://starship.rs/). Please make sure to install
it beforehand, although it's only loaded when detected.

## Plugins

The plugin manager is [Zinit](https://github.com/zdharma-continuum/zinit), with
the following plugins:

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [zsh-cargo-completion](https://github.com/MenkeTechnologies/zsh-cargo-completion)

### Oh-my-zsh plugins

Although I don't use omz (too slow), Zinit allows us to take advantage of [its plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins):

- [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)

## Integrations

There are a couple of integrations with some packages, so please install them.
They are only enabled when detected.

- [fzf](https://github.com/junegunn/fzf)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
