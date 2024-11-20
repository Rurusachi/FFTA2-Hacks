import subprocess
import pathlib
import json
import shutil
from intro_skip import patch_intro


def run_print(args, file):
    result = subprocess.run(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    if result.stdout != "":
        print(result.stdout)
    else:
        print(f"Success: {file}")
    result.check_returncode()

# Configure External paths
devkit_path = pathlib.Path("H:/Diverse/DevkitPro/DevkitPro/devkitARM/bin")



# Project folder and main event file. TODO: Pass as arguments
source_path = pathlib.Path("archipelago")
main_file = source_path / "main.json"
build_path = source_path / "build"

with open(main_file, "r") as f:
    event = json.load(f)

# Assemble code
# arm-none-eabi-as -g -mcpu=arm7tdmi -mthumb-interwork hook.s -o hook.elf
# arm-none-eabi-ld -Ttext=0x020966F8 -g hook.elf -o hook_linked.elf
# arm-none-eabi-objcopy -S hook_linked.elf -O binary hook_linked.dmp
injection_list = []
for e in event:
    file = source_path / e["name"]
    new_path = build_path / file.with_suffix(".elf").name
    args = [devkit_path / "arm-none-eabi-as", "-g", "-mcpu=arm7tdmi", "-mthumb-interwork", file, "-o", new_path]
    run_print(args, file)

    if e["link_address"] != "":
        elf_path = new_path
        new_path = new_path.with_stem(f"{new_path.stem}_linked")
        args = [devkit_path / "arm-none-eabi-ld", f"-Ttext={hex(int(e['link_address'], 16))}", "-g", elf_path, "-o", new_path]
        run_print(args, elf_path)

    elf_path = new_path
    new_path = build_path / file.with_suffix(".dmp").name
    args = [devkit_path / "arm-none-eabi-objcopy", "-S", elf_path, "-O", "binary", new_path]
    run_print(args, elf_path)

    injection_list.append((new_path, e["rom_address"]))

# Copy rom
rom = pathlib.Path("rom/FFTA2 resized.nds")
patched_rom = build_path / rom.with_stem("FFTA2 patched").name
shutil.copy(rom, patched_rom)

# Patch rom
with open(patched_rom, "r+b") as rom_file:
    for file, address in injection_list:
        with open(file, "rb") as dmp_file:
            dmp = dmp_file.read()
        rom_file.seek(int(address, 16))
        rom_file.write(dmp)

# Intro skip
patch_intro(patched_rom)
