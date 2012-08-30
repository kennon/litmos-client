module LitmosClient
  module Teams
    def teams(params={})
      get :teams, params
    end

    def find_team_by_id(id)
      get("teams/#{id}").to_hashugar
    rescue NotFound
      nil
    end

    def add_user_to_team(options={})
      raise ArgumentError.new("team_id is required") if options[:team_id].blank?
      raise ArgumentError.new("user_id is required") if options[:user_id].blank?

      post("teams/#{options[:team_id]}/users", [{'Id' => options[:user_id]}])
    end

    def remove_user_from_team(options={})
      raise ArgumentError.new("team_id is required") if options[:team_id].blank?
      raise ArgumentError.new("user_id is required") if options[:user_id].blank?

      delete("teams/#{options[:team_id]}/users/#{options[:user_id]}")
    end
  end
end