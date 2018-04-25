class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:cedula]
  
  validates_uniqueness_of :cedula
  validates :cedula, presence: true
  validates :cedula, numericality: { only_integer: true, greater_than:0, less_than: 100000000 }
  validate :cedula_digit

  def password_required?
    super if validado?
  end

  def email_required?
    true
  end 




  def cedula_digit
    if ( cedula == nil )
      errors.add(:cedula, "es obligatoria")
      return
    end
    suma = 0
    arr = [4,3,6,7,8,9,2]
    digit = cedula%10 
    c = cedula/10
    (0..6).each do |i|
       r = c%10
       c = c/10
       suma = (suma + r*arr[i]) % 10
    end
    if digit != ((10-(suma%10))%10)
      errors.add(:cedula, "con dígito verificador mal")
    end
  end
end
