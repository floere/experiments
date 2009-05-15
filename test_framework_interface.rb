require 'spec'

class Testee
  def switch; 'off' end
  def on?; switch == 'on' end
  def off?; switch == 'off' end
end

module Gourmet
  
  # Define a single stub that is installed
  # on the testee for the duration of the context.
  #
  def context stubs, &context
    tongue = Tongue.new
    tongue.stubs = stubs
    tongue.instance_eval &context
  end
  
  class Tongue
    
    attr_accessor :tastebuds, :stubs
    
    def context stubs, &context
      # TODO refactor
      tongue = Tongue.new
      tongue.stubs = self.stubs.merge stubs
      tongue.instance_eval &context
    end
    
    # What gourmet expects (in a context or elsewhere).
    #
    def expects definitions
      @expectations = definitions
    end
  
    # Run the tests.
    #
    def sample testee
      install testee, stubs
      test    testee, expectations
    end
    
    def install testee, stubs
      testee.stub! stubs
    end
    def test testee, expectations
      expectations.each_pair do |message, expected|
        it "should respond to #{message} with #{expected}" do
          testee.send(message).should == expected
        end
      end
    end
    
  end
  
  # Stub external objects.
  #
  def stub stubbees, definitions
    
  end
  
end


extend Gourmet

testee = Testee.new

describe testee do
  context switch:'on' do
    expects on?:true, off?:false
  end
  context switch:'off' do
    expects on?:false, off?:true
  end
end