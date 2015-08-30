
import Darwin
import Dispatch


public enum Time {

    case Now
    case Forever
    case Interval(Double)

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
            case .Forever: return UInt64.max
            case .Interval(let interval): return UInt64(interval * Double(NSEC_PER_SEC))
        }
    }

    internal var spec:mach_timespec_t {
        switch self {
            case .Now: return mach_timespec_t()
            case .Forever: return mach_timespec_t(tv_sec:UInt32.max, tv_nsec:Int32.max)
            case .Interval: return mach_timespec_t(tv_sec:seconds, tv_nsec:Int32(nano % NSEC_PER_SEC))
        }
    }

    //MARK: - Private

    private var seconds:UInt32 {
        switch self {
            case .Now: return UInt32.min
            case .Forever: return UInt32.max
            case .Interval: return UInt32(nano / NSEC_PER_SEC)
        }
    }
}

//MARK: - CustomStringConvertible

extension Time : CustomStringConvertible {
    public var description:String {
        switch self {
            case .Now: return "Now"
            case .Forever: return "Forever"
            case .Interval(let interval): return String(interval)
        }
    }
}

//MARK: - Hashable

extension Time : Hashable {
    public var hashValue:Int {
        return Int(nano)
    }
}

public func == (lhs:Time, rhs:Time) -> Bool {
    return lhs.nano == rhs.nano
}
