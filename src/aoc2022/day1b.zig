const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

pub fn main() !void {
    var top_three = [3]usize{ 0, 0, 0 };
    var sum: usize = 0;
    var it = std.mem.splitAny(u8, input, "\n");

    while (it.next()) |line| {
        if (line.len == 0) {
            updateTopThree(&top_three, sum);
            sum = 0;
        } else {
            const curr = try std.fmt.parseInt(usize, line, 10);
            sum += curr;
        }
    }

    const total = top_three[0] + top_three[1] + top_three[2];
    print("Top three sums: {d}, {d}, {d}\n", .{ top_three[0], top_three[1], top_three[2] });
    print("Total of top three: {d}\n", .{total});
}

fn updateTopThree(top_three: *[3]usize, new_sum: usize) void {
    if (new_sum > top_three[0]) {
        top_three[2] = top_three[1];
        top_three[1] = top_three[0];
        top_three[0] = new_sum;
    } else if (new_sum > top_three[1]) {
        top_three[2] = top_three[1];
        top_three[1] = new_sum;
    } else if (new_sum > top_three[2]) {
        top_three[2] = new_sum;
    }
}
