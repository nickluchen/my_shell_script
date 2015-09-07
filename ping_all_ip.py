#!/usr/bin/env python  
  
from threading import Thread  
import subprocess  
from Queue import Queue  
import socket

dlb_debug=0
  
num_threads=10 

ip_start=1
ip_end=254
ip_prefix='10.204.5'

ips=[]

for i in range(ip_start, ip_end + 1):
	ips.append('%s.%s' %(ip_prefix, i))

report=[{} for row in range(num_threads)]

q=Queue()  

def pingip(i, queue):  
	while True:  
		ip=queue.get()  
		if dlb_debug!=0:
			print 'Thread %s pinging %s' %(i, ip)  
		p=subprocess.Popen('ping -c 4 %s' % ip
						  ,shell=True
						  ,stdout=open('/dev/null','w')
						  ,stderr=subprocess.STDOUT)  
		ret=p.wait()
		if ret==0:  
			report[i]['%s' %ip]='is alive!'
		else:  
			report[i]['%s' %ip]='is down...'
		queue.task_done()  
  
# Branch num_threads threads  
for i in range(num_threads):  
	t=Thread(target=pingip, args=(i, q))  
	t.setDaemon(True)  
	t.start()  
  
# Main thread
for ip in ips:  
	q.put(ip)  
print 'Going to ping %s.1 ~ %s' %(ip_prefix, ip_end)
print 'Main thread waiting ...'  
q.join();print 'Done'  

# Print report
buf={}
for i in range(num_threads):
	buf.update(report[i])

# Sort the reports by IP
for k in sorted(buf.iterkeys(), key=socket.inet_aton):
	print k, buf[k]
