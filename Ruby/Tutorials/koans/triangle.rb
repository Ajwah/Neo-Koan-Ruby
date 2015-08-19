# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def isInvalid?(a, b, c)
  cycle = [[a,b,c],[b,c,a],[c,a,b]]
  # Two conditions need to be fulfilled for validity of a triangle:
  #       1. Triangle Inequality Theorem
  #       2. Every side is bigger than zero
  return (!cycle.inject(true) {|acc,e| acc && (e[0] + e[1] > e[2])}) ||
         (![a,b,c].inject(true) {|a,v| a && (v > 0)})
end

def triangle2(a, b, c)
  if isInvalid? a, b, c
    raise TriangleError
  end
  triangleType = [:scalene, :isosceles, :impossible, :equilateral]
  matches = [[a,b],[b,c],[c,a]].inject(0) {|acc,e| acc + ((e[0]==e[1])? 1:0)}
  # Impossibility of matches = 2 on account of syllogism: a = b & b = c => a = c

  return triangleType[matches]
end

##
#I was blown away by the creative approach employed here by Sergey.
#https://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions/11361502#11361502
#Slightly modified it to incorporate suggestion of SLD
##
def triangle(a,b,c)
  x,y,z = [a,b,c].sort
  raise TriangleError if x <= 0 || x + y <= z
  [:equilateral,:isosceles,:scalene][[a,b,c].uniq.size - 1]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end