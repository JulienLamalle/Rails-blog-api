class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :email

  has_many :articles do

    meta do
      { count: @object.articles.count }
    end
  end

  link :self do
    @url_helpers.api_user_url(@object.id)
  end
end