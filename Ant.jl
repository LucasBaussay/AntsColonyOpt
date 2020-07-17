mutable struct Ant

	way::Vector{City}
	lengthMade::Float64

end

function Ant(nbVille::Int64)
	return Ant(Vector{City}(), 0.)
end

function empty!(ant::Ant)
	empty!(way)
	ant.lengthMade = 0.
	return ant
end

function init!(cities::Vector{City}, ant::Ant)
	push!(ant.way, rand(cities))
	return ant
end

function chooseCity!(map::Map, ant::Ant)
	city = ant.way[length(ant.way)]
	dictProba = Dict{City, Float64}()
	for potentialCity in map.cities
		way = map.ways[city][potentialCity]

end

function round!(map::Map, ant::Ant)
	empty!(ant)
	init!(map.cities, ant)

	nbVille = length(map.cities)
	for ind = 1:nbVille-1
		chooseCity!(map, ant)

	while
end



function wayBack!(map::Map, ant::Ant, Q::Number = 100.)
	for idTown = 1:length(ant.way)-1
		city = ant.way[idTown]
		nextCity = ant.way[idTown+1]

		way = map.ways[city.index > nextCity.index ? city : nextCity]

		way.pheromone += Q/ant.lengthMade
	end
	firstCity = ant.way[1]
	lastCity = ant.way[length(ant.way)]

	way = map.ways[firstCity.index > lastCity.index ? firstCity : lastCity]

	way.pheromone += Q/ant.lengthMade

end
