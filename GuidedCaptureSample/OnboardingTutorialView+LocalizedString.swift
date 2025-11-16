/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The localized strings used by OnboardingTutorialView.
*/

import Foundation

extension OnboardingTutorialView {
    struct LocalizedString {
        static let tooFewImagesTitle = NSLocalizedString(
            "Keep moving around your object. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Keep moving around your object.",
            comment: "Feedback title for when user has less than the minimum images required."
        )

        static let tooFewImagesDetailText = NSLocalizedString(
            "You need at least <min num of images> images of your object to create a model. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "You need at least %d images of your object to create a model.",
            comment: "Feedback for when user has less than the minimum images required."
        )

        static let firstSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep going to complete the first segment. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Keep going to complete the first segment.",
            comment: "Feedback title for when user still has work to do to complete the first segment."
        )

        static let firstSegmentNeedsWorkDetailText = NSLocalizedString(
                """
                For best quality, three segments are recommended. Tap Skip if you can't make it all the way around but your final
                model may have missing areas. (Review, Object Capture, 1st Segment)
                """,
            bundle: Bundle.main,
            value:
                """
                For best quality, three segments are recommended. Tap Skip if you can't make it all the way around but your
                final model may have missing areas.
                """,
            comment: "Feedback for when user still has work to do to complete the first segment."
        )

        static let firstSegmentCompleteTitle = NSLocalizedString(
            "First segment complete. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "First segment complete.",
            comment: "Feedback title for when user has finished capturing first segment."
        )

        static let firstSegmentCompleteDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. (Review, Object Capture, 1st Segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended.",
            comment: "Feedback for when user has finished capturing first segment."
        )

        static let flipObjectTitle = NSLocalizedString(
            "Flip object on its side and capture again. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Flip object on its side and capture again.",
            comment: "Feedback title for when user should flip the object and capture again."
        )

        static let flipObjectDetailText = NSLocalizedString(
            "Make sure that the areas you captured previously can still be seen. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Make sure that the areas you captured previously can still be seen. Avoid flipping your object if it changes shape.",
            comment: "Feedback for when user should flip the object and capture again"
        )

        static let flippingObjectNotRecommendedTitle = NSLocalizedString(
            "Flipping this object is not recommended. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Flipping this object isn't recommended.",
            comment: "Feedback that this object is likely to fail if flipped."
        )

        static let flippingObjectNotRecommendedDetailText = NSLocalizedString(
            """
            Your object may have single color surfaces or be too reflective to add more segments. Tap Continue to capture more detail
            without flipping, or Flip Object Anyway. (Review, Object Capture)
            """,
            bundle: Bundle.main,
            value:
                """
                Your object may have single color surfaces or be too reflective to add more segments. Tap Continue to capture more
                detail without flipping, or Flip Object Anyway.
                """,
            comment: "Feedback that this object is likely to fail if flipped."
        )

        static let captureFromLowerAngleTitle = NSLocalizedString(
            "Capture your object again from a lower angle. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Capture your object again from a lower angle.",
            comment: "Feedback for when the person needs to retake images from a lower angle when flipping isn't recommended."
        )

        static let captureFromLowerAngleDetailText = NSLocalizedString(
            "Move down to be level with the base of your object and capture again. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Move down to be level with the base of your object and capture again.",
            comment: "Feedback for when person needs to retake images starting at the base of the object, when flipping isn't recommended."
        )

