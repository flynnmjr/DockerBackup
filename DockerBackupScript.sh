#!

mapfile -t Apps_Backed_Up < /home/mf/Documents/backups.txt
for i in ${Apps_Backed_Up[@]}
	do
		docker stop $i
		sleep 60s
		tar -cf - "/opt/appdata/$i" -P | pigz > "/tmp/PGBackups/$(date +%F-%R)-$i\Backup.tar.gz"
		echo "tarring " + $i 
		sleep 2s
		docker start $i
		sleep 2s  
	done

echo "copying to file share"
cp -r  /tmp/PGBackups/* /nfs/Backups
sleep 5m
echo "deleting temp files"
rm -rf /tmp/PGBackups/*
