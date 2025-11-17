# Syntax Highlighting Features

DocumenterShiki adds special syntax for highlighting specific lines in code blocks.

## 1. Line Range Syntax

Highlight specific lines using `@highlight:` comment at the beginning of the code block:

```nohighlight
# @highlight: 2,4-5
function example()
    x = 1  # This line will be highlighted
    y = 2
    z = x + y  # These lines will be highlighted
    return z   # These lines will be highlighted
end
```

**Line Numbers**: Line counting starts from **line 1** (the first line after the `@highlight:` comment). The `@highlight:` comment itself is not counted and will be removed from the output.

**Usage**:
- `@highlight: 2` - Highlight line 2
- `@highlight: 1,3` - Highlight lines 1 and 3
- `@highlight: 2-5` - Highlight lines 2 through 5
- `@highlight: 1,3-4,7` - Combine multiple ranges

**Example**:

```@example
# @highlight: 2,4-5
function example()
    x = 1  # This line will be highlighted
    y = 2
    z = x + y  # These lines will be highlighted
    return z   # These lines will be highlighted
end
```

## 2. Block Syntax

Highlight multiple consecutive lines using `@highlight-start` and `@highlight-end`.

**Line Range**: Highlighting starts from **the line after** `@highlight-start` and ends at **the line before** `@highlight-end`. The marker comments themselves are removed from the output.

### Standalone `@highlight-end` (Separate Line)

When `@highlight-end` is placed on its own line, that line is removed from the output and the highlighting ends at the line before it:

```nohighlight
function example()
    println("Normal line")
    # @highlight-start
    x = important_calculation()
    y = another_important_step()
    # @highlight-end
    println("Normal line")
end
```

In this pattern:
- Highlighting starts after `# @highlight-start` (from the `x = ...` line)
- Highlighting ends before `# @highlight-end` (the `y = ...` line is the last highlighted line)
- The `# @highlight-end` line itself is removed from the output

**Example**:

```@example
function example()
    println("Normal line")
    # @highlight-start
    x = 10 * 2
    y = x + 5
    # @highlight-end
    println("Normal line")
    return y
end
```

### Inline `@highlight-end` (Same Line as Code)

You can place `@highlight-end` on the same line as the last line you want to highlight. In this case, that line is highlighted and the marker is simply removed:

```nohighlight
function example()
    println("Normal line")
    # @highlight-start
    x = important_calculation()
    y = another_important_step()  # @highlight-end
    println("Normal line")
end
```

In this pattern:
- Highlighting starts after `# @highlight-start` (from the `x = ...` line)
- Highlighting includes the line with `# @highlight-end` (the `y = ...` line is highlighted)
- Only the `# @highlight-end` marker is removed, the code on that line remains

**Example**:

```@example
function example()
    println("Normal line")
    # @highlight-start
    x = 10 * 2
    y = x + 5  # @highlight-end
    println("Normal line")
    return y
end
```

**Usage**:
- Use standalone `@highlight-end` when you want a clear visual separation in your source
- Use inline `@highlight-end` to include the last line in highlighting without an extra marker line
- Both patterns are useful for highlighting logical blocks like error checking or initialization

## 3. Leveled Highlights

Use different highlight levels (1-4) to visualize nested code structures with different colors:

```nohighlight
# @highlight-start[1]
function outer()
    # @highlight-start[2]
    for i in 1:10
        # @highlight-start[3]
        if i % 2 == 0
            println(i)
        end # @highlight-end
    end # @highlight-end
end # @highlight-end
```

**Line Range**: Same as Block Syntax - highlighting starts from **the line after** the marker and ends at **the line before** the closing marker. All marker comments are removed from the output.

**Colors**:
- Level 1: Yellow
- Level 2: Red
- Level 3: Green
- Level 4: Blue

**Usage**:
- `@highlight-start[1]` - Start level 1 highlight
- Nest multiple levels to show code hierarchy
- Useful for complex algorithms with multiple nesting levels

**Example**:

```@example
# @highlight-start[1]
function outer()
    # @highlight-start[2]
    for i in 1:3
        # @highlight-start[3]
        if i % 2 == 0
            println("Even: $i")
        end # @highlight-end
    end # @highlight-end
end # @highlight-end

outer()
```

## 4. Auto-Leveled Highlights

Use `@highlight-auto-start` and `@highlight-auto-end` to automatically determine highlight levels based on nesting depth:

