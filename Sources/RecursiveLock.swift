
import Darwin


public final class RecursiveLock : Lock {
    public convenience init(name:String) {
        self.init(name:name, type:PTHREAD_MUTEX_RECURSIVE)
    }
}
