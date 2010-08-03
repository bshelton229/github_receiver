# Github Receiver

A sinatra app which receives a github post-receive service hook, logs the payload in a mysql database, and then tries to find a corresponding entry for the repository in /etc/github_receiver.conf, and if a corresponding entry is found, tries to git pull in the specified directory.

## Example /etc/github_receiver.conf

    ---
    great_application:
      dir: /var/rails_apps/great_application

    another_great_app:
      dir: /var/php_projects/another_great_app
