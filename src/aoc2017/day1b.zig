const std = @import("std");
const input = @embedFile("./i1.txt");

pub fn main() !void {
    const halfway = input.len / 2;
    var sum: usize = 0;

    for (input[0..halfway], 0..) |c, i| {
        if (c == input[i + halfway]) sum += (c - '0') * 2;
    }

    std.debug.print("{d}\n", .{sum});
}
