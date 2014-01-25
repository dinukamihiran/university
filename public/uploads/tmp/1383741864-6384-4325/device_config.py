#! /usr/bin/python
#This script if for configuring GPS/GPRS tracking device via TCP protocol
"""
Configure MVT380 device by sending configuration commands over TCP

"""

import threading
import socket
import time



def createSocket(portNumber=9091, serverIP=""):
  server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  serverIP = ""
  port = portNumber
  server.bind((serverIP, port))
  server.listen(5)
  server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  print "Socket created on IP {} port {} ".format(serverIP, port)
  return server

#global variables 
serverAddress = ""
portNumber = 9090

class testConnection(threading.Thread):
  def __init__(self):
    pass
  
  def run(self):
    pass
  

def main():
  startupAnimation()
  print "Welcome To Device configuration programm"
  device_imei = str(raw_input("Enter Device IMEI number to be configured(blank if u don't know):"))
  selection_number = 1 
  if device_imei:
      print "{}. Wait for connection from {}(IMEI) device".format(selection_number)
      selection_number +=1
  print "{}. Wait for device to connect to this( {} ) server ".format(selection_number,socket.gethostname())

  selection = int(input("Select the Method: "))
  
  if selection_number > 1 and selection == 1:
      print "Not implimented yet"
    
  elif selection is 2 or selection is 1 :
    print "Not impliment yet"


    while True:
		try:
			serverSocket = createSocket()
			if serverSocket:
				break
			
		except socket.error:
			print "Delaying connection for 5 seconds due to previously failed connection attempt..."
			time.sleep(5)
			continue

    newConnection(serverSocket.accept()).start()




class newConnection(threading.Thread):
  def __init__(self, detailsPair):
    channel , address = detailsPair
    self.channel = channel
    self.connectionImei = None
    self.address = address
    #self.approvedImei = False # this has been moved to gpsObject class
    threading.Thread.__init__(self)
  
  def disconnect(self,reson="No reson specified"):
    logging.warn("Connection has been disconnected due to >" + reson)
    self.connection.commit()
    if self.cursor:
     	self.cursor.close()
    if self.channel:
     	self.channel.shutdown(2)
    self.channel.close()
    return False
   
  def reciveGpsData(self):

	try:
		recivedDataFromGpsDevice = self.channel.recv(4096)	# 4096 is the buffer size
		#print recivedDataFromGpsDevice # for debuging only
			
	except socket.error as e:
          logging.error(e)
          print "Error connection to vehicle (disconnect without FIN packet) error = {} no re-try".format(e)
#          setOnlineFlag = """update vehicle_status set disconnected_on = now(),current_status = 0 where imei = "{}" """.format(self.connectionImei)
#          self.cursor.execute(setOnlineFlag)
#          self.connection.commit()
#          self.disconnect("Recived GPS String is invalid")
          return ''
	return recivedDataFromGpsDevice
# this method is called when thread is created
  def run(self):
    while True:
        print "Waiting for incoming messages from device....."
        print self.reciveGpsData()





def startupAnimation():
	print ''
	print ' ____ _____ ____ ____ '
	time.sleep(0.1)
	print ' / \ | | / \ / \ / \ | | '
	time.sleep(0.1)
	print '| | | | | | | \ | | | '
	time.sleep(0.1)
	print '| \____/| | \____/ \___/\ |_ |_ v0.5'
	time.sleep(0.1)
	print '|______ | |_______ '
	time.sleep(0.1)
	print ' \ | \ '
	time.sleep(0.1)
	print ' | | | '
	time.sleep(0.1)
	print ' ______/ _____/ \_____/ '
	time.sleep(0.1)
	print 'Contact us for any bug reports at syscall@knnect.com '
	time.sleep(0.1)
	print '\n'


if __name__ == "__main__":
  main()




  