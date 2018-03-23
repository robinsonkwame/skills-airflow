# This stands up alembic, skills-airflow, reads in any dags in the dag/
# Assumes that EC2 User Data sets up access to RDS, S3 and that
# IAM Role ACECredly-S3-Access is assigned (for fetching RDS credentials
# and reading/writing to S3 bucket)

source ../skills/bin/activate

echo "... upgrading databases (alembic)"
alembic upgrade head

echo "... launching airflow, note .pid file, a browser will open up"
export AIRFLOW_HOME=${AIRFLOW_HOME-~/}
./airflow_setup.sh&

#
#echo " ... appending extra locations to the config file"
#cat config/airflow_extras.cfg >> airflow.cfg
#
#echo " ... running the scheduler!"
##airflow scheduler&
