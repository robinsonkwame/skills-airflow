# skills-airflow
Orchestration of data processing tasks to power the Open Skills API

## Dependencies

- Docker
- docker-compose

## Getting Started
- Create virtualenv (ie `virtualenv -p /usr/bin/python3.4 venv`)
- `./standup.sh` # wait a couple of minutes for it to stand itself up

That's it.

### Adding a column

The database tables are defined in [api_sync/v1/models](api_sync/v1/models) in SQLAlchemy Declarative format. Alembic's migration auto-generator can pick up many changes to these files, such as new columns or tables.

- `alembic revision --autogenerate -m "Added new column"` (creates a new migration based on changes to the models not present in the database)
- `alembic upgrade head` (Upgrades the database to the latest migration)

For a more complete view of what is possible with Alembic, visit its [tutorial](http://alembic.zzzcomputing.com/en/latest/tutorial.html).

Once a column or table is created, data can be loaded into it from the [api_sync DAG](dags/api_sync_v1.py). New operators are defined in this DAG for each table, which generally call loaders defined in [api_sync/v1](api_sync/v1) to do the lower-level data loading.
