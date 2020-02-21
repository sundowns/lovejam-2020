-- Draws polygonal shapes to the screen
local renderer = Concord.system({_components.transform, _components.polygon})

function renderer:init()
  self.current_phase = nil
  self.colours = {
    ["RED"] = {1, 0, 0},
    ["BLUE"] = {0, 0, 1}
  }
end

function renderer:phase_update(new_phase)
  self.current_phase = new_phase
end

function renderer:draw()
  love.graphics.setLineWidth(2)
  for i = 1, self.pool.size do
    local e = self.pool:get(i)
    local transform = e:get(_components.transform)
    local position = transform.position
    local polygon = e:get(_components.polygon)

    local draw_mode = "fill"
    local phase = e:get(_components.phase)

    if phase then
      if self.current_phase ~= phase.current then
        draw_mode = "line"
      end

      love.graphics.setColor(self.colours[phase.current])
    end

    love.graphics.polygon(draw_mode, polygon:calculate_world_vertices(position))

    _util.l.resetColour()
  end

  love.graphics.setLineWidth(1)
  -- TODO: use multiple pools to draw the player manually last (on top of shapes)
end

return renderer
