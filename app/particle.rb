class Particle
  def self.make_new(init: -> {  }, render_override: nil, &behavior)
    klass = Class.new(Particle)
    klass.send(:define_method, :init, &init)
    klass.send(:define_method, :draw_override, &render_override) if render_override
    klass.send(:define_method, :tickp, &behavior)
    klass
  end

  def initialize(x = 0, y = 0, lifetime = nil)
    @dead = false
    @x = x
    @y = y
    @w = 2
    @h = 2
    @lifetime = lifetime
    @immortal = false

    init

    @_lifetime = @lifetime
  end

  def kill
    @dead = true
  end

  attr_reader :dead
  alias_method :dead?, :dead
  undef_method :dead

  def init
  end

  def tick(args)
    tickp(args)
    @lifetime -= 1
    @dead ||= (@lifetime <= 0 && !@immortal)
  end

  def draw_override(ffi)
    ffi.draw_sprite_3(
      @x - @w / 2,
      @y - @h / 2,
      @w,
      @h,
      "pixel",
      0,
      @a,
      @r,
      @g,
      @b,
      *[nil] * 12
    )
  end

  def tickp(args = nil)
    raise(
      NotImplementedError,
      <<~RUBY
        please override this method in subclasses
        example implementation:

        def tickp(args)
          # your code here
          __tickp() # optional if you know what you're doing
        end
      RUBY
    )
  end
end
