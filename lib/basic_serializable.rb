require 'yaml'

module BasicSerializable
  @@serializer = YAML

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end

    @@serializer.dump obj
  end

  def unserialize(string)
    obj = @@serializer.load(string)
    obj.each_key do |key|
      instance_variable_set(key, obj[key])
    end
  end
end
