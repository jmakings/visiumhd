#!/bin/bash

# -----------------------------
# 1️⃣ Remove old visiumhd environments
# -----------------------------
echo "Removing old visiumhd environments..."
conda env remove -n visiumhd --yes
conda env remove -n visiumhd2 --yes

# -----------------------------
# 2️⃣ Remove old Jupyter kernels
# -----------------------------
KERNEL_DIR="$HOME/.local/share/jupyter/kernels"
if [ -d "$KERNEL_DIR" ]; then
    echo "Removing old visiumhd kernels..."
    rm -rf $KERNEL_DIR/visiumhd*
fi

# -----------------------------
# 3️⃣ Create new visiumhd environment
# -----------------------------
echo "Creating new visiumhd environment..."
conda create -n visiumhd python=3.10 -c conda-forge -y
conda activate visiumhd

# -----------------------------
# 4️⃣ Install packages via conda
# -----------------------------
echo "Installing packages via conda..."
conda install -c conda-forge \
    numpy pandas scanpy geosketch matplotlib geopandas shapely pillow pyhere pydeseq2 -y

# -----------------------------
# 5️⃣ Install SpatialData packages via pip
# -----------------------------
echo "Installing spatialdata packages via pip..."
pip install "spatialdata[all]"

# -----------------------------
# 6️⃣ Register the environment as Jupyter kernel
# -----------------------------
echo "Registering Jupyter kernel..."
python -m ipykernel install --user --name visiumhd --display-name "Python (visiumhd)"

# -----------------------------
# 7️⃣ Done
# -----------------------------
echo "✅ visiumhd environment created and Jupyter kernel registered!"
echo "Activate it with: conda activate visiumhd"
echo "Launch Jupyter Lab/Notebook and select 'Python (visiumhd)' as the kernel."