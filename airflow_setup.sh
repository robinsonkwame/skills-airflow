# Set up Airflow Directory variable if not already defined
export AIRFLOW_HOME=${AIRFLOW_HOME-/home/ubuntu/skills-airflow}

airflow initdb

# Fix up airflow.cfg

# ... Airflow examples required Hive operator to be installed
# but we don't neccesarily have it, so we do not load examples
sed -i '/load_examples = True/c\load_examples = False' $AIRFLOW_HOME/airflow.cfg

sed -i '/dags_folder = */c\dags_folder = '"$local_repo"'skills-airflow/dags' $AIRFLOW_HOME/airflow.cfg
#cat config/airflow_extras.cfg >> $AIRFLOW_HOME/airflow.cfg

# Airflow needs a path from which to look for skills-airflow library
export PYTHONPATH=$PYTHONPATH:/home/ubuntu/skills-airflow

# Initalize Airflow database on first run, kick off a scheduler (sequential) and webserver
# Also shutdown any current webserver already running
#cat $AIRFLOW_HOME/airflow-webserver.pid | xargs kill -9
#airflow scheduler &
#airflow webserver -hn 127.0.0.1 -p 8080 &
##google-chrome-stable --args 'http://127.0.0.1:8080'
