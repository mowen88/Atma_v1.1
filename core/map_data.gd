extends Node

# --- STATIC WORLD CONFIGURATION MATRIX ---
const MAP_DATA= {
	"a_01": {
		1: "b_01",
		2: "c_01"
	},
	"b_01": {
		1: "a_01",
		2: "c_01"
	},
	"c_01": {
		1: "b_01",
		2: "a_01"
	}
}
