require 'spec_helper'

describe Movie do
  describe 'searching for movies with similar directors' do
    it 'should call Movie with director' do
      Movie.should_receive(:find_all_by_director).with('Title')
      Movie.find_all_by_director('Title')
    end
  end
end