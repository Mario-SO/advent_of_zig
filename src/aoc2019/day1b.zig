const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var sum: i64 = 0;
    var it = std.mem.splitScalar(u8, input, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue; // Skip empty lines
        const mass = try std.fmt.parseInt(i64, line, 10);
        var fuel: i64 = 0;
        calculateRealFuel(mass, &fuel);
        sum += fuel;
    }

    print("Result: {d}\n", .{sum});
}

fn calculateRealFuel(mass: i64, fuel: *i64) void {
    var current_mass = mass;
    while (@divFloor(current_mass, 3) > 2) {
        current_mass = @divFloor(current_mass, 3) - 2;
        fuel.* += current_mass;
    }
}
