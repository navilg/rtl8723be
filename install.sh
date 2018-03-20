#!/bin/bash

######### Resolving Weak WiFi Signal - Tested in Ubuntu 16.04.3 ##################################
#######################################################################
clear

#######################################################################################
###########           ASCII Text Art     ##########################################
#######################################################################################

echo
echo " 		   **************************************** "
echo -e "\033[34m 			███╗   ██╗ █████╗ ██╗   ██╗██╗ \033[m"
echo -e "\033[34m			████╗  ██║██╔══██╗██║   ██║██║ \033[m"
echo -e "\033[34m 			██╔██╗ ██║███████║██║   ██║██║ \033[m"
echo -e "\033[34m 			██║╚██╗██║██╔══██║╚██╗ ██╔╝██║ \033[m"
echo -e "\033[34m 			██║ ╚████║██║  ██║ ╚████╔╝ ██║ \033[m"
echo -e "\033[34m 			╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ \033[m"
echo -e "		   *******\033[31m Run to find your own race \033[m*******"
echo

############################################################################################3
echo
echo -e "** Resolving Weak WiFi Signal. **\nDon't forget to give feedback on navilg0409@gmail.com"
echo

############################################################################################

###Files to be downloaded
###https://github.com/lwfinger/rtlwifi_new/archive/rock.new_btcoex.zip
###https://github.com/lwfinger/rtlwifi_new/archive/master.zip

## log file $HOME/bin/Sys_log

################# Loging in as SuperUser ###############################

sudo_login()
{
echo -e "Process running as SuperUser" 2>&1 | tee -a $HOME/bin/Sys_log
sudo echo
if [ $? != 0 ]
then
	echo -e "ERROR: Failed to login";
	exit_code
fi
}

#################################################################################

initials()
{

set -o pipefail			## 
mkdir $HOME/bin > /dev/null 2>&1
date -R > $HOME/bin/Sys_log 2>&1
echo -e "\n\n ----------------------------------------------------------------\n ---------------------------------------------------------------- \n\n" >> $HOME/bin/Sys_log 2>&1
echo -e "Checking required programs" 2>&1| tee -a $HOME/bin/Sys_log
hash wget >> $HOME/bin/Sys_log 2>&1
check1=$?
hash unzip >> $HOME/bin/Sys_log 2>&1
check2=$?
hash gcc >> $HOME/bin/Sys_log 2>&1
check3=$?
hash make >> $HOME/bin/Sys_log 2>&1
check4=$?
if [ $check1 != 0 -o $check2 != 0 -o $check3 != 0 -o $check4 != 0 ]
then
	if [ $check1 != 0 ]
	then
		echo -e "'wget' program is not installed. Please install the program 'sudo apt install wget'" 2>&1| tee -a $HOME/bin/Sys_log
	fi
	
	if [ $check2 != 0 ]
	then
		echo -e "'unzip' program is not installed. Please install the program 'sudo apt install unzip'" 2>&1| tee -a $HOME/bin/Sys_log
	fi
	
	if [ $check3 != 0 ]
	then
		echo -e "'gcc' program is not installed. Please install the program 'sudo apt install gcc'" 2>&1| tee -a $HOME/bin/Sys_log
	fi
	
	if [ $check4 != 0 ]
	then
		echo -e "'make' program is not installed. Please install the program 'sudo apt install make'" 2>&1| tee -a $HOME/bin/Sys_log
	fi
	exit_code
fi
	
}

## Exit code #############################

exit_code()
{
	echo -e "Exiting Script" 2>&1| tee -a $HOME/bin/Sys_log
	exit
}

###########################################

## 1 # Checking connectivity ###########################################################

check_connection()
{
echo -e "Checking connectivity....." 2>&1| tee -a $HOME/bin/Sys_log
wget --timeout=35 --spider https://github.com/lwfinger/rtlwifi_new >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "ERROR: Failed to connect. Check your internet connection. \n$HOME/bin/Sys_log for detailed log";
	exit_code
fi
echo -e "Connected." >> $HOME/bin/Sys_log 2>&1
}

######################################################################################

## 2 # Downloading required file #########################################################

