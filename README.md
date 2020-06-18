We are going to resolve Ubuntu weak wifi signal issue 
using an easy installation script

This script is tested successfully on Ubuntu 16.04.3 LTS.

##############################################################################################################################################################

DISCLAIMER: It is advised to take backup of the data and system configuration and proceed at your own risk.
This setup fully depends on Linux kernels, current patches and versions. So in some cases this installer might not work as expected. Feedback is appreciated.
There is no risk of losing data. But there might be small risk to lose some of system configurations.
It is always ewcommended to create a restore point and keep a backup of the same as in case if system configuration is lossed or tool work unexpected, 
it can be restored back.

RECOMMENDED backup tool: 'Timeshift' or 'Systemback'. Any other backup tool can also be used

##############################################################################################################################################################

Initially you will require a internet connection. So, You can sit near to your router or connect with LAN network.

Steps:


1. Go to download path and extract the zip file

2. After extraction we will see a folder rtl8723be-script folder

3. Go inside that folder and you will find install.sh file. We will use this script to run the programs

4. Make sure you have installed following programs in your system.
Programs:

unzip : You can install it using 'sudo apt install unzip'
make : You can install it using 'sudo apt install make'
gcc : You can install it using 'sudo apt install gcc'
wget : You can install it using 'sudo apt install wget'


5. Now we will run the sript in terminal.

bash '/home/navi/Downloads/rtl8723be-script/install.sh'

6. It will ask for password so that it can install the programs as SuperUser

7. It will check for required programs. If all programs mentioned above exist in your system then it will proceed with installation procedure or else it will ask to install those programs. Those programs are by default installed in Ubuntu 16.04.3. 

8. It will ask for permission to download required files. After typing y file will be downloaded

9. Now you need to provide interface name of your wifi.

You can check that using iwconfig command. For that open new terminal

10. Copy paste the interface name

11. Installation is in progress it may take some time. Be patient. Nothing will show on terminal except dot at the time of installation.

12. If installation fails,

Don't worry. It will try installing another file to resolve the issue

Press y and enter

Again it will download another file

Again provide interface name

It will try installing and may take few minutes based on your system speed.


13. you can check the background installation processes in log file displayed on the screen

14. Now it will ask if you want to delete downloaded files. If you delete downloaded files. You will need internet connection again if in future you will need to install it again. If you retain it you don't require internet connection again and installation will be faster.

You can retain it or delete it based on your choice. I want to delete it as I already have those file 

15. Installation successful. You can reboot the system for better performance.


16. Installation is successful. After rebooting you will find strong wifi signal.


Please let me know your feedback, suggestions or any bugs on navilg0409@gmail.com

Thank YOu

:)


