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

ExplosionParticle = Particle
  .make_new(
    init: -> {
      @lifetime = 120
      t = rand * 6.28318530717958647693
      @coef = rand

      rot = @coef * 2.09439510239319549231 / 9 * 4

      cos = Math.cos(rot)
      scos = 1 - cos
      sin = Math.sin(rot)
      ot = 1.0 / 3.0
      sot = Math.sqrt(ot)

      a1 = ot * scos + sot * sin
      a2 = ot * scos - sot * sin
      # a3 = cos + ot * scos
      a4 = cos + scos / 3.0

      # @r = 0xff
      # @g = 0
      # @b = 0

      # _r = @r * a4 + @g * a2 + @b * a1
      # _g = @r * a1 + @g * a3 + @b * a2
      # _b = @r * a2 + @g * a1 + @b * a4

      @_r = @r = (0xff * a4).clamp(0, 255)
      @_g = @g = (0xff * a1).clamp(0, 255)
      @_b = @b = (0xff * a2).clamp(0, 255)

      @dx = Math.cos(t) * 10 * @coef
      @dy = Math.sin(t) * 10 * @coef

      @w = 20
      @h = 20
    }
  ) { |args|
    @x += @dx
    @y += @dy
    @dx *= 0.975
    @dy *= 0.975
    @r = @_r * (@lifetime / @_lifetime)
    @g = @_g * (@lifetime / @_lifetime)
    @b = @_b * (@lifetime / @_lifetime)
  }

$ps ||= ParticleSet.new

def tick(args)
  args.outputs.background_color = [128] * 3
  $ps << 16.map { ExplosionParticle.new(640, 360) }
  $ps.tick(args)
  args.outputs.sprites << $ps
end
