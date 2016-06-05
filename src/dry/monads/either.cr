module Dry::Monads
  class Either
    getter right, left

    def ==(other : T)
      other.is_a?(Either) && right == other.right && left == other.left
    end

    def right?
      is_a? Right
    end

    def success?
      right?
    end

    def left?
      is_a? Left
    end

    def failure?
      left?
    end

    class Right(T) < Either
      @left : Nil

      def initialize(@right : T)
      end

      def bind(proc : Proc)
        proc.call(@right)
      end

      def bind(&block)
        yield(@right)
      end

      def fmap(proc : Proc)
        Right.new(bind(proc))
      end

      def fmap(&block)
        Right.new(yield(@right))
      end

      def or(val : T)
        self
      end

      def or(&block)
        self
      end
    end

    class Left(T) < Either
      @right : Nil

      def initialize(@left : T)
      end

      def bind(proc : Proc)
        self
      end

      def bind(&block)
        self
      end

      def fmap(proc : Proc)
        self
      end

      def fmap(&block)
        self
      end

      def or(val : T)
        val
      end

      def or(&block)
        yield(@left)
      end
    end
  end
end
