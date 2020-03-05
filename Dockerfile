FROM ubuntu
#FROM openjdk:8-jdk

LABEL maintainer="maxim.yerofeyev@gmail.com"

ARG  ANDROID_COMPILE_SDK="29"
ARG  ANDROID_BUILD_TOOLS="29.0.3"
ARG  ANDROID_COMMANDLINE_TOOLS="6200805"
ARG  GRADLE_VERSION="6.2.2"

#ARG  ANDROID_SDK_TOOLS="4333796"

ENV  ANDROID_HOME=/usr/local/lib/android-sdk-linux
ENV  PATH=$PATH:/usr/local/lib/android-sdk-linux/platform-tools/:/usr/local/lib/gradle/bin

RUN apt-get --quiet update --yes  && apt-get --quiet install --yes wget tar unzip openjdk-8-jdk-headless && \
                                                                      \
wget --quiet --output-document=/tmp/commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_COMMANDLINE_TOOLS}_latest.zip && \
unzip -q -d /usr/local/lib/android-sdk-linux /tmp/commandlinetools.zip  && \
rm -rf /tmp/commandlinetools.zip                                   && \
                                                                      \
wget --quiet --output-document=/tmp/gradle-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
unzip -q -d /usr/local/lib        /tmp/gradle-bin.zip        && \
rm -rf /tmp/gradle-bin.zip                                   && \
mv /usr/local/lib/gradle-${GRADLE_VERSION} /usr/local/lib/gradle &&   \
                                                                      \
rm -rf /var/lib/apt/lists/*                                        && \
                                                                      \
echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --sdk_root=/usr/local/lib/android-sdk-linux "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null                   && \
echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --sdk_root=/usr/local/lib/android-sdk-linux "platform-tools" >/dev/null                                             && \
echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --sdk_root=/usr/local/lib/android-sdk-linux "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

RUN yes | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --sdk_root=/usr/local/lib/android-sdk-linux --licenses >/dev/null 
RUN echo "echo ; java -version ; echo ; echo android commandline-tools-version ; /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --sdk_root=/usr/local/lib/android-sdk-linux --version ; gradle -version" > /test
