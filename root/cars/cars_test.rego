package cars_test

import rego.v1

cardata := {
	"1000": {"make": "Toyota", "model": "Camry", "fuel": "petrol"},
	"1001": {"make": "Honda", "model": "Civic", "fuel": "petrol"},
	"1002": {"make": "Ford", "model": "Focus", "fuel": "diesel"},
	"1003": {"make": "Honda", "model": "CR-V", "fuel": "petrol"},
	"1004": {"make": "Renault", "model": "Clio", "fuel": "petrol"},
	"1005": {"make": "Nissan", "model": "Micra", "fuel": "diesel"},
	"1006": {"make": "Nissan", "model": "Qashqai", "fuel": "petrol"},
	"1007": {"make": "Renault", "model": "Captur", "fuel": "diesel"},
	"1008": {"make": "Renault", "model": "Scenic", "fuel": "electric"},
	"1009": {"make": "Nissan", "model": "Ariya", "fuel": "electric"},
	"1010": {"make": "Nissan", "model": "Leaf", "fuel": "electric"},
}

func_renault_models(fuel) := {modelinfo |
	some i
	cardata[i].make == "Renault"
	cardata[i].fuel == fuel
	# modelinfo := {"index": i, "model": cardata[i].model}
}

test_func_renissan if {
	results := func_renault_models("electric")
	some x in results
	x.model == "Scenic"
	every y in results {
		y.model != "Captur"
	}
}
