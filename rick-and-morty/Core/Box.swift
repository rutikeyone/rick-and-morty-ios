import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        
        listener?(value)
    }
}
