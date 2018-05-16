image=$(echo "$1" | cut -d: -f1 | cut -d- -f1)
if [ -z "$(docker ps | grep $image)" ]; then
        image_num=$image
else
        image_num=$(echo -e "$image$(docker ps | grep $image | wc -l)")
fi
#variables for sanitizing the given image into a valid container name

echo "options; defaults to -it"
   read args
      if [ -z "$args" ]; then \
        args="-it"
      fi
echo "$image_num"
      echo "Run entrypoint and run in background, y/n?"
        read answer
        case $answer in
                y | yes | "") \
                  docker run --rm $args --name $image_num -dit $1 && \
                  echo -e "$ docker run --rm $args --name $image_num -dit $1
$ docker exec -it $image_num bash" &&
#                 sleep 1 &&
                  docker exec -it $image_num bash ;;

                n | no) \
                  echo -e "docker run --rm $args --name $image_num -it $1 bash" &&
                  docker run --rm $args --name $image_num -it $1 bash ;;
        esac
          }
