import Foundation

final class CallStation {
    var usersSet: Set<User> = []
    var callsLog: [CallID: Call] = [:]
    var currentCalls: [UUID: Call] = [:]
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CallStation: Station {
    
    func users() -> [User] {
        return Array(usersSet)
    }
    
    func add(user: User) {
        usersSet.insert(user)
    }
    
    func remove(user: User) {
//        guard let index = usersSet.firstIndex(of: user) else { return }
//        usersSet.remove(at: index)
        
        usersSet.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
//        switch action {
//        case let .start(from: fromUser, to: toUser):
//            guard usersSet.contains(fromUser) else {
//                return nil
//            }
//
//            guard usersSet.contains(toUser) else {
//                let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
//                calls[call.id] = call
//                currentCalls[fromUser.id] = nil
//                currentCalls[toUser.id] = nil
//                return call.id
//            }
//
//            guard currentCall(user: toUser) == nil else {
//                    let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .userBusy))
//                    calls[call.id] = call
//                    return call.id
//                }
//            let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .calling)
//            calls[call.id] = call
//            currentCalls[fromUser.id] = call
//            currentCalls[toUser.id] = call
//            return call.id
//
//        case let .answer(from: toUser):
//            guard let call = currentCall(user: toUser) else {
//                return nil
//            }
//
//            let fromUser = call.incomingUser
//            if !usersSet.contains(fromUser) || !usersSet.contains(toUser) {
//                            let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
//                            calls[call.id] = call
//                            currentCalls[fromUser.id] = nil
//                            currentCalls[toUser.id] = nil
//                            return nil
//                        }
//
//
//        }
        return nil
    }
    
    func calls() -> [Call] {
        []
    }
    
    func calls(user: User) -> [Call] {
        []
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        nil
    }
}
