class Answer < ApplicationRecord
  belongs_to :formulary
  belongs_to :question
  belongs_to :visit
  validates :question_is_valid?
  validates :formulary_is_valid?

  def question_is_valid?
    if !Question.exists?(question_id)
      errors.add(:question_id, "Pergunta não encontrada")
    end
  end

  def formulary_is_valid?
    if !Formulary.exists?(formulary_id)
      errors.add(:formulary_id, "Formulário não encontrado")
    end
  end

end
