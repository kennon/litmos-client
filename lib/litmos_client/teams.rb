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
  end
end