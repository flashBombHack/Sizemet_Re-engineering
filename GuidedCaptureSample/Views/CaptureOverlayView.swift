/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Full-screen overlay UI with buttons to control the capture, intended to placed in a `ZStack` over the `ObjectCaptureView`.
*/

import AVFoundation
import RealityKit
import SwiftUI
import os

private let logger = Logger(subsystem: GuidedCaptureSampleApp.subsystem, category: "CaptureOverlayView")

struct CaptureOverlayView: View, OverlayButtons {
    @Environment(AppDataModel.self) var appModel
    var session: ObjectCaptureSession

    @AppStorage("show_tutorials") var areTutorialsEnabledInUserSettings: Bool = true
    
    @State private var showCaptureModeGuidance: Bool = false
    @State private var hasDetectionFailed = false
    @State private var showTutorialView = false
    @State private var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation

    var body: some View {
        ZStack {
            if areTutorialsEnabledInUserSettings, showTutorialView, let url = tutorialURL {
                TutorialView(url: url, showTutorialView: $showTutorialView)
            } else {
                VStack(spacing: 20) {
                    TopOverlayButtons(session: session,
                                      showCaptureModeGuidance: showCaptureModeGuidance)

                    Spacer()

                    if appModel.captureMode == .rotation && isCapturingStarted(state: session.state) {
                        RotationIndicatorView(session: session)
                            .transition(.opacity)
                    }

                    BoundingBoxGuidanceView(session: session, hasDetectionFailed: hasDetectionFailed)

                    BottomOverlayButtons(session: session,
                                         hasDetectionFailed: $hasDetectionFailed,
                                         showCaptureModeGuidance: $showCaptureModeGuidance,
                                         showTutorialView: $showTutorialView,
                                         rotationAngle: rotationAngle)
                }
                .padding()
                .padding(.horizontal, 15)
                .background {
                    VStack {
                        Spacer().frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 65 : 25)

                        FeedbackView(messageList: appModel.messageList)
                            .layoutPriority(1)
                    }
                    .rotationEffect(rotationAngle)
                }
                .task {
                    for await _ in NotificationCenter.default.notifications(named: UIDevice.orientationDidChangeNotification) {
                        withAnimation {
                            deviceOrientation = UIDevice.current.orientation
                        }
                    }
                }
            }
        }
        // When camera tracking isn't normal, display the AR coaching view and hide the overlay view.
        .opacity(shouldShowOverlayView ? 1.0 : 0.0)
        .onChange(of: session.state) {
            if !appModel.tutorialPlayedOnce, session.state == .capturing {
                // Start the tutorial video which will pause the capture while visible.
                withAnimation {
                    logger.log("Setting showTutorialView to true")
                    showTutorialView = true
                }
                appModel.tutorialPlayedOnce = true
            }
        }
    }

    private var shouldShowOverlayView: Bool {
        return showTutorialView || (session.cameraTracking == .normal && !session.isPaused)
    }

    private var tutorialURL: URL? {
        let interfaceIdiom = UIDevice.current.userInterfaceIdiom
        var videoName: String? = nil
        switch appModel.captureMode {
        case .area:
            videoName = interfaceIdiom == .pad ? "ScanTutorial-iPad-Area" : "ScanTutorial-iPhone-Area"
        case .object:
            videoName = interfaceIdiom == .pad ? "ScanPasses-iPad-FixedHeight-1" : "ScanPasses-iPhone-FixedHeight-1"
        case .rotation:
            videoName = interfaceIdiom == .pad ? "ScanPasses-iPad-FixedHeight-1" : "ScanPasses-iPhone-FixedHeight-1"
        }
        guard let videoName = videoName else { return nil }
        return Bundle.main.url(forResource: videoName, withExtension: "mp4")
    }

    private var rotationAngle: Angle {
        switch deviceOrientation {
            case .landscapeLeft:
                return Angle(degrees: 90)
            case .landscapeRight:
                return Angle(degrees: -90)
            case .portraitUpsideDown:
                return Angle(degrees: 180)
            default:
                return Angle(degrees: 0)
        }
    }
}

private struct TutorialView: View {
    @Environment(AppDataModel.self) var appModel
    var url: URL
    @Binding var showTutorialView: Bool

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var isVisible = false
    
    /// How long to delay the animation start once the tutorial view is dimmed.
    private let delay: TimeInterval = 0.3
    
    /// How much of the end of the animation to trim off.
    private let reducedTutorialAnimationTime: TimeInterval = 2.0

