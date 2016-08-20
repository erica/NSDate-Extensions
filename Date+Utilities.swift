import Foundation

// Thanks: AshFurrow, sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki, Lily Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen, Greg Titus, Jim Morrison, aclark, Marcin Krzyzanowski, dmitrydims, Sebastian Celis, Seyithan Teymur, 

// Base utility
extension Date {
    /// Returns date's time interval since reference date
    public var interval: TimeInterval { return self.timeIntervalSinceReferenceDate }
    
    /// Returns common shared calendar, user's preferred calendar
    public static var sharedCalendar = NSCalendar.autoupdatingCurrent
}

// Subscripting
extension DateComponents {
    /// Adds date component subscripting
    public subscript(component: Calendar.Component) -> Int? {
        switch component {
        case .era: return self.era
        case .year: return self.year
        case .month: return self.month
        case .day: return self.day
        case .hour: return self.hour
        case .minute: return self.minute
        case .second: return self.second
        case .weekday: return self.weekday
        case .weekdayOrdinal: return self.weekdayOrdinal
        case .quarter: return self.quarter
        case .weekOfMonth: return self.weekOfMonth
        case .weekOfYear: return self.weekOfYear
        case .yearForWeekOfYear: return self.yearForWeekOfYear
        case .nanosecond: return self.nanosecond
        // case .calendar: return self.calendar
        // case .timeZone: return self.timeZone
        default: return nil
        }
    }
}

// Date component retrieval
// Some of these are entirely pointless but I have included all components
public extension Date {
    /// Returns instance's year component
    public var year: Int { return Date.sharedCalendar.component(.year, from: self) }
    /// Returns instance's month component
    public var month: Int { return Date.sharedCalendar.component(.month, from: self) }
    /// Returns instance's day component
    public var day: Int { return Date.sharedCalendar.component(.day, from: self) }
    /// Returns instance's hour component
    public var hour: Int { return Date.sharedCalendar.component(.hour, from: self) }
    /// Returns instance's minute component
    public var minute: Int { return Date.sharedCalendar.component(.minute, from: self) }
    /// Returns instance's second component
    public var second: Int { return Date.sharedCalendar.component(.second, from: self) }
    
    /// Returns instance's weekday component
    public var weekday: Int { return Date.sharedCalendar.component(.weekday, from: self) }
    /// Returns instance's weekdayOrdinal component
    public var weekdayOrdinal: Int { return Date.sharedCalendar.component(.weekdayOrdinal, from: self) }
    /// Returns instance's weekOfMonth component
    public var weekOfMonth: Int { return Date.sharedCalendar.component(.weekOfMonth, from: self) }
    /// Returns instance's weekOfYear component
    public var weekOfYear: Int { return Date.sharedCalendar.component(.weekOfYear, from: self) }
    
    /// Returns instance's yearForWeekOfYear component
    public var yearForWeekOfYear: Int { return Date.sharedCalendar.component(.yearForWeekOfYear, from: self) }
    
    /// Returns instance's quarter component
    public var quarter: Int { return Date.sharedCalendar.component(.quarter, from: self) }
    
    /// Returns instance's nanosecond component
    public var nanosecond: Int { return Date.sharedCalendar.component(.nanosecond, from: self) }
    /// Returns instance's (meaningless) era component
    public var era: Int { return Date.sharedCalendar.component(.era, from: self) }
    /// Returns instance's (meaningless) calendar component
    public var calendar: Int { return Date.sharedCalendar.component(.calendar, from: self) }
    /// Returns instance's (meaningless) timeZone component.
    public var timeZone: Int { return Date.sharedCalendar.component(.timeZone, from: self) }
}

// Formatters and Strings
public extension Date {
    /// Returns the current time as a Date instance
    public static var now: Date { return Date(timeIntervalSinceNow: 0) }
    
