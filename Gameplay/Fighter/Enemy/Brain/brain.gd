class_name Brain extends Node2D

enum personality {
	AGGRESSIVE, # chases closest player
	REVENGE_LAST_DEATH, # attacks whoever killed them last
	REVENGE_MOST_DAMAGED, # attacks whoever has hurt them the most
	FINISHER, # targest player with lowest health
	AVENGE, # attacks who k illed teammate last
	SAFE, # tries to stay away from edges and stay middle of map
	RANGED, # tries to keep a distance
	DEFENSIVE, # likes to use shields and dodge
	HIDING, # runs away/hides
}


static func global_position_difference(node: Node2D, brain_parent: Node2D) -> Vector2:
	if node != null:
		return node.global_position - brain_parent.global_position
	return Vector2.ZERO


static func get_distance(node: Node2D, brain_parent: Node2D) -> float:
	return global_position_difference(node, brain_parent).length()


static func get_direction(node: Node2D, brain_parent: Node2D) -> Vector2:
	return global_position_difference(node, brain_parent).normalized()


static func set_target(parent: EnemyFighter) -> Node2D:
	#Could return player, item, safe area, high ground, item, ledge, etc.
	#we will change this based on personality and other factors like
	#proximity to players/items or current health or position (like falling of ledge)
	return closest_player(parent)

static func closest_player(brain_parent: EnemyFighter) -> Fighter:
	var closest_player_fighter: PlayerFighter = null
	var closest_distance: float = 0.0

	for player in brain_parent.players:
		if closest_player_fighter == null:
			closest_player_fighter = player;
			closest_distance = get_distance(player, brain_parent)
		else:
			var distance = get_distance(player, brain_parent)
			if distance < closest_distance:
				closest_player_fighter = player
				closest_distance = distance
	return closest_player_fighter
