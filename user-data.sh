#!/bin/bash

echo "ECS_CLUSTER=alice" > /etc/ecs/ecs.config

sudo systemctl start ecs