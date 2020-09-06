class User < ApplicationRecord
  DEFAULT_NAME = 'Amigo User'.freeze

  has_many :pets
  has_many :articles
  has_many :adoption_applications

  before_validation :set_defaults

  def add_favorite(pet_id)
    self.update(favorited_pets: (favorited_pets << pet_id).uniq)
  end

  def remove_favorite(pet_id)
    favorited_pets.delete(pet_id)
    self.update(favorited_pets: favorited_pets.uniq)
  end

  def token
    TokenService.encode('user' => id)
  end

  def index_hash
    h = standard_hash
    h[:image] = images.sample
    return h
  end

  def show_hash
    h = standard_hash
    h[:images] = images
    h[:my_pets] = pets.map{|x| x.index_hash}
    h[:my_favorited_pets] = my_favorited_pets
    h[:my_adoption_applications] = adoption_applications.map{|x| x.show_hash}
    h[:received_adoption_applications] = AdoptionApplication.received_adoption_applications(id).map{|x| x.show_hash}
    return h
  end

  def standard_hash
    {
      id: id,
      name: name,
      city: city,
      wechat: wechat,
      phone: phone,
      email: email,
      gender: gender,
      description: description,
      images: images,
      pet_owner: pet_owner,
      pet_adopter: pet_adopter,
      shelter: shelter,
      admin: admin,
      wx_open_id: nil,
      rescuer_terms: rescuer_terms,
      favorited_pets: favorited_pets
    }
  end

  def my_favorited_pets
    favorited_pets.present? ? Pet.where(id: favorited_pets).map{|x| x.index_hash} : []
  end

  def all_applications
    {
      my_adoption_applications: adoption_applications.map{|x| x.show_hash},
      received_adoption_applications: AdoptionApplication.received_adoption_applications(id).map{|x| x.show_hash}
    }
  end

  private

  def set_defaults
    self.name = DEFAULT_NAME if self.name.blank?
  end
end
