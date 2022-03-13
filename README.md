# AgriVillage

> Booking project

## Requirements

To run this project you need:

- Docker-compose

To maintain this project, you may aknowledgment in:

- Docker
- VueJS
- Ruby on Rails within Postgresql

## Getting started

To run this project, run the following command:

```bash
# Copy the env file
cp .env.example .env

# Run the containers
docker-compose up
```

This will automatically set-up the backend and the frontend.
They both are accessible at:

- backend: `localhost:3000/admin`
- frontend: `localhost:8080`

## Deployments

The deployments are made through Capistrano.
To deploy in prepoduction, run:

```bash
bundle exec cap staging deploy
```

To deploy in production, run:

```bash
bundle exec cap production deploy
```

You may need SSH access to deploy to both environments.

## Backup

To create a database backup, on the production or staging environment, run the following command:

```bash
docker-compose exec db backup perform --trigger production_backup
```

Note that, in every production deployment a database backup is forced before the deployment begins.
For each backup, it will trigger a Slack notification in the AgriVillage #backup channel.

### Common issues

If the SECRET_KEY_BASE is required, add it to `/etc/environemnt` file, since the other ones are not recognized.

If there are issues with the database, remove the tmp/db folder in the server and redeply.

## Licence

Copyright AgriVillage, 2018
