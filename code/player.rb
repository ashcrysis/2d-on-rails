class Player
  attr_accessor :square, :player_speed, :diag_player_speed, :diagonal, :facing_direction

  def initialize(x:, y:, size:)
    @square = Image.new("res/player/char.png")
    square.z = 11
    square.x = x
    square.y = y
    @player_speed = 3
    @diag_player_speed = player_speed * 0.7
    @diagonal = false
    @facing_direction = 'right'
  end


  def move(event)
    case event.key
    when 'w'
      diagonal ? square.y -= diag_player_speed : square.y -= player_speed
      @facing_direction = 'up'
    when 'a'
      diagonal ? square.x -= diag_player_speed : square.x -= player_speed
      @facing_direction = 'left'
      if square.width > 0
          square.width = -square.width
          square.x -= square.width
      end
    when 'd'
      diagonal ? square.x += diag_player_speed : square.x += player_speed
      @facing_direction = 'right'
      if square.width < 0
          square.width = -square.width
          square.x -= square.width
      end
    when 's'
      diagonal ? square.y += diag_player_speed : square.y += player_speed
      @facing_direction = 'down'
    end
  end

  def is_touching(other_object)
    self.square.x < other_object.x + other_object.width &&
    self.square.x + self.square.width > other_object.x &&
    self.square.y < other_object.y + other_object.height &&
    self.square.y + self.square.height > other_object.y
  end


  def update_diagonal(event)
    self.diagonal = case event.key
      when 'up' && 'right'
        diagonal = true
      when 'up' && 'left'
        diagonal = true
      when 'down' && 'right'
        diagonal = true
      when 'down' && 'left'
        diagonal = true
      else
        diagonal = false
      end
  end
end
