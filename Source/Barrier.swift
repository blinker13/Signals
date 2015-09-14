
import Dispatch


public struct Barrier {

    private let object:dispatch_queue_t

    //MARK: -

    internal init(object:dispatch_queue_t) {
        self.object = object
    }
}

//MARK: -

extension Barrier : Dispatch {
    public func dispatch(sync:Bool, block:() -> Void) {
        let dispatch = sync ? dispatch_barrier_sync : dispatch_barrier_async
        dispatch(object, block)
    }
}
