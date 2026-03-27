---
title: My Snake Game Tutorial
---

# Goal

In this tutorial, you will learn how to create a simple Snake game using the Godot Engine and GDScript.  
By the end of this tutorial, you will understand how to handle movement, collisions, and basic game logic.

---

# Previous Knowledge

We'll assume you already know the basics of programming, such as:

- Variables (`var`)
- Functions (`func`)
- Basic logic (if-statements, loops)

It is also helpful if you have a basic understanding of Godot, including:

- Nodes and scenes  
- Attaching scripts to nodes  

---

# What you'll learn

In this tutorial, you will learn:

- How to create a Snake game structure  
- How to move the snake using input  
- How to spawn objects (apple) randomly  
- How to detect collisions  
- How to keep track of a score  
- How to store data (like score) in a database  

---

# Tutorial

## Step 1: Create the Snake

First, we create a snake object that stores its body and movement direction:

```gdscript
var snake = []
var direction = Vector2(20, 0)

The snake is represented as a list of positions.

Step 2: Move the Snake

We update the snake's position every frame:

func move():
    var new_head = snake[0] + direction
    snake.insert(0, new_head)
    snake.remove(snake.size() - 1)

This moves the snake forward.

Step 3: Spawn an Apple

We generate a random position:

func get_random_pos():
    var x = (randi() % 20) * 20
    var y = (randi() % 20) * 20
    return Vector2(x, y)
Step 4: Detect Collision

We check if the snake eats the apple:

if snake[0] == apple_position:
    print("Apple eaten!")
Step 5: Increase Score
var score = 0

score += 1
print("Score:", score)
Step 6: Save Score to Database

We store the score using SQLite:

var dict = {"Name": "Player", "Score": score}
db.insert_row("PlayerInfo", dict)
Result
```
<img width="814" height="1176" alt="image" src="https://github.com/user-attachments/assets/5eee9c20-bbde-44af-b779-678ba4651f5c" />

At the end of this tutorial, you will have a fully working Snake game where:

The snake moves smoothly
Apples spawn randomly
The score increases when eating apples
The score is saved in a database




What could go wrong?


Here are some common problems:

 Snake does not move → Input handling is wrong
 Apple spawns inside snake → Random logic needs fixing
 Game crashes → Missing nodes or wrong paths
 Database not working → Wrong file path (res:// vs user://)
 Score not saving → Table name or columns incorrect




