class Player
  include BasicSerializable
  attr_reader :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end
end