    /// Returns an ISO 8601 formatter
    public static var iso8601Formatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        $0.locale = Locale(identifier: "en_US_POSIX")
        return $0 }(DateFormatter())
    /// Returns a short style date formatter
    public static var shortDateFormatter: DateFormatter = { $0.dateStyle = .short; return $0 }(DateFormatter())
    /// Returns a medium style date formatter
    public static var mediumDateFormatter: DateFormatter = { $0.dateStyle = .medium; return $0 }(DateFormatter())
    /// Returns a long style date formatter
    public static var longDateFormatter: DateFormatter = { $0.dateStyle = .long; return $0 }(DateFormatter())
    /// Returns a full style date formatter
    public static var fullDateFormatter: DateFormatter = { $0.dateStyle = .full; return $0 }(DateFormatter())
    /// Returns a short style time formatter
    public static var shortTimeFormatter: DateFormatter = { $0.timeStyle = .short; return $0 }(DateFormatter())
    /// Returns a medium style time formatter
    public static var mediumTimeFormatter: DateFormatter = { $0.timeStyle = .medium; return $0 }(DateFormatter())
    /// Returns a long style time formatter
    public static var longTimeFormatter: DateFormatter = { $0.timeStyle = .long; return $0 }(DateFormatter())
    /// Returns a full style time formatter
    public static var fullTimeFormatter: DateFormatter = { $0.timeStyle = .full; return $0 }(DateFormatter())
    
    /// Represents date as ISO8601 string
    public var iso8601String: String { return Date.iso8601Formatter.string(from: self) }
    
    /// Returns date components as short string
    public var shortDateString: String { return Date.shortDateFormatter.string(from:self) }
    /// Returns date components as medium string
    public var mediumDateString: String { return Date.mediumDateFormatter.string(from:self) }
    /// Returns date components as long string
    public var longDateString: String { return Date.longDateFormatter.string(from:self) }
    /// Returns date components as full string
    public var fullDateString: String { return Date.fullDateFormatter.string(from:self) }
    
    /// Returns time components as short string
    public var shortTimeString: String { return Date.shortTimeFormatter.string(from:self) }
    /// Returns time components as medium string
    public var mediumTimeString: String { return Date.mediumTimeFormatter.string(from:self) }
    /// Returns time components as long string
    public var longTimeString: String { return Date.longTimeFormatter.string(from:self) }
    /// Returns time components as full string
    public var fullTimeString: String { return Date.fullTimeFormatter.string(from:self) }
    
    /// Returns date and time components as short string
    public var shortString: String { return "\(self.shortDateString) \(self.shortTimeString)" }
    /// Returns date and time components as medium string
    public var mediumString: String { return "\(self.mediumDateString) \(self.mediumTimeString)" }
    /// Returns date and time components as long string
    public var longString: String { return "\(self.longDateString) \(self.longTimeString)" }
    /// Returns date and time components as full string
    public var fullString: String { return "\(self.fullDateString) \(self.fullTimeString)" }
}

// Standard interval reference
// Not meant to replace `offset(_: Calendar.Component, _: Int)` to offset dates
public extension Date {
    /// Returns number of seconds per second
    public static let second: TimeInterval = 1
    /// Returns number of seconds per minute
    public static let minute: TimeInterval = 60
    /// Returns number of seconds per hour
    public static let hour: TimeInterval = 3600
    /// Returns number of seconds per 24-hour day
    public static let day: TimeInterval = 86400
    /// Returns number of seconds per standard week
    public static let week: TimeInterval = 604800
}

// Utility for interval math
// Not meant to replace `offset(_: Calendar.Component, _: Int)` to offset dates
public extension Int {
    /// Returns number of seconds in n seconds
    public var seconds: TimeInterval { return TimeInterval(self) * Date.second }
    /// Returns number of seconds in n minutes
    public var minutes: TimeInterval { return TimeInterval(self) * Date.minute }
    /// Returns number of seconds in n hours
    public var hours: TimeInterval { return TimeInterval(self) * Date.hour }
    /// Returns number of seconds in n 24-hour days
    public var days: TimeInterval { return TimeInterval(self) * Date.day }
    /// Returns number of seconds in n standard weeks
    public var weeks: TimeInterval { return TimeInterval(self) * Date.week }
}

