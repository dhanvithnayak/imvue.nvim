<h3 align="center"> imvue.nvim </h3>

<p align="center">
  <i> Neovim plugin to view images </i>

## About
A Neovim plugin that opens images in your preferred application rather than opening in buffers as text

## Setup
The minimal configuration for lazy.nvim would be
```lua
{
  "dhanvithnayak/imvue.nvim",
  lazy = false,
  config = function()
    require('imvue')
  end,
}
```

Default extensions for which this plugin works are `png, jgp, jpeg, gif, svg, webp, bmp, tiff`

You can add more file formats by modifying the configuration
```lua
{
  "dhanvithnayak/imvue.nvim",
  lazy = false,
  config = function()
    require('imvue').setup({
      extensions = { 'ico', 'heic' }
    })
  end,
}
```

You can also disable specific default extensions
```lua
{
  "dhanvithnayak/imvue.nvim",
  lazy = false,
  config = function()
    require('imvue').setup({
      extensions = { png = false }
    })
  end,
}
```
Or disable all default extensions altogether
```lua
{
  "dhanvithnayak/imvue.nvim",
  lazy = false,
  config = function()
    require('imvue').setup({
      use_default_extensions = false,
      extensions = { 'ico', 'heic' }
    })
  end,
}
```
