# Github Receiver

A sinatra app which receives a github post-receive service hook, logs the payload in a mysql database, and then tries to find a corresponding entry for the repository in /etc/github_receiver.conf, and if a corresponding entry is found, tries to git pull in the specified directory.

## Installation

    # Copy the config.yml.sample file to config.yml, and edit up the mysql URI for connection to the database. 
      DataMapper will automatically create the needed table.
    # Serve the app up with passenger or with any other rack deployment method

## Example /etc/github_receiver.conf

    ---
    great_application:
      dir: /var/rails_apps/great_application

    another_great_app:
      dir: /var/php_projects/another_great_app
