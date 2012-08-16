module LitmosClient
  module User
    def users(params={})
      get :users, params
    end

    def find_user_by_id(id)
      get("users/#{id}").to_hashugar
    rescue NotFound
      nil
    end
  end
end