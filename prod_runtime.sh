VER=$(curl http://admin:admin123@10.128.0.5:8081/repository/Studentapp-snapshot/com/jdevs/studentapp/maven-metadata.xml | grep SNAPSHOT | sed -e 's/<version>//g' -e 's/<\/version>//g' | xargs | xargs -n1 | sort | tail -1)
IDNO=$(echo $VER | awk -F - '{print $1F}')
FINALVER=$(curl http://admin:admin123@10.128.0.5:8081/service/rest/repository/browse/Studentapp-snapshot/com/jdevs/studentapp/$VER/ | html2text | grep "$IDNO-" | tail -1 | awk -F  - '{print $nF}' | cut -d " " -f1)
http_url=http://admin:admin123@10.128.0.5:8081/repository/Studentapp-snapshot/com/jdevs/studentapp
URL=$http_url/$VER/studentapp-$FINALVER.war
echo $VER
echo $IDNO
echo $FINALVER
echo $http_url
echo $URL
STUDENTWAR=$URL
echo $STUDENTWAR
#ansible-playbook playbooks/studentapp-deploy.yaml -i inventory -u student --extra-vars "ansible_sudo_pass=student"
ansible-playbook playbooks/prod_depoy.yaml -i inventory --user=prod --extra-vars "ansible_sudo_pass=prod" -e "STUDENTWAR=$STUDENTWAR"
