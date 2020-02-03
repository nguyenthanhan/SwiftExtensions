import Foundation
import UIKit

public typealias DispatchBlock = () -> Swift.Void

public extension DispatchWorkItem {
    
    @discardableResult static func run(on queue: DispatchQueue? = nil, waitfor interval: DispatchTimeInterval? = nil, execute: @escaping DispatchBlock) -> DispatchWorkItem {
        let w = DispatchWorkItem(block: execute)
        if let waitInterval = interval { w.wait(waitInterval) }
        if let q = queue {
            q.async(execute: w)
        }else {
            w.perform()
        }
        return w
    }
    
    private func wait(_ interval: DispatchTimeInterval) {
        let _ =  self.wait(timeout: DispatchTime.now() + interval)
    }
    
    
}

// let queue = DispatchQueue(label: "TestQueue")
// DispatchWorkItem.run(on: queue, waitfor: .seconds(0)) {
//     print("Please assign me tasks")
//     }.notify(queue: DispatchQueue.main) {
//         print("Tasks are done, Update UI")
// }
