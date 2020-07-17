mutable struct Way
    lenght::Float64
    pheromone::Float64

    probabilitie::Float64

end

struct ProbaChange end

function Way(length::Float64, pheromone::Float64)
    return Way(length, pheromone, undef)
end

function set(way::Way, ::ProbaChange, probabilitie::Float64)
    way.probabilitie = probabilitie
end

function reset!(way::Way, ::ProbaChange)
    way.probabilitie = undef
end
