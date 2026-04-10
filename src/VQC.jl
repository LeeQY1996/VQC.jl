module VQC


using Zygote
using Zygote: @adjoint


using LinearAlgebra, StaticArrays, QuantumCircuits, QuantumCircuits.Gates
using QuantumCircuits: permute
# import LinearAlgebra, QuantumCircuits

# Re-export commonly used functions from QuantumCircuits
# Note: spin_half, boson, Hamiltonian, Observers, spin_half_state, fock_state, Variable are not defined
# using QuantumCircuits: gate  # gate may exist, but commented out for now

# Re-export common gates from QuantumCircuits.Gates
using QuantumCircuits.Gates: H, X, Y, Z, S, T, CNOT, CZ, SWAP, Rx, Ry, Rz
# U1, U2, U3 may not exist in QuantumCircuits.Gates
# Gate types are exported from QuantumCircuits, not QuantumCircuits.Gates
# using QuantumCircuits.Gates: HGate, XGate, YGate, ZGate, SGate, TGate, CNOTGate, CZGate, SWAPGate, RxGate, RyGate, RzGate, CRxGate, CRyGate, CRzGate

# Re-export functions from Utilities module
# using .Utilities: variational_circuit_1d, real_variational_circuit_1d  # Moved after include

# using KrylovKit: exponentiate
# using SparseArrays: spzeros, sparse, SparseMatrixCSC
# using Logging: @warn




# statevector
export StateVector, DensityMatrix, distance, distance2, onehot_encoding, qubit_encoding, qstate, amplitude_encoding, reset!, amplitude, amplitudes
export tr, dot, norm, normalize!, normalize, ishermitian
export reset_qubit!, reset_onehot!, storage, fidelity, rand_state, rand_densitymatrix, permute
export schmidt_numbers, renyi_entropy

# circuit operations from QuantumCircuits
export QCircuit

# Common quantum gates
export H, X, Y, Z, S, T, CNOT, CZ, SWAP, Rx, Ry, Rz
# U1, U2, U3 may not be available
export HGate, XGate, YGate, ZGate, SGate, TGate, CNOTGate, CZGate, SWAPGate, RxGate, RyGate, RzGate, CRxGate, CRyGate, CRzGate

# Hamiltonian and operator functions
# Note: spin_half, boson, Hamiltonian, Observers, spin_half_state, fock_state, Variable are not defined
# export gate  # gate may exist, but commented out for now

# utility functions
export variational_circuit_1d, real_variational_circuit_1d

# gate operations
export apply!

# measurement
export measure, measure!


# hamiltonian
export expectation

# AD for post selection may be removed in the future
export post_select, post_select!

# partial trace
export partial_tr

# utility functions



# auxiliary
include("auxiliary/distance.jl")
include("auxiliary/parallel_for.jl")
include("auxiliary/sampling.jl")
include("auxiliary/tensorops.jl")
include("auxiliary/indexop.jl")

# definitions of pure quantum gate
include("statevector.jl")

# density matrix representation 
include("densitymatrix.jl")

# quantum gate operations
include("applygates/applygates.jl")


# measurement and postselection
include("measure.jl")
include("postselect.jl")

# hamiltonian expectation
include("hamiltonian/util.jl")
include("hamiltonian/apply_qterms/apply_qterms.jl")
include("hamiltonian/expecs/expecs.jl")
include("hamiltonian/expecs_dm/expecs_dm.jl")


# differentiation
include("circuitdiff.jl")
include("expecdiff.jl")
include("additional_adjoints.jl")

# partial trace
include("ptrace.jl")

# utility functions
include("utility/utility.jl")

# Import functions from Utilities module after it's defined
import .Utilities: variational_circuit_1d, real_variational_circuit_1d


end
