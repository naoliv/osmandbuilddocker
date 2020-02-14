FROM debian:stretch-slim
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update
RUN mkdir -p /usr/share/man/man1
RUN apt-get -y install openjdk-8-jdk
RUN apt-get -y install git wget unzip make
RUN wget https://services.gradle.org/distributions/gradle-5.6.2-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-*.zip
RUN ln -s /opt/gradle/gradle-5.6.2 /opt/gradle/latest
RUN echo 'export GRADLE_HOME=/opt/gradle/latest' >> /root/.bashrc
RUN echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' >> /root/.bashrc
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -P /tmp
RUN mkdir -p /opt/android_sdk
RUN unzip -d /opt/android_sdk /tmp/sdk-tools-linux-*.zip
RUN echo 'export ANDROID_HOME=/opt/android_sdk' >> /root/.bashrc
RUN echo 'export ANDROID_SDK=/opt/android_sdk' >> /root/.bashrc
RUN echo 'export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${PATH}' >> /root/.bashrc
RUN mkdir -p /root/.android
RUN touch /root/.android/repositories.cfg
RUN yes | /opt/android_sdk/tools/bin/sdkmanager --licenses
RUN /opt/android_sdk/tools/bin/sdkmanager "platform-tools" "build-tools;28.0.3" "platforms;android-28"
RUN wget https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip -P /tmp
RUN mkdir -p /opt/android_ndk
RUN unzip -d /opt/android_ndk /tmp/android-ndk-r21-linux-x86_64.zip
RUN echo 'export ANDROID_NDK=/opt/android_ndk' >> /root/.bashrc
RUN apt-get -y upgrade
RUN mkdir -p /osmand/build
RUN mkdir -p /osmand/git
RUN mkdir -p /osmand/output
RUN git clone https://github.com/osmandapp/Osmand.git /osmand/git/Osmand
RUN git clone https://github.com/osmandapp/OsmAnd-resources.git /osmand/git/resources
RUN git clone https://github.com/osmandapp/OsmAnd-core.git /osmand/git/core

VOLUME ["/osmand/output"]
