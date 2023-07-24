require 'active_support/inflector'

module Api::V1::Concerns::SetInstance
  extend ActiveSupport::Concern

  def set_instance(id, model_class, type)
    instance = model_class.find_by_id(id)
    
    if model_class.name == 'User' && type == 'Driver'
      if instance && instance.type != 'Driver'
        instance.update(type:'Driver')
        instance = Driver.find_by_id(id)
      end
    end
    
    unless instance
      render json: { message: "#{model_class.name} not found" }, status: :not_found
      return
    end
  
    instance
  end
end