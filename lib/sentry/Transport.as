package sentry {
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.system.Capabilities;
import mx.utils.UIDUtil;

public class Transport {
    public static const PROTOCOL_VERSION:String = "7";
    public static const USER_AGENT:String = "sentry-as3/" + Sentry.VERSION;
    public static const CONTENT_TYPE:String = "application/x-sentry-envelope";

    private var dsn:DSN;
    public function Transport(dsn: DSN) {
        this.dsn = dsn;
    }

    public function send(envelope: Envelope): void {
        var request:URLRequest = this.buildRequest();
        var loader : URLLoader = new URLLoader();

        request.data = envelope.toString();
        trace("Sending event to Sentry: " + request.data);

        loader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void {
            trace("Error sending event to Sentry: " + event.text);
        });

        loader.load(request);
    }

    private function buildRequest(): URLRequest {
        var request:URLRequest = new URLRequest(this.dsn.envelopeEndpoint);
        request.method = "POST";
        request.contentType = Transport.CONTENT_TYPE;
        request.userAgent = Transport.USER_AGENT;
        request.requestHeaders.push(new URLRequestHeader("X-Sentry-Auth", this.buildAuthHeader()));

        return request;
    }

    private function buildAuthHeader():String {
        return "Sentry " +
                "sentry_version=" + Transport.PROTOCOL_VERSION + "," +
                "sentry_client=" + Transport.USER_AGENT + "," +
                "sentry_key=" + this.dsn.publicKey + ","
    }
}
}
