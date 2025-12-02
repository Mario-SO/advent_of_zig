const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

const Turn = struct {
    dir: u8,
    amount: i32,
};

fn parseTurn(line: []const u8) !Turn {
    const dir = line[0];
    const amount = std.fmt.parseInt(i32, line[1..], 10) catch |err| {
        return err;
    };
    return .{ .dir = dir, .amount = amount };
}

pub fn main() !void {
    var it = std.mem.tokenizeScalar(u8, input, '\n');
    var currentPos: i32 = 50;
    var zeros: usize = 0;

    while (it.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, " \r\t");
        if (line.len == 0) continue;

        const turn = try parseTurn(line);

        if (turn.dir == 'L') {
            currentPos = @mod((currentPos - turn.amount), 100);
        } else {
            currentPos = @mod((currentPos + turn.amount), 100);
        }
        if (currentPos == 0) {
            zeros += 1;
        }
    }
    print("Result: {d}\n", .{zeros});
}
