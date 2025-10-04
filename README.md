# Advent of Code - Zig Solutions

Solutions to Advent of Code challenges implemented in Zig.

## Requirements

- Zig 0.15.1 or later

## Building

```bash
zig build
```

## Running

Run any specific day using command-line arguments:

```bash
zig build run -- <year> <day>
```

Examples:
```bash
zig build run -- 2024 1a
zig build run -- 2015 1b
zig build run -- 2023 1a
```

To see available days, run without arguments:
```bash
zig build run
```

## Test Results

All solutions tested on Zig 0.15.1:

### 2015
- **Day 1a**: Floor: 280 (0.151ms) ✅
- **Day 1b**: Floor: 1797 (0.022ms) ✅

### 2016
- **Day 1a**: 243 (0.055ms) ✅
- **Day 1b**: 142 (0.336ms) ✅

### 2017
- **Day 1a**: Result = 1251 (0.017ms) ✅
- **Day 1b**: 1244 (0.014ms) ✅

### 2018
- **Day 1a**: Result: 425 (0.079ms) ✅
- **Day 1b**: First frequency reached twice: 57538 (65.763ms) ✅

### 2019
- **Day 1a**: Result: 3412207 (0.028ms) ✅
- **Day 1b**: Result: 5115436 (0.476ms) ✅

### 2020
- **Day 1a**: Result: 842016 (2.844ms) ✅
- **Day 1b**: Result: 9199664 (258.755ms) ✅

### 2021
- **Day 1a**: Number of times increased: 1266 (0.242ms) ✅
- **Day 1b**: Result: 1217 (0.215ms) ✅

### 2022
- **Day 1a**: Max: 70720 (0.227ms) ✅
- **Day 1b**: Total of top three: 207148 (0.218ms) ✅

### 2023
- **Day 1a**: Total sum: 54239 (0.160ms) ✅
- **Day 1b**: Total sum: 55343 (4.451ms) ✅

### 2024
- **Day 1a**: 1530215 (0.659ms) ✅

## Project Structure

```
advent_of_zig/
├── build.zig
├── build.zig.zon
├── src/
│   ├── main.zig
│   ├── aoc2015/
│   │   ├── day1a.zig
│   │   ├── day1b.zig
│   │   └── i1.txt
│   ├── aoc2016/
│   ├── aoc2017/
│   ├── aoc2018/
│   ├── aoc2019/
│   ├── aoc2020/
│   ├── aoc2021/
│   ├── aoc2022/
│   ├── aoc2023/
│   └── aoc2024/
└── README.md
```

## Zig 0.15.1 Migration Notes

This project has been updated to work with Zig 0.15.1. Key changes include:

- Updated `build.zig` to use `root_module` structure
- Changed `std.ArrayList(T)` to `std.ArrayListUnmanaged(T)`
- Updated `std.mem.split()` to `std.mem.splitScalar()` or `std.mem.splitSequence()`
- Updated `std.mem.tokenize()` to `std.mem.tokenizeScalar()`
- Replaced `std.math.absCast()` with `@abs()` and `@intCast()`
- Added `fingerprint` field to `build.zig.zon`

## License

This is personal learning code for Advent of Code challenges.
