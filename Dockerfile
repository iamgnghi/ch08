FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat/webapps/ROOT

# copy file jsp, html
COPY web/ .

# copy file java đã biên dịch (nếu có sẵn trong out/production/)
COPY out/production/ch08_ex1_email_sol/WEB-INF ./WEB-INF

EXPOSE 8080
CMD ["catalina.sh", "run"]
