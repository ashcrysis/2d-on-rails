class Slash
  def slash_touching(other_object,slash)
    if slash
      slash.x < other_object.x + other_object.width &&
      slash.x + slash.width > other_object.x &&
      slash.y < other_object.y + other_object.height &&
      slash.y + slash.height > other_object.y
      end
  end

  def slash_recreate(slash,player,slashes)
    slash.z = 20
    slash.x = player.square.x
    slash.y = player.square.y
    slash.width = player.square.width
    slashes.push(slash)
    canHit = false
  end
end
