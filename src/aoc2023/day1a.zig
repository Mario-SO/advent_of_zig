const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var it = std.mem.tokenizeScalar(u8, input, '\n');
    var sum: u32 = 0;

    while (it.next()) |line| {
        var first: u8 = 0;
        var last: u8 = 0;

        // Find first digit
        for (line) |char| {
            if (std.ascii.isDigit(char)) {
                // '5' (ASCII 53) - '0' (ASCII 48) = 5
                // '9' (ASCII 57) - '0' (ASCII 48) = 9
                first = char - '0';
                break;
            }
        }

        // Find last digit
        var i = line.len;
        while (i > 0) {
            i -= 1;
            const char = line[i];
            if (std.ascii.isDigit(char)) {
                last = char - '0';
                break;
            }
        }

        sum += first * 10 + last;
    }

    print("Total sum: {}\n", .{sum});
}
