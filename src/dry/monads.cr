require "./monads/*"

module Dry::Monads
  extend self

  def maybe(value : T)
    Maybe.lift(value)
  end

  def some(value : T)
    Maybe::Some.new(value)
  end

  def none
    Maybe::None.instance
  end

  def right(value : T)
    Either::Right.new(value)
  end

  def left(value : T)
    Either::Left.new(value)
  end
end
