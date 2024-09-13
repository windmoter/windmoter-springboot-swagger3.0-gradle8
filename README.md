# maven -> gradle변경 설치
https://jjam89.tistory.com/271
다운로드 : https://gradle.org/releases/
    - Download: binary-only
시스템 변수 - 편집 클릭 > gradle변경 path

# Swagger Introduction & Examples
SwaggerSpringDemoApplication.java 실행
java 17  
springframework-boot 3.2


# UI
http://172.26.92.250:8081/employees
http://localhost:8081/employees


# gradle
./gradlew clean build --refresh-dependencies
java -jar .\build\libs\springboot-swagger3.0-gradle8-0.0.1-SNAPSHOT.jar
gradle clean
gradle build 

# jenkins 설정
General > GitHub project
    > Project url : https://github.com/windmoter/windmoter-springboot-swagger3.0-gradle8.git/
소스 코드 관리 > git > Repositories
    > Repository URL : https://github.com/windmoter/windmoter-springboot-swagger3.0-gradle8.git
    > Credentials : github 설정 pem 키 계정 선택
소스 코드 관리 > git > Branches to build
    > Branch Specifier (blank for 'any') : */main
빌드 유발 >  GitHub hook trigger for GITScm polling : 체크
Build Steps > Add build step  > Invoke Gradle script
    > Invoke Gradle : Gradle installations
    > Tasks : clean build
빌드 후 조치 >  Add another task > Post build task
    > Tasks > Log text : BUILD SUCCESSFUL
    > Tasks > Operation : AND
    > Tasks > Script  
        echo "Build 성공"
        pkill -f  springboot-swagger3.0-gradle8-0.0.1-SNAPSHOT.war || true
        sleep 10
        java -jar /var/jenkins_home/workspace/springboot-swagger3.0-gradle8/build/libs/springboot-swagger3.0-gradle8-0.0.1-SNAPSHOT.war & 
        echo "배포까지 성공 !!"
    > Tasks > Run script only if all previous steps were successful :  체크

# docker-compos
sudo docker images
sudo docker ps -a
sudo docker-compose down
sudo docker-compose up -d
sudo docker exec -u root -it jenkins-main /bin/bash
sudo docker exec -u root -it nginx-server /bin/bash

sudo docker restart jenkins // dockerfile  
sudo docker-compose restart jenkins // docker-compse
sudo docker-compose restart nginx
 sudo docker-compose logs nginx

# docker images 생성
docker commit [컨테이너_ID] [새로운_이미지_이름:태그-jenkins-coustom-user:latest]
sudo docker rmi jenkins-coustom-user:latest
sudo docker run -d --name my-jenkins-container -p 9061:8080 jenkins-coustom-user:latest
sudo docker login -u kandlstleo
sudo docker tag jenkins-custom kandlstleo/jenkins-custom-user:latest
sudo docker push kandlstleo/jenkins-custom-user:latest
 
# nginx config 설정


# servier  접속
http://172.26.92.250/employees


# pipline TEST