        static let secondSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep going to complete the second segment. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Keep going to complete the second segment.",
            comment: "Feedback for when the person hasn't finished capturing the second segment."
        )

        static let secondSegmentNeedsWorkDetailText = NSLocalizedString(
            """
            For best quality, three segments are recommended. Tap Skip if you can't make it all the way around the object; your final
            model may have missing areas. (Review, Object Capture, 2nd Segment)
            """,
            bundle: Bundle.main,
            value:
                """
                For best quality, three segments are recommended. Tap Skip if you can't make it all the way around the object; your
                final model may have missing areas.
                """,
            comment: "Feedback for when the person hasn't finished capturing the second segment."
        )

        static let secondSegmentCompleteTitle = NSLocalizedString(
            "Second segment complete. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Second segment complete.",
            comment: "Feedback for when the person has finished capturing the second segment."
        )

        static let secondSegmentCompleteDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. (Review, Object Capture, 2nd segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended.",
            comment: "Feedback for when the person has finished capturing the second segment."
        )

        static let flipObjectASecondTimeTitle = NSLocalizedString(
            "Flip the object on the opposite side and capture again. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Flip the object on the opposite side and capture again",
            comment: "Feedback for when the person hasn't flipped object on the opposite side."
        )

        static let flipObjectASecondTimeDetailText = NSLocalizedString(
            "Make sure that areas you captured previously can still be seen. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Make sure that areas you captured previously can still be seen. Avoid flipping your object if it will change shape.",
            comment: "Feedback for when the person hasn't flipped object on the opposite side."
        )

        static let captureFromHigherAngleTitle = NSLocalizedString(
            "Capture your object again from a higher angle. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Capture your object again from a higher angle.",
            comment: "Feedback title for when user should capture again from a higher angle given flipping isn't recommended."
        )

        static let captureFromHigherAngleDetailText = NSLocalizedString(
            "Move above your object and make sure that the areas you captured previously can still be seen. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Move above your object and make sure that the areas you captured previously can still be seen.",
            comment: "Feedback for when the person should capture the images again from above, given that flipping the object isn't recommended."
        )

        static let thirdSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep going to complete the final segment. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Keep going to complete the final segment.",
            comment: "Feedback for when the person needs to complete the final segment."
        )

        static let thirdSegmentNeedsWorkDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. If you're done, tap Finish to complete your object. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. If you're done, tap Finish to complete your object.",
            comment: "Feedback for when user still has work to do to complete the final segment."
        )

        static let thirdSegmentCompleteTitle = NSLocalizedString(
            "All segments complete. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "All segments complete.",
            comment: "Feedback for when the person has captured the final segment."
        )

        static let thirdSegmentCompleteDetailText = NSLocalizedString(
            "Tap Finish to process your object. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Tap Finish to process your object.",
            comment: "Feedback for when the person has captured the final segment and can process the object model."
        )

        static let captureInAreaModeTitle = NSLocalizedString(
            "Capture Preview (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Capture Preview",
            comment: "Feedback for when the person is in Area Mode."
        )

        static let captureInAreaModeDetailText = NSLocalizedString(
            """
            Points show what will be included in the final model. Continue capturing to include a larger area or process now.
            (Review, Object Capture)
            """,
            bundle: Bundle.main,
            value: "Points show what will be included in the final model. Continue capturing to include a larger area or process now.",
            comment: "Feedback for when person is in Area Mode."
        )

        static let estimatedProcessingTime = NSLocalizedString(
            "Estimated processing time: 5-10 min (Review, Object Capture)",
            bundle: Bundle.main,
            value: "Estimated processing time: 5-10 min",
            comment: "Estimated reconstruction time."
        )

        static let transferToMacGuidance = NSLocalizedString(
            "%d of %d images will be processed on iPhone. Transfer images to Mac to create the full model. (Review, Object Capture)",
            bundle: Bundle.main,
            value: "%d of %d images will be processed on iPhone. Transfer images to Mac to create the full model. ",
            comment: "Guidance to transfer the images to Mac."
        )

        static let rotationTooFewImagesTitle = NSLocalizedString(
            "Keep rotating your object. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Keep rotating your object.",
            comment: "Feedback title for when user has less than the minimum images required in rotation mode."
        )

        static let rotationTooFewImagesDetailText = NSLocalizedString(
            "You need at least <min num of images> images of your object to create a model. Rotate slowly and steadily. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "You need at least %d images of your object to create a model. Rotate slowly and steadily.",
            comment: "Feedback for when user has less than the minimum images required in rotation mode."
        )

        static let rotationFirstSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep rotating to complete the first segment. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Keep rotating to complete the first segment.",
            comment: "Feedback title for when user still has work to do to complete the first segment in rotation mode."
        )

        static let rotationFirstSegmentNeedsWorkDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. Keep your device stationary and rotate the object slowly. (Review, Rotation Capture, 1st Segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. Keep your device stationary and rotate the object slowly.",
            comment: "Feedback for when user still has work to do to complete the first segment in rotation mode."
        )

        static let rotationFirstSegmentCompleteTitle = NSLocalizedString(
            "First segment complete. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "First segment complete.",
            comment: "Feedback title for when user has finished capturing first segment in rotation mode."
        )

        static let rotationFirstSegmentCompleteDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. Continue rotating for additional segments. (Review, Rotation Capture, 1st Segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. Continue rotating for additional segments.",
            comment: "Feedback for when user has finished capturing first segment in rotation mode."
        )

        static let rotationSecondSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep rotating to complete the second segment. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Keep rotating to complete the second segment.",
            comment: "Feedback for when the person hasn't finished capturing the second segment in rotation mode."
        )

        static let rotationSecondSegmentNeedsWorkDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. Rotate the object slowly and keep device stationary. (Review, Rotation Capture, 2nd Segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. Rotate the object slowly and keep device stationary.",
            comment: "Feedback for when the person hasn't finished capturing the second segment in rotation mode."
        )

        static let rotationSecondSegmentCompleteTitle = NSLocalizedString(
            "Second segment complete. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Second segment complete.",
            comment: "Feedback for when the person has finished capturing the second segment in rotation mode."
        )

        static let rotationSecondSegmentCompleteDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. Continue rotating for the final segment. (Review, Rotation Capture, 2nd segment)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. Continue rotating for the final segment.",
            comment: "Feedback for when the person has finished capturing the second segment in rotation mode."
        )

        static let rotationThirdSegmentNeedsWorkTitle = NSLocalizedString(
            "Keep rotating to complete the final segment. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Keep rotating to complete the final segment.",
            comment: "Feedback for when the person needs to complete the final segment in rotation mode."
        )

        static let rotationThirdSegmentNeedsWorkDetailText = NSLocalizedString(
            "For best quality, three segments are recommended. If you're done, tap Finish to complete your object. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "For best quality, three segments are recommended. If you're done, tap Finish to complete your object.",
            comment: "Feedback for when user still has work to do to complete the final segment in rotation mode."
        )

        static let rotationThirdSegmentCompleteTitle = NSLocalizedString(
            "All segments complete. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "All segments complete.",
            comment: "Feedback for when the person has captured the final segment in rotation mode."
        )

        static let rotationThirdSegmentCompleteDetailText = NSLocalizedString(
            "Tap Finish to process your object. (Review, Rotation Capture)",
            bundle: Bundle.main,
            value: "Tap Finish to process your object.",
            comment: "Feedback for when the person has captured the final segment and can process the object model in rotation mode."
        )
    }
}
