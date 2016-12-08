
reload() {
  source ${BASH_SOURCE[0]}
}
alias r=reload

get-image-field() {
  local imageId=$1
  local field=$2
  : ${imageId:? reuired}
  : ${field:? required}

  docker images --no-trunc|sed -n "/${imageId}/ s/ \+/ /gp"|cut -d" " -f $field
}

get-image-name() {
  get-image-field $1 1
}

get-image-tag() {
  get-image-field $1 2
}

save-all-image() {
  local ids=$(docker images -q)
  local name safename tag

  for id in $ids; do
    name=$(get-image-name $id)
    tag=$(get-image-tag $id)
    if [[  $name =~ / ]] ; then
       dir=${name%/*}
       mkdir -p $dir
    fi
    echo [DEBUG] save $name:$tag ...
    (time  docker save $name:$tag | gzip -c > $name.$tag.dim) 2>&1|grep real
  done
}

load-all-image() {
  local name safename noextension tag

  for image in $(find . -name \*.dim); do
    echo [DEBUG] load
    tar -Oxzf $image repositories
    echo
    docker load -i $image
  done
}
