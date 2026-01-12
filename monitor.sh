#!/BIN/BASH

LOG_FILE="$HOME/projects/linus-system-monitor/system.log"
THRESHOLD=80
while true
do

clear
echo"===SYSTEM MONITOR($(date))==="
# CPU Usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 -$8}')
echo "CPU Usage: $CPU%" 

# Memory usage
MEM=$(free | awk 'NR==2 {print(($3/$2)}')
echo "Memory Usage: $MEM%"

#Disk Usage
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $DISK%"

#Log to file
echo "$(date) | CPU: $CPU% | MEM: $MEM% | DISK: $DISK%" >> "$LOG_FILE"

# Alert if disk > Threshold
if ["$DISK" -gt "$THRESHOLD" ]; then
echo "WARNING: DISK usage is above $THRESHOLD% | tee -a "$LOG_FILE"
fi
sleep 5
done
