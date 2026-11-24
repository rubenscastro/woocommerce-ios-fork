/// The steps of the Guided Access guide, in the order it shows them.
enum POSGuidedAccessGuideSlide: Int, CaseIterable {
    case openSettings
    case turnOn
    case start

    enum Action {
        case openSettings
        case done
    }

    var previous: Self? { Self(rawValue: rawValue - 1) }
    var next: Self? { Self(rawValue: rawValue + 1) }
    var action: Action { next == nil ? .done : .openSettings }
}