download_file1()
{
check_connection
mkdir $HOME/.tmp_wifi >> $HOME/bin/Sys_log 2>&1
echo -e "$HOME/.tmp_wifi created" >> $HOME/bin/Sys_log 2>&1
cd $HOME/.tmp_wifi
echo -e "In directory $HOME/.tmp_wifi" >> $HOME/bin/Sys_log 2>&1
read -p "Approx 2MB of file will be downloaded. Do you want to continue ?(y/n): " ans
if [ $ans == 'y' -o $ans == 'Y' ]
then
	echo -e "Downloading required file..." 2>&1|tee -a $HOME/bin/Sys_log
	wget --timeout=35 https://github.com/lwfinger/rtlwifi_new/archive/rock.new_btcoex.zip --progress=dot -q --show-progress 2>&1 | tee -a $HOME/bin/Sys_log
	if [ $? != 0 ]
	then
		echo -e "ERROR: Failed to download. Check your internet connection \n$HOME/bin/Sys_log for detailed log";
		exit_code
	fi
	echo -e "\nFile downloaded" 2>&1|tee -a $HOME/bin/Sys_log
else
	echo -e "Aborted." 2>&1|tee -a $HOME/bin/Sys_log
	exit_code
fi
}

########################################################################################

## 3 # Installation ####################################################################

install_new1()
{

file="$HOME/.tmp_wifi/rock.new_btcoex.zip"
echo -e "Checking required files" 2>&1 | tee -a $HOME/bin/Sys_log
if [ ! -f "$file" ]
then
	echo -e "Files not found. Files will be downloaded" 2>&1 | tee -a $HOME/bin/Sys_log
	download_file1
fi
read -p "Open new terminal and type iwconfig command and copy-paste the interface name here (e.g. wlp19s0): " interface_name
echo -e "INTERFACE NAME: $interface_name" >> $HOME/bin/Sys_log 2>&1
cd $HOME/.tmp_wifi/
echo -e "In directory $HOME/.tmp_wifi/" >> $HOME/bin/Sys_log 2>&1							## change with $HOME/.tmp_wifi/rtlwifi_new-rock.new_btcoex.zip
unzip -o "$HOME/.tmp_wifi/rock.new_btcoex.zip" >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Trying with different file."
	installation_failed_retry
	exit_code
fi
cd $HOME/.tmp_wifi/rtlwifi_new-rock.new_btcoex
echo -e "In directory $HOME/.tmp_wifi/rtlwifi_new-rock.new_btcoex" >> $HOME/bin/Sys_log 2>&1
echo -e "Installing..." 2>&1 | tee -a $HOME/bin/Sys_log
echo -e "It may take few minutes. Check $HOME/bin/Sys_log for detailed log"
echo -e "."
make >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Trying with different file."
	installation_failed_retry
	exit_code
fi
echo -e ".."
sudo make install >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Trying with different file."
	installation_failed_retry
	exit_code
fi
echo -e "..."
sudo modprobe -rv rtl8723be >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Check $HOME/bin/Sys_log for detailed log" 2>&1 | tee -a $HOME/bin/Sys_log
fi

sudo modprobe -v rtl8723be ant_sel=2 >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Check $HOME/bin/Sys_log for detailed log" 2>&1 | tee -a $HOME/bin/Sys_log
fi

sudo ip link set $interface_name up >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Check $HOME/bin/Sys_log for detailed log" 2>&1 | tee -a $HOME/bin/Sys_log
fi

sudo iw dev $interface_name scan >> $HOME/bin/Sys_log 2>&1
if [ $? != 0 ]
then
	echo -e "Installation failed. Check $HOME/bin/Sys_log for detailed log" 2>&1 | tee -a $HOME/bin/Sys_log
fi

echo "options rtl8723be ant_sel=2"|sudo tee /etc/modprobe.d/50-rtl8723be.conf >> /dev/null 2>&1
read -p "Do you want to remove downloaded temporary files ? Retaining files will ensure faster installation next time.(y/n): " ans3
if [ $ans3 == 'y' -o $ans3 == 'Y' ]
then
	sudo rm -r $HOME/.tmp_wifi >> $HOME/bin/Sys_log 2>&1
	if [ $? != 0 ]
	then
		echo -e "\nFailed to remove temporary files" 2>&1 | tee -a $HOME/bin/Sys_log
	fi
fi
echo -e "Installation Successful" >> $HOME/bin/Sys_log 2>&1
echo -e "\n\n ----------------------------------------------------------------\n ---------------------------------------------------------------- \n\n" >> $HOME/bin/Sys_log 2>&1
date -R > $HOME/bin/Sys_log 2>&1
echo -e "\n\n" >> $HOME/bin/Sys_log 2>&1
read -p "Installation Successful. Do you want to reboot now ?(y/n): " ans
if [ $ans == 'y' -o $ans == 'Y' ]
then
	reboot
else
	echo -e "Don't forget to reboot manually."
	exit_code
fi
}
########################################################################################

## 0 # Functions _for installation using another _file ####################################

