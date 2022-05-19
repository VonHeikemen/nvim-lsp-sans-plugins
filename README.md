Ever wondered how you can use neovim's builtin LSP client without plugins? This example configuration can show you one way of doing it.

> This is not a neovim distribution.

## How does it work?

At the heart of everything there are two functions:

* `vim.lsp.start_client()`: This function creates a "client object" that handles all communications with a language server.

* `vim.lsp.buf_attach_client()`: With it we tell the language server it needs track the changes made to a particular file.

In order to simplify the code automatic "root dir" detection is not included. Instead, you should specify in a "local config" the servers you want to enable. Once a language server start running an autocommand is created, if the language server supports the filetype of the current buffer then it call `vim.lsp.buf_attach_client()`.

## Project setup

For this configuration to work we need to call each server explicitly. It means we would need to have a configuration file per project. How can we do this without plugins? I propose we use the builtin session mechanism. A session can have configuration file.

### Test run

Navigate to a lua project and create a `.nvim` folder in the root directory.

Open neovim. Create a session file in the new folder.

```vim
:mksession ./.nvim/Session.vim
```

Now create a config file for this session.

```vim
:edit ./.nvim/Sessionx.vim
```

Inside `Sessionx.vim` we can call our language servers. For the moment we are trying out `lua-language-server`. Add this.

```lua
lua require('lsp').start('sumneko_lua')
```

Save the file and exit neovim. Now start neovim with this command.

```sh
nvim -S ./nvim/Session.vim
```

After the session state is restored neovim will source `Sessionx.vim` and this will call our language server. If you have any errors the diagnostic signs will show in the gutter. Completion suggestion can be triggered in insert mode using `<C-x><C-o>`. Check out [user.keymaps](https://github.com/VonHeikemen/nvim-sans-plugins/tree/main/lua/user/keymaps.lua) to know what kind of actions you can do once the language server is attached to a buffer.

## Files you might find interesting

* [lsp.client](https://github.com/VonHeikemen/nvim-sans-plugins/tree/main/lua/lsp/client.lua): Here you can find the "core" functions to start the client and attach it to a buffer.

* [lsp.configs.shared](https://github.com/VonHeikemen/nvim-sans-plugins/tree/main/lua/lsp/configs/shared.lua): Used to build the configuration for a language servers. Here you can find initialization hooks, clean up hooks, capabilities. All the boilerplate necessary to reuse a language server instance in a project.

* [lsp](https://github.com/VonHeikemen/nvim-sans-plugins/tree/main/lua/lsp/init.lua): `init.lua` in the lsp folder has all user customizations you would expect to find in a "regular config" using `nvim-lspconfig`.

* [user.sessions](https://github.com/VonHeikemen/nvim-sans-plugins/tree/main/lua/lsp/init.lua): As a bonus I've added some helper to make it easier to manage sessions.

## Support

If you find this useful and want to support my efforts you can [buy me a coffee ☕](https://www.buymeacoffee.com/vonheikemen).

[![buy me a coffee](https://res.cloudinary.com/vonheikemen/image/upload/v1618466522/buy-me-coffee_ah0uzh.png)](https://www.buymeacoffee.com/vonheikemen)

