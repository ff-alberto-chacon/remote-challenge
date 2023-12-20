## HOW TO EXECUTE THE CODE

```ruby
remote-challenge % ruby conference_track_management.rb
# **Track 1:**

#  9:00 AM: Rails Magic
# 10:00 AM: Ruby on Rails: Why We Should Move On
# 11:00 AM: Writing Fast Tests Against Enterprise Rails

#  12:00PM Lunch 

#  1:00 PM: Ruby on Rails Legacy App Maintenance
#  2:00 PM: Communicating Over Distance
#  3:00 PM: Ruby Errors from Mismatched Gem Versions
#  3:45 PM: Pair Programming vs Noise
#  4:30 PM: User Interface CSS in Rails Apps
#  5:00 PM Networking Event

# **Track 2:**

#  9:00 AM: Accounting-Driven Development
#  9:45 AM: Clojure Ate Scala (on my project)
# 10:30 AM: Common Ruby Errors
# 11:15 AM: Overdoing it in Python

#  12:00PM Lunch 

#  1:00 PM: Lua for the Masses
#  1:30 PM: Woah
#  2:00 PM: Sit Down and Write
#  2:30 PM: Programming in the Boondocks of Seattle
#  3:00 PM: Ruby vs. Clojure for Back-End Development
#  3:30 PM: A World Without HackerNews
#  4:00 PM: Rails for Python Developers
#  4:05 PM Networking Event
```

## Notes:
- I focused mainly in the logic to organize the talks.
- I couldn't finish the full logic to organize the talks, probably there are still edge cases that can require changes to the logic.
- I couldn't add specs however, I created a method for a first visualization confirmation of the logic.
- This is how the relationships of the tables could look if we are going to work with Ruby on Rails:

```ruby
# app/models/conference.rb
class Conference < ApplicationRecord
  has_many :tracks
end

# app/models/track.rb
class Track < ApplicationRecord
  belongs_to :conference
  has_many :sessions
end

# app/models/session.rb
class Session < ApplicationRecord
  belongs_to :track
  has_many :talks
end

# app/models/talk.rb
class Talk < ApplicationRecord
  belongs_to :session
end
```
