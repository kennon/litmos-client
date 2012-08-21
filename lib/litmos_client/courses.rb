module LitmosClient
  module Courses
    def courses(params={})
      get :courses, params
    end

    def find_course_by_id(id)
      get("courses/#{id}").to_hashugar
    rescue NotFound
      nil
    end
  end
end