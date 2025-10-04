const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var sum: i64 = 0;
    var it = std.mem.splitScalar(u8, input, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue; // Skip empty lines
        const mass = try std.fmt.parseInt(i64, line, 10);
        const fuel = @divFloor(mass, 3) - 2;
        sum += fuel;
    }
    print("Result: {}\n", .{sum});
}
