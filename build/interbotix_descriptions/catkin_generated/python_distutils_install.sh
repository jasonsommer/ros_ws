#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/jason/ros_ws/src/interbotix_ros_arms/interbotix_descriptions"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jason/ros_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jason/ros_ws/install/lib/python2.7/dist-packages:/home/jason/ros_ws/build/interbotix_descriptions/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jason/ros_ws/build/interbotix_descriptions" \
    "/usr/bin/python2" \
    "/home/jason/ros_ws/src/interbotix_ros_arms/interbotix_descriptions/setup.py" \
     \
    build --build-base "/home/jason/ros_ws/build/interbotix_descriptions" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/jason/ros_ws/install" --install-scripts="/home/jason/ros_ws/install/bin"
