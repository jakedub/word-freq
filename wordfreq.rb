class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @data = File.read(filename).downcase
    @data.gsub!(/[^a-z0-9\s]/i, ' ')
    STOP_WORDS.each do |word|
      @data.gsub!(/\b(?:#{word})\b/, '')
    end
    puts @data
  end

#\b is the boundary
  def frequency(word)
    counter = @data.scan(/\b(?:#{word})\b/).count
    puts counter
  end

# Hash.new is the same as {}
  def frequencies
    @f_array = @data.split(' ')

    @counts = Hash.new 0

    @f_array.each do |word|
      @counts[word] += 1
    end
    @counts
  end

# take returns the number of values based on user input
  def top_words(number)
    sorted_freq = frequencies.sort_by {|_word, freq| freq}
    sorted_freq.reverse!
    freq_array = []
    sorted_freq.each do |word, freq|
      freq_array << [word, freq]
    end
    freq_array.take(number)
  end

  def print_report
    top_words(10).each do |word, number|
      puts "#{word} | #{number}" + '*' * number
    end
  end

end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
