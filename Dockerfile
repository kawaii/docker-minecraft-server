FROM openjdk:9-jre
MAINTAINER Kane Valentine <kane@cute.im>

ENV MINECRAFT_VERSION 1.12.2
ENV MINECRAFT_SHA1 886945bfb2b978778c3a0288fd7fab09d315b25f

RUN mkdir -p /opt/minecraft/
WORKDIR /opt/minecraft/

RUN set -ex; \
	curl -o minecraft-server.jar -fSL "https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/minecraft_server.${MINECRAFT_VERSION}.jar"; \
	echo "$MINECRAFT_SHA1 *minecraft-server.jar" | sha1sum -c -; \
	chmod +x minecraft-server.jar

CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft-server.jar", "nogui"]
