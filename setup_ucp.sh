#scp -i $STUDENT.pem ./$STUDENT.pem ubuntu@$CEPH_ADMIN_PUBLICIP:/home/ubuntu/ceph-on-AWS

# ssh -i $STUDENT.pem ubuntu@$CEPH_ADMIN_PUBLICIP "echo "LAB_SUBNET=$LAB_SUBNET" >> ./ceph-on-AWS/lab.conf"

sshpass -p 'nutanix/4u' scp -o StrictHostKeyChecking=no ./pl_rsa.pub  nutanix@192.168.178.140:
sshpass -p 'nutanix/4u' ssh nutanix@192.168.178.140 'cat ~/pl_rsa.pub >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys'
sshpass -p 'nutanix/4u' scp -o StrictHostKeyChecking=no ./pl_rsa.pub  nutanix@192.168.178.141:
sshpass -p 'nutanix/4u' ssh nutanix@192.168.178.141 'cat ~/pl_rsa.pub >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys'
sshpass -p 'nutanix/4u' scp -o StrictHostKeyChecking=no ./pl_rsa.pub  nutanix@192.168.178.142:
sshpass -p 'nutanix/4u' ssh nutanix@192.168.178.142 'cat ~/pl_rsa.pub >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys'
sshpass -p 'nutanix/4u' scp -o StrictHostKeyChecking=no ./pl_rsa.pub  nutanix@192.168.178.143:
sshpass -p 'nutanix/4u' ssh nutanix@192.168.178.143 'cat ~/pl_rsa.pub >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys'


ssh -i ./pl_rsa nutanix@192.168.178.140 "docker run --rm --tty --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:2.1.4 install --host-address 192.168.178.140  --admin-username admin --admin-password nutanix/4u  --swarm-port 2377"
MANAGER=`ssh -i ./pl_rsa nutanix@192.168.178.140 "docker swarm join-token manager -q"`
WORKER=`ssh -i ./pl_rsa nutanix@192.168.178.140 "docker swarm join-token worker -q"`

ssh -i ./pl_rsa  nutanix@192.168.178.141 "docker swarm join --token $MANAGER 192.168.178.140:2377"
ssh -i ./pl_rsa  nutanix@192.168.178.142 "docker swarm join --token $MANAGER 192.168.178.140:2377"
ssh -i ./pl_rsa  nutanix@192.168.178.143 "docker swarm join --token $WORKER 192.168.178.140:2377"

ssh -i ./pl_rsa nutanix@192.168.178.143 "docker run --rm --tty docker/dtr:2.2.4 install --ucp-node UCP4 --ucp-insecure-tls --dtr-external-url https://192.168.178.143 --ucp-url https://192.168.178.140 --ucp-username admin --ucp-password nutanix/4u"
