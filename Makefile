###############################################
#
# Makefile
#
###############################################

.DEFAULT_GOAL := install

#
# BlueSee API docs
#

install:
	cp bluesee/m365.lua ~/Library/Containers/com.synapse.bluesee.appstore/Data/Library/BlueSee/Scripts/m365.lua

docs:
	open -a Google\ Chrome file:///Applications/BlueSee.app/Contents/Resources/lua_api.html

#
# Apps
#

macos:
	open https://apps.apple.com/us/app/bluesee-ble-debugger/id1336679524

ios:
	open https://apps.apple.com/us/app/bluesee-ble-debugger/id1336676493
	

#
# Links
#

bluesee:
	open -a Google\ Chrome https://www.synapse.com/bluesee/user-guide

btle:
	open -a Google\ Chrome https://www.jaredwolff.com/get-started-with-bluetooth-low-energy/

stlink:
	open -a Google\ Chrome https://www.st.com/en/development-tools/stsw-link007.html
