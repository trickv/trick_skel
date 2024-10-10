import os
import sys
from PIL import Image
from PIL.ExifTags import TAGS

def get_timestamp(filepath):
    img = Image.open(filepath)
    exif_data = img._getexif()
    if exif_data:
        for tag, value in exif_data.items():
            if TAGS.get(tag) == 'DateTimeOriginal':
                return value
    # Fallback to filename format
    return os.path.splitext(os.path.basename(filepath))[0].split('_')[-1]

def main(image_folder, output_file):
    i  = 0
    overlay_file = 'overlays.txt'
    with open(output_file, 'w') as f, open(overlay_file, 'w') as overlay_f:
        for filename in sorted(os.listdir(image_folder)):
            i = i + 1
            if i > 1200:
                print("ERR: max input pictures")
                sys.exit()
            if filename.endswith('.JPG'):
                filepath = os.path.join(image_folder, filename)
                timestamp = get_timestamp(filepath).replace(":", "_")
                f.write(f"file '{filepath}'\n")
                f.write(f"duration 0.033333333\n")  # 1/30 second per image
                #f.write(f"label '{timestamp}'\n")
                # Write to overlays.txt
                overlay_f.write(f"{timestamp}\n")  # Write the timestamp for each image
                #f.write(f"file_packet_metadata timestamp='{timestamp}'\n")  # Add the timestamp as metadata

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: <script> <picture path>")
        sys.exit(42)
    image_folder = sys.argv[1]
    output_file = 'timestamps.txt'
    main(image_folder, output_file)
