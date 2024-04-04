package sentry {
public class ErrorEvent extends Event {
    public static const FrameRegexp:RegExp = /at\s([\w.:\/]+)\/([\w\s]+)\(\)(\[([^\n]+):(\d+)])?/;

    public function ErrorEvent(error:Error) {
        super();

        super._payload["exception"] = buildException(error);
    }

    private function buildException(error:Error):Object {
        return {
            "values": [
                {
                    "type": error.name,
                    "value": error.message,
                    "stacktrace": {
                        "frames": buildFrames(error.getStackTrace())
                    }
                }
            ]
        };
    }

    private function buildFrames(stackTrace:String):Array {
        var traces:Array = stackTrace.split("\n");
        var frames:Array = [];

        traces.shift();

        for each (var trace:String in traces) {
            var match:Array = FrameRegexp.exec(trace);
            if (match) {
                frames.unshift({
                    "abs_path": match[4],
                    "function": match[5],
                    "module": match[1],
                    "lineno": Number(match[4])
                });
            }
        }

        return frames;
    }
}
}
