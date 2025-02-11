#!/bin/bash

# start services
function start_services(){

    # jenkins: 
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
}

start_services