import os, time
import sys
import signal

def sigchld_handler(signum, frame):
    print("Wait needed to process SIGCHILD")
    os.wait()

def sigterm_handler(signum, frame):
    print('SIGTERM processing')
    sys.exit(0)


def sigint_handler(signum, frame):
    print('SIGINT processing')
    sys.exit(0)

signal.signal(signal.SIGCHLD, sigchld_handler)
signal.signal(signal.SIGTERM, sigterm_handler)
signal.signal(signal.SIGINT, sigint_handler)

print('Signal handling example')
pid = os.fork()
print('Foked, pid of my child is %s' % pid)
if pid == 0:
    print('I am a child. Im going to sleep')
    for i in range(1,70):
      print('\x1b[6;30;42m' + 'Hello from child'  + '\x1b[0m')
      a = 2**i
      print(a)
      pid = os.fork()
      if pid == 0:
            print('my name is %s' % a)
            sys.exit(0)
      else:
            print("my child pid is %s" % pid)
      time.sleep(1)
    print('Bye')
    sys.exit(0)

else:
    for i in range(1,200):
      print('Hello from main process')

      time.sleep(1)
      print(3**i)
    print('I am the parent')

#pid, status = os.waitpid(pid, 0)
#print "wait returned, pid = %d, status = %d" % (pid, status)
