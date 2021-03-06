class Birdman::Show < Birdman::ApiResource

  RESOURCE_ATTRIBUTES = [ :id, :title, :year, :ids ]

  attr_accessor *RESOURCE_ATTRIBUTES

  # Returns a single shows's details.
  # If you get extended info, the airs object is relative to the show's country.
  # You can use the day, time, and timezone to construct your own date then convert it to whatever timezone your user is in.
  # Note: When getting full extended info, the status field can have a value of returning series (airing right now),
  # in production (airing soon), canceled, or ended.
  def self.find(id)
    build_single_resource(Birdman::Requester.get("shows/#{id}", {}), id)
  end

  # Returns all title aliases for a show. Includes country where name is different.
  def aliases
    Birdman::Requester.get("shows/#{id}/aliases")
  end

  # [Optional] 2 character country code Example: us. (String)
  # Returns all releases for a movie including country, certification, and release date.
  def releases(country = nil)
    Birdman::Requester.get("shows/#{id}/releases/#{country}")
  end

  # [Optional] 2 character language code Example: es. (String)
  # Returns all translations for a show, including language and translated values for title and overview.
  def translations(language = nil)
    Birdman::Requester.get("shows/#{id}/translations/#{language}")
  end

  # Returns all top level comments for a show. Most recent comments returned first.
  # 📄 Pagination
  def comments
    Birdman::ApiPaginatedCollection.new("shows/#{id}/comments")
  end

  # Returns collection progress for show including details on all seasons and episodes.
  # The next_episode will be the next episode the user should collect, if there are no upcoming episodes it will be set to null.
  # 🔒 OAuth Required
  def collection_progress
    Birdman::Requester.get("shows/#{id}/progress/collection")
  end

  # Returns watched progress for show including details on all seasons and episodes.
  # The next_episode will be the next episode the user should watch, if there are no upcoming episodes it will be set to null.
  # 🔒 OAuth Required
  def watched_progress
    Birdman::Requester.get("shows/#{id}/progress/watched")
  end

  # Returns all cast and crew for a show.
  def people
    Birdman::Requester.get("shows/#{id}/people")
  end

  # Returns rating (between 0 and 10) and distribution for a movie.
  def ratings
    Birdman::Requester.get("shows/#{id}/ratings")
  end

  # Returns related and similar shows. By default, 10 related shows will returned. You can send a limit to get up to 100 items.
  def related
    Birdman::Requester.get("shows/#{id}/related")
  end

  # COMING SOON™
  # Returns lots of show stats including ratings breakdowns, scrobbles, checkins, collections, lists, and comments.
  def stats
    Birdman::Requester.get("shows/#{id}/stats")
  end

  # Returns all users watching this show right now.
  def watching
    Birdman::Requester.get("shows/#{id}/watching")
  end

  # Returns the most popular shows. Popularity is calculated using the rating percentage and the number of ratings.
  # 📄 Pagination
  def self.popular
    Birdman::Requester.get("shows/popular")
  end

  # Returns all shows being watched right now. Shows with the most users are returned first.
  # 📄 Pagination
  def self.trending
    Birdman::Requester.get("shows/trending")
  end

  # Returns all shows updated since the specified UTC date. We recommended storing the date you can be efficient using this method moving forward.
  # 📄 Pagination
  def self.updates(start_date=Time.now)
    Birdman::Requester.get("shows/updates/#{start_date.strftime("%Y-%m-%d")}")
  end
end