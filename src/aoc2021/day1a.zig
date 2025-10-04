const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var it = std.mem.tokenizeScalar(u8, input, '\n');
    var prev: usize = 0;
    var increased: usize = 0;

    while (it.next()) |line| {
        const curr: usize = try std.fmt.parseInt(usize, line, 10);
        if (curr > prev) increased += 1;
        prev = curr;
    }

    // -1 because the first increase doesnt count as we are forcing it
    print("Result: {d}\n", .{increased - 1});
}
