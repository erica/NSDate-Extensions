import Cocoa

// General Thanks: AshFurrow, sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen

public extension Date {
    public static var now: Date { return Date(timeIntervalSinceNow: 0) }
    
    public static let iso8601Formatter: DateFormatter = { $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"; return $0 }(DateFormatter())
    public static let shortDateFormatter: DateFormatter = { $0.dateStyle = .short; return $0 }(DateFormatter())
    public static let mediumDateFormatter: DateFormatter = { $0.dateStyle = .medium; return $0 }(DateFormatter())
    public static let longDateFormatter: DateFormatter = { $0.dateStyle = .long; return $0 }(DateFormatter())
    public static let fullDateFormatter: DateFormatter = { $0.dateStyle = .full; return $0 }(DateFormatter())
    public static let shortTimeFormatter: DateFormatter = { $0.timeStyle = .short; return $0 }(DateFormatter())
    public static let mediumTimeFormatter: DateFormatter = { $0.timeStyle = .medium; return $0 }(DateFormatter())
    public static let longTimeFormatter: DateFormatter = { $0.timeStyle = .long; return $0 }(DateFormatter())
    public static let fullTimeFormatter: DateFormatter = { $0.timeStyle = .full; return $0 }(DateFormatter())
    
    public var iso8601String: String { return Date.iso8601Formatter.string(from: self) }
    
    public var shortDateString: String { return Date.shortDateFormatter.string(from:self) }
    public var mediumDateString: String { return Date.mediumDateFormatter.string(from:self) }
    public var longDateString: String { return Date.longDateFormatter.string(from:self) }
    public var fullDateString: String { return Date.fullDateFormatter.string(from:self) }
    
    public var shortTimeString: String { return Date.shortTimeFormatter.string(from:self) }
    public var mediumTimeString: String { return Date.mediumTimeFormatter.string(from:self) }
    public var longTimeString: String { return Date.longTimeFormatter.string(from:self) }
    public var fullTimeString: String { return Date.fullTimeFormatter.string(from:self) }
    
    public var shortString: String { return "\(self.shortDateString) \(self.shortTimeString)" }
    public var mediumString: String { return "\(self.mediumDateString) \(self.mediumTimeString)" }
    public var longString: String { return "\(self.longDateString) \(self.longTimeString)" }
    public var fullString: String { return "\(self.fullDateString) \(self.fullTimeString)" }
}

public extension Date {
    public static let second: TimeInterval = 1
    public static let minute: TimeInterval = 60
    public static let hour: TimeInterval = 3600
    public static let day: TimeInterval = 86400
    public static let week: TimeInterval = 604800
}

public extension Int {
    public var seconds: TimeInterval { return TimeInterval(self) * Date.second }
    public var minutes: TimeInterval { return TimeInterval(self) * Date.minute }
    public var hours: TimeInterval { return TimeInterval(self) * Date.hour }
    public var days: TimeInterval { return TimeInterval(self) * Date.day }
    public var weeks: TimeInterval { return TimeInterval(self) * Date.week }
}

public extension Date {
    public static var dateComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .nanosecond]
    public static var allComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone]
    
    public var components: DateComponents { return Date.sharedCalendar.dateComponents(Date.dateComponents, from: self) }
    public var allComponents: DateComponents { return Date.sharedCalendar.dateComponents(Date.allComponents, from: self) }
    public var interval: TimeInterval { return self.timeIntervalSinceReferenceDate }
    
    public static var sharedCalendar = NSCalendar.autoupdatingCurrent
    
    public func offset(_ component: Calendar.Component, _ count: Int) -> Date {
        var newComponent: DateComponents = DateComponents(second: 0)
        switch component {
        case .era: newComponent = DateComponents(era: count)
        case .year: newComponent = DateComponents(year: count)
        case .month: newComponent = DateComponents(month: count)
        case .day: newComponent = DateComponents(day: count)
        case .hour: newComponent = DateComponents(hour: count)
        case .minute: newComponent = DateComponents(minute: count)
        case .second: newComponent = DateComponents(second: count)
        case .weekday: newComponent = DateComponents(weekday: count)
        case .weekdayOrdinal: newComponent = DateComponents(weekdayOrdinal: count)
        case .quarter: newComponent = DateComponents(quarter: count)
        case .weekOfMonth: newComponent = DateComponents(weekOfMonth: count)
        case .weekOfYear: newComponent = DateComponents(weekOfYear: count)
        case .yearForWeekOfYear: newComponent = DateComponents(yearForWeekOfYear: count)
        case .nanosecond: newComponent = DateComponents(nanosecond: count)
            // case .calendar: newComponent = DateComponents(calendar: count)
        // case .timeZone: newComponent = DateComponents(timeZone: count)
        default: break
        }
        return Date.sharedCalendar.date(byAdding: newComponent, to: self) ?? self
    }
    
    public var startOfDay: Date {
        let midnight = DateComponents(year: components.year, month: components.month, day: components.day)
        return Date.sharedCalendar.date(from: midnight) ?? self
    }
    public var today: Date { return self.startOfDay }
    public var tomorrow: Date { return self.today.offset(.day, 1) }
    public var yesterday: Date { return self.today.offset(.day, -1) }
    
    public static var today: Date { return Date.now.startOfDay }
    public static var tomorrow: Date { return Date.today.offset(.day, 1) }
    public static var yesterday: Date { return Date.today.offset(.day, -1) }
    
    public var endOfDay: Date { return self.tomorrow.startOfDay.offset(.second, -1) }
    public static var endOfToday: Date { return Date.now.endOfDay }
    
    public static func sameDate(_ date1: Date, _ date2: Date) -> Bool {
        let components1 = date1.components
        let components2 = date2.components
        
        return
            components1.year  == components2.year &&
                components1.month == components2.month &&
                components1.day   == components2.day
    }
    
    public var isToday: Bool { return Date.sameDate(self, Date.today) }
    public var isTomorrow: Bool { return Date.sameDate(self, Date.tomorrow) }
    public var isYesterday: Bool { return Date.sameDate(self, Date.yesterday) }
    
    public static var thisWeek: Date {
        let components = Date.now.allComponents
        let startOfWeek = DateComponents(weekOfYear: components.weekOfYear, yearForWeekOfYear: components.yearForWeekOfYear)
        return Date.sharedCalendar.date(from: startOfWeek) ?? Date.now
    }
    
    public var nextWeek: Date { return self.offset(.weekOfYear, 1) }
    public var lastWeek: Date { return self.offset(.weekOfYear, -1) }
    public static var nextWeek: Date { return Date.now.offset(.weekOfYear, 1) }
    public static var lastWeek: Date { return Date.now.offset(.weekOfYear, -1) }
    
    // This kind of sucks but it's useful enough to keep around
    public static func sameWeek(_ date1: Date, _ date2: Date) -> Bool {
        // dates within 1 week of each other more or less, increasing
        // tolerance for DST changes. Thanks Omni Greg Titus
        guard abs(date1.interval - date2.interval) <= 8.days else { return false }
        
        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        let components1 = date1.allComponents
        let components2 = date2.allComponents
        return components1.weekOfYear == components2.weekOfYear
    }
    
    public var isThisWeek: Bool { return Date.sameWeek(self, Date.thisWeek) }
    public var isNextWeek: Bool { return Date.sameWeek(self, Date.nextWeek) }
    public var isLastWeek: Bool { return Date.sameWeek(self, Date.lastWeek) }
    
    public static var thisYear: Date {
        let components = Date.now.components
        let theyear = DateComponents(year: components.year)
        return Date.sharedCalendar.date(from: theyear) ?? Date.now
    }
    
    public static var nextYear: Date { return thisYear.offset(.year, 1) }
    public static var lastYear: Date { return thisYear.offset(.year, -1) }
    
    public static func sameYear(_ date1: Date, _ date2: Date) -> Bool {
        let components1 = date1.allComponents
        let components2 = date2.allComponents
        return components1.year == components2.year
    }
    
    public var isThisYear: Bool { return Date.sameYear(self, Date.thisYear) }
    public var isNextYear: Bool { return Date.sameYear(self, Date.nextYear) }
    public var isLastYear: Bool { return Date.sameYear(self, Date.lastYear) }
    
    public var isPast: Bool { return self < Date.now }
    public var isFuture: Bool { return self > Date.now }
    
    public var isTypicallyWeekend: Bool {
        let components = self.allComponents
        return components.weekday == 1 || components.weekday == 7
    }
    public var isTypicallyWorkday: Bool { return !self.isTypicallyWeekend }
}

