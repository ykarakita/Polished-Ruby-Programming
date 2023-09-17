# Null Object パターン

=begin
class Employee
  attr_reader :name
  attr_reader :position
  attr_reader :phone

  def initialize(name, position, phone, supervisor)
    @name = name
    @position = position
    @phone = phone
    @supervisor = supervisor
  end

  def employee_info
    <<~END
      Name: #{@name}
      Position: #{@position}
      Phone: #{@phone}
      Supervisor Name: #{@supervisor.name}
      Supervisor Position: #{@supervisor.position}
      Supervisor Phone: #{@supervisor.phone}
    END
  end
end

supervisor = Employee.new("Juan Manuel", "CEO", "111-222-333", nil)
subordinate = Employee.new("Aziz Karim", "CTO", "999-888-777", supervisor)
print subordinate.employee_info
# print supervisor.employee_info
# => NoMethodError


class NullEmployee
  def name; "" end
  def position; "" end
  def phone; "" end
end
supervisor = Employee.new("Juan Manuel", "CEO", "111-222-333", NullEmployee.new)
print supervisor.employee_info

=end

class AbstractEmployee
  attr_reader :name
  attr_reader :position
  attr_reader :phone

  def employee_info
    <<~END
      Name: #{@name}
      Position: #{@position}
      Phone: #{@phone}
      Supervisor Name: #{@supervisor.name}
      Supervisor Position: #{@supervisor.position}
      Supervisor Phone: #{@supervisor.phone}
    END
  end
end

class Employee < AbstractEmployee
  attr_reader :supervisor

  def initialize(name, position, phone, supervisor)
    @name = name
    @position = position
    @phone = phone
    @supervisor = supervisor
  end
end

class NullEmployee < AbstractEmployee
  def initialize
    @name = ""
    @position = ""
    @phone = ""
  end

  def supervisor
    @supervisor = NullEmployee.new
  end

  def employee_info
    supervisor
    super
  end
end

null_employee = NullEmployee.new
puts null_employee.employee_info
