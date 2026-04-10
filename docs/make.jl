push!(LOAD_PATH, "../src")

using Documenter
using VQC

makedocs(
    sitename="VQC.jl",
    authors = "Guo Chu",
    pages=[
        "Home" => "index.md",
        "Getting Started" => "gettingstarted.md",
        "Variational Quantum Circuits" => "variational.md",
        "Hamiltonian Simulation" => "ham.md",
        "Quantum Control" => "qctrl.md"
    ],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    )
)