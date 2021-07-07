class User < ApplicationRecord
	
  has_secure_password
  has_many :visits

  validates :password_digest, 
  format: { with: /(?=.*[a-zA-Z])(?=.*[0-9])/, message: "Senha inválida, a senha deve possuir números e letras." },
  length: { minimum: 6, message: "A senha deve possuir um número mínimo de 6 digitos." }
  validates :email, uniqueness: true, presence: true
  validates :cpf, uniqueness: true, presence: true
  validates :cpf, cpf: true

end	
