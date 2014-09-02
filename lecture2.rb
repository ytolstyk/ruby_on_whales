#INSTANCE EVAL

class Trip
  def snorkeling
    puts "snorkeling"
  end

  def jet_skis
    puts "jet skis!"
  end

  def eating_jerk_chicken
    puts "eating jerk chicken - what a jerk!"
  end

  def swimming
    puts "swimming"
  end

  def plan(&blk)
    instance_eval(&blk)
    #gets rid of all the iten. stuff
    #calling ourselves on the block
    #applying self. to all methods in the block

    #blk.call(self) #not pretty
  end
end

jamaican_vacation = Trip.new
jamaican_vacation.plan do
  snorkeling
  jet_skis
  swimming
  eating_jerk_chicken
end

# jamaican_vacation = Trip.new
# jamaican_vacation.plan do |iten|
#   iten.snorkeling
#   iten.jet_skis
#   iten.swimming
#   iten.eating_jerk_chicken
# end