download_file2()
{
	cd $HOME/.tmp_wifi
	echo -e "In directory $HOME/.tmp_wifi" >> $HOME/bin/Sys_log 2>&1
	read -p "Approx 2MB of another file will be downloaded. Do you want to continue ?(y/n): " ans
	if [ $ans == 'y' -o $ans == 'Y' ]
	then
		echo -e "Downloading required file..." 2>&1|tee -a $HOME/bin/Sys_log
		wget --timeout=35 https://github.com/lwfinger/rtlwifi_new/archive/master.zip --progress=dot -q --show-progress 2>&1 | tee -a $HOME/bin/Sys_log
		if [ $? != 0 ]
		then
			echo -e "ERROR: Failed to download. Check your internet connection \n$HOME/bin/Sys_log for detailed log";
			exit_code
		fi
		echo -e "\nFile downloaded" 2>&1|tee -a $HOME/bin/Sys_log
	else
		echo -e "Aborted." 2>&1|tee -a $HOME/bin/Sys_log
		exit_code
	fi
}

install_new2()
{	
	file="$HOME/.tmp_wifi/master.zip"
	echo -e "Checking required files" 2>&1 | tee -a $HOME/bin/Sys_log
	if [ ! -f "$file" ]
	then
		echo -e "Files not found. Files will be downloaded" 2>&1 | tee -a $HOME/bin/Sys_log
		download_file2
	fi
	read -p "Open new terminal and type iwconfig command and copy-paste the interface name here (e.g. wlp19s0): " interface_name
	echo -e "INTERFACE NAME: $interface_name" >> $HOME/bin/Sys_log 2>&1
	cd $HOME/.tmp_wifi/
	echo -e "In directory $HOME/.tmp_wifi/" >> $HOME/bin/Sys_log 2>&1
	unzip -o "$HOME/.tmp_wifi/master.zip" >> $HOME/bin/Sys_log 2>&1
	if [ $? != 0 ]
	then
		echo -e "Installation failed."
		exit_code
	fi
	cd $HOME/.tmp_wifi/rtlwifi_new-master
	echo -e "In directory $HOME/.tmp_wifi/rtlwifi_new-master" >> $HOME/bin/Sys_log 2>&1
	echo -e "Installing..." 2>&1 | tee -a $HOME/bin/Sys_log
	echo -e "It may take few minutes. Check $HOME/bin/Sys_log for detailed log"
	echo -e "."
	make >> $HOME/bin/Sys_log 2>&1
	if [ $? != 0 ]
	then
		echo -e "Installation failed."
		exit_code
	fi
	echo -e ".."
	sudo make install >> $HOME/bin/Sys_log 2>&1
	if [ $? != 0 ]
	then
			echo -e "Installation failed."
			exit_code
	fi
	echo -e "..."
	sudo modprobe -rv rtl8723be >> $HOME/bin/Sys_log 2>&1
	sudo modprobe -v rtl8723be ant_sel=2 >> $HOME/bin/Sys_log 2>&1
	sudo ip link set $interface_name up >> $HOME/bin/Sys_log 2>&1
	sudo iw dev $interface_name scan >> $HOME/bin/Sys_log 2>&1
	echo "options rtl8723be ant_sel=2"|sudo tee /etc/modprobe.d/50-rtl8723be.conf >> /dev/null 2>&1
	read -p "Do you want to remove downloaded temporary files ? Retaining files will help faster installation next time.(y/n): " ans2
	if [ $ans2 == 'y' -o $ans2 == 'Y' ]
	then
		sudo rm -r $HOME/.tmp_wifi >> $HOME/bin/Sys_log 2>&1
			if [ $? != 0 ]
			then
				echo -e "\nFailed to remove temporary files" 2>&1 | tee -a $HOME/bin/Sys_log
			fi
	fi
	echo -e "Installation Successful" >> $HOME/bin/Sys_log 2>&1
	echo -e "\n\n ----------------------------------------------------------------\n ---------------------------------------------------------------- \n\n" >> $HOME/bin/Sys_log 2>&1
	date -R > $HOME/bin/Sys_log 2>&1
	echo -e "\n\n" >> $HOME/bin/Sys_log 2>&1
	read -p "Installation Successful. Do you want to reboot now ?(y/n): " ans1
	if [ $ans1 == 'y' -o $ans1 == 'Y' ]
	then
		reboot
	else
		echo -e "Don't forget to reboot manually."
		exit_code
	fi
}	

########################################################################################

### Re-trying with another _file ########################################################

installation_failed_retry()
{
	install_new2
	exit_code
}

########################################################################################
	
############################ Main Script ###############################################################

sudo_login
initials
install_new1
exit_code

########################################################################################
