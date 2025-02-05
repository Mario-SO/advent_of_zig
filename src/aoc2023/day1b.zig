const std = @import("std");

pub fn main() !void {
    // Embed your input file (change "i1.txt" as needed)
    const input = @embedFile("i1.txt");

    // Split the input by newline characters.
    var lines = std.mem.split(u8, input, "\n");

    // Spelled-out numbers ("one" through "nine") with the digit value equal to index + 1.
    const nums = [_][]const u8{
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    };

    var sum: usize = 0;

    // Process each line.
    while (lines.next()) |line| {
        // Skip lines that are too short.
        if (line.len < 2) continue;

        var first: ?u8 = null;
        var last: ?u8 = null;

        // Scan through every position of the line.
        for (line, 0..) |c, i| {
            // Check for spelled-out numbers. For each possible word, if the line
            // starting at position i begins with that word, interpret it as the corresponding digit.
            for (nums, 1..) |word, j| {
                if (std.mem.startsWith(u8, line[i..], word)) {
                    if (first == null) {
                        first = @intCast(j);
                    } else {
                        last = @intCast(j);
                    }
                }
            }
            // Check if the current character is a numeric digit.
            if (std.ascii.isDigit(c)) {
                if (first == null) {
                    first = c - '0';
                } else {
                    last = c - '0';
                }
            }
        }
        // If only one digit is found, use it for both positions.
        if (first == null) continue;
        if (last == null) last = first;

        sum += first.? * 10 + last.?;
    }

    std.debug.print("Total sum: {d}\n", .{sum});
}
