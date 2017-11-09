#!/usr/bin/env ruby

class StreetFighter2
  def initialize(code)
    @tokens = code.scan(/(波動拳|昇竜拳|竜巻旋風脚|ヨガフレイム|ﾀｲｶﾞｰｱﾊ|ソニックブーム|↓R↑LYBXA|↑X↓BLYRA)/).flatten
    @jumps = analyze_jumps(@tokens)
  end

  def run
    array = []
    index = 0
    now = 0

    while index < @tokens.size
      case @tokens[index]
        when "竜巻旋風脚"
          array[now] ||= 0
          array[now] += 1
        when "ヨガフレイム"
          array[now] ||= 0
          array[now] -= 1
        when "波動拳"
          now += 1
        when "昇竜拳"
          now -= 1
        when "ﾀｲｶﾞｰｱﾊ"
          n = (array[now] || 0)
          print n.chr
        when "ソニックブーム"
          array[now] = $stdin.getc
        when "↓R↑LYBXA"
          index = @jumps[index] if array[now] == 0
        when "↑X↓BLYRA"
          index = @jumps[index] if array[now] != 0
      end
      index += 1
    end
  end

  private

  def analyze_jumps(tokens)
    stack = []
    jumps = {}
    start_word = "↓R↑LYBXA"
    end_word = "↑X↓BLYRA"
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

StreetFighter2.new(ARGF.read).run
