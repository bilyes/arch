### 99-monitor-hotplug
The following variables might need to be adjusted:
- `DISPLAY`: The display currently in use. Run `env | grep DISPLAY` to find out the current value.
- `XAUTHORITY`: The path to Xauthority file holding xauth cookie. Run `env | grep XAUTHORITY` to get the current value.

Note: These values should match the ones is use while logged in as the user (not root).

The script path (in `RUN`) should correspond to where the `monitor-hotplug.sh` script is located. Likely under `/home/<YOUR_USERNAME>/scripts/monitor-hotplug.sh``

