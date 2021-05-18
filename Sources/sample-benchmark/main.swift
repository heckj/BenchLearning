import CollectionsBenchmark
import Foundation

// Create a new benchmark instance.
var benchmark = Benchmark(title: "Locking")

benchmark.registerInputGenerator(for: String.self) { size in
    return "\(size)"
}

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

benchmark.addSimple(
  title: "only os_unfair_lock",
  input: String.self
) { input in
  blackHole(
    unfairlock()
  )
}

benchmark.addSimple(
  title: "only nslock",
  input: String.self
) { input in
  blackHole(
    nslock()
  )
}

// Execute the benchmark tool with the above definitions.
benchmark.main()
