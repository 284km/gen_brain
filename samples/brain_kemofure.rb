#!/usr/bin/env ruby

class BrainKemofure
  def initialize(code)
    @tokens = code.scan(/(わーい|すごーい|たーのしー|あなたは何のフレンズさんですか？|われわれはかしこいので|どうもどうもありがとう|食べないでください|食べないよ)/).flatten
    @jumps = analyze_jumps(@tokens)
  end

  def run
    array = []
    index = 0
    now = 0

    while index < @tokens.size
      case @tokens[index]
        when "たーのしー"
          array[now] ||= 0
          array[now] += 1
        when "あなたは何のフレンズさんですか？"
          array[now] ||= 0
          array[now] -= 1
        when "わーい"
          now += 1
        when "すごーい"
          now -= 1
        when "われわれはかしこいので"
          n = (array[now] || 0)
          print n.chr
        when "どうもどうもありがとう"
          array[now] = $stdin.getc
        when "食べないでください"
          index = @jumps[index] if array[now] == 0
        when "食べないよ"
          index = @jumps[index] if array[now] != 0
      end
      index += 1
    end
  end

  private

  def analyze_jumps(tokens)
    stack = []
    jumps = {}
    start_word = "食べないでください"
    end_word = "食べないよ"
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

BrainKemofure.new(ARGF.read).run
