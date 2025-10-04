const input = @embedFile("./i1.txt");
const std = @import("std");
const print = std.log.debug;

pub fn main() !void {
    var increments: usize = 0;
    var it = std.mem.tokenizeScalar(u8, input, '\n');

    var window: [3]usize = .{
        // as .next() may return ?[]const (optional string), we need to forcefully unwrap with .?
        try std.fmt.parseInt(usize, it.next().?, 10),
        try std.fmt.parseInt(usize, it.next().?, 10),
        try std.fmt.parseInt(usize, it.next().?, 10),
    };

    var last_sum = window[0] + window[1] + window[2];

    while (it.next()) |line| {
        window[0] = window[1];
        window[1] = window[2];
        window[2] = try std.fmt.parseInt(usize, line, 10);

        const new_sum = window[0] + window[1] + window[2];
        defer last_sum = new_sum;

        if (new_sum > last_sum) increments += 1;
    }
    print("Result: {}\n", .{increments});
}
