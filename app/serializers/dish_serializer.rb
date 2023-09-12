class DishSerializer < ActiveModel::Serializer
  attributes :id ,:name, :price ,:images
  
  def images 
    object.images.map do |data|
      data.url
    end
  end

end
