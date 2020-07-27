import Random

mutable struct Map

    cities::Vector{City}

    ways::Dict{City, Dict{City, Way}}

    solution::Solution

end

struct RandomCreation end

function Map()
    return Map(Vector{City}(), Dict{City, Dict{City, Way}}(), Solution())
end

#Is it better for Space complexity ? Time Complexity ? to not recrate space memory every time

# function Map(nbrVille)
#     return Map(Vector{City}(undef, nbrVille), Vector{Vector{Float64}}( undef, nbrVille ))
# end

# TODO : Find how to use the macro correctly

# TODO :
# - Precise  which city are connected to each other ! To make a perfect map
# - Give ptentially a set distance to each other city, like a Dict{City, distance}
#   Then if there isn't that : the distance are calculate by x^2 + y^2
#   else : the fixed one are used

function city!(map::Map, x::Float64, y::Float64, pheroInit::Float64=2.)

    nbrVille::Int64 = length(map.cities)
    city::City = City(x, y, nbrVille+=1)

    push!(map.cities, city)

    ways::Dict{City, Way} = Dict(map.cities[ind] => Way(distance(city, map.cities[ind]), pheroInit) for ind = 1:nbrVille)

    push!(map.ways, city => ways)

    return city
end

#TODO : Find how tu use the macro correctly

function Map(nbrVille::Int64, ::RandomCreation, borneX::Int64 = 50, borneY::Int64 = 50)
    m = Map()
    for ind = 1:nbrVille
        cityX = borneX*rand()
        cityY = borneY*rand()
        city!(m, cityX, cityY)
    end
    return m
end

function updatePhero!(map::Map, p::Float64)
    for dictWays in collect(values(map.ways))
        for way in collect(values(dictWays))
            way.phero *= p
        end
    end
    return map
end
