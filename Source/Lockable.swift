
public protocol Lockable {
    func tryLock() -> Bool
    func lock()
    func unlock()
}

//MARK: -

extension Lockable {

    public func atomic<T>(block:() -> T) -> T {
        lock()
        let value = block()
        unlock()
        return value
    }

    public func atomic<T>(@autoclosure block:() -> T) -> T {
        return atomic(block)
    }
}
