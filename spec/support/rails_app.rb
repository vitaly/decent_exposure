require "active_support/all"
require "action_controller"
require "action_dispatch"
require "rails"

module Rails
  class App
    def env_config
      {}
    end

    def routes
      @routes ||= ActionDispatch::Routing::RouteSet.new.tap do |routes|
        routes.draw do
          resources :birds
          resource :birds, only: :show
        end
      end
    end
  end

  def self.application
    @app ||= App.new
  end
end

class Bird
  def self.special
    self
  end
end

class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class BirdsController < ApplicationController
  expose(:birds)
  expose(:bird)

  expose(:special_birds) { Bird.special }
  expose(:bird, from: :special_birds)

  def index
    render nothing: true
  end

  def show
    render nothing: true
  end
end

