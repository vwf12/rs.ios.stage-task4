import Foundation

struct User: Equatable {
    let id: UUID
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
