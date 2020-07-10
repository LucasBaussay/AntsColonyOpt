mutable struct Ant

	way::Vector{Int}
	lengthMade::Float

end

function Ant(nbVille::Int)
	return Ant(Vector{Int}(undef, nbVille), 0.)
end
