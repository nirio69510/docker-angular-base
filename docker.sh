# @Author: PRIN Nicolas <NicoPrin>
# @Date:   02-26-2017 15:02:28
# @Email:  contact@nicolasprin.fr
# @Filename: docker.sh
# @Last modified by:   NicoPrin
# @Last modified time: 02-26-2017 16:09:43
# @License: MIT



#!/bin/sh

# Functions declarations
build() {
    echo "Building docker image..." && docker build --rm -t nprin/angular_frontend --file Dockerfile . && echo "Done!"
}

run() {
    echo "Cleaning dangling volumes..."
    docker volume rm $(docker volume ls -qf dangling=true) || echo "Nothing to clean!"

    echo "Stop running dev containers..."
    docker stop nprin_angular_frontend && echo " stopped!" || echo "Nothing to stop."
    docker rm -v nprin_angular_frontend && echo " removed!" || echo "Nothing to remove."
    echo "Running development container in foreground..."
    docker run --rm -t -i -v $(pwd):/frontend -p 3000:3000 --name nprin_angular_frontend nprin/angular_frontend npm start
}

case "$1" in
    b | build )
        if [ $# -eq 2 ]; then
            build $2
        else
            build
        fi;;
    r | run )
        if [ $# -eq 2 ]; then
            run $2
        else
            run
        fi;;
esac
exit 0
