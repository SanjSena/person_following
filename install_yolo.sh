#!/bin/bash
# install_yolo.sh
# ===============
# Run this INSIDE the Docker container on the Jetson (once).
# After running, commit the container so changes persist.
#
# Usage:
#   chmod +x install_yolo.sh
#   ./install_yolo.sh
#
# Then commit (outside docker):
#   docker ps -a                                        # find CONT_ID
#   docker container commit <CONT_ID> robotics2_docker_image

set -e

echo "=== System dependencies ==="
apt-get update -qq
apt-get install -y --no-install-recommends \
    python3-pip libgl1-mesa-glx libglib2.0-0

echo "=== Installing ultralytics (YOLOv8) ==="
# 8.2.0 is stable on Python 3.8/3.10 (typical Jetson)
pip3 install --upgrade pip
pip3 install ultralytics==8.2.0

echo "=== Pre-downloading YOLOv8n-pose model ==="
python3 -c "from ultralytics import YOLO; YOLO('yolov8n-pose.pt'); print('Model OK')"

echo "=== Verifying cv_bridge ==="
python3 -c "from cv_bridge import CvBridge; print('cv_bridge OK')"

echo ""
echo "=== Done. NOW commit the container to save changes: ==="
echo "  1. Open a new terminal (OUTSIDE the docker)"
echo "  2. docker ps -a"
echo "  3. docker container commit <CONT_ID> robotics2_docker_image"
