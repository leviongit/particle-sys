SimpleParticle = Particle.make_new(
  init: -> {
    @lifetime = 120
    t = rand * 6.28318530717958647693
    @dx = Math.cos(t) * 5
    @dy = Math.sin(t) * 5
  }
) { |args|
  @x += @dx
  @y += @dy
  @dx *= 0.97
  @dy *= 0.97
}

$ps ||= ParticleSet.new

def tick(args)
  args.outputs.background_color = [0] * 3
  $ps << SimpleParticle.new(640, 360)
  $ps.tick(args)
  args.outputs.sprites << $ps
end
