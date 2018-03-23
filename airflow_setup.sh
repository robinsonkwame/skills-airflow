# Set up Airflow related variables, dags
export AIRFLOW_HOME=/home/ubuntu/skills-airflow
export PYTHONPATH=$PYTHONPATH:/home/ubuntu/skills-airflow
# ... remove example dags because we don't want the clutter
mv -n ../skills/lib/python3.5/site-packages/airflow/example_dags\
      ../skills/lib/python3.5/site-packages/airflow/_example_dags

airflow initdb

# Fix up airflow.cfg
cat config/airflow_extras.cfg >> $AIRFLOW_HOME/airflow.cfg

#sed -i '/dags_folder = */c\dags_folder = '"$local_repo"'skills-airflow/dags' $AIRFLOW_HOME/airflow.cfg
#
## Airflow needs a path from which to look for skills-airflow library
#
## Initalize Airflow database on first run, kick off a scheduler (sequential) and webserver
## Also shutdown any current webserver already running
##cat $AIRFLOW_HOME/airflow-webserver.pid | xargs kill -9
##airflow scheduler &
##airflow webserver -hn 127.0.0.1 -p 8080 &
###google-chrome-stable --args 'http://127.0.0.1:8080'
