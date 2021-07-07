class Visit < ApplicationRecord
  belongs_to :user
  validate :date_cannot_be_in_the_past
  validate :checkin_cannot_be_greater_or_equal_than_today
  validate :user_is_valid?
  validate :status_is_valid?

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

  def user_is_valid?
    if !User.exists?(user_id)
      errors.add(:user_id, "Usuário não encontrado")
    end
  end

  def status_is_valid?
    if status != "REALIZANDO" and status != "REALIZADO" and status != "PENDENTE"
      errors.add(:status, "Status inválido")
    end
  end
end
