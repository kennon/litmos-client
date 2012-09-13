module LitmosClient
  module Courses
    def courses(params={})
      get :courses, params
    end

    def find_course_by_id(id)
      get("courses/#{id}")
    rescue NotFound
      nil
    end

    def find_courses_by_user_id(id)
      get("users/#{id}/courses")
    rescue NotFound
      nil
    end
  end
end