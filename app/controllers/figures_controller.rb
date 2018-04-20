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

    @figure.landmarks << Landmark.create(:name => params[:landmark][:name]) if !params[:landmark][:name].empty?
    @figure.titles << Title.create(:name => params[:title][:name]) if !params[:title][:name].empty?

    
    params[:figure][:title_ids].each do |title|
      @figure.titles << Title.find(title)
    end
    
    params[:figure][:landmark_ids].each do |landmark|
      @figure.landmarks << Landmark.find(landmark)
    end


    @figure.save
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end
end
