import Testing
import UIKit
@testable import PointOfSale

struct POSGuidedAccessIllustrationDeviceTests {
    private let phoneScreen = CGSize(width: 402, height: 874)

    @Test func test_illustrationDevice_when_phone_is_compact_then_draws_a_phone_in_the_screen_proportions() {
        // When
        let device = POSGuidedAccessGuideView.illustrationDevice(idiom: .phone, isCompact: true, parentSize: phoneScreen)

        // Then
        #expect(device == .phone(heightRatio: 874.0 / 402.0))
    }

    @Test func test_illustrationDevice_when_phone_has_regular_width_then_draws_a_tablet() {
        // Given an unfolded iPhone Duo
        let unfoldedScreen = CGSize(width: 780, height: 560)

        // When
        let device = POSGuidedAccessGuideView.illustrationDevice(idiom: .phone, isCompact: false, parentSize: unfoldedScreen)

        // Then
        #expect(device == .pad)
    }

    @Test(arguments: [true, false])
    func test_illustrationDevice_when_running_on_a_tablet_then_draws_a_tablet(isCompact: Bool) {
        // When
        let device = POSGuidedAccessGuideView.illustrationDevice(idiom: .pad, isCompact: isCompact, parentSize: CGSize(width: 375, height: 800))

        // Then
        #expect(device == .pad)
    }

    @Test func test_illustrationDevice_when_parent_size_is_unknown_then_draws_a_tablet() {
        // When
        let device = POSGuidedAccessGuideView.illustrationDevice(idiom: .phone, isCompact: true, parentSize: .zero)

        // Then
        #expect(device == .pad)
    }

    @Test func test_size_when_device_is_a_tablet_then_matches_the_design_frame_with_room_for_its_buttons() {
        // When
        let size = POSGuidedAccessIllustration.size(for: .pad)

        // Then
        #expect(size == CGSize(width: 379, height: 301))
    }

    @Test(arguments: [(2.0, 360.0), (1.4, 252.0), (1.0, 234.0), (3.0, 396.0)])
    func test_size_when_device_is_a_phone_then_height_follows_the_screen_ratio_within_limits(heightRatio: Double, expectedHeight: Double) {
        // When
        let size = POSGuidedAccessIllustration.size(for: .phone(heightRatio: heightRatio))

        // Then
        #expect(size == CGSize(width: 204, height: expectedHeight))
    }
}
