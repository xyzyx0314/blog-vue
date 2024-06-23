# 基于 Node.js 的官方 Docker 镜像
FROM node:lts-alpine

# 安装一个简单的 http 服务来运行静态内容
RUN npm install -g http-server

# 设置工作目录
WORKDIR /app

# 将 package.json 和 package-lock.json 复制到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 复制项目文件到工作目录
COPY . .

# 构建应用
RUN npm run build

# 切换到构建输出的目录
WORKDIR /app/dist

# 对外暴露 8080 端口
EXPOSE 8080

# 运行 http 服务
CMD [ "http-server", "." ]
