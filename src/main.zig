const std = @import("std");

const day1a15 = @import("./aoc2015/day1a.zig");
const day1b15 = @import("./aoc2015/day1b.zig");

const day1a16 = @import("./aoc2016/day1a.zig");
const day1b16 = @import("./aoc2016/day1b.zig");

const day1a17 = @import("./aoc2017/day1a.zig");
const day1b17 = @import("./aoc2017/day1b.zig");

const day1a18 = @import("./aoc2018/day1a.zig");
const day1b18 = @import("./aoc2018/day1b.zig");

const day1a19 = @import("./aoc2019/day1a.zig");
const day1b19 = @import("./aoc2019/day1b.zig");

const day1a20 = @import("./aoc2020/day1a.zig");
const day1b20 = @import("./aoc2020/day1b.zig");

const day1a21 = @import("./aoc2021/day1a.zig");
const day1b21 = @import("./aoc2021/day1b.zig");

const day1a22 = @import("./aoc2022/day1a.zig");
const day1b22 = @import("./aoc2022/day1b.zig");

const day1a23 = @import("./aoc2023/day1a.zig");
const day1b23 = @import("./aoc2023/day1b.zig");

const day1a24 = @import("./aoc2024/day1a.zig");
// const day1b24 = @import("./aoc2024/day1b.zig");

const day1a25 = @import("./aoc2025/day1a.zig");

const DayModule = struct {
    year: u16,
    day: []const u8,
    main_fn: *const fn () anyerror!void,
};

const available_days = [_]DayModule{
    .{ .year = 2015, .day = "1a", .main_fn = day1a15.main },
    .{ .year = 2015, .day = "1b", .main_fn = day1b15.main },
    .{ .year = 2016, .day = "1a", .main_fn = day1a16.main },
    .{ .year = 2016, .day = "1b", .main_fn = day1b16.main },
    .{ .year = 2017, .day = "1a", .main_fn = day1a17.main },
    .{ .year = 2017, .day = "1b", .main_fn = day1b17.main },
    .{ .year = 2018, .day = "1a", .main_fn = day1a18.main },
    .{ .year = 2018, .day = "1b", .main_fn = day1b18.main },
    .{ .year = 2019, .day = "1a", .main_fn = day1a19.main },
    .{ .year = 2019, .day = "1b", .main_fn = day1b19.main },
    .{ .year = 2020, .day = "1a", .main_fn = day1a20.main },
    .{ .year = 2020, .day = "1b", .main_fn = day1b20.main },
    .{ .year = 2021, .day = "1a", .main_fn = day1a21.main },
    .{ .year = 2021, .day = "1b", .main_fn = day1b21.main },
    .{ .year = 2022, .day = "1a", .main_fn = day1a22.main },
    .{ .year = 2022, .day = "1b", .main_fn = day1b22.main },
    .{ .year = 2023, .day = "1a", .main_fn = day1a23.main },
    .{ .year = 2023, .day = "1b", .main_fn = day1b23.main },
    .{ .year = 2024, .day = "1a", .main_fn = day1a24.main },
    // .{ .year = 2024, .day = "1b", .main_fn = day1b24.main },
    .{ .year = 2025, .day = "1a", .main_fn = day1a25.main },
};

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        printUsage(args[0]);
        return error.InvalidArguments;
    }

    // Check for "all" command
    if (std.mem.eql(u8, args[1], "all")) {
        try runAll();
        return;
    }

    if (args.len < 3) {
        printUsage(args[0]);
        return error.InvalidArguments;
    }

    const year = try std.fmt.parseInt(u16, args[1], 10);
    const day = args[2];

    for (available_days) |day_module| {
        if (day_module.year == year and std.mem.eql(u8, day_module.day, day)) {
            var timer = try std.time.Timer.start();
            try day_module.main_fn();
            const finish = timer.read();

            const milliseconds = @as(f64, @floatFromInt(finish)) / 1_000_000.0;
            std.debug.print("It took {d:.3}ms\n", .{milliseconds});
            return;
        }
    }

    std.debug.print("Day {d} {s} not found\n", .{ year, day });
    return error.DayNotFound;
}

fn printUsage(program_name: []const u8) void {
    std.debug.print("Usage: {s} <year> <day>\n", .{program_name});
    std.debug.print("       {s} all\n", .{program_name});
    std.debug.print("\nExamples:\n", .{});
    std.debug.print("  {s} 2024 1a\n", .{program_name});
    std.debug.print("  {s} all\n", .{program_name});
    std.debug.print("\nAvailable days:\n", .{});
    for (available_days) |day_module| {
        std.debug.print("  {d} {s}\n", .{ day_module.year, day_module.day });
    }
}

fn runAll() !void {
    std.debug.print("Running all days...\n\n", .{});

    for (available_days) |day_module| {
        std.debug.print("=== {d} Day {s} ===\n", .{ day_module.year, day_module.day });

        var timer = try std.time.Timer.start();
        day_module.main_fn() catch |err| {
            std.debug.print("Error: {}\n", .{err});
            continue;
        };
        const finish = timer.read();

        const milliseconds = @as(f64, @floatFromInt(finish)) / 1_000_000.0;
        std.debug.print("Time: {d:.3}ms\n\n", .{milliseconds});
    }

    std.debug.print("All days completed!\n", .{});
}
