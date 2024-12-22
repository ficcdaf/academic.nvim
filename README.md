# academic.nvim

This plugin installs and initializes an [Academic English](https://github.com/emareg/acamedic) dictionary for Neovim. It configures the dictionary as the `en-academic` language, automatically adding it to Neovim's `spelllang` table.

# Features

- Generates Neovim compatible `.spl` dictionary format from the [Acamedic](https://github.com/emareg/acamedic) hunspell dictionary.
- Automatically re-generates `.spl` binaries when needed.
- Supports directly downloading dictionary from Acamedic source with optional dependencies.

# Installation

You can install `academic` with your favourite plugin manager. For example, with `lazy.nvim`:

```lua
{
  "ficcdaf/academic.nvim",
  -- optional: only load for certain filetypes
  ft = {"markdown", "tex"}
}
```

If you are not using a plugin manager, you can clone this repository, add it to your runtime path, and then load the plugin in your Neovim configuration:

```lua
-- In your init.lua
require("academic").load()
```

`academic.nvim` will automatically run its setup logic as soon as it is loaded. There are currently no configuration options.

## Optional Dependencies

If you wish to build your dictionary directly from Acamedic with the update function, you must have `bash`, `curl`, and `unmunch` available on your `$PATH`. `unmunch` is installed alongside `hunspell` on most systems. This functionality is _optional_. **A reasonably up-to-date version of the dictionary is included with this plugin.**

# Usage

The following commands are provided:

| User Command     | Lua API                                    | Requires Dependencies |
| ---------------- | ------------------------------------------ | --------------------- |
| `AcademicUpdate` | `require("academic").update()`             | Yes                   |
| `AcademicBuild`  | `require("academic").generate_spellfile()` | No                    |
