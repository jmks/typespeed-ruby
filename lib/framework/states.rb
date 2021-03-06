require "set"

# States module will provide state registration, query, and transition methods
module States
  def self.included(klass)
    klass.instance_variable_set :@registered_states, Set.new
    klass.instance_variable_set :@current_state, nil
    klass.extend ClassMethods
  end

  # Class-level methods
  module ClassMethods
    def register_state(*states)
      options = states.last.is_a?(Hash) ? states.pop : {}

      states.each do |state|
        symbolized_state = state.to_sym
        next if @registered_states.include?(symbolized_state)

        @registered_states << symbolized_state

        self.state = symbolized_state if options[:initial] == symbolized_state || symbolized_state == states.first

        self.send :define_method, :"#{symbolized_state}?" do
          @current_state == symbolized_state
        end

        self.send :define_method, :"#{symbolized_state}!" do
          @current_state = symbolized_state
        end
      end
    end
    send :alias_method, :register_states, :register_state

    def state=(new_state)
      @current_state = new_state
    end
  end

  def states
    registered_states.to_a
  end

  def state
    current_state
  end

  def state=(new_state)
    raise StateError, "State #{new_state} not registered" unless registered_states.include?(new_state)
    self.current_state = new_state
  end

  private

  def registered_states
    self.class.instance_variable_get(:@registered_states)
  end

  def current_state
    self.class.instance_variable_get(:@current_state)
  end

  def current_state=(new_state)
    self.class.instance_variable_set(:@current_state, new_state)
  end
end
