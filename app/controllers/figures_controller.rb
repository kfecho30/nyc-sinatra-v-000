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
    @figure = Figure.create(params[:figure])

    @figure.landmarks << Landmark.create(params[:landmark]) if !params[:landmark][:name].empty?
    @figure.titles << Title.create(params[:title]) if !params[:title][:name].empty?

    @figure.save
    redirect_to '/figures/#{@figure.id}'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    @figure.landmarks << Landmark.create(params[:landmark]) if !params[:landmark][:name].empty?
    @figure.titles << Title.create(params[:title]) if !params[:title][:name].empty?
    
    @figure.save
    redirect_to '/figures/#{@figure.id}'
  end
end
