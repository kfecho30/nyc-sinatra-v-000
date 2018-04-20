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
binding.pry
    @figure.landmarks << Landmark.create(params[:landmark]) if !params[:landmark].empty?
    @figure.titles << Title.create(params[:title]) if !params[:title].empty?

    params[:figure][:title_ids].each do |title|
      @figure.titles << Title.find(title)
    end

    #params[:figure][:landmark_ids].each do |landmark|
    #  @figure.landmarks << Landmark.find(landmark)
    #end


    @figure.save
    redirect_to '/figures/#{@figure.id}'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end
end
