# OpenFOSS Build Environment

This is the build environment for the OpenFOSS development group. Using VirtualBox and Vagrant

## Installing

Ensure that you have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) installed on your machine.

You have to run the following for Vagrant to share a local directory between your localbox and it's image. This way you can do your development on your machine with whatever IDE you want, and share the openmrs-core directory between the vagrant VM and your local machine.

    git clone https://github.com/OpenFOSS/openmrs-core

please ensure that it's within the same directory as this readme, as the pathing for this is relative.

Build the vagrant image:

    vagrant up

Note this takes around 15 minutes for my local build.

This will install all the required software and Java dependencies for OpenMRS to function. However running the OpenMRS web app still requires a manual start which is documented within the "Usage" section below.

If the install does not error, it should return see the following:

```
==> default: [INFO] Reactor Summary:
==> default: [INFO]
==> default: [INFO] OpenMRS ............................................ SUCCESS
==> default: [INFO] openmrs-tools ...................................... SUCCESS
==> default: [INFO] openmrs-test ....................................... SUCCESS
==> default: [INFO] openmrs-api ........................................ SUCCESS
==> default: [INFO] openmrs-web ........................................ SUCCESS
==> default: [INFO] openmrs-webapp ..................................... SUCCESS
==> default: [INFO] ------------------------------------------------------------------------
==> default: [INFO] BUILD SUCCESS
==> default: [INFO] ------------------------------------------------------------------------
==> default: [INFO] Total time: XX:XX min
==> default: [INFO] Finished at: XXXXX
==> default: [INFO] Final Memory: XX M/XX M
==> default: [INFO] ------------------------------------------------------------------------
==> default: Atomic Batteries to Power. Turbines to Speed. Rodger! Ready to Roll!
```

### Rebuilding
Building the OpenMRS webapp runs a maven install on the machine. For the first run this requires tests to be run, as the testing artifacts are required for opperation of the service.

After your first build, you don't have to do run these tests. you can build openMRS with the following:

    mvn clean install -Dmaven.test.skip=true

If you intend to run a specific test but not the whole suite you can do so with the following:

    mvn test -Dtest=Classname

## Usage

To access the internals of the box you can ssh into it with the following command:

    vagrant ssh

Running the web-app can be done with the following:

    cd openmrs-core/webapp/ && mvn jetty:run

Accessing the webapp can then be done through your local web browser:

    http://127.0.0.1:8080/openmrs

Closing the web-app can be done through the standard Ctrl+C bash command

## Debugging

It should be noted like most things that we do, there can be issues.

If you need to debug the vagrant box that OpenMRS is running on, you can do do by reading the Vagrantfile included within the build directory. This allows you to do things like allocate more ram or hard disk space from your host to the virtual box, or forward ports to the internal box.
If you need to debug the installation of OpenMRS the install of the service is documented within the install.sh script in the box_setup directory. This is where one would install various software on the virtual box that we all use.

