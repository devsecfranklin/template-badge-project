import network
from machine import TouchPad, Pin
from binascii import hexlify


def wlan_init(wlan):

    if not wlan.active():
        wlan.active(True)

    if wlan.isconnected():
        wlan.disconnect()


def wifi_read(wifi_tuple):

    if wifi_tuple is not None and isinstance(wifi_tuple, tuple):
        
        (ssid, bssid, channel, rssi, authmode, hidden) = wifi_tuple

        authmodes = {
            0: "OPEN",
            1: "WEP",
            2: "WPA-PSK",
            3: "WPA2-PSK",
            4: "WPA/WPA2-PSK",
            5: "UNKNOWN"
        }

        output = {
            "SSID": ssid.decode() or "",
            "BSSID": hexlify(bssid) or "",
            "Channel": channel or 0,
            "Signal Strength": rssi or 0,
            "Authentication": authmodes.get(authmode) or "UNKNOWN",
            "Hidden": str(hidden)
        }

        return output


def wifi_scan(wlan, wifi_library):
    
    scan = wlan.scan()

    for wifi in scan:
        data = wifi_read(wifi)

        if wifi_library.get(data['SSID']) is None:
            wifi_library[data['SSID']] = {}
        
        if wifi_library.get(data['SSID']).get(data['BSSID']) is None:
            wifi_library[data['SSID']][data['BSSID']] = {
                "Channel": data["Channel"],
                "Signal Strength": data["Signal Strength"],
                "Authentication": data["Authentication"],
                "Hidden": data["Hidden"]
            }


def wifi_print(wifi_library):

    if wifi_library is not None and isinstance(wifi_library, dict):

        print_line = "{:<40}".format("SSID")
        print_line += "{:<14}".format("BSSID")
        print_line += "{:<9}".format("Channel")
        print_line += "{:<10}".format("Strength")
        print_line += "{:<16}".format("Authentication")
        print_line += "Hidden"
        print(print_line)
        print("---------------------------------------------------------------------------------")

        for ssid in wifi_library:
            for bssid in wifi_library[ssid]:

                print_line = "{:<40}".format(ssid)
                print_line += "{:<14}".format(bssid)
                print_line += "{:<9}".format(wifi_library[ssid][bssid]["Channel"])
                print_line += "{:<10}".format(wifi_library[ssid][bssid]["Signal Strength"])
                print_line += "{:<16}".format(wifi_library[ssid][bssid]["Authentication"])
                print_line += wifi_library[ssid][bssid]["Hidden"]
                print(print_line)


def scan_print_button():
    scan_pin = TouchPad(Pin(14))
    if scan_pin.read() < 600: # Returns a smaller number when touched
        return True


wifi_library = {}

wlan = network.WLAN(network.STA_IF)
wlan_init(wlan)

while True:

    wifi_scan(wlan, wifi_library)

    if scan_print_button():
        wifi_print(wifi_library)
