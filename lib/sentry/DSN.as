package sentry {
import mx.charts.chartClasses.StackedSeries;
import mx.utils.URLUtil;

public class DSN {
    public const DsnRegexp: RegExp = new RegExp("^(\\w+):\\/\\/(\\w+)@([\\w.-]+)(\\/[\\w.-_]+)?\\/(\\d+)$");

    private var _dsnString:String;
    private var _scheme:String;
    private var _publicKey:String;
    private var _host:String;
    private var _path:String;
    private var _projectId:String;
    public function DSN(dsnString: String) {
        var match: Array = dsnString.match(DsnRegexp);
        if(!match) {
            throw new Error("Invalid DSN: " + dsnString);
        }

        this._dsnString = dsnString;
        this._scheme = match[1];
        this._publicKey = match[2];
        this._host = match[3];
        this._path = match[4];
        this._projectId = match[5];
    }

    public function get publicKey(): String {
        return this._publicKey;
    }

    public function get rawString(): String {
        return this._dsnString;
    }

    public function get server(): String {
        return this._scheme + "://" + this._host;
    }

    public function get envelopeEndpoint(): String {
        var endpoint: String = this.server;
        if (this._path) {
            endpoint += this._path;
        }

        return endpoint + "/api/" + this._projectId + "/envelope/";
    }
}
}