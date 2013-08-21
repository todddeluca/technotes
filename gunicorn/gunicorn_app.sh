#!/bin/bash

# Source:
# http://senko.net/en/django-nginx-gunicorn/

# Purpose:
# An executable to configure and serve a wsgi app using gunicorn.

set -e

VENV=%(deploy_dir)s/venv
NUM_WORKERS=2
APP_DIR=%(deploy_dir)s/webapp
PORT=%(port)s

# module containing wsgi app needs to be in the python path.
cd $APP_DIR
exec $VENV/bin/gunicorn -w $NUM_WORKERS --bind 127.0.0.1:$PORT
  --log-level=debug heyluca:app
  --access-logfile %(logfile)s \
  --error-logfile  %(logfile)s \
  --log-file %(logfile)s



