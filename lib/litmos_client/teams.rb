module LitmosClient
  module Teams
    def teams(options={})
      get :teams, options
    end

    def find_team_by_id(id)
      get("teams/#{id}")
    rescue NotFound
      nil
    end

    def find_users_by_team_id(id)
      get("teams/#{id}/users")
    rescue NotFound
      nil
    end

    def add_user_to_team(options={})
      raise ArgumentError.new("team_id is required") if options[:team_id].blank?
      raise ArgumentError.new("user_id is required") if options[:user_id].blank?

      params = {
        'Id' => options[:user_id]
      }

      post("teams/#{options[:team_id]}/users", [params])
    end

    def remove_user_from_team(options={})
      raise ArgumentError.new("team_id is required") if options[:team_id].blank?
      raise ArgumentError.new("user_id is required") if options[:user_id].blank?

      delete("teams/#{options[:team_id]}/users/#{options[:user_id]}")
    end
  end
end