class Museum
  attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommended_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  #need to create a hash with all exhibits as keys
  # need to interate through each exhibit and find all patrons interested in it
  # Add all patrons interested into the value of that hash key
  #return whole hash

  def patrons_by_exhibit_interest
    hash = @exhibits.to_h { |exhibit| [exhibit, []] }

    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        if patron.recommended_exhibits.include?(exhibit)
          hash[exhibit] << patron
        end
      end
    end
    hash
  end
end