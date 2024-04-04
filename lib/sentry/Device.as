package sentry {
import flash.net.NetworkInfo;
import flash.net.NetworkInterface;
import flash.system.Capabilities;
import flash.system.System;

public class Device {
    private var _name:String = "unknown";
    public function Device() {
        findName();
    }

    public function get name():String {
        return _name;
    }

    public function get arch():String {
        return Capabilities.cpuArchitecture;
    }

    public function get type():String {
        return Capabilities.playerType;
    }

    private function findName():void {
       if(!NetworkInfo.isSupported) {
          return;
       }

        var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
        var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces();
        for each (var networkInterface:NetworkInterface in interfaces) {
            if (networkInterface.active) {
                _name = networkInterface.addresses[0].address;
                break;
            }
        }
    }

}
}
