
import Darwin


public final class System {

    //MARK: - Computer Information

    public static var processorCount:Int = {
        return System.infoByName("hw.ncpu", defaultValue:1)
    }()

    public static var activeProcessorCount:Int = {
        return System.infoByName("hw.activecpu", defaultValue:1)
    }()

    public static var logicalProcessorCount:Int = {
        return System.infoByName("hw.logicalcpu_max", defaultValue:1)
    }()

    public static var physicalProcessorCount:Int = {
        return System.infoByName("hw.physicalcpu_max", defaultValue:1)
    }()

    public static var physicalMemory:UInt64 = {
        return System.infoByName("hw.memsize", defaultValue:0)
    }()

    //MARK: -

    private static func infoByName<T>(name:String, defaultValue:T) -> T {

        var value = [defaultValue]
        var size:Int = sizeofValue(value)
        let ignore:UnsafeMutablePointer<Void> = nil

        let state = sysctlbyname(name, &value, &size, ignore, 0)

        return (state == 0) ? value.first! : defaultValue
    }
}
