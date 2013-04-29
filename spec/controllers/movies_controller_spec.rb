require 'spec_helper'

describe MoviesController do

  describe 'add director' do
   
    it 'should call update_attributes and redirect' do
      movie=mock(Movie, :title => "Movie1", :director => "director", :id => "1")
      Movie.stub!(:find).with("1").and_return(movie)
      movie.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "1", :movie => movie}
      response.should redirect_to(movie_path(movie))
    end
  end

  describe 'no director' do

    it 'should redirect to index if movie does not have a director and have a flash notice' do
      movie=mock(Movie, :title => "Movie1", :director => nil, :id => "1")
      Movie.stub!(:find).with("1").and_return(movie)
      
      get :similar, :movie_id => "1"
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end


  describe 'similar director movie found' do
    it 'should generate routing for movies with similar director' do
      movie=mock(Movie, :title => "Movie1", :director => "director", :id => "1")
      Movie.stub!(:find).with("1").and_return(movie)
      
      { :post => movie_similar_path(1) }.
      should route_to(:controller => "movies", :action => "similar", :movie_id => "1")
    end

    it 'should find movies with similar director by calling the model method similar' do
      movie=mock(Movie, :title => "Movie1", :director => "director", :id => "1")
      Movie.stub!(:find).with("1").and_return(movie)
      
      similarMovies = [mock('Movie1'), mock('Movie')]
      
      Movie.should_receive(:find_all_by_director).with('director').and_return(similarMovies)
      get :similar, :movie_id => "1"
    end

  end

  describe 'create' do
    it 'should create a new movie' do
      MoviesController.stub(:create).and_return(mock('Movie'))
      post :create, :movie_id => "1"
    end
  end

  describe 'destroy' do
    it 'should destroy a movie' do
      movie = mock(Movie, :id => "1", :title => "Movie", :director => nil)
      Movie.stub!(:find).with("1").and_return(movie)
      movie.should_receive(:destroy)
      delete :destroy, {:id => "1"}
    end
  end

end

