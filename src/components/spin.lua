local spin =
  Concord.component(
  function(e, speed)
    e.speed = speed or 0
  end
)

return spin
