import os
import xml.etree.ElementTree as ET
from PIL import Image
import math
import argparse

# Install this before run this script: pip install pillow
# Folder path should be "/", not "\"
# Example: python spritesheet.py "{input_folder}" -o "{output_folder}" -n "{name}"
def get_trimmed_info(img, max_width, max_height):
    """Cut out the transparent part and calculate frameX, frameY"""
    bbox = img.getbbox()
    if not bbox:
        return img, 0, 0, img.width, img.height

    cropped = img.crop(bbox)
    frameX = bbox[0] - (max_width - img.width) // 2
    frameY = bbox[1] - (max_height - img.height) // 2
    return cropped, frameX, frameY, bbox[2] - bbox[0], bbox[3] - bbox[1]

def create_spritesheet(input_folder, output_folder, output_name):
    # Check input folder
    if not os.path.exists(input_folder):
        print("❌ Error: Input directory does not exist!")
        return

    os.makedirs(output_folder, exist_ok=True)

    # 📂 Get PNG list, sorted by file name
    image_files = sorted([f for f in os.listdir(input_folder) if f.endswith(".png")])
    images = [Image.open(os.path.join(input_folder, f)) for f in image_files]

    if not images:
        print("❌ Error: PNG image not found in folder!")
        return

    # ⚡ Determine the largest size
    max_width = max(img.width for img in images)
    max_height = max(img.height for img in images)

    # ⚡ Calculate number of columns & rows for Spritesheet (square)
    num_images = len(images)
    grid_size = math.ceil(math.sqrt(num_images))
    spritesheet_width = max_width * grid_size
    spritesheet_height = max_height * grid_size

    # 🏗️ Create Spritesheet image
    spritesheet = Image.new("RGBA", (spritesheet_width, spritesheet_height))
    root = ET.Element("TextureAtlas", imagePath=f"{output_name}.png")

    for index, (img, filename) in enumerate(zip(images, image_files)):
        row = index // grid_size
        col = index % grid_size
        x = col * max_width
        y = row * max_height

        # 🔹 Cut the blank
        trimmed_img, frameX, frameY, trimmed_width, trimmed_height = get_trimmed_info(img, max_width, max_height)

        # 🖼 Paste the image in spritesheet
        spritesheet.paste(trimmed_img, (x, y))

        # 🔹 Get file name without .png extension
        name_without_ext = os.path.splitext(filename)[0]

        # 📝 Add information in XML
        ET.SubElement(root, "SubTexture",
                      name=name_without_ext,
                      x=str(x), y=str(y),
                      width=str(trimmed_width), height=str(trimmed_height),
                      frameX=str(frameX), frameY=str(frameY),
                      frameWidth=str(max_width), frameHeight=str(max_height))

    # 💾 Save Spritesheet
    spritesheet_path = os.path.join(output_folder, f"{output_name}.png")
    spritesheet.save(spritesheet_path)

    # 💾 Save XML with correctly header
    xml_path = os.path.join(output_folder, f"{output_name}.xml")
    tree = ET.ElementTree(root)
    with open(xml_path, "wb") as f:
        f.write(b"<?xml version='1.0' encoding='utf-8'?>\n")
        tree.write(f, encoding="utf-8")

    print(f"✅ Spritesheet & XML was saved at: {output_folder}")

# 🛠️ Add command line support
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create Spritesheet and XML from PNG images")
    parser.add_argument("input_folder", type=str, help="Folder containing PNG images")
    parser.add_argument("-o", "--output", type=str, required=True, help="Spritesheet and XML storage folder")
    parser.add_argument("-n", "--name", type=str, required=True, help="Output file name (without extension)")

    args = parser.parse_args()
    create_spritesheet(args.input_folder, args.output, args.name)
