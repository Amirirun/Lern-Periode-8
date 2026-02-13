---
title: Snake Game Tutorial
---

# Snake Game in Godot 3



## Your Goal

In this tutorial, you will learn how to create a simple Snake game in **Godot 3** using **GDScript**.
You will implement grid movement, apple spawning, snake growth, collision detection, and game over logic.

## What you need to know

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
The snake’s direction is controlled using the arrow keys.

![Aufzeichnung 2026-02-13 105034](https://github.com/user-attachments/assets/a57d1622-86bd-4873-9ba6-a7bfe761ad0a)


## Common Issues

One common issue is incorrect coordinate calculations.  
Make sure the snake moves exactly in grid steps using the same `width` value everywhere (for example `40`). If the coordinates are inconsistent, the snake and apple positions will not align properly.

Another frequent mistake is downloading **Godot 4 instead of Godot 3**.  
This project is written for **Godot 3**, and some code (like `rect_position` or certain APIs) will not work correctly in Godot 4.

