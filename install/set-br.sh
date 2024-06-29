#!/bin/bash

REPOSC="https://raw.githubusercontent.com/sengnawang/premium/main"
apt install rclone
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "${REPOSC}/install/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
cd /usr/bin
wget -q -O backup "${REPOSC}/menu/backup.sh"
wget -q -O restore "${REPOSC}/menu/restore.sh"
wget -q -O cleaner "${REPOSC}/install/cleaner.sh"
wget -q -O xp "${REPOSC}/menu/xp.sh"
chmod +x /usr/bin/backup
chmod +x /usr/bin/restore
chmod +x /usr/bin/cleaner
chmod +x /usr/bin/xp
cd
cat > /home/re_otm <<-END
7
END

service cron restart > /dev/null 2>&1

# > Pasang Limit

#wget -q ${REPOSC}/bin/limit.sh" >/dev/null 2>&1

#chmod +x limit.sh && bash limit.sh >/dev/null 2>&1
rm -f /root/set-br.sh
#rm -f /root/limit.sh
