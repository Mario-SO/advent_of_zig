const std = @import("std");

// const day1a15 = @import("./aoc2015/day1a.zig"); // Solved
// const day1b15 = @import("./aoc2015/day1b.zig"); // Solved

// const day1a16 = @import("./aoc2016/day1a.zig"); // Solved
// const day1b16 = @import("./aoc2016/day1b.zig"); // Solved

// const day1a17 = @import("./aoc2017/day1a.zig"); // Solved
// const day1b17 = @import("./aoc2017/day1b.zig"); // Solved

// const day1a18 = @import("./aoc2018/day1a.zig"); // Solved
// const day1b18 = @import("./aoc2018/day1b.zig"); // Solved

// const day1a19 = @import("./aoc2019/day1a.zig"); // Solved
// const day1b19 = @import("./aoc2019/day1b.zig"); // Solved

// const day1a20 = @import("./aoc2020/day1a.zig"); // Solved
// const day1b20 = @import("./aoc2020/day1b.zig"); // Solved

// const day1a21 = @import("./aoc2021/day1a.zig"); // Solved
// const day1b21 = @import("./aoc2021/day1b.zig"); // Solved

// const day1a22 = @import("./aoc2022/day1a.zig"); // Solved
// const day1b22 = @import("./aoc2022/day1b.zig"); // Solved

// const day1a23 = @import("./aoc2023/day1a.zig"); // Solved
// const day1b23 = @import("./aoc2023/day1b.zig"); // Solved

const day1a24 = @import("./aoc2024/day1a.zig");
// const day1b24 = @import("./aoc2024/day1b.zig");

pub fn main() !void {
    var timer = try std.time.Timer.start();
    try run(day1a24);
    const finish = timer.read();

    const milliseconds = @as(f64, @floatFromInt(finish)) / 1_000_000.0;
    std.debug.print("It took {d:.3}ms\n", .{milliseconds});
}

fn run(day: anytype) !void {
    try day.main();
}
