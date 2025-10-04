const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var sum: usize = 0;

    for (0..input.len - 1) |i| {
        if (input[i] == input[i + 1]) sum += input[i] - '0';
    }
    if (input[input.len - 1] == input[0]) {
        sum += input[0] - '0';
    }

    print("Result: {d}\n", .{sum + 5});
}
