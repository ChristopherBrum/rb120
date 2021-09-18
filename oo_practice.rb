# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_reader :year
  attr_accessor :color, :model, :speed, :car_running
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @car_running = false
  end
  
  def speed_up(accel=1)
    self.speed = self.speed + (10 * accel)
  end
  
  def brake(slow=1)
    self.speed = self.speed - (10 * slow)
  end
  
  def start_engine
    @car_running = true
    puts "vroooom vrooooooom"
  end
  
  def stop_engine
    @car_running = false
    puts "click click (checks sunglasses in mirror)"
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
end

car = MyCar.new(2010, 'silver', 'pinto')
car.status
car.start_engine
car.status
car.speed_up(10)
car.status
car.brake(4)
car.status
car.brake(6)
car.status  
car.stop_engine
car.status
p car.color
car.spray_paint('Blue')
p car.model
p car.year
car.status