```nohighlight
# @highlight-auto-start
function outer()
    # @highlight-auto-start
    for i in 1:10
        # @highlight-auto-start
        if i % 2 == 0
            println(i)
        # @highlight-auto-end
    # @highlight-auto-end
# @highlight-auto-end
end
```

**Line Range**: Same as Block Syntax - highlighting starts from **the line after** the marker and ends at **the line before** the closing marker. All marker comments are removed from the output.

**Automatic Level Assignment**:
- First nested level: Level 1 (Yellow)
- Second nested level: Level 2 (Red)
- Third nested level: Level 3 (Green)
- Fourth nested level: Level 4 (Blue)
- Fifth nested level and beyond: Level continues to increase (5, 6, 7...), but colors cycle through 1-4

**Usage**:
- `@highlight-auto-start` - Start automatic highlight (level determined by depth)
- `@highlight-auto-end` - End automatic highlight
- No need to manually specify level numbers
- Useful when you want automatic color coding based on nesting structure

**Example**:

```@example
# @highlight-auto-start
function outer()
    # @highlight-auto-start
    for i in 1:3
        # @highlight-auto-start
        if i % 2 == 0
            println("Even: $i")
        end # @highlight-auto-end
    end # @highlight-auto-end
end # @highlight-auto-end

outer()
```

**Deep Nesting Example** (5 levels - demonstrating color cycling):

```@example
# @highlight-auto-start
function process_data(data)
    # @highlight-auto-start
    for item in data
        # @highlight-auto-start
        if item > 0
            # @highlight-auto-start
            while item > 10
                # @highlight-auto-start
                item = item - 5
                println("Reduced: $item")
                # @highlight-auto-end
            end # @highlight-auto-end
            println("Final: $item")
        end # @highlight-auto-end
    end # @highlight-auto-end
end # @highlight-auto-end

process_data([15, 8, 22])
```

Note: Level 5 uses the same color as Level 1 (yellow), demonstrating color cycling while maintaining distinct level numbers.

### Custom Background Color

You can specify a custom background color using the `bgcolor` option:

```nohighlight
# @highlight-auto-start,bgcolor=lightpink
function calculate(x, y)
    # @highlight-auto-start,bgcolor=#ffeecc
    result = x + y
    println("Result: $result")
    # @highlight-auto-end
    return result
end # @highlight-auto-end

calculate(5, 3)
```

**Example**:

```@example
# @highlight-auto-start,bgcolor=lightpink
function calculate(x, y)
    # @highlight-auto-start,bgcolor=#ffeecc
    result = x + y
    println("Result: $result")
    # @highlight-auto-end
    return result
end # @highlight-auto-end

calculate(5, 3)
```

**Color specification**:
- Hex colors: `bgcolor=#ffcc00`, `bgcolor=#90ee90`
- Named colors: `bgcolor=lightblue`, `bgcolor=lightcoral`, `bgcolor=lightyellow`

This is useful for emphasizing specific code sections with distinctive colors.

## 5. Inline Comment Syntax

Highlight specific lines using `[!code highlight]` in comments (compatible with Shiki transformers):

```nohighlight
function example()
    x = 1
    y = 2  # [!code highlight]
    return x + y
end
```

For multiple consecutive lines:

```nohighlight
function example()
    x = 1  # [!code highlight:3]
    y = 2
    z = 3
    return x + y + z
end
```

**Usage**:
- Add `# [!code highlight]` at the end of the line to highlight
- Add `# [!code highlight:N]` to highlight N consecutive lines starting from that line
- Compatible with standard Shiki notation

**Example**:

```@example
function example()
    x = 1
    y = 2  # [!code highlight]
    z = 3
    return x + y + z
end
```

## 6. REPL Block Highlighting

Highlighting also works with `@repl` blocks that show Julia REPL prompts:

```nohighlight
# @highlight: 2-3
julia> x = [1, 2, 3, 4, 5]
julia> sum(x)
15
julia> mean(x)
3.0
```

**Example**:

```@repl
# @highlight: 2-3
x = [1, 2, 3, 4, 5]
sum(x)
mean(x)
```

All highlight syntaxes work with REPL blocks, including block markers and auto-leveling.

## When to Use Each Syntax

- **Line Range Syntax**: When you need to highlight specific, non-consecutive lines
- **Block Syntax**: For highlighting logical blocks (error checking, initialization, etc.)
- **Leveled Highlights**: For visualizing nested structures and code hierarchy with manual control
- **Auto-Leveled Highlights**: For automatic color coding based on nesting depth without manual level management
- **Inline Comment Syntax**: For quick, ad-hoc highlighting of individual lines
