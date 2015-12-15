
import Darwin


public enum Quality {

    case Interactive
    case Initiated
    case Default
    case Utility
    case Background
    case Unspecified

    //MARK: -

    public static var current:Quality {
        let pthread = pthread_self()
        return Quality(pthread)
    }

    //MARK: -

    internal init(_ qos:qos_class_t) {
        if qos == QOS_CLASS_USER_INTERACTIVE { self = .Interactive }
        else if qos == QOS_CLASS_USER_INITIATED { self = .Initiated }
        else if qos == QOS_CLASS_DEFAULT { self = .Default }
        else if qos == QOS_CLASS_UTILITY { self = .Utility }
        else if qos == QOS_CLASS_BACKGROUND { self = .Background }
        else { self = .Unspecified }
    }

    internal init(_ pthread:pthread_t) {
        var qos = qos_class_t(0)
        let state = pthread_get_qos_class_np(pthread, &qos, nil)
        if state != 0 { qos = QOS_CLASS_UNSPECIFIED }
        self = Quality(qos)
    }

    //MARK: -

    internal var qos:qos_class_t {
        switch self {
            case .Interactive: return QOS_CLASS_USER_INTERACTIVE
            case .Initiated: return QOS_CLASS_USER_INITIATED
            case .Default: return QOS_CLASS_DEFAULT
            case .Utility: return QOS_CLASS_UTILITY
            case .Background: return QOS_CLASS_BACKGROUND
            case .Unspecified: return QOS_CLASS_UNSPECIFIED
        }
    }
}

//MARK: - CustomStringConvertible

extension Quality : CustomStringConvertible {
    public var description:String {
        switch self {
            case .Interactive: return "Interactive"
            case .Initiated: return "Initiated"
            case .Default: return "Default"
            case .Utility: return "Utility"
            case .Background: return "Background"
            case .Unspecified: return "Unspecified"
        }
    }
}
