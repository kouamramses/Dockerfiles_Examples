$PAYARA_DIR/bin/asadmin --user=admin --passwordfile=/opt/payara/passwordFile start-domain production && wait &&\
    $PAYARA_DIR/bin/asadmin --user=admin --passwordfile=/opt/payara/passwordFile  create-jdbc-connection-pool \
    --datasourceclassname com.microsoft.sqlserver.jdbc.SQLServerDataSource \
    --restype javax.sql.DataSource \
    --property User=USER:Password=PASSWORD:DatabaseName=DATABASE_NAME:ServerName=DB_NAME:IntegratedSecurity=false:\
TrustServerCertificate=false:PortNumber=1433:Encrypt=false NOM_POOL_CONNECTION && \
    $PAYARA_DIR/bin/asadmin --user=admin --passwordfile=/opt/payara/passwordFile create-jdbc-resource --connectionpoolid NOM_POOL_CONNECTION NOM_JNDI && \
    $PAYARA_DIR/bin/asadmin --user=admin --passwordfile=/opt/payara/passwordFile deploy $DEPLOY_DIR/NOM_WAR.war && $PAYARA_DIR/bin/asadmin --user=admin --passwordfile=/opt/payara/passwordFile stop-domain production