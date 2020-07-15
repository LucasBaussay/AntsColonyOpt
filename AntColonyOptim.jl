module VrpAnt

import Base.empty, Random.rand

include("City.jl")
include("Way.jl")
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
#
#


end  # module
