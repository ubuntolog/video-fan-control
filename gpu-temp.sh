#!/bin/zsh

smiOut=$(nvidia-smi -q -d temperature)

gpuTemp="${smiOut#*GPU Current Temp}"
gpuTemp="${gpuTemp#*:}"
gpuTemp="${gpuTemp%%GPU Shutdown Temp*}"
gpuTemp="${gpuTemp%%C*}"
gpuTemp=$(echo $gpuTemp | sed -e 's/^[ \t]*//')


#echo "$smiOut"
echo "Current GPU temperature: $gpuTemp"
echo "Previously saved value: $GPU_CUR_TEMP"


gpuTemp=$(($gpuTemp + 0))

if [[ $gpuTemp != $GPU_CUR_TEMP ]]; then
	echo "The GPU temperature has changed. The fans have to be adjusted"

	if [[ $gpuTemp -gt 0 && $gpuTemp -lt 25 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=5'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=5'
	fi

	if [[ $gpuTemp -gt 24 && $gpuTemp -lt 30 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=10'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=10'
	fi

	if [[ $gpuTemp -gt 29 && $gpuTemp -lt 35 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=15'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=15'
	fi

	if [[ $gpuTemp -gt 34 && $gpuTemp -lt 40 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=30'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=30'
	fi

	if [[ $gpuTemp -gt 39 && $gpuTemp -lt 45 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=40'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=40'
	fi

	if [[ $gpuTemp -gt 44 && $gpuTemp -lt 50 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=50'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=50'
	fi

	if [[ $gpuTemp -gt 49 && $gpuTemp -lt 55 ]]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=60'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=60'
	fi

	if [ $gpuTemp -gt 54 ]; then
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=99'
		nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=99'
	fi
fi

export GPU_CUR_TEMP=$(($gpuTemp))
echo "Updated environment variable: $GPU_CUR_TEMP"