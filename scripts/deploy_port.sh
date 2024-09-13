#!/bin/bash
# 작업 디렉토리를 /var/jenkins_home/custom/snapcampus으로 변경
cd /var/jenkins_home/custom/snapcampus

# 환경변수 DOCKER_APP_NAME : 애플리케이션 메인 이름
APP_NAME=spring-snapcampus
LOG_FILE=./deploy_port.log

# 포트 번호 설정
BLUE_PORT=8081
GREEN_PORT=8082

# 실행 중인 포트 확인
EXIST_BLUE=$(netstat -tuln | grep ":$BLUE_PORT")
EXIST_GREEN=$(netstat -tuln | grep ":$GREEN_PORT")

# 배포 시작한 날짜와 시간을 기록
echo "배포 시작일자 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE

# green이 실행 중이면 blue up
if [ -z "$EXIST_BLUE" ]; then
  # blue 배포 시작
  echo "blue 배포 시작 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE

  # blue 애플리케이션 실행
  nohup java -jar your-spring-boot-app.jar --server.port=$BLUE_PORT > blue.log 2>&1 &

  # 30초 대기 (애플리케이션이 시작될 시간을 고려)
  sleep 30

  # green 중단 시작
  if [ -n "$EXIST_GREEN" ]; then
    echo "green 중단 시작 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE

    # green 애플리케이션 종료
    pkill -f "your-spring-boot-app.jar --server.port=$GREEN_PORT"

    echo "green 중단 완료 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE
  fi

# blue가 실행 중이면 green up
else
  echo "green 배포 시작 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE

  # green 애플리케이션 실행
  nohup java -jar your-spring-boot-app.jar --server.port=$GREEN_PORT > green.log 2>&1 &

  # 30초 대기
  sleep 30

  # blue 중단 시작
  if [ -n "$EXIST_BLUE" ]; then
    echo "blue 중단 시작 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE

    # blue 애플리케이션 종료
    pkill -f "your-spring-boot-app.jar --server.port=$BLUE_PORT"

    echo "blue 중단 완료 : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE
  fi
fi

echo "배포 종료  : $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)" >> $LOG_FILE
echo "===================== 배포 완료 =====================" >> $LOG_FILE
echo >> $LOG_FILE
