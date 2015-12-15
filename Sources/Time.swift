
import Darwin
import Dispatch


public enum Time : Hashable, CustomStringConvertible {

    case Now
    case Interval(Double)
    case Forever

    //MARK: -

    public init(_ interval:Double = 0.0) {
        switch interval {
            case 0.0: self = .Now
            case Double.infinity: self = .Forever
            default: self = .Interval(interval)
        }
    }

    //MARK: - Public

    public var absolute:UInt64 {
        switch self {
            case .Forever: return UInt64.max
            default: return nano + mach_absolute_time()
        }
    }

    //MARK: - Internal

    internal var nano:UInt64 {
        switch self {
            case .Now: return UInt64.min
            case .Interval(let interval): return UInt64(interval * Double(NSEC_PER_SEC))
            case .Forever: return UInt64.max
        }
    }

    internal var spec:mach_timespec_t {
        switch self {
            case .Now: return mach_timespec_t()
            case .Interval: return mach_timespec_t(tv_sec:seconds, tv_nsec:Int32(nano % NSEC_PER_SEC))
            case .Forever: return mach_timespec_t(tv_sec:UInt32.max, tv_nsec:Int32.max)
        }
    }

    //MARK: - Private

    private var seconds:UInt32 {
        switch self {
            case .Now: return UInt32.min
            case .Interval: return UInt32(nano / NSEC_PER_SEC)
            case .Forever: return UInt32.max
        }
    }

    //MARK: - Hashable

    public var hashValue:Int {
        return Int(nano)
    }

    //MARK: - CustomStringConvertible

    public var description:String {
        switch self {
            case .Now: return "Now"
            case .Interval(let interval): return String(interval)
            case .Forever: return "Forever"
        }
    }
}

public func == (lhs:Time, rhs:Time) -> Bool {
    return lhs.nano == rhs.nano
}
