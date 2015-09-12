
public protocol Apply {
    func apply(iterations:Int, block:(Int) -> Void)
}

//MARK: -

extension Apply {
    public func apply<T>(array:[T], block:(T) -> Void) {
        apply(array.count) { block(array[$0]) }
    }
}
