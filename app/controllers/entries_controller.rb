class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def random_entries
    @entries = Entry.order("RANDOM()").limit(5)
  end
end
