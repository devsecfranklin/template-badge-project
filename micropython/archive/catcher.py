import network
from esp import espnow
from binascii import hexlify, unhexlify


wlan = network.WLAN(network.STA_IF)
wlan.active(True)
esp_obj = espnow.ESPNow()
esp_obj.init()


def peer_check(peer):
    try:
        esp_obj.get_peer(peer)
        return True
    except:
        return False


def peer_add(peer):
    if not peer_check(peer):
        try:
            esp_obj.add_peer(peer)
        except Exception as error:
            print(error)


def peers_decode(peers):
    for peer in peers:

        ifidx_type = {
            0: "Station",
            1: "Access Point"
        }

        (mac, lmk, channel, ifidx, encrypt) = peer
        print('MAC: %s' % hexlify(mac).decode())
        print('Local Master Key: %s' % hexlify(lmk).decode())
        print('Channel: %s' % channel)
        print('Interface Index: %s' % ifidx_type.get(ifidx))
        print('Encrypt: %s' % encrypt)


broadcast = unhexlify('ffffffffffff')
peer_add(broadcast)

while True:
    if esp_obj.poll():
        (mac, message) = esp_obj.irecv()
        print(hexlify(mac).decode(), message.decode())

        if not peer_check(mac):
            print("New peer discovered: %s" % hexlify(mac).decode())
            peer_add(mac)

        peers_decode(esp_obj.get_peers())
