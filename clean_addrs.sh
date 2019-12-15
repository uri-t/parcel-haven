grep "status" data/addr/*.json | grep "OVER" | awk -F: '{print $1}' | xargs -p rm
