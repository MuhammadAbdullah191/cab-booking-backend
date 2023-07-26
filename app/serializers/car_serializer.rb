class CarSerializer < ActiveModel::Serializer
  attributes :id, :reg_number, :make, :model, :seats
end