public extension Date {
    
    public func interval(to date: Date) -> TimeInterval {
        return date.interval - self.interval
    }
    
    public func distance(to date: Date, component: Calendar.Component) -> Int {
        let gregorian = Calendar(identifier: .gregorian)
        let theNow = gregorian.component(component, from: self)
        let theThen = gregorian.component(component, from: date)
        return theThen - theNow
    }
    
    public func days(to date: Date) -> Int { return distance(to: date, component: .day) }
    public func hours(to date: Date) -> Int { return distance(to: date, component: .hour) }
    public func minutes(to date: Date) -> Int { return distance(to: date, component: .minute) }
    public func seconds(to date: Date) -> Int { return distance(to: date, component: .second) }
    
    public func offsets(to date: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        var ti = Int(floor(date.interval - self.interval))
        let seconds = ti % 60; ti = ti / 60
        let minutes = ti % 60; ti = ti / 60
        let hours = ti % 24; ti = ti / 24
        let days = ti
        return (days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}

public extension Date {
    public var era: Int { return Date.sharedCalendar.component(.era, from: self) }
    public var year: Int { return Date.sharedCalendar.component(.year, from: self) }
    public var month: Int { return Date.sharedCalendar.component(.month, from: self) }
    public var day: Int { return Date.sharedCalendar.component(.day, from: self) }
    public var hour: Int { return Date.sharedCalendar.component(.hour, from: self) }
    public var minute: Int { return Date.sharedCalendar.component(.minute, from: self) }
    public var second: Int { return Date.sharedCalendar.component(.second, from: self) }
    public var weekday: Int { return Date.sharedCalendar.component(.weekday, from: self) }
    public var weekdayOrdinal: Int { return Date.sharedCalendar.component(.weekdayOrdinal, from: self) }
    public var quarter: Int { return Date.sharedCalendar.component(.quarter, from: self) }
    public var weekOfMonth: Int { return Date.sharedCalendar.component(.weekOfMonth, from: self) }
    public var weekOfYear: Int { return Date.sharedCalendar.component(.weekOfYear, from: self) }
    public var yearForWeekOfYear: Int { return Date.sharedCalendar.component(.yearForWeekOfYear, from: self) }
    public var nanosecond: Int { return Date.sharedCalendar.component(.nanosecond, from: self) }
    public var calendar: Int { return Date.sharedCalendar.component(.calendar, from: self) }
    public var timeZone: Int { return Date.sharedCalendar.component(.timeZone, from: self) }
}

public extension Date {
    public var nearestHour: Int { return (self.offset(.minute, 30)).hour }
}
