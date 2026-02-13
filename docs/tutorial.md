---
title: Snake Game Tutorial
---

# Snake Game in Godot 3



## Dein Ziel

In this tutorial, you will learn how to create a simple Snake game in **Godot 3** using **GDScript**.
You will implement grid movement, apple spawning, snake growth, collision detection, and game over logic.

## Benötigtes Vorwissen

You already know the basics of Godot (scenes/nodes), and basic programming in GDScript:
variables, functions, arrays (lists), if / else, loops, and how to run a scene.

## Concepts

In this tutorial, we focus on:

- Creating classes using `class_name`
- Movement with `Vector2`
- Collision detection
- A timer-based game loop

---

## Movement (Snake.move)

```gdscript
func move():
	if is_apple_colide:
		body_copy = body.slice(0, body.size() - 1)
		is_apple_colide = false
	else:
		body_copy = body.slice(0, body.size() - 2)

	var new_head = body_copy[0] + direction
	body_copy.insert(0, new_head)
	body = body_copy
```

The snake moves by calculating a new head position and updating the body accordingly.

---

## Input Handling

```gdscript
func _input(_event):
	if Input.is_action_pressed("ui_right"):
		snake.direction = Vector2(snake.width, 0)
```




