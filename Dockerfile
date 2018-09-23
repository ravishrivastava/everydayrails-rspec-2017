# Use an official Ruby runtime as a parent image
FROM ruby:2.4.1

# Define environment variable
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app
# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -y vim nodejs mysql-server mysql-client libmysqlclient-dev --no-install-recommends apt-utils 
   
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN \
#  sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" \
#  /etc/mysql/mariadb.conf.d/50-server.conf
RUN bundle install

# Make port available to the world outside this container
EXPOSE 3000
EXPOSE 3306

#ENTRYPOINT ["bundle", "exec"]

RUN ["chmod", "+x", "./cmd.sh"]

# Run rails server when the container launches
ENTRYPOINT ["./cmd.sh"]