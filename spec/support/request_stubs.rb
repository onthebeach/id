module RequestStubs
  extend self

  def trevor
    File.read 'spec/support/trevor.json'
  end

  def trevors
    File.read 'spec/support/trevors.json'
  end

end