    var body: some View {
        VStack {
            Spacer()
            TutorialVideoView(url: url, isInReviewSheet: false)
                .frame(maxHeight: horizontalSizeClass == .regular ? 350 : 280)
                .overlay(alignment: .bottom) {
                    if appModel.captureMode == .object || appModel.captureMode == .rotation {
                        Text(appModel.captureMode == .rotation ? LocalizedString.rotationTutorialText : LocalizedString.tutorialText)
                            .font(.headline)
                            .padding(.bottom, (appModel.captureMode == .object || appModel.captureMode == .rotation) ? 16 : 0)
                            .foregroundStyle(.white)
                    }
                }
            Spacer()
        }
        .opacity(isVisible ? 1 : 0)
        .background(Color.black.opacity(0.5))
        .allowsHitTesting(false)
        .onAppear {
            // Let the screen dim before the animation tutorial plays.
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // Pause the capture session while the tutorial plays to reduce visual clutter
                // and avoid taking shots while the screen is covered.
                logger.log("Tutorial onAppear() is pausing the session...")
                appModel.objectCaptureSession?.pause()

                withAnimation {
                    isVisible = true
                }
            }
        }
        .onDisappear {
            // Resume the capture session once the tutorial is done.
            logger.log("Tutorial onDisappear() is resuming the session...")
            appModel.objectCaptureSession?.resume()
        }
        .task {
            let animationDuration = try? await AVURLAsset(url: url).load(.duration).seconds - reducedTutorialAnimationTime
            DispatchQueue.main.asyncAfter(deadline: .now() + (animationDuration ?? 0.0)) {
                showTutorialView = false
            }
        }
    }

    private struct LocalizedString {
        static let tutorialText = NSLocalizedString(
            "Move slowly around your object. (Object Capture, Orbit, Tutorial)",
            bundle: Bundle.main,
            value: "Move slowly around your object.",
            comment: "Guided feedback message to move slowly around object to start capturing."
        )
        static let rotationTutorialText = NSLocalizedString(
            "Rotate your object slowly and steadily. (Object Capture, Rotation, Tutorial)",
            bundle: Bundle.main,
            value: "Rotate your object slowly and steadily.",
            comment: "Guided feedback message to rotate object slowly for rotation capture."
        )
    }
}

private struct BoundingBoxGuidanceView: View {
    @Environment(AppDataModel.self) var appModel
    var session: ObjectCaptureSession
    var hasDetectionFailed: Bool

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        HStack {
            if let guidanceText {
                Text(guidanceText)
                    .font(.callout)
                    .bold()
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: horizontalSizeClass == .regular ? 400 : 360)
            }
        }
    }

    private var guidanceText: String? {
        if case .ready = session.state {
            switch appModel.captureMode {
                case .object:
                    if hasDetectionFailed {
                        return NSLocalizedString(
                            "Can‘t find your object. It should be larger than 3 in (8 cm) in each dimension.",
                            bundle: Bundle.main,
                            value: "Can‘t find your object. It should be larger than 3 in (8 cm) in each dimension.",
                            comment: "Feedback message when detection has failed.")
                    } else {
                        return NSLocalizedString(
                            "Move close and center the dot on your object, then tap Continue. (Object Capture, State)",
                            bundle: Bundle.main,
                            value: "Move close and center the dot on your object, then tap Continue.",
                            comment: "Feedback message to fill the camera feed with the object.")
                    }
                case .area:
                    return NSLocalizedString(
                        "Look at your subject (Object Capture, State).",
                        bundle: Bundle.main,
                        value: "Look at your subject.",
                        comment: "Feedback message to look at the subject in the area mode.")
                case .rotation:
                    if hasDetectionFailed {
                        return NSLocalizedString(
                            "Can‘t find your object. It should be larger than 3 in (8 cm) in each dimension.",
                            bundle: Bundle.main,
                            value: "Can‘t find your object. It should be larger than 3 in (8 cm) in each dimension.",
                            comment: "Feedback message when detection has failed.")
                    } else {
                        return NSLocalizedString(
                            "Position your object and center the dot on it, then tap Continue. (Object Capture, Rotation, State)",
                            bundle: Bundle.main,
                            value: "Position your object and center the dot on it, then tap Continue.",
                            comment: "Feedback message to position object for rotation capture.")
                    }
                }
        } else if case .detecting = session.state {
            if appModel.captureMode == .rotation {
                return NSLocalizedString(
                    "Ensure the whole object is inside the box. Drag handles to manually resize. (Object Capture, Rotation, State)",
                    bundle: Bundle.main,
                    value: "Ensure the whole object is inside the box. Drag handles to manually resize.",
                    comment: "Feedback message to resize the box to the object in rotation mode.")
            } else {
                return NSLocalizedString(
                    "Move around to ensure that the whole object is inside the box. Drag handles to manually resize. (Object Capture, State)",
                    bundle: Bundle.main,
                    value: "Move around to ensure that the whole object is inside the box. Drag handles to manually resize.",
                    comment: "Feedback message to resize the box to the object.")
            }
        } else if isCapturingStarted(state: session.state) && appModel.captureMode == .rotation {
            return NSLocalizedString(
                "Rotate the object slowly and steadily. Keep device stationary. (Object Capture, Rotation, Capturing)",
                bundle: Bundle.main,
                value: "Rotate the object slowly and steadily. Keep device stationary.",
                comment: "Guidance message during rotation capture.")
        } else {
            return nil
        }
    }
}

protocol OverlayButtons {
    func isCapturingStarted(state: ObjectCaptureSession.CaptureState) -> Bool
}

extension OverlayButtons {
    func isCapturingStarted(state: ObjectCaptureSession.CaptureState) -> Bool {
        switch state {
            case .initializing, .ready, .detecting:
                return false
            default:
                return true
        }
    }
}

private struct RotationIndicatorView: View {
    @Environment(AppDataModel.self) var appModel
    var session: ObjectCaptureSession
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.title2)
                    .foregroundColor(.white)
                Text(LocalizedString.rotationModeActive)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            
            Text(LocalizedString.rotationGuidance)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
    
    private struct LocalizedString {
        static let rotationModeActive = NSLocalizedString(
            "Rotation Mode Active (Object Capture)",
            bundle: Bundle.main,
            value: "Rotation Mode Active",
            comment: "Title showing rotation mode is active during capture.")
        
        static let rotationGuidance = NSLocalizedString(
            "Keep your device stationary and rotate the object slowly 360 degrees. (Object Capture, Rotation)",
            bundle: Bundle.main,
            value: "Keep your device stationary and rotate the object slowly 360 degrees.",
            comment: "Guidance text for rotation mode during capture.")
    }
}