// Components
public extension Date {
    /// Returns set of common date components
    public static var dateComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    /// Returns set of exhaustive date components
    public static var allComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone]
    
    /// Extracts common date components for date
    public var components: DateComponents { return Date.sharedCalendar.dateComponents(Date.dateComponents, from: self) }
    /// Extracts all date components for date
    public var allComponents: DateComponents { return Date.sharedCalendar.dateComponents(Date.allComponents, from: self) }
    
    /// Offset a date by n calendar components. Can be functionally chained
    /// For example:
    ///
    /// ```
    /// let afterThreeDays = date.offset(.day, 3)
    /// print(Date().offset(.day, 3).offset(.hour, 1).fullString)
    /// ```
    ///
    /// Not all components or offsets are useful
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
        // These items complete the component vocabulary but cannot be used in this way
        // case .calendar: newComponent = DateComponents(calendar: count)
        // case .timeZone: newComponent = DateComponents(timeZone: count)
        default: break
        }
        
        // If offset is not possible, return unmodified date
        return Date.sharedCalendar.date(byAdding: newComponent, to: self) ?? self
    }
}

// Alternative offset approach that constructs date components for offset duty
// I find this more verbose, less readable, less functional but your mileage may vary
extension DateComponents {
    /// Returns components populated by n years
    public static func years(_ count: Int) -> DateComponents { return DateComponents(year: count) }
    /// Returns components populated by n months
    public static func months(_ count: Int) -> DateComponents { return DateComponents(month: count) }
    /// Returns components populated by n days
    public static func days(_ count: Int) -> DateComponents { return DateComponents(day: count) }
    /// Returns components populated by n hours
    public static func hours(_ count: Int) -> DateComponents { return DateComponents(hour: count) }
    /// Returns components populated by n minutes
    public static func minutes(_ count: Int) -> DateComponents { return DateComponents(minute: count) }
    /// Returns components populated by n seconds
    public static func seconds(_ count: Int) -> DateComponents { return DateComponents(second: count) }
    /// Returns components populated by n nanoseconds
    public static func nanoseconds(_ count: Int) -> DateComponents { return DateComponents(nanosecond: count) }
}

/// Performs calendar math using date components as alternative
/// to `offset(_: Calendar.Component, _: Int)`
/// e.g.
/// ```swift
/// print((Date() + DateComponents.days(3) + DateComponents.hours(1)).fullString)
/// ```
public func +(lhs: Date, rhs: DateComponents) -> Date {
    return Date.sharedCalendar.date(byAdding: rhs, to: lhs)! // yes force unwrap. sue me.
}

// Date characteristics
extension Date {
    /// Returns true if date falls before current date
    public var isPast: Bool { return self < Date() }
    /// Returns true if date falls after current date
    public var isFuture: Bool { return self > Date() }
    
    /// Returns true if date falls on typical weekend
    public var isTypicallyWeekend: Bool {
        return Date.sharedCalendar.isDateInWeekend(self)
    }
    /// Returns true if date falls on typical workday
    public var isTypicallyWorkday: Bool { return !self.isTypicallyWeekend }
}

// Date distances
public extension Date {
    /// Returns the time interval between two dates
    static public func interval(_ date1: Date, _ date2: Date) -> TimeInterval {
        return date2.interval - date1.interval
    }
    /// Returns a time interval between the instance and another date
    public func interval(to date: Date) -> TimeInterval {
        return Date.interval(self, date)
    }
    
