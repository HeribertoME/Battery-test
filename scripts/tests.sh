#!/usr/bin/env bash
echo "Emulator start booting..."
#$ANDROID_HOME/emulator/emulator -avd FirstEmulator -wipe-data -port 5790 &
EMULATOR_PID=$!

$ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell dumpsys batterystats --reset

set PACKAGE_ID_PARAM="$1"
set OS_TYPE_PARAM="$2"
set TEST_TYPE_PARAM="$3"
set TEST_TIME_PARAM=$4

if [ "$PACKAGE_ID_PARAM" = "" ]; then
  echo "PACKAGE ID NOT FOUND"
  exit 1
fi

if [ "$OS_TYPE_PARAM" = "iOS" ]; then
  echo "OS TYPE ID NOT YET SUPPORTED"
  exit 1
fi


# Wait for Android to finish booting
#echo "Waiting for emulator to finish booting..."
#WAIT_CMD=$($ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82')
#until $WAIT_CMD; do
 #sleep 1
#done

echo "Emulator reported that the startup process is $EMULATOR_STATUS"
sleep 10

echo "Emulator is ready for use"
# Unlock the Lock Screen
$ANDROID_HOME/platform-tools/adb connect 192.168.252.125:5555
$ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell input keyevent 82

#Clear and capture logcat
$ANDROID_HOME/platform-tools/adb logcat -c
$ANDROID_HOME/platform-tools/adb logcat > logcat.log &
LOGCAT_PID=$!


if [ "$TEST_TYPE_PARAM" = "manual" ]; then
  # Install app (Only for manually tests)
  ${WORKSPACE}/gradlew installDebug
  let minutes=60*$TEST_TIME_PARAM
  echo "Sleep process for $minutes seconds"
  sleep $minutes
else
  # Run automated tests
  ${WORKSPACE}/gradlew :app:connectedCheck :app:installDebug :app:installDebugAndroidTest
  $ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell am instrument -w com.example.batterytestapplication/android.support.test.runner.AndroidJUnitRunner
fi

# Generates battery stats file
echo "Tests is running"
echo "Generating batterystats"
if [ "$TEST_TYPE_PARAM" = "manual" ]; then
  $ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell dumpsys batterystats ${PACKAGE_ID_PARAM} > ${WORKSPACE}/batterystats.txt
else
  $ANDROID_HOME/platform-tools/adb -s 192.168.252.125:5555 shell dumpsys batterystats "${PACKAGE_ID_PARAM}.test" > ${WORKSPACE}/batterystats.txt
fi

#$ANDROID_HOME/platform-tools/adb bugreport ${WORKSPACE}/bugreport.zip

# Stop the background processes
#kill $LOGCAT_PID
#kill $EMULATOR_PID