## 项目名称
yuesen_air_purification - 悦森空气净化项目
## 技术架构
* PHP >7.1.0
* MySQL >5.7.0
* Nginx >1.12.0
* Laravel > 5.5.0
## 安装第三方组件
>注意：可以自定义 [`composer`](https://pkg.phpcomposer.com/) 镜像，加快拉取速度

```
$ composer update
```
## 目录结构及权限
###配置 `.env` 文件，数据库、redis 等
```
$ cp .env.example .env
```
### 创建目录
> 注意：git clone 从仓库拉取的代码，可能会存在 storage 目录缺失的问题，需要手动创建

```
$ mkdir -p storage/{app,debugbar,framework,logs}
$ mkdir -p storage/framework/{cache,sessions,testing,views}
```
### 修改权限
>注意：必须保证 `storage`，`bootstarp/cache` 有读写权限

```
$ chmod -R 777 storage bootstrap/cache
```
## 创建 KEY
```
$ php artisan key:generate
```
## 创建 storage 到 public 的软链接
> 注意：如果是 Docker 环境，此步骤必须在容器内执行
```
$ php artisan storage:link
```
## 数据迁移及导入初始化 SQL
### 数据迁移
> 注意：如果是 Docker 环境，此步骤必须在容器内执行
```
$ php artisan migrate
```
### 导入初始 sql
sql 文件位于根目录，`nt_admin_framework_init.sql`，建议使用 Navicat 导入。
### 添加计划任务 `crontab`
```cron
* * * * * php <项目目录>/artisan schedule:run
```
