require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
      self.send(name)
    end

    def link_to(name, url, options = {})
      options[:method] = :get if options.empty?
      html = "<a href='#{url}' method='#{options[:method]}'>#{name}</a>"
      html
    end

    def button_to(name, url, options = {})
      options[:method] = :get if options.empty?
      html = "<form action='#{url}' method='#{options[:method]}'>
      <input type='submit' value='#{name}'></form>"
      html
    end
  end
end
