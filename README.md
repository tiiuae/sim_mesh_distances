# sim_mesh_distances
ROS2 node to publish distances of the drones in simulation

## Install dependencies
```
apt-get update -y && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    dh-make debhelper \
    cmake \
    git-core \
    fakeroot \
    python3-bloom \
    nlohmann-json3-dev
```

## Build with colcon 
```
colcon build
```

## Generate Debian package (Docker build)
```
build_number=1 \
&& docker build --build-arg BUILD_NUMBER=${build_number} -t fogsw-sim_mesh_distances . \
&& container_id=$(docker create fogsw-sim_mesh_distances "") \
&& docker cp ${container_id}:/packages . \
&& docker rm ${container_id} \
&& cp packages/*.deb . \
&& rm -Rf packages
```
