module GenBrain
  class Generator
    attr_accessor :title, :p_inc, :p_dec, :v_inc, :v_dec,
      :output, :input, :jump_forward, :jump_back

    def initialize(config)
      @title = config["title"]
      @p_inc = config["p_inc"]
      @p_dec = config["p_dec"]
      @v_inc = config["v_inc"]
      @v_dec = config["v_dec"]
      @output= config["output"]
      @input = config["input"]
      @jump_forward = config["jump_forward"]
      @jump_back = config["jump_back"]
    end

    def words
      [
        p_inc,
        p_dec,
        v_inc,
        v_dec,
        output,
        input,
        jump_forward,
        jump_back
      ].map{|word|Regexp.escape(word)}.join('|')
    end

    def call
      File.write("#{title}.rb", lang)
      File.write("#{title}_hello_world", hello_world_input_sample)
      puts "🎉 Created #{title}.rb and #{title}_hello_world"
      puts "🌈 Let's execute the following code!!"
      puts "#=> ruby #{title}.rb #{title}_hello_world"
    end

    def lang
      class_name = title.split(/[^[:alnum:]]+/).map(&:capitalize).join
<<TEMPLATE
#!/usr/bin/env ruby

class #{class_name}
  def initialize(code)
    @tokens = code.scan(/(#{words})/).flatten
    @jumps = analyze_jumps(@tokens)
  end

  def run
    array = []
    index = 0
    now = 0

    while index < @tokens.size
      case @tokens[index]
        when "#{v_inc}"
          array[now] ||= 0
          array[now] += 1
        when "#{v_dec}"
          array[now] ||= 0
          array[now] -= 1
        when "#{p_inc}"
          now += 1
        when "#{p_dec}"
          now -= 1
        when "#{output}"
          n = (array[now] || 0)
          print n.chr
        when "#{input}"
          array[now] = $stdin.getc
        when "#{jump_forward}"
          index = @jumps[index] if array[now] == 0
        when "#{jump_back}"
          index = @jumps[index] if array[now] != 0
      end
      index += 1
    end
  end

  private

  def analyze_jumps(tokens)
    stack = []
    jumps = {}
    start_word = "#{jump_forward}"
    end_word = "#{jump_back}"
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

#{class_name}.new(ARGF.read).run
TEMPLATE
    end

    def hello_world_input_sample
      "+++++++++[>++++++++>+++++++++++>+++++<<<-]>.>++.+++++++..+++.>-.------------.<++++++++.--------.+++.------.--------.>+.".
        gsub(/\>/, p_inc).
        gsub(/\</, p_dec).
        gsub(/\+/, v_inc).
        gsub(/\-/, v_dec).
        gsub(/\./, output).
        gsub(/\,/, input).
        gsub(/\[/, jump_forward).
        gsub(/\]/, jump_back)
    end
  end
end
