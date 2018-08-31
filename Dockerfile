FROM gcr.io/google_appengine/base

# Install Python, pip, and dev libraries necessary to compile Python libraries.
RUN apt-get -q update && \
 apt-get install --no-install-recommends -y -q \
   python2.7 python3.4 python2.7-dev python3.4-dev python-pip build-essential git mercurial \
   libffi-dev libssl-dev libxml2-dev \
   libxslt1-dev libpq-dev libmysqlclient-dev libcurl4-openssl-dev \
   libjpeg-dev zlib1g-dev libpng12-dev \
   gfortran libblas-dev liblapack-dev libatlas-dev libquadmath0 \
   libfreetype6-dev pkg-config swig curl\
   && \
 apt-get clean && rm /var/lib/apt/lists/*_*

# Setup locale.
ENV LANG C.UTF-8

# Upgrade pip and install virtualenv.
RUN pip install --upgrade pip virtualenv

RUN ln -s /home/vmagent/app /app
WORKDIR /app

# Port 8080 is the port used by Google App Engine for serving HTTP traffic.
EXPOSE 8080
ENV PORT 8080

# Create a virtualenv for the application dependencies.
# If you want to use Python 3, add the -p python3.4 flag.
RUN virtualenv /env

# Set virtualenv environment variables. This is equivalent to running
# source /env/bin/activate. This ensures the application is executed within
# the context of the virtualenv and will have access to its dependencies.
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

# Install dependencies.
ADD requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

# Add application code.
ADD . /app

# Instead of using gunicorn directly, we'll use Honcho. Honcho is a python port
# of the Foreman process manager. $PROCESSES is set in the pod manifest
# to control which processes Honcho will start.
CMD honcho start -f /app/procfile $PROCESSES
