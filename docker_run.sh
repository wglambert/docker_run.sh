image=$(echo "$1" | cut -d- -f1 | cut -d: -f1 | cut -d- -f1)
if [ -z "$(docker ps | grep $image)" ]; then
        image_num=$image
else
        image_num=$(echo -e "$image$(docker ps | grep $image | wc -l)") 
fi

if [ "$(echo "$1" | grep alpine)" ]; then
        shell=sh
else
        shell=bash
fi

echo "options; defaults to -d"
   read -e args
      if [ -z "$args" ]; then \
        args="-d"
      fi
echo -e "container name: \033[0;36m$image_num\033[0m \n"
      echo "exec -it $image_num $shell, y/n?"
        read -e answer
        case $answer in
                y | yes | "") \
                  docker run --rm $args --name $image_num -d $1 && \
                  echo -e "\n$ docker run --rm $args --name $image_num $1
$ docker exec -it $image_num $shell" && 
                  docker exec -it $image_num $shell ;; 

                n | no) \
                  echo -e "\n$ docker run --rm $args --name $image_num -it $1" &&
                  docker run --rm $args --name $image_num -it $1 ;;
        esac
