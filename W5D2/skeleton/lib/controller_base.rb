require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'router'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res,options_hash={})
    @req = req
    @res = res
    @params = req.params
    @params.merge!(options_hash)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    if @already_built_response
      return true
    else
      @already_built_response = 1
      return false
    end
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "double render" if already_built_response?
    res['Location']=url
    res.status = 302
    @session.store_session(res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "double render" if already_built_response?
    res.write(content)
    res['Content-Type'] = content_type
    @session.store_session(res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    content = File.read("views/#{self.class.name.underscore}/#{template_name}.html.erb")
    template = ERB.new(content).result(binding)
    render_content(template,'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    send(name)
  end
end
