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

echo_and_run cd "/home/suryak/ECE3091-S2-2021/src/diff_drive"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/suryak/ECE3091-S2-2021/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/suryak/ECE3091-S2-2021/install/lib/python3/dist-packages:/home/suryak/ECE3091-S2-2021/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/suryak/ECE3091-S2-2021/build" \
    "/usr/bin/python3" \
    "/home/suryak/ECE3091-S2-2021/src/diff_drive/setup.py" \
     \
    build --build-base "/home/suryak/ECE3091-S2-2021/build/diff_drive" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/suryak/ECE3091-S2-2021/install" --install-scripts="/home/suryak/ECE3091-S2-2021/install/bin"
