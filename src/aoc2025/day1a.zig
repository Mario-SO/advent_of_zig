const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

const Turn = struct {
    dir: u8,
    amount: usize,
};

fn parseTurn(line: []const u8) !Turn {
    const dir = line[0];
    const amount = std.fmt.parseInt(usize, line[1..], 10) catch |err| {
        return err;
    };
    return .{ .dir = dir, .amount = amount };
}

pub fn main() !void {
    var it = std.mem.tokenizeScalar(u8, input, '\n');
    while (it.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, " \r\t");
        if (line.len == 0) continue;

        const turn = try parseTurn(line);
        print("{c} - {d}\n", .{ turn.dir, turn.amount });
    }
}
