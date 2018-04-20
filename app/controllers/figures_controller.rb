class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(:name => params[:figure][:name])
    Landmark.create(:name => params[:landmark][:name]) if !params[:landmark][:name].empty?
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end
end
