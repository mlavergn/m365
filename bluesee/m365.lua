local bluesee = require "bluesee"

-- define the services
local m365_info_service_uuid = bluesee.UUID.new('FE95')
bluesee.set_display_name(m365_info_service_uuid, 'Xiaomi Mi Scooter m365 - Info')
bluesee.set_display_category(m365_info_service_uuid, bluesee.device)

local m365_X_service_uuid = bluesee.UUID.new('1804')
bluesee.set_display_name(m365_X_service_uuid, 'Xiaomi Mi Scooter m365 X')
bluesee.set_display_category(m365_X_service_uuid, bluesee.device)

local m365_Y_service_uuid = bluesee.UUID.new('6E400001-B5A3-F393-E0A9-E50E24DCCA9E')
bluesee.set_display_name(m365_Y_service_uuid, 'Xiaomi Mi Scooter m365 Y')
bluesee.set_display_category(m365_Y_service_uuid, bluesee.device)

local m365_Z_service_uuid = bluesee.UUID.new('00001530-1212-EFDE-1523-785FEABCD123')
bluesee.set_display_name(m365_Z_service_uuid, 'Xiaomi Mi Scooter m365 Z')
bluesee.set_display_category(m365_Z_service_uuid, bluesee.device)


-- nRF51822

-- define characteristics
local info_01_uuid = bluesee.UUID.new('0001')
local info_02_uuid = bluesee.UUID.new('0002')
local info_04_uuid = bluesee.UUID.new('0004')
local info_10_uuid = bluesee.UUID.new('0010')
local info_13_uuid = bluesee.UUID.new('0013')
local info_14_uuid = bluesee.UUID.new('0014')


-- Register the service
bluesee.register_service(m365_info_service_uuid, function(span)
	span:log("m365 info [FE95]")

    -- Create a label widget
    local fw_label = bluesee.new_widget(bluesee.label)
    fw_label.title = "Firmware"
    fw_label.value = "(unknown)"

	-- Add a divider
	span:add_widget(bluesee.new_widget(bluesee.hr))

    -- Add the label widget to the service panel
	span:add_widget(fw_label)	

	-- Add a divider
	span:add_widget(bluesee.new_widget(bluesee.hr))
	
	-- Define characteristic discovery callback
	span.on_ch_discovered = function(ch)
		span:log("m365 info - discovery")
		span:log(ch.uuid)
		-- Define characteristic read callbacks
		if ch.uuid == info_01_uuid then
			span:log("m365 info - 0001")
            local update_function = function()
				span:log("m365 info - 0001 read")
				local info = ch.value[1]
				fw_label.value = string.format("Data: %s", info)
			end
            ch:add_read_callback(update_function)
            ch:subscribe(update_function)
            ch:read()
		end
	end
end)


-- local device_info_service_uuid = bluesee.UUID.new('180A')
-- local device_info_service_uuid = bluesee.UUID.new('101A')

-- 10,1A,67,17


-- UUID Peripheral Id: 06298267-1A3B-4773-B54F-CBD915AB033A
-- mfg 4E 42 22 00 00 00 00 DD

-- svc FE95
	-- 0001
	-- 0002
	-- 0004
	-- 0010
	-- 0013
	-- 0014

-- svc 1804
	-- 2A07

-- @chcp 1251
-- @openocd.exe -d0 -f "stlink.cfg" -f "nrf51.cfg" -c "init" -c "reset halt" -c "nrf51 mass_erase" -c "program CODE_PRO 0 verify" -c "program UI

-- bluesee.set_adv_parser(bluesee.adv_mfg_cic, 76, function(cic, name, data)
--     puck_type = data[3]
--     data_len = data[4]
--     puck_type_str = '(unknown)'
--     extra_str = data:sub(5,5 + data_len):as_hex_string()
--     if     puck_type == 1  then 
--     	puck_type_str = 'iPhone'
--     elseif puck_type == 2  then 
--     	puck_type_str = 'iBeacon'
--     	uuid_data = data:sub(5, 20)
--     	uuid = bluesee.UUID.new(uuid_data)
--     	major = data[21]
--     	minor = data[22]
--     	tx = data[23]
--     	extra_str = tostring(uuid) .. " (Maj " .. tostring(major) .. ", Min " .. tostring(minor) .. ", TxP " .. tostring(tx) .. ")"
--     elseif puck_type == 9  then 
--     	puck_type_str = 'TV'
--     elseif puck_type == 12 then 
--     	puck_type_str = 'MacBook'
--     end
--     return 'Apple ' .. puck_type_str .. ': ' .. extra_str
-- end)


