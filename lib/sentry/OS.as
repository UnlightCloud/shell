package sentry {
import flash.system.Capabilities;

public class OS {
    private var _rawDescription:String;
    public function OS() {
        _rawDescription = Capabilities.os;
    }

    public function get name():String {
        if (isWindows()) { return "Windows"; }
        if (isMac()) { return "macOS"; }
        if (isLinux()) { return "Linux"; }

        return "Unknown";
    }

    public function get version():String {
        if(isWindows()) { return _rawDescription.match(/Windows\s(.*)/)[1]; }
        if(isMac()) { return _rawDescription.match(/Mac OS\s(.*)/)[1]; }

        return "Unknown";
    }

    public function isWindows():Boolean {
        return _rawDescription.indexOf("Windows") != -1;
    }

    public function isMac():Boolean {
        return _rawDescription.indexOf("Mac") != -1;
    }

    public function isLinux():Boolean {
        return _rawDescription.indexOf("Linux") != -1;
    }
}
}