    /// Returns the distance between two dates
    /// using the user's preferred calendar
    /// e.g.
    /// ```
    /// let date1 = Date.shortDateFormatter.date(from: "1/1/16")!
    /// let date2 = Date.shortDateFormatter.date(from: "3/13/16")!
    /// Date.distance(date1, to: date2, component: .day) // 72
    /// ```
    /// - Warning: Returns 0 for bad components rather than crashing
    static public func distance(_ date1: Date, to date2: Date, component: Calendar.Component) -> Int {
        return Date.sharedCalendar.dateComponents([component], from: date1, to: date2)[component] ?? 0
    }
    
    /// Returns the distance between the instance and another date
    /// using the user's preferred calendar
    /// e.g.
    /// ```
    /// let date1 = Date.shortDateFormatter.date(from: "1/1/16")!
    /// let date2 = Date.shortDateFormatter.date(from: "3/13/16")!
    /// date1.distance(to: date2, component: .day) // 72
    /// ```
    /// - Warning: Returns 0 for bad components rather than crashing
    public func distance(to date: Date, component: Calendar.Component) -> Int {
        return Date.sharedCalendar.dateComponents([component], from: self, to: date)[component] ?? 0
    }
    
    /// Returns the number of days between the instance and a given date. May be negative
    public func days(to date: Date) -> Int { return distance(to: date, component: .day) }
    /// Returns the number of hours between the instance and a given date. May be negative
    public func hours(to date: Date) -> Int { return distance(to: date, component: .hour) }
    /// Returns the number of minutes between the instance and a given date. May be negative
    public func minutes(to date: Date) -> Int { return distance(to: date, component: .minute) }
    /// Returns the number of seconds between the instance and a given date. May be negative
    public func seconds(to date: Date) -> Int { return distance(to: date, component: .second) }
    
    /// Returns a (days, hours, minutes, seconds) tuple representing the
    /// time remaining between the instance and a target date.
    /// Not for exact use. For example:
    ///
    /// ```
    /// let test = Date().addingTimeInterval(5.days + 3.hours + 2.minutes + 10.seconds)
    /// print(Date().offsets(to: test))
    /// // prints (5, 3, 2, 10 or possibly 9 but rounded up)
    /// ```
    ///
    /// - Warning: returns 0 for any error when fetching component
    public func offsets(to date: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let components = Date.sharedCalendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: self, to: date.addingTimeInterval(0.5)) // round up
        return (
            days: components[.day] ?? 0,
            hours: components[.hour] ?? 0,
            minutes: components[.minute] ?? 0,
            seconds: components[.second] ?? 0
        )
    }
}

// Utility
public extension Date {
    /// Return the nearest hour using a 24 hour clock
    public var nearestHour: Int { return (self.offset(.minute, 30)).hour }
    
    /// Return the nearest minute
    public var nearestMinute: Int { return (self.offset(.second, 30)).minute }
}

// Canonical dates
extension Date {
    
    /// Returns a date representing midnight at the start of this day
    public var startOfDay: Date {
        let midnight = DateComponents(year: components.year, month: components.month, day: components.day)
        // If offset is not possible, return unmodified date
        return Date.sharedCalendar.date(from: midnight) ?? self
    }
    /// Returns a date representing midnight at the start of this day.
    /// Is synonym for `startOfDay`.
    public var today: Date { return self.startOfDay }
    /// Returns a date representing midnight at the start of tomorrow
    public var tomorrow: Date { return self.today.offset(.day, 1) }
    /// Returns a date representing midnight at the start of yesterday
    public var yesterday: Date { return self.today.offset(.day, -1) }
    
    /// Returns today's date at the midnight starting the day
    public static var today: Date { return Date().startOfDay }
    /// Returns tomorrow's date at the midnight starting the day
    public static var tomorrow: Date { return Date.today.offset(.day, 1) }
    /// Returns yesterday's date at the midnight starting the day
    public static var yesterday: Date { return Date.today.offset(.day, -1) }
    
