mutable struct City

    x::Float64
    y::Float64

    index::Int64
end

function distance(city_1::City, city_2::City)
    return sqrt( (city_1.x - city_2.x)^2 + (city_1.y - city_2.y)^2 )
end
