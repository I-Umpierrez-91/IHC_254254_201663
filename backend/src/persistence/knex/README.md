# Knex guide:

https://knexjs.org/guide/

# Knex Gotchas:

`npx knex migrate:make migration_task_name` - creates new migration

`npx knex migrate:latest` - run all pending migrations

`npx knex migrate:up` - run the next pending migration

`npx knex migrate:down` - roll back the most recent migration

`npx knex migrate:list` - show current state of migrations.
