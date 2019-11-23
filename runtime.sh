VER=$(curl http://admin:admin123@10.128.0.7:8081/repository/studenapp-snapshot/com/jdevs/studentapp/maven-metadata.xml | grep SNAPSHOT | sed -e 's/<version>//g' -e 's/<\/version>//g' | xargs | xargs -n1 | sort | tail -1)
IDNO=$(echo $VER | awk -F - '{print $1F}')
FINALVER=$(curl http://admin:admin123@10.128.0.7:8081/service/rest/repository/browse/studenapp-snapshot/com/jdevs/studentapp/$VER/ | html2text | grep "$IDNO-" | tail -1)
http_url=http://admin:admin123@10.128.0.7:8081/repository/studenapp-snapshot/com/jdevs/studentapp/
STUDENTWAR=$http_url/$VER/studentapp-$FINALVER.war)
echo $STUDENTWAR