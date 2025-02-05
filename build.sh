#!/bin/bash
docker build -t test .
docker run -itd -p 93:80 test
