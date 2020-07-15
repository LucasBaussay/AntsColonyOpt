import Random

mutable struct Map
    cities::Vector{City}
    ways::Dict{City, Dict{City, Way}}
end

function Map()
    return Map(Vector{City}(), Dict{City, Dict{City, Way}}())
end

# function Map(nbrVille)
#     return Map(Vector{City}(undef, nbrVille), Vector{Vector{Float64}}( undef, nbrVille ))
# end

#TODO : Find how tu use the macro correctly

function city!(map::Map, x::Float64, y::Float64, pheroInit::Float64=1.)

    nbrVille::Int64 = length(map.cities)
    city::City = City(x, y, nbrVille+=1)

    push!(map.cities, city)

    ways::Dict{City, Way} = Dict(map.cities[ind] => Way(distance(city, map.cities[ind]), pheroInit) for ind = 1:nbrVille)

    push!(map.ways, city => ways)

    return city
end # macro

#TODO : Find how tu use the macro correctly

function Map(nbrVille::Int64, borneX::Int64 = 50, borneY::Int64 = 50)
    m = Map()
    for ind = 1:nbrVille
        cityX = borneX*rand()
        cityY = borneY*rand()
        city!(m, cityX, cityY)
    end
    return m
end
