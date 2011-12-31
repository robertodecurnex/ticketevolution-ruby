Introduction
============
The Ticketevolution GEM is a toolkit that provides a seamless and total wrapper around the Ticketevolution API's. It provides a Class for each major resource. Any resources that semantically and are actually related (a venue to an event) to others are setup in a manner so that they are associated and related content is accessible within the class itself through delegation and the usage of proxy apis that are similar to the way that Active Record allows for its has_many and belongs_to relationships related objects to be traversed and accessed via Association Proxies.

As a connivence all reposes which are returned in the format of JSON are automatically decoded, parsed and instantiated into objects of their respective type


Installation
------------
  
    gem install ticketevolution-ruby
    # In your ruby application
    require 'ticketevolution-ruby
  


Connecting to Ticketevolution
---------------------

    # Uses block syntax
    Ticketevolution::configure do |config|
      config.token   = "958acdf7da323bd7a4ac63b17ff26eabf45"
      config.secret  = "TSaldkl34kdoCbGa7I93s3S9OBcBQoogseNeccHIEh"
      config.version = 8
      config.mode    = :sandbox
    end



Catalog Resources :: Fetching and Interaction With A Venue
---------------------
    All returned results are cast into Venue objects that have all of their attributes accessible to you. No JSON interaction is needed unless desired
    
    # Passing in the id of the venue
    venue = Ticketevolution::Venue.find(9) 
  
    # Using search to find a particular venue (this will return a list a paginated venues that match your query)
    venue = Ticketevolution::Venue.Search("The Stone Pony") 

    venue = Ticketevolution::Venue.find(9)
    venue.name                          # => "Abraham Chavez Theatre"    
    venue.address                       # => { "region"=>"TX", "latitude"=>nil, "country_code"=>"US", "extended_address"=>nil, "postal_code"=>"79901".... }
    venue.location                      # => "El Paso, TX"
    venue.updated_at                    # => "2011-11-28T17:57:00Z"
    venue.url                           # => "/venues/9"
    venue.id                            # => 9
    
    Accessing Associated Other Objects...
    venue.events                        # => [{events}]
    venue.performers                    # => [{performers}]



Catalog Resources :: Fetching and Interaction With A Performer
---------------------
    All returned results are cast into Performer objects that have all of their attributes accessible to you. No JSON interaction is needed unless desired

    # Passing in the id of the venue
    person = Ticketevolution::Performer.find(3219) 
  
    # Using search to find a particular venue (this will return a list a paginated venues that match your query)
    person = Ticketevolution::Performer.Search("Dipset") 

    person = Ticketevolution::Performer.find(9)
    person.name                          # => "Dipset"    
    person.category                      # => nil
    person.updated_at                    # => 2011-11-28T17:57:00Z
    person.url                           # => "/performers/3219""
    person.id                            # => 3219
    person.upcoming_events               # => {"last"=>nil, "first"=>nil}
    person.venue                         # => nil
   
   
Catalog Resources :: Fetching and Interaction With An Event 
---------------------   
All returned results are cast into Performer objects that have all of their attributes accessible to you. No JSON interaction is needed unless desired

    # Passing in the id of the event
    event = Ticketevolution::Event.find(3219) 

    # Using search to find a particular venue (this will return a list a paginated venues that match your query)
    event = Ticketevolution::Event.Search("3219") 

    event = Ticketevolution::Event.find(9)
    event.name                              # => "Promises Promises"    
    event.category                          # => {"parent"=>nil, "url"=>"/categories/68", "id"=>"68"}
    event.configuration                     
                                            # => "configuration"=>{"name"=>"Full House", "fanvenues_key"=>nil, "url"=>"/configurations/14413", "id"=>"14413",                                                                                               
                                                 "seating_chart"=> {"large"=>"http://media.sandbox.ticketevolution.com/
                                                 configurations/static_maps/14413/large.jpg?1315492230", 
                                                 "medium"=>"http://media.sandbox.ticketevolution.com/configurations/static_maps/14413/medium.jpg?1315492230"}}
    event.id                                # => 3219
    event.name                              # => "/performers/3219""
    event.performances                            # => 3219
    event.products_count                    # => {"last"=>nil, "first"=>nil}
    event.state                             # => nil
    event.updated_at                        # => "2010-11-17T14:52:07Z"
    event.venue                             # => {"name"=>"Broadway Theatre-NY", "location"=>"New York, NY", "url"=>"/venues/187", "id"=>"187"}    
    event.occurs_at                         # => "2010-10-02T14:00:00Z"
    event.url                               # => "/events/3219"
    
    
    Since we have the venue id embedded inside of the venue attribute its as simple as calling event.venue to pull up the full local copy of the venue 