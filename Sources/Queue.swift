
import Dispatch


public final class Queue {

    public static var main = Queue(handle:dispatch_get_main_queue())
    public static var live = Queue(global:.Live)
    public static var high = Queue(global:.High)
    public static var low = Queue(global:.Low)
    public static var background = Queue(global:.Background)

    //MARK: -

//    public var barrier:Barrier {
//        return Barrier(object:object)
//    }

    public var name:String {
        let label = dispatch_queue_get_label(handle)
        return String(stringInterpolationSegment:label)
    }

    internal let handle:dispatch_queue_t

    //MARK: -

    public init(name:String, quality:Quality = .Default, serial:Bool = false) {
        let type = serial ? DISPATCH_QUEUE_SERIAL : DISPATCH_QUEUE_CONCURRENT
        let attribute = dispatch_queue_attr_make_with_qos_class(type, quality.qos, 0)
        self.handle = dispatch_queue_create(name, attribute)
    }

    private init(global:Quality) {
        self.handle = dispatch_get_global_queue(global.qos, 0)
    }

    private init(handle:dispatch_queue_t) {
        self.handle = handle
    }
}

//MARK: -

extension Queue : After {
    public func after(time:Time, block:() -> Void) {
        dispatch_after(time.nano, handle, block)
    }
}

//MARK: -

extension Queue : Apply {
    public func apply(iterations:Int, block:(Int) -> Void) {
        dispatch_apply(iterations, handle, block);
    }
}

extension Queue : Dispatch {
    public func dispatch(sync:Bool = false, block:() -> Void) {
        let dispatch = sync ? dispatch_async : dispatch_sync
        dispatch(handle, block)
    }
}

//MARK: -

extension Queue : Work {

    public func suspend() {
        dispatch_suspend(handle)
    }

    public func resume() {
        dispatch_resume(handle)
    }
}
