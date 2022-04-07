module VQC


using Zygote
using Zygote: @adjoint


using LinearAlgebra, StaticArrays, QuantumCircuits, QuantumCircuits.Gates
import LinearAlgebra, QuantumCircuits

# using KrylovKit: exponentiate
# using SparseArrays: spzeros, sparse, SparseMatrixCSC
# using Logging: @warn




# statevector
export StateVector, distance, distance2, onehot_encoding, qubit_encoding, reset!, amplitude, amplitudes, dot, norm, normalize!, normalize
export reset_qubit!, reset_onehot!, rand_state, storage
# gate operations
export apply!

# measurement
export measure, measure!


# hamiltonian
export expectation

# AD for post selection may be removed in the future
export post_select, post_select!





# auxiliary
include("auxiliary/distance.jl")
include("auxiliary/parallel_for.jl")
include("auxiliary/sampling.jl")
include("auxiliary/tensorops.jl")

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


# differentiation
include("circuitdiff.jl")
include("additional_adjoints.jl")


# utility functions
include("utility/utility.jl")


end
