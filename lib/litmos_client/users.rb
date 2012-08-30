module LitmosClient
  module Users
    def users(params={})
      get :users, params
    end

    def find_user_by_id(id)
      get("users/#{id}").to_hashugar
    rescue NotFound
      nil
    end

    def create_user(options={})
      options.merge!({
        'DisableMessages' => true,
        'IsCustomUsername' => true,
        'SkipFirstLogin' => true
      })

      raise ArgumentError.new("UserName is required") if options['UserName'].blank?
      raise ArgumentError.new("FirstName is required") if options['FirstName'].blank?
      raise ArgumentError.new("LastName is required") if options['LastName'].blank?
      raise ArgumentError.new("Email is required") if options['Email'].blank?

      post "users", options
    end
  end
end