    /// Returns a date representing a second before midnight at the end of the day
    public var endOfDay: Date { return self.tomorrow.startOfDay.offset(.second, -1) }
    /// Returns a date representing a second before midnight at the end of today
    public static var endOfToday: Date { return Date().endOfDay }
    
    /// Determines whether two days share the same date
    public static func sameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Date.sharedCalendar.isDate(date1, inSameDayAs: date2)
    }
    
    /// Returns true if this date is the same date as today for the user's preferred calendar
    public var isToday: Bool { return Date.sharedCalendar.isDateInToday(self) }
    /// Returns true if this date is the same date as tomorrow for the user's preferred calendar
    public var isTomorrow: Bool { return Date.sharedCalendar.isDateInTomorrow(self) }
    /// Returns true if this date is the same date as yesterday for the user's preferred calendar
    public var isYesterday: Bool { return Date.sharedCalendar.isDateInYesterday(self) }
    
    /// Returns the start of the instance's week of year for user's preferred calendar
    public var startOfWeek: Date {
        let components = self.allComponents
        let startOfWeekComponents = DateComponents(weekOfYear: components.weekOfYear, yearForWeekOfYear: components.yearForWeekOfYear)
        // If offset is not possible, return unmodified date
        return Date.sharedCalendar.date(from: startOfWeekComponents) ?? self
    }
    /// Returns the start of the current week of year for user's preferred calendar
    public static var thisWeek: Date {
        return Date().startOfWeek
    }
    
    /// Returns the start of next week of year for user's preferred calendar
    public var nextWeek: Date { return self.offset(.weekOfYear, 1) }
    /// Returns the start of last week of year for user's preferred calendar
    public var lastWeek: Date { return self.offset(.weekOfYear, -1) }
    /// Returns the start of next week of year for user's preferred calendar relative to date
    public static var nextWeek: Date { return Date().offset(.weekOfYear, 1) }
    /// Returns the start of last week of year for user's preferred calendar relative to date
    public static var lastWeek: Date { return Date().offset(.weekOfYear, -1) }
    
    /// Returns true if two weeks likely fall within the same week of year
    /// in the same year, or very nearly the same year
    public static func sameWeek(_ date1: Date, _ date2: Date) -> Bool {
        return date1.startOfWeek == date2.startOfWeek
    }
    
    /// Returns true if date likely falls within the current week of year
    public var isThisWeek: Bool { return Date.sameWeek(self, Date.thisWeek) }
    /// Returns true if date likely falls within the next week of year
    public var isNextWeek: Bool { return Date.sameWeek(self, Date.nextWeek) }
    /// Returns true if date likely falls within the previous week of year
    public var isLastWeek: Bool { return Date.sameWeek(self, Date.lastWeek) }
    
    /// Returns the start of year for the user's preferred calendar
    public static var thisYear: Date {
        let components = Date().components
        let theyear = DateComponents(year: components.year)
        // If offset is not possible, return unmodified date
        return Date.sharedCalendar.date(from: theyear) ?? Date()
    }
    /// Returns the start of next year for the user's preferred calendar
    public static var nextYear: Date { return thisYear.offset(.year, 1) }
    /// Returns the start of previous year for the user's preferred calendar
    public static var lastYear: Date { return thisYear.offset(.year, -1) }
    
    /// Returns true if two dates share the same year component
    public static func sameYear(_ date1: Date, _ date2: Date) -> Bool {
        return date1.allComponents.year == date2.allComponents.year
    }
    
    /// Returns true if date falls within this year for the user's preferred calendar
    public var isThisYear: Bool { return Date.sameYear(self, Date.thisYear) }
    /// Returns true if date falls within next year for the user's preferred calendar
    public var isNextYear: Bool { return Date.sameYear(self, Date.nextYear) }
    /// Returns true if date falls within previous year for the user's preferred calendar
    public var isLastYear: Bool { return Date.sameYear(self, Date.lastYear) }
}
