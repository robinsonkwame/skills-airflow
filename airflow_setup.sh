# Set up Airflow related variables, dags
export AIRFLOW_HOME=/home/ubuntu/skills-airflow
export PYTHONPATH=$PYTHONPATH:/home/ubuntu/skills-airflow
# ... remove example dags because we don't want the clutter
mv -n ../skills/lib/python3.5/site-packages/airflow/example_dags\
      ../skills/lib/python3.5/site-packages/airflow/_example_dags

airflow initdb

## Fix up airflow.cfg
#cat config/airflow_extras.cfg >> $AIRFLOW_HOME/airflow.cfg
#
## Stand up Airflow, EC2 inbound should be set for your IP to look at the webserver
#
## ... shutdown any current webserver already running
#cat $AIRFLOW_HOME/airflow-webserver.pid | xargs kill -9
#
## ... stand up airflow, note host on 0.0.0.0, assume EC2 inbound protects
#airflow scheduler &
#airflow webserver -hn 0.0.0.0 -p 8080 &
