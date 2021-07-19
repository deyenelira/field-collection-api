class Visit < ApplicationRecord
  
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :date, presence: true
  validates :checkin_at, presence: true
  validates :checkout_at, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  validate :date_is_valid?
  validate :checkin_checkout_valid?
  validate :user_is_valid?
  validate :status_is_valid?
  

  def date_is_valid?
    if date == nil
      errors.add(:date, "Insira uma data")
    elsif date < Date.today
      errors.add(:date, "A data não pode ser no passado.")      
    end
  end

  def checkin_checkout_valid?
    if checkin_at == nil
      errors.add(:checkin_at, "Insira a data de check-in.")
    elsif checkout_at == nil
      errors.add(:checkout_at, "Insira a data de check-out.")
    elsif checkin_at >= Date.today and checkin_at > checkout_at 
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data atual, nem maior que a data de check-out.")
    elsif checkin_at >= Date.today
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data atual")
    elsif checkin_at > checkout_at
      errors.add(:checkin_at, "A data de check-in não pode ser maior que a data de check-out")
    end
  end

  def user_is_valid?
    if user_id == nil
      errors.add(:user_id, "Insira um ID")
    elsif !User.exists?(user_id)
      errors.add(:user_id, "Usuário não encontrado")
    end
  end

  def status_is_valid?
    if status == nil
      errors.add(:status, "Insira um status.")
    elsif status != "REALIZANDO" and status != "REALIZADO" and status != "PENDENTE"
      errors.add(:status, "Status inválido")
    end
  end
  
end
