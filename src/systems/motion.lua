local motion = Concord.system({_components.transform})

function motion:init()
  self.obstacle_min_x = nil
  self.obstacle_max_x = nil
  self.obstacle_min_y = nil
  self.obstacle_max_y = nil
  self:calculate_obstacle_dead_zones(love.graphics.getWidth(), love.graphics.getHeight())
end

function motion:update(dt)
  local to_remove = {}
  for i = 1, self.pool.size do
    local e = self.pool:get(i)
    local transform = e:get(_components.transform)
    transform.position = transform.position + transform.velocity * dt
    if e:has(_components.control) then
      self:enforce_boundaries(transform)
    elseif self:remove_out_of_bound_obstacles(e) then
      table.insert(to_remove, e)
    end
  end

function motion:player_collided()
  self:disable()
end

function motion:onEntityAdded(e)
  for i, entity in ipairs(to_remove) do
    self:getWorld():removeEntity(entity)
  end
end

function motion:enforce_boundaries(transform)
  -- horizontal
  local x_min = love.graphics.getWidth() / _constants.PLAYER.SIZE
  local x_max = love.graphics.getWidth() - x_min
  if transform.position.x > x_max then
    transform.position.x = x_max
    transform.velocity.x = 0
  elseif transform.position.x < x_min then
    transform.position.x = x_min
    transform.velocity.x = 0
  end

  -- vertical
  local y_min = love.graphics.getHeight() / _constants.PLAYER.SIZE
  local y_max = love.graphics.getHeight() - y_min
  if transform.position.y > y_max then
    transform.position.y = y_max
    transform.velocity.y = 0
  elseif transform.position.y < y_min then
    transform.position.y = y_min
    transform.velocity.y = 0
  end
end

function motion:remove_out_of_bound_obstacles(e)
  local position = e:get(_components.transform).position
  if position.x < self.obstacle_min_x then
    return true
  end
  if position.x > self.obstacle_max_x then
    return true
  end
  if position.y < self.obstacle_min_y then
    return true
  end
  if position.y > self.obstacle_max_y then
    return true
  end

  return false
end

function motion:calculate_obstacle_dead_zones(screen_w, screen_h)
  self.obstacle_min_x = -_constants.REMOVE_OBSTACLES_BUFFER_DISTANCE
  self.obstacle_max_x = screen_w + _constants.REMOVE_OBSTACLES_BUFFER_DISTANCE
  self.obstacle_min_y = -_constants.REMOVE_OBSTACLES_BUFFER_DISTANCE
  self.obstacle_max_y = screen_h + _constants.REMOVE_OBSTACLES_BUFFER_DISTANCE
end

function motion:resize(w, h)
  self:calculate_obstacle_dead_zones(w, h)
end

return motion
