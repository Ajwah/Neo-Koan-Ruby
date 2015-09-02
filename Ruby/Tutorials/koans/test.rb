
def score0(dice)
  h = Hash.new(0)
  worth = Hash.new(0)

  dice.each{ |e| h[e] += 1; worth[[e,3]] = e * 100 }
  worth[[1,3]] = 1000
  worth[[1,1]] = 100
  worth[[5,1]] = 50

  r = h.reduce(0) {|acc,(k,v)| acc + ((v/3)*worth[[k,3]] + (v%3)*worth[[k,1]])}
end

def score1(dice)
  score = [0, 100, 200, 1000, 1100, 1200][dice.count(1)]
  score += [0, 50, 100, 500, 550, 600][dice.count(5)]
  [2,3,4,6].each do |num|
      if dice.count(num) >= 3 then score += num * 100 end
  end
  score
end

def score2(dice)
  ## score is set to 0 to start off so if no dice, no score
  score = 0
  ## setting the 1000 1,1,1 rule
  score += 1000 if (dice.count(1) / 3) == 1
  ## taking care of the single 5s and 1s here
  score += (dice.count(5) % 3) * 50
  score += (dice.count(1) % 3) * 100
  ## set the other triples here
  [2, 3, 4, 5, 6].each do |num|
    score += num * 100 if (dice.count(num) / 3 ) == 1
  end
  score
end

def score3(dice)
  p = Hash.new([100,0]).merge({1 => [1000,100], 5 => [100,50]})
  dice.uniq.inject(0) { |sum, n| sum + dice.count(n) / 3 * n * p[n][0] + dice.count(n) % 3 * p[n][1] }
end

puts score0([2,2,2,2,2,2,3,5,5,5,5,5,5,1,1,1,1])
# puts score1([2,2,2,2,2,2,3,5,5,5,5,5,5,1,1,1,1])
puts score2([2,2,2,2,2,2,3,5,5,5,5,5,5,1,1,1,1])
puts score3([2,2,2,2,2,2,3,5,5,5,5,5,5,1,1,1,1])
