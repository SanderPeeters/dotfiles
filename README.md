### Setting up your Mac

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Copy public and private SSH keys to `~/.ssh` and make sure they're set to `600`
5. Clone this repo to `~/.dotfiles`
6. Run `install.sh` to start the installation
7. Restart your computer to finalize the process

Your Mac is now ready to use!

> Note: you can use a different location than `~/.dotfiles` if you want. Just make sure you also update the reference in the `.zshrc` file.

### VSCODE
Vscode does not work with automatic symlinking.

Commands to symlink settings:
```bash
ln -s /Users/<username>/.dotfiles/VSCode/settings.json /Users/<username>/Library/Application\ Support/Code/User/settings.json
```

```bash
ln -s /Users/<username>/.dotfiles/VSCode/keybindings.json /Users/<username>/Library/Application\ Support/Code/User/keybindings.json
```
```bash
ln -s /Users/<username>/.dotfiles/VSCode/snippets/ /Users/<username>/Library/Application\ Support/Code/User
```