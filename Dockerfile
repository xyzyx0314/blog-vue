# 使用官方的node基础镜像
FROM node:latest as build-stage

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json到工作目录
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件到工作目录
COPY . .

# 构建项目
RUN npm run build

# 使用nginx镜像
FROM nginx as production-stage

# 将构建好的文件复制到nginx的html目录下
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露80端口
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
