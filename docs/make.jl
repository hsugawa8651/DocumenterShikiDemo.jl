using Documenter
using DocumenterShikiDemo
include("./ShikiHighlighter.jl")
using .ShikiHighlighter

makedocs(;
    modules=[DocumenterShikiDemo],
    format=shiki_html(
        theme="github-light",
        dark_theme="github-dark",
        languages=["julia", "javascript", "python", "bash", "json", "yaml", "toml"],
        cdn_url="https://esm.sh",
        canonical="https://hsugawa8651.github.io/DocumenterShikiDemo.jl/",
        edit_link=:commit,
    ),
    sitename="DocumenterShikiDemo",
    pages=[
        "Home" => "index.md",
    ],

)

# Add Shiki assets to build directory
add_shiki_assets(joinpath(@__DIR__, "build"))

deploydocs(;
    repo="github.com/hsugawa8651/DocumenterShikiDemo.jl",
    devbranch="main",
    push_preview=true
)
