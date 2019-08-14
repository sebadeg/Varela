class Persona < ApplicationRecord

  def self.Find(p)
    persona = Persona.find(p) rescue nil
    if persona == nil
      persona = Persona.new
    end
    return persona
  end

end
