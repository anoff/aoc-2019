#!/usr/bin/ruby

def split_to_layers(data, width, height)
  pixels_per_layer = width * height
  if data.length % pixels_per_layer != 0
    raise "Image data of length %d does not fit format of %dx%d" % [data.length, width, height]
  end
  layers = data.chars.each_slice(pixels_per_layer)
    .map(&:join)
    .map{|layer|
      layer.chars.each_slice(width).map(&:join)
    }
end

def part1(data)
  layers = split_to_layers(data, 25, 6)
  min_zero_index = layers
    .map{|layer|
      layer.join("").count("0")
    }
    .each_with_index
    .min[1]
  one_count = layers[min_zero_index].join("").count("1")
  two_count = layers[min_zero_index].join("").count("2")
  one_count * two_count
end

def merge_layers(layers)
  out = Array.new
  for y in 0..(layers[0].length-1)
    line = ""
    for x in 0..(layers[0][0].length-1)
      layer_ix = 0
      while (color = layers[layer_ix][y][x]) == "2" && layer_ix < layers.length
        # puts "layer:%d y:%d x:%d -> %s" % [layer_ix, y, x, color]
        layer_ix += 1
      end
      line += color
    end
    out.push(line)
  end
  out
end
def part2(data)
  layers = split_to_layers(data, 25, 6)
  image = merge_layers(layers)
  image.each{|line| puts line}
end

if caller.length == 0
  input = File.read("./input.txt")
  puts "Solution for part1: %d" % part1(input)
  puts "Solution for part2"
  part2(input)
end