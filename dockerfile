FROM node:18-alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# EB 내 nginx에 대한
FROM nginx
EXPOSE 80
# --from=builder 빌더 컨테이너에서
# /app/dist 해당 경로에 필요한 항목을 앱에 복사
# /usr/share/nginx/html 이 위치에 복사한다. 이 위치는 빌드 파일을 복사할 수 있는 nginx의 기본 폴더. index.html 파일과 같은 모든 정적 파일 및 react에 의해 생성된 기타 파일이므로 이 html 폴더 내의 모든 항목을 복사하고 nginx는 80 포트에서 이 빌드 폴더를 제공할 것이므로
# 이는 EB 프로덕션에서 실행하기 위한 프로덕션용 Docker 파일이다.

# 이제 Docker compose가 이러한 이미지를 컨테이너로 실행할 수 있도록 docker-compose 파일을 작성한다.
COPY --from=builder /app/dist /usr/share/nginx/html

#EXPOSE 8080

#CMD [ "npm", "run", "preview" ]