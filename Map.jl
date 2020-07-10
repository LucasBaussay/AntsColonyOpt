mutable struct Map
    cities::Vector{City}
end

macro city(map::Map, x::Float, y::Float)
    city = City(x, y)
    append!(map.cities, city) 
    return city
end # macro
