package sentry {
public class Envelope {
    private var _header:Object = {
       meta: Sentry.META
    };
    private var _items:Array = [];
    public function Envelope(eventId: String, dsn: String) {
        _header["event_id"] = eventId;
        _header["dsn"] = dsn;
    }

    public function add(item: EnvelopeItem):void {
        _items.push(item);
    }

    public function toString():String {
        const items:Array = [];
        items.push(JSON.stringify(_header));

        for(var i:int = 0; i < _items.length; i++) {
            items.push(_items[i].toString());
        }

        return items.join("\n");
    }
}
}
