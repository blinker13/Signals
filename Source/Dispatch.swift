
public protocol Dispatch {
    func dispatch(sync:Bool, block:() -> Void)
}
