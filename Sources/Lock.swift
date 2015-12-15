
import Darwin


public class Lock {

    public let name:String
    internal var mutex = pthread_mutex_t()

    //MARK: -

    internal init(name:String, type:Int32) {
        var attributes = pthread_mutexattr_t()
        pthread_mutexattr_init(&attributes)
        pthread_mutexattr_settype(&attributes, type)
        let error = pthread_mutex_init(&mutex, &attributes)
        assert(error == 0, "Unable to create mutex")
        pthread_mutexattr_destroy(&attributes)
        self.name = name
    }

    public convenience init(name:String) {
        self.init(name:name, type:PTHREAD_MUTEX_ERRORCHECK)
    }

    deinit {
        pthread_mutex_destroy(&mutex)
    }
}

//MARK: -

extension Lock : Lockable {
    public func tryLock() -> Bool {
        let error = pthread_mutex_trylock(&mutex)
        return (error == 0)
    }

    public func lock() {
        let error = pthread_mutex_lock(&mutex)
        assert(error != EINVAL, "Unable to lock mutex")
        assert(error != EDEADLK, "Deadlock")
    }

    public func unlock() {
        let error = pthread_mutex_unlock(&mutex)
        assert(error == 0, "Unable to unlock mutex")
    }
}

//MARK: -

extension Lock : CustomStringConvertible {
    public var description:String {
        return name
    }
}
