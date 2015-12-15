
import Dispatch


public struct Barrier {

    private let handle:dispatch_queue_t

    //MARK: -

    internal init(handle:dispatch_queue_t) {
        self.handle = handle
    }
}

//MARK: -

extension Barrier : Dispatch {
    public func dispatch(sync:Bool, block:() -> Void) {
        let dispatch = sync ? dispatch_barrier_sync : dispatch_barrier_async
        dispatch(handle, block)
    }
}
