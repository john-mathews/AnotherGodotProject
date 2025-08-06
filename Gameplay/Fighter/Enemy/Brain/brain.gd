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


static func global_position_difference(node_pos: Vector2, brain_parent_pos: Vector2) -> Vector2:
	if node_pos != null:
		return node_pos - brain_parent_pos
	return Vector2.ZERO


static func get_distance(node_pos: Vector2, brain_parent_pos: Vector2) -> float:
	return global_position_difference(node_pos, brain_parent_pos).length()


static func get_direction(node_pos: Vector2, brain_parent_pos: Vector2) -> Vector2:
	return global_position_difference(node_pos, brain_parent_pos).normalized()


static func set_target(parent: EnemyFighter) -> Node2D:
	#Could return player, item, safe area, high ground, item, ledge, etc.
	#we will change this based on personality, goals, and other factors like
	#proximity to players/items or current health or position (like falling of ledge)
	var closest = closest_player(parent)
	return closest

static func set_target_pos(parent: EnemyFighter) -> Vector2:
	var buffer: float = parent.buffer_distance
	var min_dist: float = 50.0
	if parent.current_target_distance < buffer && parent.current_target_distance > min_dist:
		return parent.global_position
	
	return parent.current_target.global_position - (parent.current_target_dir * buffer)


static func closest_player(brain_parent: EnemyFighter) -> Fighter:
	var closest_player_fighter: PlayerFighter = null
	var closest_distance: float = 0.0

	for player in brain_parent.players:
		if closest_player_fighter == null:
			closest_player_fighter = player;
			closest_distance = get_distance(player.global_position, brain_parent.global_position)
		else:
			var distance = get_distance(player.global_position, brain_parent.global_position)
			if distance < closest_distance:
				closest_player_fighter = player
				closest_distance = distance
	brain_parent.current_target_distance = closest_distance
	return closest_player_fighter
