Gem::Specification.new do |s|
  s.name        = 'blackjack_state_machine'
  s.version     = '0.0.1'
  s.summary     = 'blackjack built on top of state_machine'
  s.description = 'An example of how to build interactive applications on top of a state machine'
  s.authors     = ['Andre Pinter']
  s.email       = 'endform@gmail.com'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'http://github.com/endform/blackjack_state_machine'
  s.add_dependency 'state_machine', '~> 1.1'
  s.add_development_dependency 'rspec', '~> 2.7'
end
