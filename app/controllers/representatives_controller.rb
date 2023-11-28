# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    index = params[:id]
    @representative = Representative.find(index)
    render :show
  end
end
