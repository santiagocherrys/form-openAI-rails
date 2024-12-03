class Response < ApplicationRecord
  belongs_to :form

  #enums
  enum status: {pendiente: 0, completado: 1, fallido: 2}
  
end
