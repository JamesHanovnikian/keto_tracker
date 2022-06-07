require "edamam_api"

class FoodsController < ApplicationController
  def show
    parser = EdamamApi.new(params[:food])
    render json: parser.nutrients
  end
end
