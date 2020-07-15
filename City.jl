mutable struct City
    x::Float64
    y::Float64

    index::Int64

end

# import Base
# Base.length(::City) = 1
# Base.iterate(c::City) = (c, nothing)
# Base.isequal(c1::City, c2::City) =  c1.index==c2.index && c1.x==c2.x && c1.y==c2.y

function distance(city_1::City, city_2::City)
    return sqrt( (city_1.x - city_2.x)^2 + (city_1.y - city_2.y)^2 )
end
