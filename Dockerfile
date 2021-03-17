# sim_mesh_distances BUILDER
# There should not be need to publish this builder image anywhere
FROM ros:foxy as sim_mesh_distances-builder

ARG BUILD_NUMBER

# Install build dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    dh-make debhelper \
    cmake \
    git-core \
    fakeroot \
    python3-bloom \
    nlohmann-json3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY . sim_mesh_distances/

RUN cd sim_mesh_distances/packaging/ \
    && ./package.sh ${BUILD_NUMBER}

FROM scratch
COPY --from=sim_mesh_distances-builder /build/*.deb /packages/
