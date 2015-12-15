
public protocol After {
    func after(timeout:Time, block:() -> Void)
}

//MARK: -

extension After {
    public func after(timeout:Double, block:() -> Void) {
        after(Time(timeout), block:block)
    }
}
