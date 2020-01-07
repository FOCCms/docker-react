# создаём фазу для сборки проекта, которую называем builder
FROM node:alpine as builder
# указываем директорию
WORKDIR '/app'
# копируем файл с зависимостями
COPY package.json .
# устанавлимваем всё что надо
RUN npm install
#  копируем файлы проекта в контейнер
COPY . .
# собираем проект
RUN npm run build

# берём нгинкс
FROM nginx
# копируем в его дефолтную папку всё, что мы набилдили на предыдущем этапе
COPY --from=builder /app/build /usr/share/nginx/html
# не запускаем, т.к. он делает это сам по дефолту

