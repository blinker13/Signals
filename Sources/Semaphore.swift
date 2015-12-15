
import Dispatch


public final class Semaphore {

    internal let object:dispatch_semaphore_t

    //MARK: -

    public init(value:UInt = 0) {
        let startValue = Int(value)
        object = dispatch_semaphore_create(startValue)
    }

    //MARK: -

    public func wait(timeout:Time) -> Int {
        return dispatch_semaphore_wait(object, timeout.nano)
    }

    public func signal() -> Int {
        return dispatch_semaphore_signal(object)
    }
}
