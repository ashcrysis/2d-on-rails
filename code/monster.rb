class Unnamed
  attr_accessor :hp, :hpmax, :speed, :damage,:sprite

  def initialize(hp:,hpmax:,speed:,damage:,x:,y:)
    @sprite = Image.new("res/npcs/unnamed.png")
    @hp = hp
    @hpmax = hpmax
    sprite.z = 10
    @speed = speed
    @damage = damage
    @sprite.x = x
    @sprite.y = y
    @rotation_amount = 1
    @rotation_direction = 1
  end

  def move(player)
    if (player.square.x >= @sprite.x )
  ##
  # This Ruby function moves a sprite towards a player's position based on their x and y coordinates.
  #
  # Args:
  #   player: The `player` parameter in the `move` method seems to represent an object that has a
  # `square` attribute with `x` and `y` coordinates. The method uses these coordinates to move the
  # `@sprite` object towards the player's position based on the comparison of x and y coordinates
      @sprite.x += @speed
    end
    if (player.square.x <= @sprite.x )
      @sprite.x -= @speed
    end
    if (player.square.y >= @sprite.y )
      @sprite.y += @speed
    end
    if (player.square.y <= @sprite.y )
      @sprite.y -= @speed
    end
  end


end
