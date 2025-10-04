const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var max: usize = 0;
    var sum: usize = 0;
    var it = std.mem.splitAny(u8, input, "\n");

    while (it.next()) |line| {
        if (line.len == 0) {
            if (sum > max) {
                max = sum;
            }
            sum = 0;
        } else {
            const curr = try std.fmt.parseInt(usize, line, 10);
            sum += curr;
        }
    }
    print("Result: {d}\n", .{max});
}
