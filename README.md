# Concerto-App

Over Christmas break of my second year I got quite bored, and decided I wanted to learn Ruby, as well as more about web development. My idea was to create a site that would aggregate and list all of the local concerts in Manitoba, since that was only being done with national acts, and not amateur performances. 

Concerto consists of two parts: the scraper, and the website itself. The scraper uses Mechanize to download www.manitobamusic.com and navigate to the page with listings for all of the concerts. It then uses Nokogiri to scrape the page, parsing out the elements that are useful. The information is then dumped into a Postgres database using Sequel. 

The website is simple, in that all it does is pull concerts from the database and displays them nicely on the website. 

Note: In putting this portfolio together I realized I was violating the terms of use of www.manitobamusic.com, and thus have shut down the site.

## Features
<ul>
  <li>Scraper program</li>
  <li>Analytics using Mixpanel</li>
  <li>Testing with RSpec</li>
  <li>Website based on Sinatra</li>
</ul>


## Skills Demonstrated

<ul>
  <li>Combining multiple technologies into one project (Postgres, Javascript, Bootstrap, Ruby, RSpec, Sinatra, RESTful APIs, Mixpanel, Heroku, Git, HTML, CSS)</li>
  <li>Testing with the RSpec framework</li>
  <li>Ruby</li>
</ul>
