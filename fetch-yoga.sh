ROOT=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
cd "$ROOT" || exit 1

TMP=$(mktemp -d)

cd $TMP
git clone https://github.com/facebook/yoga.git
cd yoga
git reset --hard v1.19.0

# remove android stuff
sed -i '/android/d' CMakeLists.txt
# insert linking options
sed -i 's/add_compile_options(/add_compile_options(\n    -fPIC/' CMakeLists.txt

cd $ROOT
mkdir static_yoga/yoga/yoga
mv $TMP/yoga/yoga $TMP/yoga/CMakeLists.txt static_yoga/yoga/yoga
rm -rf $TMP
