FROM openjdk:9-jre-slim
MAINTAINER Kane Valentine <kane@cute.im>

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-suggests --no-install-recommends \
		curl \
	; \
        apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV MINECRAFT_VERSION 1.12.2
ENV MINECRAFT_SHA1 886945bfb2b978778c3a0288fd7fab09d315b25f

WORKDIR /opt/minecraft/

RUN set -ex; \
	curl -o minecraft-server.jar -fSL "https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/minecraft_server.${MINECRAFT_VERSION}.jar"; \
	echo "$MINECRAFT_SHA1 *minecraft-server.jar" | sha1sum -c -; \
	chmod +x minecraft-server.jar

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 25565
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft-server.jar", "nogui"]
