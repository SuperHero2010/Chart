import os
import xml.etree.ElementTree as ET
from PIL import Image
import argparse

# Install this before run this script: pip install pillow
# Folder path should be "/", not "\"
# Example: python spritesheet.py "{input_folder}" -o "{output_folder}" -n "{name}"

# ✂️ Cut out the transparent part of the image and get the frameX, frameY information
def get_trimmed_info(img):
    bbox = img.getbbox()
    if not bbox:
        return img, 0, 0, img.width, img.height

    cropped = img.crop(bbox)
    frameX, frameY = bbox[0], bbox[1]
    trimmed_width, trimmed_height = bbox[2] - bbox[0], bbox[3] - bbox[1]
    
    return cropped, frameX, frameY, trimmed_width, trimmed_height

# 📌 Sort images by size (large first, small last)
def sort_images_by_size(images, filenames):
    sorted_pairs = sorted(zip(images, filenames), key=lambda x: x[0].width * x[0].height, reverse=True)
    return zip(*sorted_pairs)

# 📌 Create spritesheet automatically, avoid image compression errors
def create_spritesheet(input_folder, output_folder, output_name, max_sheet_width=2048):
    if not os.path.exists(input_folder):
        print("❌ Error: Input directory does not exist!")
        return

    os.makedirs(output_folder, exist_ok=True)

    # 📂 Get PNG list
    image_files = sorted([f for f in os.listdir(input_folder) if f.endswith(".png")])
    images = [Image.open(os.path.join(input_folder, f)) for f in image_files]

    if not images:
        print("❌ Error: PNG image not found in folder!")
        return

    # 🔹 Arrange images from largest to smallest
    images, image_files = sort_images_by_size(images, image_files)

    # 🏗️ Arrange images properly on spritesheet
    x_offset, y_offset = 0, 0
    row_max_height = 0
    sheet_width = min(max_sheet_width, sum(img.width for img in images))  # Width limit

    spritesheet = Image.new("RGBA", (sheet_width, sum(img.height for img in images)))
    root = ET.Element("TextureAtlas", imagePath=f"{output_name}.png")

    for img, filename in zip(images, image_files):
        trimmed_img, frameX, frameY, trimmed_width, trimmed_height = get_trimmed_info(img)

        # If image exceeds maximum width, wrap to new line
        if x_offset + trimmed_img.width > sheet_width:
            x_offset = 0
            y_offset += row_max_height
            row_max_height = 0

        # Paste images in spritesheet
        spritesheet.paste(trimmed_img, (x_offset, y_offset))

        # Update XML
        name_without_ext = os.path.splitext(filename)[0]
        ET.SubElement(root, "SubTexture",
                      name=name_without_ext,
                      x=str(x_offset), y=str(y_offset),
                      width=str(trimmed_width), height=str(trimmed_height),
                      frameX=str(-frameX), frameY=str(-frameY),
                      frameWidth=str(img.width), frameHeight=str(img.height))

        # Update location
        x_offset += trimmed_img.width
        row_max_height = max(row_max_height, trimmed_img.height)

    # Cut off excess spritesheet
    final_height = y_offset + row_max_height
    spritesheet = spritesheet.crop((0, 0, sheet_width, final_height))

    # 💾 Save spritesheet & XML
    spritesheet_path = os.path.join(output_folder, f"{output_name}.png")
    spritesheet.save(spritesheet_path)

    xml_path = os.path.join(output_folder, f"{output_name}.xml")
    tree = ET.ElementTree(root)
    with open(xml_path, "wb") as f:
        f.write(b"<?xml version='1.0' encoding='utf-8'?>\n")
        tree.write(f, encoding="utf-8")

    print(f"✅ Spritesheet & XML was saved at: {output_folder}")

# 🛠️ Run script with command line
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create optimized Spritesheet and XML")
    parser.add_argument("input_folder", type=str, help="Folder containing PNG images")
    parser.add_argument("-o", "--output", type=str, required=True, help="Output folder for Spritesheet & XML")
    parser.add_argument("-n", "--name", type=str, required=True, help="Output filename (without extension)")
    parser.add_argument("--max_width", type=int, default=2048, help="Maximum width of spritesheet (default: 2048)")

    args = parser.parse_args()
    create_spritesheet(args.input_folder, args.output, args.name, args.max_width)
