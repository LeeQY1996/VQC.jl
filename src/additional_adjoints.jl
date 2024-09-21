

@adjoint storage(x::Union{StateVector, DensityMatrix}) = storage(x), z -> (typeof(x)(z),)
@adjoint nqubits(x::Union{StateVector, DensityMatrix}) = nqubits(x), z -> (nothing,)
@adjoint StateVector(data::AbstractVector{<:Number}, n::Int) = StateVector(data, n), z -> (storage(z), nothing)
@adjoint StateVector(data::AbstractVector{<:Number}) = StateVector(data), z -> (storage(z),)
@adjoint DensityMatrix(data::AbstractMatrix{<:Number}, n::Int) = DensityMatrix(data, n), z -> (storage(z), nothing)
@adjoint DensityMatrix(data::AbstractMatrix{<:Number}) = DensityMatrix(data), z -> (storage(z),)

# @adjoint dot(x::StateVector, y::StateVector) = begin
# 	v, back = Zygote.pullback(dot, storage(x), storage(y))
# 	return v, z -> begin
# 		a, b = back(z)
# 		return StateVector(a, nqubits(x)), StateVector(b, nqubits(y))
# 	end
# end

# # this is stupid, why should I need it
# @adjoint dot(x::StateVector, y::StateVector) = Zygote.pullback(dot, storage(x), storage(y))

