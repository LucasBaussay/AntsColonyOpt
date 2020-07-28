# Attention changement de patrmaetre a vérifier sur tout les appels

mutable struct Ant

	way::Vector{City}
	lengthMade::Float64
	notWay::Vector{City}

end

function Ant(cities::Vector{City})

	ant = Ant(Vector{City}(), 0., cities[:])

	city = rand(cities)

	push!(ant.way, city)
	filter!(notCity -> notCity != city, ant.notWay)

	return ant

end


# Find how to empty ant.way
function empty!(ant::Ant, cities::Vector{City})

	firstCity::City = ant.way[1]
	ant.way = Vector{City}()
	push!(ant.way, firstCity)

	ant.lengthMade = 0.
	ant.notWay = filter(city -> city != firstCity, cities)

	return ant

end

function addCity!(ant::Ant, city::City, way::Way)

	push!(ant.way, city)
	ant.lengthMade += way.length
	filter!(notCity -> notCity != city, ant.notWay)

end

function calcTotal(ways::Dict{City, Way}, α::Real = 0.5, β::Real = 0.5)

	total::Float64 = 0.
	values = values(ways)
	for way in values
		total += way.pheromone^α * way.length^(-β)
	end

	return total

end

function calcProba(ant::Ant, way::Way, total::Float64, α::Real = 0.5, β::Real = 0.5)
	return way.pheromone^α * way.length^(-β) / total
end

function chooseCity(map::Map, ant::Ant)

	city::City = ant.way[length(ant.way)]
	# dictProba::Dict{City, Float64} = Dict{City, Float64}()

	#TODO : Which ways ?
	total::Float64 = calcTotal(ways::Dict{City, Way}) #Ther is an error here # MDR

	maxProba::Float64 = 0.
	nextCity = nothing
	nextWay = nothing

	for potentialCity in ant.notWay
		way::Way = map.ways[city][potentialCity]

		proba = calcProba(ant, way, total)
		if maxProba < proba
			maxProba = proba
			nextCity = potentialCity
			nextWay = way
		end
	end

	return potentialCity, nextWay

end

# TODO : Find how tu use the macro correctly

function round!(ant::Ant, map::Map)
	empty!(ant, map.cities)
	nbVille = length(map.cities)
	print(nbVille, "\n")
	for ind = 1:nbVille-1
		nextCity, nextWay = chooseCity(map, ant)
		addCity!(ant, nextCity, nextWay)
	end
	firstCity = ant.way[1]
	addCity!(ant, firstCity, map.ways[nextCity][firstCity])
	return ant

end

function wayBack!(map::Map, ant::Ant, Q::Real)

	for idTown = 1:length(ant.way)-1
		city = ant.way[idTown]
		nextCity = ant.way[idTown+1]

		if firstCity.index > lastCity.index
			way = map.ways[firstCity][lastCity]
		else
			way = map.ways[lastCity][firstCity]
		end

		way.pheromone += Q/ant.lengthMade
	end
	firstCity = ant.way[1]
	lastCity = ant.way[length(ant.way)]

	if firstCity.index > lastCity.index
		way = map.ways[firstCity][lastCity]
	else
		way = map.ways[lastCity][firstCity]
	end

	way.pheromone += Q/ant.lengthMade

end

function searchBestAnt(antList::Vector{Ant})
	bestAnt::Ant = antList[1]
	for ant in antList
		if ant.lengthMade < bestAnt.lengthMade
			bestAnt = ant
		end
	end
	return bestAnt
end
