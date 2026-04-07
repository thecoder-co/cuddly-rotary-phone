import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState
    
    public struct ContentState: Codable, Hashable {
        var appGroupId: String
    }
    
    var id = UUID()
}

extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}

let sharedDefault = UserDefaults(suiteName: "group.com.qarrprojects.trackers")!

// MARK: - Colors
private let accentGreen = Color(red: 52/255, green: 199/255, blue: 89/255)
private let dimGreen = Color(red: 52/255, green: 199/255, blue: 89/255).opacity(0.3)

@available(iOS 16.1, *)
struct WorkoutTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            let exerciseName = sharedDefault.string(forKey: context.attributes.prefixedKey("exerciseName")) ?? "Rest"
            let endTimeUnix = sharedDefault.double(forKey: context.attributes.prefixedKey("endTime"))
            let endDate = endTimeUnix > 0 ? Date(timeIntervalSince1970: endTimeUnix) : Date().addingTimeInterval(60)
            let now = Date()
            let safeEnd = endDate > now ? endDate : now.addingTimeInterval(1)
            
            // MARK: - Lock Screen / Banner
            HStack(spacing: 14) {
                // Pulsing timer ring
                ZStack {
                    Circle()
                        .stroke(dimGreen, lineWidth: 3)
                        .frame(width: 44, height: 44)
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(accentGreen, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 44, height: 44)
                        .rotationEffect(.degrees(-90))
                    Image(systemName: "figure.strengthtraining.functional")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(accentGreen)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("REST TIMER")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundColor(accentGreen)
                    Text(exerciseName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                
                Spacer()
                
                // Countdown pill
                Text(timerInterval: now...safeEnd, countsDown: true)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .monospacedDigit()
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.white.opacity(0.08))
                    )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .activityBackgroundTint(Color.black)
            
        } dynamicIsland: { context in
            let exerciseName = sharedDefault.string(forKey: context.attributes.prefixedKey("exerciseName")) ?? "Rest"
            let endTimeUnix = sharedDefault.double(forKey: context.attributes.prefixedKey("endTime"))
            let endDate = endTimeUnix > 0 ? Date(timeIntervalSince1970: endTimeUnix) : Date().addingTimeInterval(60)
            let now = Date()
            let safeEnd = endDate > now ? endDate : now.addingTimeInterval(1)
            
            return DynamicIsland {
                // MARK: - Expanded
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Label {
                            Text("Rest")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                        } icon: {
                            Image(systemName: "timer")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(accentGreen)
                        
                        Text(exerciseName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(1)
                    }
                    .padding(.leading, 2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timerInterval: now...safeEnd, countsDown: true)
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .monospacedDigit()
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 2)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(timerInterval: now...safeEnd, countsDown: true)
                        .tint(accentGreen)
                        .labelsHidden()
                }
                
            } compactLeading: {
                // MARK: - Compact Leading
                Image(systemName: "timer")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(accentGreen)
                
            } compactTrailing: {
                // MARK: - Compact Trailing
                Text(timerInterval: now...safeEnd, countsDown: true)
                    .monospacedDigit()
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundColor(accentGreen)
                    .frame(width: 42, alignment: .trailing)
                
            } minimal: {
                // MARK: - Minimal
                Image(systemName: "timer")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(accentGreen)
                    .padding(4)
            }
        }
    }
}
