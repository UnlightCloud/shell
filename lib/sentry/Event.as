package sentry {
import mx.utils.UIDUtil;

public class Event implements EnvelopeItem {
    private static var _header:Object = {
        "type": "event",
        "content_type": "application/json"
    }

    protected var _payload:Object;

    public function Event() {
        _payload = {
            "event_id": UIDUtil.createUID().replace(/-/g, ""),
            "timestamp": (new Date().getTime()) / 1000,
            "level": "error",
            "platform": Sentry.PLATFORM,
            "sdk": Sentry.META,
            "contexts": Sentry.getContexts()
        }
    }

    public function get header():Object {
        return _header;
    }

    public function get payload():Object {
        return _payload;
    }

    public function get eventId():String {
        return _payload["event_id"];
    }

    public function toString():String {
        return [
            JSON.stringify(header),
            JSON.stringify(payload)
        ].join("\n");
    }
}
}
