# Video Fan Control Script
Script that adjusts a video card fan speed depending on the temperature

## Setup
GPU Fan parameters are not visible in the NVIDIA Settings App by default. We need to change it. Find `/usr/share/X11/xorg.conf.d/10-nvidia.conf`

- Add the coolbits option there and now looks like this:
```
Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "Coolbits" "28"
    ModulePath "/usr/lib/x86_64-linux-gnu/nvidia/xorg"
EndSection
```
- Create an environment variable by adding the line `export GPU_CUR_TEMP="0"` to your shell config
- To reload without logging out `. ~/.zshrc` (run the script like `. ./gpu-temp.sh` to keep the envirnment variable value)

- Run `crontab -e` to add these cron jobs:
```
* * * * * /home/ubuntolog/github/video-fan-control/gpu-temp.sh 2>&1
* * * * * sleep 15;/home/ubuntolog/github/video-fan-control/gpu-temp.sh 2>&1
* * * * * sleep 30;/home/ubuntolog/github/video-fan-control/gpu-temp.sh 2>&1
* * * * * sleep 45;/home/ubuntolog/github/video-fan-control/gpu-temp.sh 2>&1
```

Now the fan speed will be automatically adjusted to the temperature every 15 seconds