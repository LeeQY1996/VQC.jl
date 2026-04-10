# VQC.jl

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://leeQY1996.github.io/VQC.jl/)

VQC.jl is a Julia framework for simulating variational quantum circuits and quantum machine learning tasks. It provides a differentiable programming interface for quantum circuits, enabling seamless integration with classical machine learning libraries like Flux.

## Features

* **Simple but powerful**: Supports single-qubit, two-qubit, and three-qubit gate operations, measurements, and post-selection. The same quantum circuit can be used as a variational quantum circuit with minimal code changes.

* **Everything is differentiable**: Both quantum circuits and quantum states are differentiable using automatic differentiation. Complex expressions built on top of quantum circuits and states can be differentiated end-to-end.

* **Flexible circuit operations**: Quantum circuits and gates support operations such as adjoint, transpose, conjugate, and shift, making it easier to build complex circuits.

* **Zygote backend**: Uses Zygote for automatic differentiation, enabling gradient-based optimization of quantum circuits.

* **Hamiltonian simulation**: Preliminary support for Hamiltonian evolution and variational Hamiltonian simulation.

* **Density matrix support**: Basic support for density matrix operations and open quantum systems.

## Installation

To install VQC.jl, use the Julia package manager:

```julia
julia> using Pkg
julia> Pkg.add("VQC")
```

Alternatively, you can install the development version directly from GitHub:

```julia
julia> Pkg.add(url="https://github.com/LeeQY1996/VQC.jl")
```

## Quick Start

### Creating a Bell State

```julia
using VQC

# Create a 2-qubit state
state = qstate(2)

# Build a circuit to create a Bell state
circuit = QCircuit()
push!(circuit, (1, H))
push!(circuit, ((1, 2), CNOT))

# Apply the circuit to the state
apply!(circuit, state)

# Check the amplitudes
println(amplitudes(state))

# Perform measurement
i, prob = measure!(state, 1)
println("Probability of the 1st qubit in state $i is $prob.")
```

### Variational Quantum Circuit

```julia
using VQC
using Zygote

# Create a 3-qubit variational circuit
L = 3
state = qstate(L)
circuit = QCircuit()
for i in 1:L
    push!(circuit, RzGate(i, Variable(rand())))
    push!(circuit, RyGate(i, Variable(rand())))
    push!(circuit, RzGate(i, Variable(rand())))
end

# Create a target state
target_state = qrandn(L)

# Define a loss function
loss(c) = distance(target_state, c * state)

# Compute the gradient
grad = gradient(loss, circuit)
println("Gradient computed successfully!")
```

### Hamiltonian Simulation

```julia
using VQC

# Create spin-1/2 and boson operators
ps = spin_half()
pb = boson(d=4)
ham = Hamiltonian([ps, pb])

# Add interaction terms
add!(ham, (1,2), ("sp", "a"), coeff=1)
add!(ham, (1,2), ("sm", "adag"), coeff=1)
add!(ham, (1,), ("sz",), coeff=0.5)

# Create initial state and evolve
state = kron(spin_half_state(0), fock_state(4, 2))
state = apply(ham, 0.5, state)
```

## Documentation

For detailed documentation, including API reference and tutorials, please visit the [official documentation](https://leeQY1996.github.io/VQC.jl/).

You can also build the documentation locally:

```bash
julia docs/make.jl
```

### Setting up GitHub Pages

The documentation is automatically deployed to GitHub Pages via GitHub Actions. To enable this:

1. Go to your repository on GitHub: https://github.com/LeeQY1996/VQC.jl
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**

The GitHub Actions workflow (`.github/workflows/documenter.yml`) will automatically build and deploy the documentation to `https://leeQY1996.github.io/VQC.jl/` on every push to the `master` branch.

## Dependencies

VQC.jl depends on the following packages:
- [Zygote](https://github.com/FluxML/Zygote.jl) - Automatic differentiation
- [QuantumCircuits](https://github.com/guochu/QuantumCircuits.jl) - Quantum circuit representation
- [StaticArrays](https://github.com/JuliaArrays/StaticArrays.jl) - Efficient array operations
- [KrylovKit](https://github.com/Jutho/KrylovKit.jl) - Krylov subspace methods

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues on [GitHub](https://github.com/LeeQY1996/VQC.jl).

## License

VQC.jl is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

## Citation

If you use VQC.jl in your research, please consider citing:

```bibtex
@software{vqc_jl,
  author = {Guo Chu},
  title = {VQC.jl: A Variational Quantum Circuit Framework in Julia},
  year = {2023},
  url = {https://github.com/LeeQY1996/VQC.jl}
}
```

## Acknowledgements

This project is inspired by and builds upon several existing quantum computing frameworks, including [Yao.jl](https://yaoquantum.org/) and [Qiskit](https://qiskit.org/).
