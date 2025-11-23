# DocumenterShiki

Modern syntax highlighting for Documenter.jl using Shiki.

## Overview

DocumenterShiki integrates [Shiki](https://shiki.style/) syntax highlighting into [Documenter.jl](https://documenter.juliadocs.org/), providing beautiful and customizable code highlighting for your Julia documentation.

### Features

- 🎨 Modern syntax highlighting powered by Shiki
- 🌓 Light/dark theme support with automatic detection
- 📋 Copy button for code blocks
- ⚡ Dynamic loading from CDN
- 🎯 Custom highlight annotations
- 🔧 Highly configurable

## How This Package Was Created

This package was generated using [PkgTemplatesShikiPlugin](https://github.com/hsugawa8651/PkgTemplatesShikiPlugin.jl) to demonstrate its capabilities:

```julia
using PkgTemplates
using PkgTemplatesShikiPlugin

t = Template(;
    julia=v"1",  # Broad compatibility: Julia 1.x
    plugins=[
        ProjectFile(version=v"0.1.0"),  # Initial development version
        GitHubActions(),
        DocumenterShiki{GitHubActions}()
    ]
)

t("DocumenterShikiDemo")
```

This single command automatically generated:
- ✅ Package structure with `src/DocumenterShikiDemo.jl`
- ✅ Documentation setup in `docs/` with `ShikiHighlighter.jl`
- ✅ GitHub Actions workflows (CI.yml, Documentation.yml)
- ✅ Node.js configuration (`package.json`, `pnpm-lock.yaml`)
- ✅ Proper `.gitignore` settings

### Key Settings

- **`julia=v"1"`**: Sets `[compat] julia = "1"` for all Julia 1.x versions (default: `"1.6.7"`)
- **`ProjectFile(version=v"0.1.0")`**: Sets initial version to `0.1.0` (default: `"1.0.0-DEV"`)

## Using PkgTemplatesShikiPlugin for Your Package

You can use the same approach for your own Julia packages:

For detailed instructions, see the [PkgTemplatesShikiPlugin documentation](https://hsugawa8651.github.io/PkgTemplatesShikiPlugin.jl/).

## Generated Files

When using PkgTemplatesShikiPlugin, the following files are **automatically generated**:

### `docs/ShikiHighlighter.jl`

This module provides the `shiki_html()` function and `add_shiki_assets()` function. It's automatically included in your `docs/make.jl`:

### `docs/make.jl`

The generated `docs/make.jl` already includes the ShikiHighlighter module:

```julia
using Documenter
include("./ShikiHighlighter.jl")
using .ShikiHighlighter

makedocs(;
    format=shiki_html(
        theme="github-light",
        dark_theme="github-dark"
    ),
    sitename="My Documentation",
    pages=["Home" => "index.md"]
)

# Add Shiki assets after building
add_shiki_assets("build")
```

### Configuration Options

The `shiki_html()` function accepts the following Shiki-specific options:

- `theme::String="github-light"` - Default theme for light mode
- `dark_theme::String="github-dark"` - Theme for dark mode
- `languages::Vector{String}` - List of supported languages (default: julia, javascript, python, bash, json, yaml, toml)
- `cdn_url::String="https://esm.sh"` - CDN URL for Shiki library
- `load_themes::Vector{String}` - Additional themes to load

All standard `Documenter.HTML()` options are also supported.

## Supported Code Blocks

### Where Shiki Highlighting Works

Shiki syntax highlighting is applied to the following types of code blocks:

#### Documenter Special Blocks

- **`@example`** - Displays both code and execution results with syntax highlighting
- **`@repl`** - Shows code with REPL prompts and results, both highlighted

#### Standard Markdown Code Blocks

Any code block with a [language specifier](https://shiki.style/languages):

````markdown
```julia
# Your Julia code here
```
````

#### Blocks Where Shiki Does NOT Apply

- **`@setup`** - Code is hidden, so no highlighting is displayed
- **`@eval`** - Code is hidden, only results are shown
- **`@docs`**, **`@autodocs`**, etc. - These are not code blocks
- **`nohighlight`** - Code blocks marked as `nohighlight` are intentionally excluded from Shiki processing and rendered as plain text. Highlight markers (such as `# @highlight:`, `[!code highlight]`, etc.) will not be processed in these blocks.

### Supported Languages

Shiki supports **over 200 programming languages**. See the complete list at: **[Shiki Languages](https://shiki.style/languages)**

#### Default Languages

By default, the following languages are supported:
- julia
- javascript
- python
- bash
- json
- yaml
- toml

#### Adding More Languages

You can add support for additional languages in your `docs/make.jl`:

\`\`\`julia
format=shiki_html(
    languages=["julia", "javascript", "python", "bash", "rust", "go", "cpp"]
)
\`\`\`

#### Unsupported Languages

If you use a language that is not in the `languages` list:
- A warning will appear in the browser console
- The code will be displayed without Shiki highlighting
- The code block will still be readable, just without syntax colors

## Next Steps

- See [Syntax Highlighting](syntax.md) for detailed documentation on highlight syntax
- Browse the [Gallery](gallery.md) for practical examples

## License

MIT License

## See Also

- [Documenter.jl](https://documenter.juliadocs.org/)
- [Shiki](https://shiki.style/)

