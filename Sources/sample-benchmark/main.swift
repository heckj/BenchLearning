import CollectionsBenchmark
import Foundation

// Create a new benchmark instance.
var benchmark = Benchmark(title: "Locking")

//benchmark.registerInputGenerator(for: String.self) { size in
//    return "\(size)"
//}

var _oldLock = os_unfair_lock_s()
let _newLock = NSLock()
func unfairlock() {
    os_unfair_lock_lock(&_oldLock)
    os_unfair_lock_unlock(&_oldLock)
}
func nslock() {
    _newLock.lock()
    _newLock.unlock()
}

// more complex version of adding a task
let lockTask = Task<Int>("nslock") { someInt in
    return { timer in
        nslock()
    }
}
benchmark.add(lockTask)

//benchmark.add(title: "os_unfair_lock", input: Int.self, maxSize: 1) { someInt in
//    return { timer in
//        nslock()
//    }
//}

//benchmark.addSimple(
//  title: "blackhole os_unfair_lock",
//  input: Int.self
//) { input in
//  blackHole(
//    unfairlock()
//  )
//}

benchmark.addSimple(
  title: "blackhole nslock",
  input: Int.self
) { input in
  blackHole(
    nslock()
  )
}

// Execute the benchmark tool with the above definitions.
benchmark.main()
