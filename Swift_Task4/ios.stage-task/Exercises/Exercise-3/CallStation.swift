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
        switch action {
        case let .start(from: fromUser, to: toUser):
            guard usersSet.contains(fromUser) else {
                return nil
            }

            guard usersSet.contains(toUser) else {
                let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
                callsLog[call.id] = call
                currentCalls[fromUser.id] = nil
                currentCalls[toUser.id] = nil
                return call.id
            }

            guard currentCall(user: toUser) == nil else {
                    let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .userBusy))
                callsLog[call.id] = call
                    return call.id
                }
            let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .calling)
            callsLog[call.id] = call
            currentCalls[fromUser.id] = call
            currentCalls[toUser.id] = call
            return call.id

        case let .answer(from: toUser):
            guard let call = currentCall(user: toUser) else {
                return nil
            }

            let fromUser = call.incomingUser
            if !usersSet.contains(fromUser) || !usersSet.contains(toUser) {
                            let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
                            callsLog[call.id] = call
                            currentCalls[fromUser.id] = nil
                            currentCalls[toUser.id] = nil
                            return nil
                        }
            
            if let answeringUserCall = currentCall(user: toUser) {
                            if (answeringUserCall.status != .calling || answeringUserCall.id != call.id) {
                                let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
                                callsLog[call.id] = call
                                currentCalls[toUser.id] = nil
                                currentCalls[fromUser.id] = nil
                                return nil
                            }
                let call = Call(id: CallID(), incomingUser: fromUser, outgoingUser: toUser, status: .talk)
                                callsLog[call.id] = call
                                currentCalls[toUser.id] = call
                                currentCalls[fromUser.id] = call
                return call.id
        }
            return call.id
        case let .end(from: fromUser):
            guard let call = currentCall(user: fromUser) else {
                return nil
            }
// TODO
            
        return nil
    }
    }
    
    func calls() -> [Call] {
        return Array(callsLog.values)
    }
    
    func calls(user: User) -> [Call] {
        var array: [Call] = []
        for value in callsLog.values {
            if value.incomingUser.id == user.id || value.outgoingUser.id == user.id {
                array.append(value)
            }
        }
        return array
        
    }
    
    func call(id: CallID) -> Call? {
        return callsLog[id]
    }
    
    func currentCall(user: User) -> Call? {
        return currentCalls[user.id]
    }

}
