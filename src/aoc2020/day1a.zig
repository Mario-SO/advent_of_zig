const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var mult: i64 = 0;
    var it = std.mem.splitScalar(u8, input, '\n');

    while (it.next()) |line1| {
        if (line1.len == 0) continue;
        const num1 = try std.fmt.parseInt(i64, line1, 10);

        var it2 = std.mem.splitScalar(u8, input, '\n');
        while (it2.next()) |line2| {
            if (line2.len == 0) continue;
            const num2 = try std.fmt.parseInt(i64, line2, 10);

            if (num1 + num2 == 2020) {
                mult = num1 * num2;
                break;
            }
        }
        if (mult != 0) break;
    }

    if (mult != 0) {
        print("Result: {}\n", .{mult});
    } else {
        print("No solution found\n", .{});
    }
}
