build_nbr=${1:-0}
distr=${2:-focal}

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
cat << EOF > CHANGELOG.rst
$title
$(printf '%*s' "${#title}" | tr ' ' "-")
* commit: $(git rev-parse HEAD)
EOF

bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro foxy --place-template-files \
&& sed -i "s/@(DebianInc)@(Distribution)//" debian/changelog.em \
&& [ ! "$distr" = "" ] && sed -i "s/@(Distribution)/${distr}/" debian/changelog.em || : \
&& bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro foxy --process-template-files \
&& sed -i 's/^\tdh_shlibdeps.*/& --dpkg-shlibdeps-params=--ignore-missing-info/g' debian/rules \
&& fakeroot debian/rules binary
