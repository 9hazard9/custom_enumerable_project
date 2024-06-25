module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    self.each {|el| yield el}
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0

    self.each_with_index do |el|
      yield el, i
      i += 1
    end
  end

  def my_select
    result = []

    if block_given?
      self.select {|el| result << el if yield(el)} 
      result
    else
      self
    end
  end

  def my_all?
    self.all? {|el| yield(el)}
  end

  def my_any?
    self.any? {|el| yield(el)}
  end

  def my_none?
    self.none? {|el| yield(el)}
  end

  def my_count
    return self.count unless block_given?
    
    counter = 0

    my_each {|el| counter += 1 if yield(el)}

    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    lam = -> (el) { yield(el) }
    my_each { |el| result << lam.call(el) }
    result
  end

  def my_inject accumulator = nil
    self.size.times do |index|
      if accumulator == nil && index == 0
        accumulator = self[index]
        next
      end
      accumulator = yield accumulator, self[index]    
    end
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method

