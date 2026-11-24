import Testing
@testable import PointOfSale

struct POSGuidedAccessGuideSlideTests {
    @Test func test_allCases_when_listed_then_follow_the_guide_order() {
        // When
        let slides = POSGuidedAccessGuideSlide.allCases

        // Then
        #expect(slides == [.openSettings, .turnOn, .start])
        #expect(slides.map(\.rawValue) == [0, 1, 2])
    }

    @Test(arguments: [(POSGuidedAccessGuideSlide.openSettings, POSGuidedAccessGuideSlide?.none),
                      (.turnOn, .openSettings),
                      (.start, .turnOn)])
    func test_previous_when_slide_is_shown_then_returns_the_slide_before(slide: POSGuidedAccessGuideSlide, expected: POSGuidedAccessGuideSlide?) {
        // When
        let previous = slide.previous

        // Then
        #expect(previous == expected)
    }

    @Test(arguments: [(POSGuidedAccessGuideSlide.openSettings, POSGuidedAccessGuideSlide?.some(.turnOn)),
                      (.turnOn, .start),
                      (.start, nil)])
    func test_next_when_slide_is_shown_then_returns_the_slide_after(slide: POSGuidedAccessGuideSlide, expected: POSGuidedAccessGuideSlide?) {
        // When
        let next = slide.next

        // Then
        #expect(next == expected)
    }

    @Test func test_arrows_when_on_first_or_last_slide_then_only_the_inner_arrow_has_a_target() {
        // Given
        let first = POSGuidedAccessGuideSlide.openSettings
        let last = POSGuidedAccessGuideSlide.start

        // Then
        #expect(first.previous == nil)
        #expect(first.next != nil)
        #expect(last.previous != nil)
        #expect(last.next == nil)
    }

    @Test(arguments: [(POSGuidedAccessGuideSlide.openSettings, POSGuidedAccessGuideSlide.Action.openSettings),
                      (.turnOn, .openSettings),
                      (.start, .done)])
    func test_action_when_slide_is_shown_then_only_the_last_slide_finishes_the_guide(slide: POSGuidedAccessGuideSlide,
                                                                                    expected: POSGuidedAccessGuideSlide.Action) {
        // When
        let action = slide.action

        // Then
        #expect(action == expected)
    }

    @Test func test_stepping_when_moving_forward_and_back_then_returns_to_the_same_slide() {
        // Given
        var slide = POSGuidedAccessGuideSlide.openSettings

        // When
        while let next = slide.next {
            slide = next
        }
        let last = slide
        while let previous = slide.previous {
            slide = previous
        }

        // Then
        #expect(last == .start)
        #expect(slide == .openSettings)
    }
}
