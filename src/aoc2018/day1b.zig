const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var map = std.AutoHashMap(i64, void).init(allocator);
    defer map.deinit();

    var frequency: i64 = 0;
    try map.put(frequency, {});

    while (true) {
        var it = std.mem.tokenizeScalar(u8, input, '\n');
        while (it.next()) |line| {
            const change = try std.fmt.parseInt(i64, line, 10);
            frequency += change;

            if (map.contains(frequency)) {
                print("First frequency reached twice: {}\n", .{frequency});
                return;
            }

            try map.put(frequency, {});
        }
    }
}
