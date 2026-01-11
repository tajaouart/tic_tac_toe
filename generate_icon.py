#!/usr/bin/env python3
"""Generate beautiful tic-tac-toe app icons with perfect anti-aliasing."""

from PIL import Image, ImageDraw
import math

def create_gradient(size, color1, color2):
    """Create a smooth diagonal gradient."""
    img = Image.new('RGBA', (size, size))
    for y in range(size):
        for x in range(size):
            ratio = (x + y) / (2 * size)
            r = int(color1[0] * (1 - ratio) + color2[0] * ratio)
            g = int(color1[1] * (1 - ratio) + color2[1] * ratio)
            b = int(color1[2] * (1 - ratio) + color2[2] * ratio)
            img.putpixel((x, y), (r, g, b, 255))
    return img

def create_modern_icon(target_size=1024):
    """Create modern OX icon with perfect anti-aliasing."""
    # Render at 4x size for smooth anti-aliasing
    scale = 4
    size = target_size * scale

    gradient_start = (67, 56, 202)
    gradient_end = (192, 38, 211)
    white = (255, 255, 255, 255)

    # Create gradient background
    img = create_gradient(size, gradient_start, gradient_end)

    # Create a mask for the O (ring shape)
    o_mask = Image.new('L', (size, size), 0)
    o_draw = ImageDraw.Draw(o_mask)

    thickness = size // 11
    o_cx = int(size * 0.38)
    o_cy = int(size * 0.45)
    o_outer = size // 4
    o_inner = o_outer - thickness

    # Draw outer circle (white = include)
    o_draw.ellipse([o_cx - o_outer, o_cy - o_outer,
                    o_cx + o_outer, o_cy + o_outer], fill=255)
    # Cut out inner circle (black = exclude)
    o_draw.ellipse([o_cx - o_inner, o_cy - o_inner,
                    o_cx + o_inner, o_cy + o_inner], fill=0)

    # Create white layer and composite using mask
    white_layer = Image.new('RGBA', (size, size), white)
    img = Image.composite(white_layer, img, o_mask)

    # Now draw X on top
    draw = ImageDraw.Draw(img)
    x_cx = int(size * 0.62)
    x_cy = int(size * 0.55)
    x_half = size // 4
    cap = thickness // 2

    # X lines
    draw.line([(x_cx - x_half, x_cy - x_half), (x_cx + x_half, x_cy + x_half)],
              fill=white, width=thickness)
    draw.line([(x_cx + x_half, x_cy - x_half), (x_cx - x_half, x_cy + x_half)],
              fill=white, width=thickness)

    # Rounded caps
    for ex, ey in [(x_cx - x_half, x_cy - x_half), (x_cx + x_half, x_cy + x_half),
                   (x_cx + x_half, x_cy - x_half), (x_cx - x_half, x_cy + x_half)]:
        draw.ellipse([ex - cap, ey - cap, ex + cap, ey + cap], fill=white)

    # Downscale with high-quality resampling
    img = img.resize((target_size, target_size), Image.LANCZOS)
    return img

def create_clean_icon(target_size=1024):
    """Clean O X side by side."""
    scale = 4
    size = target_size * scale

    gradient_start = (79, 70, 229)
    gradient_end = (147, 51, 234)
    white = (255, 255, 255, 255)

    img = create_gradient(size, gradient_start, gradient_end)

    thickness = size // 11

    # O on left
    o_mask = Image.new('L', (size, size), 0)
    o_draw = ImageDraw.Draw(o_mask)

    o_cx = size // 3
    o_cy = size // 2
    o_outer = size // 4
    o_inner = o_outer - thickness

    o_draw.ellipse([o_cx - o_outer, o_cy - o_outer,
                    o_cx + o_outer, o_cy + o_outer], fill=255)
    o_draw.ellipse([o_cx - o_inner, o_cy - o_inner,
                    o_cx + o_inner, o_cy + o_inner], fill=0)

    white_layer = Image.new('RGBA', (size, size), white)
    img = Image.composite(white_layer, img, o_mask)

    # X on right
    draw = ImageDraw.Draw(img)
    x_cx = size * 2 // 3
    x_cy = size // 2
    x_half = size // 4
    cap = thickness // 2

    draw.line([(x_cx - x_half, x_cy - x_half), (x_cx + x_half, x_cy + x_half)],
              fill=white, width=thickness)
    draw.line([(x_cx + x_half, x_cy - x_half), (x_cx - x_half, x_cy + x_half)],
              fill=white, width=thickness)

    for ex, ey in [(x_cx - x_half, x_cy - x_half), (x_cx + x_half, x_cy + x_half),
                   (x_cx + x_half, x_cy - x_half), (x_cx - x_half, x_cy + x_half)]:
        draw.ellipse([ex - cap, ey - cap, ex + cap, ey + cap], fill=white)

    img = img.resize((target_size, target_size), Image.LANCZOS)
    return img

