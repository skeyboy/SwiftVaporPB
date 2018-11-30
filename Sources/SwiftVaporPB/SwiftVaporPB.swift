import Vapor
import SwiftProtobuf
public struct PB<T> : Content where T: Message{
    var value: Data
    init(_ data: T) throws {
        self.value = try data.serializedData()
    }
}
extension PB{
  internal  var entry:T? {
        return  try? T(serializedData:value)
    }
}
extension PB{
    internal static func with<T>(_ populator:( inout T)->()) throws -> PB<T> where T: Message{
        var p = T.init()
        populator(&p)
        let pb = try  PB<T>.init(p)
        return pb
    }
}
extension PB{
    internal func textFormatString() -> String{
        return self.textString
    }
}
extension PB{
  internal  var textString:String{
        guard let entry = self.entry else {
            return ""
        }
        return entry.textFormatString()
    }
}
extension PB: CustomDebugStringConvertible, CustomStringConvertible{
  public  var description: String {
        return "\(self)"
    }
    
public    var debugDescription: String{
        return "Debug:\(self)"
    }
}
extension PB: Equatable{
    public static func ==  (lhs: PB, rhs: PB) -> Bool {
        if lhs.entry == nil || rhs.entry == nil {
            return false
        }
        return "\(String(describing: lhs.entry))" == "\(String(describing: rhs.entry))"
    }
}

extension Request{
   public   func makePB<T>(value: T) throws -> EventLoopFuture<PB<T>> where T: Message{
        let result = self.eventLoop.newPromise(PB<T>.self)
        
        let pb = try PB.init(value)
        
        result.succeed(result: pb)
        
        return result.futureResult
    }
}
