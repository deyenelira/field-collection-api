class Visit < ApplicationRecord
  belongs_to :user
  validates :date_cannot_be_in_the_past
  validates :checkin_cannot_be_greater_or_equal_than_today
  validates :checkout_cannot_be_less_than_checkin
  validates :user_is_valid?
  validates :status_is_valid?

  def date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, "A data não pode ser no passado.")      
    end
  end

  def checkin_cannot_be_greater_or_equal_than_today
    if checkin_at >= Date.today and checkin_at > checkout_at 
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data atual, nem maior que a data de check-out.")
    elsif checkin_at >= Date.today
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data atual")
    elsif checkin_at > checkout_at
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data de check-out")
    end
  end

  def checkout_cannot_be_less_than_checkin
    if checkin_at <= checkout_at
      errors.add(:checkout_at, "A data de check-out não pode ser menor ou igual que a data de check-in")
    end
  end

  def user_is_valid?
    if !User.exists?(user_id)
      errors.add(:user_id, "Usuário não encontrado")
    end
  end

  def status_is_valid?
    if status != ("PENDENTE" || "REALIZANDO" || "REALIZADA")
      errors.add(:status, "Status inválido")
    
  end
end
