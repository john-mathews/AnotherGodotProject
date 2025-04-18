class_name Utils extends Node

static func closest_to_zero(arr: Array[float]):
	var lowest: float
	for num in arr:
		if !lowest || abs(num) < abs(lowest):
			lowest = num
	return lowest

static func farthest_from_zero(arr: Array[float]):
	var highest: float
	for num in arr:
		if !highest || abs(num) > abs(highest):
			highest = num
	return highest
