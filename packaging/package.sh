build_nbr=$1
cd ..

if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then
        echo "--- Initialize rosdep"
        sudo rosdep init
fi
echo "--- Updating rosdep"
rosdep update

sed -i "s/[0-9]*<\/version>/${build_nbr}<\/version>/" package.xml
version=$(grep "<version>" package.xml | sed 's/[^>]*>\([^<"]*\).*/\1/')
title="$version ($(date +%Y-%m-%d))"
dashes=$(printf '%*s' "${#title}" | tr ' ' "=")
echo "$title" > CHANGELOG.rst
echo "$dashes" >> CHANGELOG.rst
echo "* commit: $(git rev-parse HEAD)" >> CHANGELOG.rst

bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro foxy && fakeroot debian/rules binary

