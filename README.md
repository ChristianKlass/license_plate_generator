# License Plate SVG Generator

A simple and powerful command-line tool to generate SVG images of Singapore-style vehicle license plates. This tool is built to be run either natively on a Linux system or within a self-contained Docker container.



---

## ## Features

* **Two Plate Styles**: Supports both **double-line** (car) and **single-line** (motorcycle) plate formats.
* **High-Quality Output**: Generates clean, scalable **SVG** vector files, perfect for high-resolution use.
* **Containerized**: Includes a `Dockerfile` for a dependency-free workflow, ensuring it runs consistently everywhere.

---

## ## Setup & Usage

There are two methods to use this tool: via Docker (recommended for simplicity) or natively.

### ### Docker Method (Recommended)

This is the easiest way to run the generator, as it automatically handles all dependencies.

#### #### 1. Prerequisites

Ensure you have the following files in your project directory:
* `plategen.sh` (the script)
* `CharlesWright-Bold.otf` (the font file)
* `Dockerfile` (provided in the appendix below)

#### #### 2. Build the Docker Image

From your terminal, run the build command once:
```bash
docker build -t plate-generator .
```

#### #### 3. Run the Generator

Execute the script inside the container. The `-v "$(pwd)":/app` command maps your current directory to the container's working directory, so the output SVG is saved directly to your project folder.

**To generate a double-line (car) plate:**
```bash
docker run --rm -v "$(pwd)":/app plate-generator double SFX6275M
```
> This will create a file named `SFX6275M_double.svg`.

**To generate a single-line (motorcycle) plate:**
```bash
docker run --rm -v "$(pwd)":/app plate-generator single FAS1234C
```
> This will create a file named `FAS1234C_single.svg`.

---

### ### Native Method (Manual)

If you prefer to run the script directly on your machine without Docker.

#### #### 1. Install Dependencies

The script requires **ImageMagick** and **Potrace**. On Debian/Ubuntu, you can install them with:
```bash
sudo apt-get update && sudo apt-get install imagemagick potrace
```

#### #### 2. Get Required Files

Ensure you have the script and the font file in your project directory:
* `plategen.sh`
* `CharlesWright-Bold.otf`

#### #### 3. Make the Script Executable
Run this command once to give the script permission to execute:
```bash
chmod +x plategen.sh
```

#### #### 4. Run the Generator

You can now run the script directly.

**To generate a double-line (car) plate:**
```bash
./plategen.sh double SFX6275M
```

**To generate a single-line (motorcycle) plate:**
```bash
./plategen.sh single FAS1234C
```
