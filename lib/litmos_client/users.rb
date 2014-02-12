module LitmosClient
  module Users
    def users(params={})
      get(:users, params)
    end

    def find_user_by_id(id)
      get("users/#{id}")
    rescue NotFound
      nil
    end

    def create_user(options={})
      raise ArgumentError.new(":username is required") if options[:username].blank?
      raise ArgumentError.new(":first_name is required") if options[:first_name].blank?
      raise ArgumentError.new(":last_name is required") if options[:last_name].blank?
      raise ArgumentError.new(":email is required") if options[:email].blank?

      params = {
        'UserName' => options[:username],
        'FirstName' => options[:first_name],
        'LastName' => options[:last_name],
        'Email' => options[:email],
        'DisableMessages' => true,
        'IsCustomUsername' => true,
        'SkipFirstLogin' => true
      }

      post("users", params)
    end

    def delete_user(id)
      delete "/users/#{id}"
    end
  end
end