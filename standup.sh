# This is a quick and dirty script that stands up skills-airflow
# against the robinsonkwame/skills-airflow fork (modifications made
# so alembic wouldn't crash on env.py, etc. etc.

# Assumes new virtualenv is active
read -p "Have you created a new virtualenv for skills-airflow to live in?" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "... great, setting up skills-airflow ..."
else
    echo " ... Okay, then please create a new python virtual env, activate it and run this script."
    exit 1
fi

pip install requirements.txt
pip install requirements-dev.txt


echo "... Standing up local elasticsearch, postgres"
docker-compose down
cd db
docker rm postgres_1
docker build .
cd ..
docker-compose down
docker-compose up&
# gives the services some time to stand up
sleep 15


echo "... upgrading databases (alembic)"
alembic upgrade head

echo "... launching airflow, note .pid file, a browser will open up"
export AIRFLOW_HOME=${AIRFLOW_HOME-~/airflow/}
./airflow_setup.sh&

echo " ... appending extra locations to the config file"
cat config/airflow_extras.cfg >> airflow/airflow.cfg

echo " ... setting ES endpoint variable"
# not tested, only used for ES normalizer
export ELASTICSEARCH_ENDPOINT=http://127.0.0.1/bank/_search?

echo " ... running the scheduler!"
#airflow scheduler&
