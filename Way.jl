mutable struct Way

    lenght::Float64
    pheromone::Float64

end

function Way(length::Float64, pheromone::Float64)
    return Way(length, pheromone)
end
