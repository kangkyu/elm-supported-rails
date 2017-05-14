class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def random_entries
    headers['Access-Control-Allow-Origin'] = '*'
    @entries = Entry.order("RANDOM()").limit(5)
  end
end
