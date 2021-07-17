class User < ApplicationRecord

  has_secure_password
  has_many :visits, dependent: :destroy 
  acts_as_paranoid without_default_scope: true

  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "O nome deve possuir apenas letras" }, presence: true
  validates :password_digest, 
  format: { with: /(?=.*[a-zA-Z])(?=.*[0-9])/, message: "Senha inválida, a senha deve possuir números e letras." },
  length: { minimum: 6, message: "A senha deve possuir um número mínimo de 6 digitos." }
  validates :cpf, uniqueness: true, presence: true
  validates :cpf, cpf: true
  validates :email,
  format: { with: /\A^(.+)@(.+)$\z/, message: "Email invalido" },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 },
            presence: true 
end	

