
import Dispatch


public final class Queue {

    public static var main = Queue(object:dispatch_get_main_queue())
    public static var userInteractive = Queue(global:.Interactive)
    public static var userInitiated = Queue(global:.Initiated)
    public static var utility = Queue(global:.Utility)
    public static var background = Queue(global:.Background)

    //MARK: -

    internal let object:dispatch_queue_t

    public var name:String {
        let label = dispatch_queue_get_label(object)
        return String(stringInterpolationSegment:label)
    }

    //MARK: -

    public init(name:String, quality:Quality = .Default, serial:Bool = false) {
        assert(quality != .Unspecified, "Can not initialize queue with unspecified quality")
        let type = serial ? DISPATCH_QUEUE_SERIAL : DISPATCH_QUEUE_CONCURRENT
        let attribute = dispatch_queue_attr_make_with_qos_class(type, quality.qos, 0)
        self.object = dispatch_queue_create(name, attribute)
    }

    private init(global:Quality) {
        self.object = dispatch_get_global_queue(global.qos, 0)
    }

    private init(object:dispatch_queue_t) {
        self.object = object
    }
}

//MARK: -

extension Queue : After {
    public func after(time:Time, block:() -> Void) {
        dispatch_after(time.nano, object, block)
    }
}

//MARK: -

extension Queue : Apply {
    public func apply(iterations:Int, block:(Int) -> Void) {
        dispatch_apply(iterations, object, block);
    }
}

extension Queue : Dispatch {
    public func dispatch(sync:Bool = false, block:() -> Void) {
        let dispatch = sync ? dispatch_async : dispatch_sync
        dispatch(object, block)
    }
}

//MARK: -

extension Queue : Work {

    public func suspend() {
        dispatch_suspend(object)
    }

    public func resume() {
        dispatch_resume(object)
    }
}
