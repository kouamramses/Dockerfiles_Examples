FROM payara/server-full:5.194

USER root

RUN apt-get update && \
    apt-get install -y curl tar && \
    rm -rf /var/lib/apt/lists/*

# Télécharge le fichier tar.gz du jdbc sqlServer et l'extrait
RUN curl -L -o /tmp/sqljdbc_12.2.0.0_fra.tar.gz https://go.microsoft.com/fwlink/?linkid=2222954 

RUN tar xvf /tmp/sqljdbc_12.2.0.0_fra.tar.gz -C /tmp/ 

RUN rm /tmp/sqljdbc_12.2.0.0_fra.tar.gz

# Copie le contenu extrait dans le répertoire de la bibliothèque du domaine
RUN cp /tmp/sqljdbc_12.2/enu/mssql-jdbc-12.2.0.jre8.jar /opt/payara/appserver/glassfish/domains/production/lib/

COPY dist/NOM_WAR.war $DEPLOY_DIR

COPY script.sh $PAYARA_DIR

EXPOSE 8080

CMD  sh $PAYARA_DIR/script.sh && sh /opt/payara/scripts/startInForeground.sh
