#!/bin/bash

echo "Updating package lists..."
apt-get update
echo "Done."

echo "Attempting to install Java 9 & Maven..."
apt-get install -y default-jdk maven
echo "Done."

echo "Attempting to install MySQL"
apt-get install -y debconf-utils
echo "MySQL default password is \"password\" ..."
debconf-set-selections <<< "mysql-server mysql-server/root_password password password"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password password"
apt-get install -y mysql-server
echo "Done."

echo "Attempting to install Apache..."
apt-get install -y git
echo "Done."

echo "Updating OpenMRS source code."
cd openmrs-core
git pull origin master
echo "Extracting pre-built pom and jar files... We don't have all week"
tar -xzf /home/vagrant/box_setup/m2.tgz -C /home/vagrant
echo "Starting Mysql if not started already."
systemctl start mysql
echo "Installing OpenMRS with Maven."
mvn clean install
echo "YAY full stack of openMVN installed!!!"

echo "Installing OpenMRS SDK"
mkdir openmrs-sdk
cd openmrs-sdk
mvn org.openmrs.maven.plugins:openmrs-sdk-maven-plugin:setup-sdk
echo "Done."

echo "Atomic Batteries to Power. Turbines to Speed. Rodger! Ready to Roll!"

