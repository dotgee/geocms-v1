# DotGeoCMS #

DotGeoCMS is an open source tool that allows for the vizualisation of geospatial data on the web.

It was built to make it easier for people to vizualize, combine and share layers from various data sources (Geoservers/Mapservers)

You can see multiples demos at [indigeo.fr](http://indigeo.fr/visualiseur), check it out !

<img src="http://i.imgur.com/U5gHI.jpg?1" alt="dotgeocms preview" title="dotgeocms preview" width="900"/>

# DotGeoCMS - Features #

DotGeoCMS allows you to import layers from multiple GeoServers and organize them into categories.

You can then visualize them and combine them to give your map the meaning you want. Once you are done editing your custom map, you will be able to save your map and share it with others, either on DotGeoCMS or embedded on any site.

<img src="http://i.imgur.com/MGIUw.png" alt="dotgeocms preview" title="dotgeocms preview" width="900"/>

# DotGeoCMS - Dependecies #

In order for DotGeoCMS to work properly, you will need the followings installed on your machine :

- Ruby 1.9 and greater
- Rails 3.1 and greater
- PostgreSQL 9.1
- ElasticSearch

# DotGeoCMS - Installation #

The installation process should be rather straightforward once you make sure that all dependecies are installed.

1. Clone the project

  ```bash
  $ git clone https://github.com/dotgee/dotgeocms.git
  ```

2. Configure your database

  ```yaml
    development:
      adapter: postgresql
      encoding: unicode
      database: geocms_dev
      pool: 5
      username: [username]
      password: [password]
      host: localhost
  ```

3. Configure context thumbnails creation

  ```bash
  // install npm if necessary
  $ npm install -g phantomjs
  $ RAILS_ENV=production sidekiq -d -l log/sidekiq.log
  ```

4. Customize your installation

  You can edit 'config/application.yml' and define the two parameters : 
  - MONO_ACCOUNT (boolean) : Defines if you want to run only one instance or allow multiple accounts to be created on your DotGeoCMS.
  - SUBDOMAIN (string) : DotGeoCMS uses subdomain for every account. So, if you are running DotGeoCMS on a url with a subdomain, you have to write it here. (eg : I'm deploying to 'xxxxx.dotgeocms.com', if I want to run multiple accounts, I will mark 'xxxxx' as my subdomain). Note that you will have to configure your web server accordingly to accept any subdomains.

5. Run it !
  
  We recommend using [pow](http://pow.cx/) if you're just testing it on your local machine as it provides an easy way to use subdomains on DotGeoCMS.
  Don't forget to run bundle install, open the website and you're done ! We hope you will enjoy our application !

# DotGeoCMS - Contact #

DotGeoCMS is developped by Dotgee (@dotgee). If you have any questions or if you want us to build a custom implementation of DotGeoCMS to better fit your needs, send us an email at [contact@dotgee.fr](mailto:contact@dotgee.fr) !
