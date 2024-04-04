package sentry {
public class Sentry {
    public static const VERSION:String = "0.0.1";
    public static const PLATFORM:String = "as3";
    public static const META:Object = {
        "name": "sentry-as3",
        "version": VERSION
    }

    private static var _instance:Sentry;
    private var _dsn:DSN;
    private var _transport:Transport;
    private var _os:OS = new OS();
    private var _device:Device = new Device();
    private var _user:Object = {
        "ip_address": ""
    }

    public function Sentry(dsn:String) {
        if (_instance) {
            throw new Error("Sentry is a singleton and should not be instantiated directly.");
        }

        try {
            _instance = this;
            _dsn = new DSN(dsn);
            _transport = new Transport(_dsn);
        } catch (e:Error) {
            throw new Error("Failed to initialize Sentry: " + e.message);
        }
    }

    public static function get current():Sentry {
        if (!_instance) {
            throw new Error("Sentry has not been initialized.");
        }

        return _instance;
    }

    public static function init(dsn: String):void {
        try {
            new Sentry(dsn);
        } catch (e:Error) {
            trace("Failed to initialize Sentry: " + e.message);
        }
    }

    public static function captureError(error:Error):void {
        if (!Sentry.current) {
            return;
        }

        var event:ErrorEvent = new ErrorEvent(error);
        var envelope:Envelope = new Envelope(event.eventId, Sentry.current._dsn.rawString);
        envelope.add(event);

        Sentry.current._transport.send(envelope);
    }

    public static function setUserId(userId:uint):void {
        Sentry.current._user["id"] = userId;
    }

    public static function setUsername(username:String):void {
        Sentry.current._user["username"] = username;
    }

    public static function getContexts():Object {
        return {
            "os": {
                "type": "os",
                "name": Sentry.current._os.name,
                "version": Sentry.current._os.version
            },
            "device": {
                "type": "device",
                "name": Sentry.current._device.name,
                "arch": Sentry.current._device.arch,
                "device_type": Sentry.current._device.type
            },
            "user": Sentry.current._user
        };
    }
}
}
