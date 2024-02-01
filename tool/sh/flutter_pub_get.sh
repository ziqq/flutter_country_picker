flutter pub get
cd packages
for dir in */ ; do

    echo "╠ DIRECTORY: ${dir}"
    cd ${dir}
    flutter pub get
    cd ..
    if [ "$#" -gt 0 ]; then shift; fi
    # shift
done