require 'ruby2d'
require_relative 'player'
require_relative 'monster'
require_relative 'slash'

set width: 1000
set height: 620
set fps_cap:60
set title: "what the fox say"

frame_count = 0
canHit = true
ded_list = []
slashes = []
enemy_list = []
slash_script = Slash.new

=begin

 This Ruby function checks if two objects are touching each other based on their coordinates and
 dimensions.

 Args:
  other_object: The `other_object` parameter represents another object in the game or application
  that we want to check if it is touching the `slash` object. The `slash` object is likely a weapon or
  a tool that can interact with other objects in the game world. The function `slash_touching` is
  slash: The `slash` parameter in the `slash_touching` method seems to represent an object that has
  properties `x`, `y`, `width`, and `height`. This object is likely used to determine if it is
  touching another object (`other_object`) based on their positions and dimensions.
=end
Image.new('res/scene/background.png')
player = Player.new(
  x: 400, y: 210,
  size: 50
)
unnamed = Unnamed.new(
  hp: 10,hpmax: 10,
  speed: 1,damage: 1,
  x: Random.rand(get :width), y: Random.rand(get :height)
)
enemy_list.push(unnamed)

rotation_amount = 1
rotation_direction = 1

frame_count = 0

# This `update` block in the Ruby code is responsible for handling the game logic and updating the game frame by frame

update do
  frame_count += 1
  unnamed.move(player)
  unnamed.sprite.rotate += rotation_direction * rotation_amount
  if frame_count >= 15
    if slashes.length > 0
      for i in 0...slashes.length
        if slashes[i]
          slashes[i].remove
        end
        if slash_script.slash_touching(unnamed.sprite,slashes[i])

          unnamed.sprite.rotate += 180
          unnamed.sprite.z = 1
          unnamed = Unnamed.new(
                hp: 10,hpmax: 10,
                speed: 1,damage: 1,
                x: Random.rand(get :width), y: Random.rand(get :height)
              )
        end
        slashes.delete(slashes[i])
      end
    end
    canHit = true
    frame_count = 0
      if unnamed.sprite.rotate >= rotation_amount || unnamed.sprite.rotate <= -rotation_amount
        rotation_direction *= -1
      end
  end
end

# These lines of code are setting up event handlers for keyboard input in the Ruby game.
on :key_held do |event|
  player.move(event)
end
on :key do |event|
  player.update_diagonal(event)
end

=begin
 This block of code in the Ruby program is handling the event when the mouse button is pressed down.
 It checks if the mouse button pressed is the left button and if the player is able to hit
 (controlled by the `canHit` variable). Depending on the direction the player is facing
 (`player.facing_direction`), it creates a new image object representing a slash in that direction.
 The image path for the slash is determined based on the player's facing direction. The created slash
 image is then positioned accordingly and added to the `slashes` array. Finally, it sets `canHit` to
 false to prevent immediate consecutive hits.
=end

on :mouse_down do |event|
  #puts event.x, event.y
  case event.button
  when :left
    if canHit
      if player.facing_direction == 'left'
        slash = Image.new("res/player/slashes/slash_esquerda.png")
          slash.z = 20
          slash.x = player.square.x - 200
          slash.y = player.square.y
          slashes.push(slash)
          canHit = false
      elsif player.facing_direction == 'right'
        slash = Image.new("res/player/slashes/slash_direita.png")
        slash_script.slash_recreate(slash,player,slashes)
      elsif player.facing_direction == 'down'
        slash = Image.new("res/player/slashes/slash_baixo.png")
        slash_script.slash_recreate(slash,player,slashes)
      elsif player.facing_direction == 'up'
        slash = Image.new("res/player/slashes/slash_cima.png")
        slash_script.slash_recreate(slash,player,slashes)
      end
    end
  end
end

show
