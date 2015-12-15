
import Darwin


public enum Quality : String {

    case Live
    case High
    case Default
    case Low
    case Background

    //MARK: -

    public static var current:Quality {
        let pthread = pthread_self()
        return Quality(pthread)
    }

    //MARK: -

    internal init(_ qos:qos_class_t) {
        if qos == QOS_CLASS_USER_INTERACTIVE { self = .Live }
        else if qos == QOS_CLASS_USER_INITIATED { self = .High }
        else if qos == QOS_CLASS_UTILITY { self = .Low }
        else if qos == QOS_CLASS_BACKGROUND { self = .Background }
        else { self = .Default }
    }

    internal init(_ pthread:pthread_t) {
        var qos = qos_class_t(0)
        let state = pthread_get_qos_class_np(pthread, &qos, nil)
        if state != 0 { qos = QOS_CLASS_DEFAULT }
        self = Quality(qos)
    }

    //MARK: -

    internal var qos:qos_class_t {
        switch self {
            case .Live: return QOS_CLASS_USER_INTERACTIVE
            case .High: return QOS_CLASS_USER_INITIATED
            case .Default: return QOS_CLASS_DEFAULT
            case .Low: return QOS_CLASS_UTILITY
            case .Background: return QOS_CLASS_BACKGROUND
        }
    }
}
