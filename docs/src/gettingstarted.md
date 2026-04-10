# Getting Started

This section provides a simple pipeline to demonstrate how to use VQC.jl for quantum computing applications.

## Installation

If you haven't installed VQC.jl yet, you can install it using the Julia package manager:

```julia
using Pkg
Pkg.add("VQC")
```

Alternatively, for the development version:

```julia
Pkg.add(url="https://github.com/guochu/VQC.jl")
```

## Pipeline for Quantum Circuit Simulation

### Initialize a Quantum State

The `qstate` function creates a quantum state. Several signatures are available:

```@docs
qstate(::Type{T}, thetas::AbstractVector{<:Real}) where {T <: Number}
qstate(thetas::AbstractVector{<:Real})
qstate(::Type{T}, n::Int) where {T <: Number}
qstate(n::Int) 
```

To extract amplitudes from a quantum state:

```@docs
amplitude(s::StateVector, i::AbstractVector{Int}) 
amplitudes(s::StateVector)
```

#### Examples

```@example
push!(LOAD_PATH, "../../src")
using VQC
state = qstate(2)
state = qstate([1, 0])
state = qstate([0.5, 0.7])
```

### Quantum Gates

VQC.jl provides a set of predefined elementary gates: 
`X, Y, Z, S, H, sqrtX, sqrtY, T, Rx, Ry, Rz, CONTROL, CZ, CNOT, CX, SWAP, iSWAP, XGate, YGate, ZGate, HGate, SGate, TGate, SqrtXGate, SqrtYGate, RxGate, RyGate, RzGate, CZGate, CNOTGate, SWAPGate, iSWAPGate, CRxGate, CRyGate, CRzGate, TOFFOLIGate`.

```@example
using VQC

circuit = QCircuit()

# Standard one-qubit gate
push!(circuit, (1, H))
empty!(circuit)
push!(circuit, HGate(1))
empty!(circuit)
push!(circuit, gate(1, H))
empty!(circuit)

# Standard two-qubit gate
push!(circuit, ((1, 2), CZ))
empty!(circuit)
push!(circuit, CZGate((1, 2)))
empty!(circuit)
push!(circuit, gate((1,2), CZ))
empty!(circuit)

# A parametric one-qubit gate
push!(circuit, RxGate(1, Variable(0.5)))
empty!(circuit)

# A parametric two-qubit gate
push!(circuit, CRxGate((1,2), Variable(0.5)))
empty!(circuit)

# This creates a non-parametric gate instead
push!(circuit, RxGate(1, 0.5))
```

### Quantum Circuit

Adding new gates to a circuit:

<!-- ```@docs
add!(x::AbstractCircuit, s)
Base.push!(x::AbstractCircuit, s::AbstractGate)
Base.append!(x::AbstractCircuit, y::AbstractCircuit)
Base.append!(x::AbstractCircuit, y::Vector{T}) where {T<:AbstractGate}
``` -->

Circuit manipulations:

```@example
using VQC
circuit = QCircuit()
push!(circuit, (1, H))
push!(circuit, ((1, 2), CZ))
c1 = transpose(circuit)
c2 = conj(circuit)
c3 = circuit'
```

### Apply Quantum Circuit to State

```@docs
apply!(circuit::QCircuit, state::Union{StateVector, DensityMatrix})
*(circuit::QCircuit, state::Union{StateVector, DensityMatrix})
```

### Quantum Measurement

Measure and collapse a quantum state:

```@docs
measure(qstate::StateVector, pos::Int)
measure!(qstate::StateVector, pos::Int; auto_reset::Bool=true)
```

Postselection:

```@docs
post_select!(qstate::StateVector, key::Int, state::Int=0)
post_select(qstate::StateVector, key::Int, state::Int=0; keep::Bool=false)
```

## Next Steps

Continue to the [Variational Quantum Circuit](variational.md) section to learn how to build and optimize parameterized quantum circuits.