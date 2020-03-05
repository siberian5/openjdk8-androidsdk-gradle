FROM busybox

LABEL maintainer="maxim.yerofeyev@gmail.com"

ARG  ANDROID_COMPILE_SDK="28"
ARG  ANDROID_BUILD_TOOLS="28.0.3"
ARG  ANDROID_SDK_TOOLS="4333796"

ENV  ANDROID_HOME=/usr/local/lib/android-sdk-linux
ENV  PATH=$PATH:/usr/local/lib/android-sdk-linux/platform-tools/

