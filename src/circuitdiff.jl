
@adjoint *(circuit::QCircuit, x::StateVector) = begin
    y = circuit * x
    return y, Δ -> begin
        Δ, grads, y = back_propagate(copy(Δ), circuit, copy(y))
        return grads, Δ
    end
end

@adjoint qubit_encoding(::Type{T}, mpsstr::Vector{<:Real}) where {T<:Number} = begin
    y = qubit_encoding(T, mpsstr)
    return y, Δ -> begin
        circuit = QCircuit([RyGate(i, theta*pi, isparas=true) for (i, theta) in enumerate(mpsstr)])
        Δ, grads, y = back_propagate(Δ, circuit, copy(y))
        return nothing, grads .* pi
    end
end



function back_propagate(Δ::AbstractVector, m::Gate, y::StateVector)
    Δ = StateVector(Δ, nqubits(y))
    Δ = apply!(m', Δ)
    y = apply!(m', y)
    ∇θs = nothing
    if nparameters(m) > 0
        ∇θs = [real(expectation(y, item, Δ)) for item in differentiate(m)]
    end
    return storage(Δ), ∇θs, y
end


function back_propagate(Δ::AbstractVector, circuit::QCircuit, y::StateVector)
    RT = real(eltype(y))
    grads = Vector{RT}[]
    for item in reverse(circuit)
        Δ, ∇θs, y = back_propagate(Δ, item, y)
        !isnothing(∇θs) && push!(grads, ∇θs)
    end

    ∇θs_all = RT[]
    for item in Iterators.reverse(grads)
        append!(∇θs_all, item)
    end

    return Δ, ∇θs_all, y
end


# function back_propagate(Δ::AbstractMatrix, m::Gate, y::DensityMatrix)
#     Δ = StateVector(Δ, nqubits(y))
#     Δ = apply!(m', Δ)
#     y = apply!(m', y)
#     ∇θs = nothing
#     if nparameters(m) > 0
#         ∇θs = [real(expectation(y, item, Δ)) for item in differentiate(m)]
#     end
#     return storage(Δ), ∇θs, y
# end