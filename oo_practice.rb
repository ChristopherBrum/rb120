# Write a method called age that calls a private method to calculate the age of the vehicle. 
# Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help

module OffRoadable
  def off_road
    puts "You've switched on the four wheel drive, time to go off roading!"
  end
end

class Vehicle
  attr_reader :year
  attr_accessor :color, :model, :speed, :car_running
  
  @@subclasses = 0
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @car_running = false
    @@subclasses += 1
  end
  
  def self.say_subclasses
    puts "This Superclasses has #{@@subclasses} many subclasses under it"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "This car gets #{miles / gallons} miles to the gallon"
  end
  
  def start_engine
    @car_running = true
    puts "vroooom vrooooooom"
  end
  
  def stop_engine
    @car_running = false
    puts "click click (checks sunglasses in mirror)"
  end
  
  def speed_up(accel=1)
    self.speed = self.speed + (10 * accel)
  end
  
  def brake(slow=1)
    self.speed = self.speed - (10 * slow)
  end
  
  def engine_status
    self.car_running ? "running" : "not running"
  end
  
  def status
    puts "This #{self.year} #{self.color} #{self.model} is currently #{self.engine_status} and traveling at #{self.speed} mph."
  end
  
  def spray_paint(clr)
    self.color = clr
    puts "Your new #{self.color} paint job looks choice!"
  end
  
  def age
    puts "This #{model} is #{fetch_age(self.year)} years old."
  end
  
  private 
  
  def fetch_age(vehicle_year)
    Time.now.year - vehicle_year
  end
end

class MyTruck < Vehicle
  include OffRoadable
  
  SEATS = 2
end

class MyCar < Vehicle
  SEATS = 4
end

car = MyCar.new(1999, 'blue', 'corolla')
truck = MyTruck.new(2010, 'gray', 'tacoma')

car.age
truck.age