def create_grid_icon(target_size=1024):
    """Tic-tac-toe board with pieces."""
    scale = 4
    size = target_size * scale

    gradient_start = (79, 70, 229)
    gradient_end = (168, 85, 247)
    white = (255, 255, 255, 255)
    grid_color = (255, 255, 255, 100)

    img = create_gradient(size, gradient_start, gradient_end)
    draw = ImageDraw.Draw(img)

    # Grid
    padding = size // 6
    cell = (size - 2 * padding) // 3
    line_w = size // 50

    for i in range(1, 3):
        x = padding + i * cell
        draw.line([(x, padding + cell//3), (x, size - padding - cell//3)],
                  fill=grid_color, width=line_w)
        y = padding + i * cell
        draw.line([(padding + cell//3, y), (size - padding - cell//3, y)],
                  fill=grid_color, width=line_w)

    margin = cell // 4
    sym_size = cell - 2 * margin
    thickness = size // 18
    cap = thickness // 2

    def cell_center(row, col):
        return padding + col * cell + cell // 2, padding + row * cell + cell // 2

    # X at (0,0) and (2,2)
    for row, col in [(0, 0), (2, 2)]:
        cx, cy = cell_center(row, col)
        half = sym_size // 2
        draw.line([(cx - half, cy - half), (cx + half, cy + half)], fill=white, width=thickness)
        draw.line([(cx + half, cy - half), (cx - half, cy + half)], fill=white, width=thickness)
        for ex, ey in [(cx - half, cy - half), (cx + half, cy + half),
                       (cx + half, cy - half), (cx - half, cy + half)]:
            draw.ellipse([ex - cap, ey - cap, ex + cap, ey + cap], fill=white)

    # O at (1,1) and (0,2)
    o_outer = sym_size // 2
    o_inner = o_outer - thickness

    for row, col in [(1, 1), (0, 2)]:
        cx, cy = cell_center(row, col)
        o_mask = Image.new('L', (size, size), 0)
        o_draw = ImageDraw.Draw(o_mask)
        o_draw.ellipse([cx - o_outer, cy - o_outer, cx + o_outer, cy + o_outer], fill=255)
        o_draw.ellipse([cx - o_inner, cy - o_inner, cx + o_inner, cy + o_inner], fill=0)
        white_layer = Image.new('RGBA', (size, size), white)
        img = Image.composite(white_layer, img, o_mask)

    img = img.resize((target_size, target_size), Image.LANCZOS)
    return img

def create_minimal_icon(target_size=1024):
    """X through O centered."""
    scale = 4
    size = target_size * scale

    gradient_start = (99, 102, 241)
    gradient_end = (168, 85, 247)
    white = (255, 255, 255, 255)

    img = create_gradient(size, gradient_start, gradient_end)

    center = size // 2
    thickness = size // 10
    cap = thickness // 2

    # O
    o_outer = size // 3
    o_inner = o_outer - thickness

    o_mask = Image.new('L', (size, size), 0)
    o_draw = ImageDraw.Draw(o_mask)
    o_draw.ellipse([center - o_outer, center - o_outer,
                    center + o_outer, center + o_outer], fill=255)
    o_draw.ellipse([center - o_inner, center - o_inner,
                    center + o_inner, center + o_inner], fill=0)

    white_layer = Image.new('RGBA', (size, size), white)
    img = Image.composite(white_layer, img, o_mask)

    # X
    draw = ImageDraw.Draw(img)
    x_half = int(size * 0.35)

    draw.line([(center - x_half, center - x_half), (center + x_half, center + x_half)],
              fill=white, width=thickness)
    draw.line([(center + x_half, center - x_half), (center - x_half, center + x_half)],
              fill=white, width=thickness)

    for ex, ey in [(center - x_half, center - x_half), (center + x_half, center + x_half),
                   (center + x_half, center - x_half), (center - x_half, center + x_half)]:
        draw.ellipse([ex - cap, ey - cap, ex + cap, ey + cap], fill=white)

    img = img.resize((target_size, target_size), Image.LANCZOS)
    return img

if __name__ == '__main__':
    import os

    output_dir = '/Users/mounirtajaouart/Developer/tic_tac_toe/assets/images'
    os.makedirs(output_dir, exist_ok=True)

    print("Generating smooth icons (4x supersampling)...")

    # Modern (default)
    icon = create_modern_icon(1024)
    icon.save(f'{output_dir}/app_icon.png', 'PNG')
    icon.save(f'{output_dir}/icon_modern.png', 'PNG')
    print("  - app_icon.png / icon_modern.png (O + X)")

    # Clean
    icon = create_clean_icon(1024)
    icon.save(f'{output_dir}/icon_clean.png', 'PNG')
    print("  - icon_clean.png (O X side by side)")

    # Grid
    icon = create_grid_icon(1024)
    icon.save(f'{output_dir}/icon_grid.png', 'PNG')
    print("  - icon_grid.png (game board)")

    # Minimal
    icon = create_minimal_icon(1024)
    icon.save(f'{output_dir}/icon_minimal.png', 'PNG')
    print("  - icon_minimal.png (X through O)")

    # Splash
    splash = create_modern_icon(1536)
    splash.save(f'{output_dir}/logo_square.png', 'PNG')
    print("  - logo_square.png (splash screen)")

    print("\nDone! Icons ready.")
