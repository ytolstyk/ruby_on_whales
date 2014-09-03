require_relative '../phase3/controller_base'
require_relative './session'
require_relative '../phase7/flash.rb'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super(url)
      session.store_session(@res)
      flash.store_hash(@res)
    end

    def render_content(content, type)
      super(content, type)
      session.store_session(@res)
      flash.store_hash(@res)
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(@req)
    end

    def flash
      @flash ||= Flash.new(@req)
    end
  end
end
