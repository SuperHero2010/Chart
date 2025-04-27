import os
import xml.etree.ElementTree as ET
from PIL import Image
import math
import argparse

def get_trimmed_info(img):
    bbox = img.getbbox()
    if not bbox:
        return img, 0, 0, img.width, img.height

    cropped = img.crop(bbox)
    frameX, frameY = bbox[0], bbox[1]
    trimmed_width, trimmed_height = bbox[2] - bbox[0], bbox[3] - bbox[1]
    
    return cropped, frameX, frameY, trimmed_width, trimmed_height

def sort_images_by_size(images, filenames):
    sorted_pairs = sorted(zip(images, filenames), key=lambda x: x[0].width * x[0].height, reverse=True)
    return zip(*sorted_pairs)

def create_spritesheet(input_folder, output_folder, output_name):
    if not os.path.exists(input_folder):
        print("❌ Error: Input directory does not exist!")
        return

    os.makedirs(output_folder, exist_ok=True)

    image_files = sorted([f for f in os.listdir(input_folder) if f.endswith(".png")])
    images = [Image.open(os.path.join(input_folder, f)) for f in image_files]

    if not images:
        print("❌ Error: PNG image not found in folder!")
        return

    images, image_files = sort_images_by_size(images, image_files)

    num_images = len(images)
    num_columns = math.ceil(math.sqrt(num_images))
    max_width = max(img.width for img in images)
    max_height = max(img.height for img in images)

    spritesheet_width = num_columns * max_width
    spritesheet_height = math.ceil(num_images / num_columns) * max_height

    spritesheet = Image.new("RGBA", (spritesheet_width, spritesheet_height))
    root = ET.Element("TextureAtlas", imagePath=f"{output_name}.png")

    x_offset, y_offset = 0, 0
    col_count = 0

    for img, filename in zip(images, image_files):
        trimmed_img, frameX, frameY, trimmed_width, trimmed_height = get_trimmed_info(img)

        spritesheet.paste(trimmed_img, (x_offset, y_offset))

        offsetX = (max_width - trimmed_width) // 2
        offsetY = (max_height - trimmed_height) // 2

        name_without_ext = os.path.splitext(filename)[0]
        ET.SubElement(root, "SubTexture",
                      name=name_without_ext,
                      x=str(x_offset), y=str(y_offset),
                      width=str(trimmed_width), height=str(trimmed_height),
                      frameX=str(-offsetX), frameY=str(-offsetY),
                      frameWidth=str(max_width), frameHeight=str(max_height))

        col_count += 1
        if col_count >= num_columns:
            col_count = 0
            x_offset = 0
            y_offset += max_height
        else:
            x_offset += max_width

    spritesheet_path = os.path.join(output_folder, f"{output_name}.png")
    spritesheet.save(spritesheet_path)

    xml_path = os.path.join(output_folder, f"{output_name}.xml")
    tree = ET.ElementTree(root)
    with open(xml_path, "wb") as f:
        f.write(b"<?xml version='1.0' encoding='utf-8'?>\n")
        tree.write(f, encoding="utf-8")

    print(f"✅ Spritesheet & XML was saved at: {output_folder}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create Spritesheet and XML from PNG images")
    parser.add_argument("input_folder", type=str, help="Folder containing PNG images")
    parser.add_argument("-o", "--output", type=str, required=True, help="Spritesheet and XML storage folder")
    parser.add_argument("-n", "--name", type=str, required=True, help="Output file name (without extension)")

    args = parser.parse_args()
    create_spritesheet(args.input_folder, args.output, args.name)
