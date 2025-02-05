#!/bin/bash
    echo hi123
    sh 'chmod +x build.sh'
    sh './build.sh'
    docker login -u shandeep04 -p shandeep-4621
    docker tag test shandeep04/docker_jenkins_task2
    docker push shandeep04/docker_jenkins_task2
    
