module VrpAnt

import Base.empty, Random.rand

include("City.jl")
include("Way.jl")
include("Solution.jl")
include("Map.jl")
include("Ant.jl")

# function empty!(antList::Vector{Ant})
#     antList = [empty!(ant) for ant in antList]
#     return antList
# end
#
# function init!(map::Map, antList::Vector{Ant})
#     return [init!(map, ant) for ant in antList]
# end
#
# function lap(map::Map, antList::Vector{Ant})
#     empty!(antList)
#     init!(map, antList)
#

# true if it has to stop, otherwise return false
function stopCondition!(map::Map, antList::Vector{Ant}, ind::Int64, NCmax::Int64)
    if ind > NCmax
        map.solution.state = NCEnding()
        return true
    elseif ind == 0
        return false
    else
        if reduce( & , [ant.lengthMade ≈ antList[1].lengthMade for ant in antList])
            map.solution.state = AntEnding()
            return true
        else
            return false
        end
    end
end


function optimize!(map::Map, m::Union{Nothing, Int64} = nothing, p::Float64 = 0.5, α::Real = 1, β::Real = 1, Q::Real = 100, NCmax::Int64 = 5000)
    m == nothing ? _optimize!(map, length(map.cities), p, α, β, Q, NCmax) : _optimize!(map, m, p, α, β, Q, NCmax)
    return map
end

function _optimize!(map::Map, m::Int64, p::Float64, α::Real, β::Real, Q::Real, NCmax::Int64)
    antList::Vector{Ant} = [Ant(map.cities) for loop = 1:m]
    ind::Int64 = 0

    while !stopCondition!(map, antList, ind, NCmax)

        if ind != 0
            for ant in antList
                wayBack!(map, ant, Q)
            end
        end
        updatePhero!(map, p)
        for ant in antList
            round!(ant, map)
        end
        ind += 1
    end

    updateSolution!(map, antList)
    return map
end


function updateSolution!(map::Map, antList::Vector{Ant})
    bestAnt::Ant = searchBestAnt(antList)

    map.solution.path = bestAnt.way
    map.solution.length = bestAnt.lengthMade

end

export optimize!

end  # module
