#!/usr/bin/env ruby

class BrainSample
  def initialize(code)
    @tokens = code.scan(/(>|<|\+|\-|\.|,|\[|\])/).flatten
    @jumps = analyze_jumps(@tokens)
  end

  def run
    array = []
    index = 0
    now = 0

    while index < @tokens.size
      case @tokens[index]
        when "+"
          array[now] ||= 0
          array[now] += 1
        when "-"
          array[now] ||= 0
          array[now] -= 1
        when ">"
          now += 1
        when "<"
          now -= 1
        when "."
          n = (array[now] || 0)
          print n.chr
        when ","
          array[now] = $stdin.getc
        when "["
          index = @jumps[index] if array[now] == 0
        when "]"
          index = @jumps[index] if array[now] != 0
      end
      index += 1
    end
  end

  private

  def analyze_jumps(tokens)
    stack = []
    jumps = {}
    start_word = "["
    end_word = "]"
    tokens.each_with_index do |v,i|
      if v == start_word
        stack.push(i)
      elsif v == end_word
        from = stack.pop
        to = i
        jumps[from] = to
        jumps[to] = from
      end
    end
    jumps
  end
end

BrainSample.new(ARGF.read).run
