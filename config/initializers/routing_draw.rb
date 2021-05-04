# frozen_string_literal: true

class ActionDispatch::Routing::Mapper
  def draw(*routes)
    path = routes.map(&:to_s).join('/')
    instance_eval(File.read(Rails.root.join("config/routes/#{path}.rb")))
  end
end
