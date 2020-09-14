require 'securerandom'

class Randomizer
  attr :randoms

  def initialize
    @randoms = {}
  end

  def new_random identifier
    randoms[identifier] = SecureRandom.uuid
    randoms[identifier]
  end

  def last_or_new_random identifier
    randoms[identifier] || new_random(identifier)
  end

  def reset
    @randoms = {}
  end
end