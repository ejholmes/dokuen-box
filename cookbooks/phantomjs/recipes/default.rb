package "chrpath"
package "git-core"
package "libssl-dev"
package "libfontconfig1-dev"

bash "install_phantomjs" do
  user "root"
  code <<EOF
if [ ! -f /usr/local/bin/phantomjs ]; then
  mkdir -p /tmp/phantomjs &&
  git clone git://github.com/ariya/phantomjs.git && cd phantomjs &&
  git checkout 1.7 &&
  ./build.sh &&
  cp bin/phantomjs /usr/local/bin
fi
EOF
end
