class ParticleSet
  def initialize(particles = [])
    @particles = particles
  end

  def tick(args)
    @particles.each { _1.tick(args) }.reject!(&:dead?)
  end

  def <<(particle)
    @particles << particle
    self
  end

  def draw_override(ffi)
    @particles.each { _1.draw_override(ffi) }
  end
end
