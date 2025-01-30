# academic.nvim

This plugin installs and initializes an
[Academic English](https://github.com/emareg/acamedic) dictionary for Neovim. It
configures the dictionary as the `en-academic` language, automatically adding it
to Neovim's `spelllang` table.

# Features

- Generates Neovim compatible `.spl` dictionary format from the
  [Acamedic](https://github.com/emareg/acamedic) hunspell dictionary.
- Optional: Automatically re-generates `.spl` binaries when needed.
- Optional: Supports directly downloading and building dictionary from Acamedic
  source (requires [dependencies](#optional-dependencies)).

# Installation

You can install `academic` with your favourite plugin manager. For example, with
`lazy.nvim`:

```lua
{
  "ficcdaf/academic.nvim",
  -- recommended: rebuild on plugin update
  build = ":AcademicBuild"
  -- ONLY uncomment this if you want to change the defaults!
  -- you do NOT need to set opts for Academic to load!
  -- opts = {
  -- -- change settings here
  -- }
}
```

`academic.nvim` loads automatically. There is no need to call `setup` unless you
wish to change the default options. The `build` option of the `lazy.nvim` plugin
spec is recommended -- otherwise, you will need to run `:AcademicBuild` when you
first install the plugin, and on subsequent updates.

# Configuration

Configuration is entirely optional. You can pass a table to the `setup`
function, or set the `opts` field in the Lazy plugin spec.

The following options are available:

```lua
-- default settings
{
  auto_install = true,
  auto_rebuild = false,
}
```

## Auto Install

> Recommended: **true**

The `auto_install` feature will check the Neovim spellfile directory for an
existing Academic spellfile. If none is found, it will automatically generate
and install the spellfile.

It is recommended to keep this setting **on** because it has a negligible effect
on startup performance, and eliminates the need to manually run the
`AcademicBuild` command when installing the plugin for the first time.

## Auto Rebuild

> Recommended: **false**

The `auto_rebuild` feature checks the creation date of the compiled Academic
spellfile against the source dictionary in the plugin source. If outdated, the
spellfile is automatically re-built using `AcademicBuild`.

It is recommended to keep this setting **off** because it may significantly
increase startup time on some systems. I was able to save around `1 ms` on my
machine by disabling the setting.

If you're using `lazy.nvim` you can leverage the `build` option to automatically
rebuild the spellfile _only_ when the plugin is updated. This is the recommended
approach, please see the [installation](#installation) section.

## Optional Dependencies

If you wish to build your dictionary directly from Acamedic with the update
function, you must have `bash`, `curl`, and `unmunch` available on your `$PATH`.
`unmunch` is installed alongside `hunspell` on most systems. This functionality
is _optional_. **A reasonably up-to-date version of the dictionary is included
with this plugin.**

# Usage

The following commands are provided:

| User Command     | Lua API                                    | Requires Dependencies |
| ---------------- | ------------------------------------------ | --------------------- |
| `AcademicUpdate` | `require("academic").update()`             | Yes                   |
| `AcademicBuild`  | `require("academic").generate_spellfile()` | No                    |
