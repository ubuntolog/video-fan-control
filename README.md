# Video Fan Control Script
Script that adjusts a video card fan depending on the temperature

## Setup
GPU Fan parameters are not visible in the NVIDIA Settings App by default. We need to change it. Find `/usr/share/X11/xorg.conf.d/10-nvidia.conf`

Add the coolbits option there and now looks like this:

>Section "OutputClass"
>    Identifier "nvidia"
>    MatchDriver "nvidia-drm"
>    Driver "nvidia"
>    Option "AllowEmptyInitialConfiguration"
>    Option "Coolbits" "28"
>    ModulePath "/usr/lib/x86_64-linux-gnu/nvidia/xorg"
>EndSection



<b>Sets fan #0 to 50%</b>
`nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=50'`

<b>Sets fan #1 to 50%</b>
`nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=50'`

<b>Create an Environment Variable</b>
- Add the line `export GPU_CUR_TEMP="0"` to your shell config
- To reload without logging out `. ~/.zshrc`

Run the script like `. ./gpu-temp.sh` to keep the envirnment variable value