# encoding: utf-8
#
# Sentence segmentation based on a set of predefined
# rules that handle a large number of usage cases of
# sentence enders. The idea is to remove all cases of
# .!? being used for other purposes than marking a
# full stop before naively segmenting the text.
class Scalpel

  # Current version.
  VERSION = '0.2.1'

  # Segment a text using the Scalpel algorithm.
  # This will eventually be ported to a gem.
  def self.cut(text)

    # Get a copy of the string.
    text = text.to_s
    # Remove composite abbreviations.
    text.gsub!('et al.', '&&&')
    # Remove suspension points.
    text.gsub!('...', '&;&.')
    # Remove floating point numbers.
    text.gsub!(/([0-9]+)\.([0-9]+)/) { $1 + '&@&' + $2 }
    # Handle floats without leading zero.
    text.gsub!(/\s\.([0-9]+)/) { ' &#&' + $1 }
    # Remove abbreviations.
    text.gsub!(/(?:[A-Za-z]\.){2,}/) { |abbr| abbr.gsub('.', '&-&') }
    # Remove titles.
    text.gsub!(/[A-Z][a-z]{1,2}\./) { |title| title.gsub('.', '&*&') }
    # Unstick sentences from each other.
    text.gsub!(/([^.?!]\.|\!|\?)([^\s"'])/) { $1 + ' ' + $2 }
    # Remove sentence enders next to quotes.
    text.gsub!(/'([.?!])\s?"/) { '&^&' + $1 }
    text.gsub!(/'([.?!])\s?”/) { '&*&' + $1 }
    text.gsub!(/([.?!])\s?”/) { '&=&' + $1 }
    text.gsub!(/([.?!])\s?'"/) { '&,&' + $1 }
    text.gsub!(/([.?!])\s?'/) { '&%&' + $1 }
    text.gsub!(/([.?!])\s?"/) { '&$&' + $1 }
    # Remove sentence enders before parens.
    text.gsub!(/([.?!])\s?\)/) { '&€&' + $1 }
    # Split on any sentence ender.
    sentences = text.split(/([.!?])/)
    new_sents = []
    # Join the obtaine slices.
    sentences.each_slice(2) do |slice|
      new_sents << slice.join('')
    end
    # Repair the damage we've done.
    results = []
    new_sents.each do |sentence|
      # Skip whitespace zones.
      next if sentence.strip == ''
      # Repair composite abbreviations.
      sentence.gsub!('&&&', 'et al.')
      # Repair abbreviations.
      sentence.gsub!('&-&', '.')
      # Repair titles.
      sentence.gsub!('&*&', '.')
      # Repair suspension points.
      sentence.gsub!('&;&.', '...')
      # Repair floats.
      sentence.gsub!(/([0-9]+)&@&([0-9]+)/) { $1 + '.' + $2 }
      # Repair quotes with sentence enders
      sentence.gsub!(/&=&([.!?])/) { $1 + '”' }
      sentence.gsub!(/&,&([.!?])/) { $1 + "'\"" }
      sentence.gsub!(/&%&([.!?])/) { $1 + "'" }
      sentence.gsub!(/&\^&([.?!])/) { "'" + $1 + '"' }
      sentence.gsub!(/&\*&([.?!])/) { "'" + $1 + '”' }
      sentence.gsub!(/&\$&([.!?])/) { $1 + '"' }
      # Repair parens with sentence enders
      sentence.gsub!(/&€&([.!?])/) { $1 + ')' }
      # Repair floats without leading zeros.
      sentence.gsub!(/&#&([0-9]+)/) { '.' + $1 }
      results << sentence.strip
    end

    results

  end

end
