#!/bin/bash
set -e  # Exit on error

echo "Setting up environment for BERT classifier project..."

# Define Miniconda installation path
MINICONDA_DIR="$HOME/miniconda"

# Check if Conda exists
if ! command -v conda &> /dev/null; then
    echo "Conda not found. Installing Miniconda..."
    
    # Download and install Miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -p $MINICONDA_DIR
    rm miniconda.sh
    
    # Add Conda to PATH for current script execution
    export PATH="$MINICONDA_DIR/bin:$PATH"
    echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc
    
    # Initialize Conda in ~/.bashrc
    $MINICONDA_DIR/bin/conda init bash
    
    # Initialize conda in the current shell without sourcing bashrc
    eval "$($MINICONDA_DIR/bin/conda shell.bash hook)"
else
    # Conda exists, ensure it's in the PATH for this script
    export PATH="$MINICONDA_DIR/bin:$PATH"
    eval "$(conda shell.bash hook)"
fi

# Environment name
ENV_NAME="bert_hw"

# Create the conda environment if it doesn't exist
if ! conda env list | grep -q "$ENV_NAME"; then
    echo "Creating Conda environment '$ENV_NAME' with Python 3.10..."
    conda create -y -n $ENV_NAME python=3.10
fi

echo "Activating Conda environment..."
# Activate the environment for the current script
conda activate $ENV_NAME

# Install latest PyTorch with CUDA support
echo "Installing latest PyTorch with CUDA support..."
pip install --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install latest required packages for the BERT classifier
echo "Installing latest dependencies for BERT classifier..."
pip install --upgrade transformers scikit-learn tqdm numpy safetensors filelock requests tokenizers

# Create project structure
echo "Setting up project structure..."
mkdir -p data

# Check if data files exist, if not, create placeholder notification
if [ ! -f "data/cfimdb-train.txt" ]; then
    echo "Note: Data files not found in ./data directory."
    echo "Please place your cfimdb-train.txt, cfimdb-dev.txt, and cfimdb-test.txt files in the ./data directory."
fi

# Verify installation
echo "Verifying installation..."
python -c "import torch; print('PyTorch version:', torch.__version__); print('CUDA available:', torch.cuda.is_available()); print('CUDA device count:', torch.cuda.device_count()); print('CUDA version:', torch.version.cuda if torch.cuda.is_available() else 'N/A')"
python -c "import transformers; print('Transformers version:', transformers.__version__)"

echo "Setup complete! Your environment is ready for the BERT classifier project."
echo ""
echo "IMPORTANT: For the changes to take effect in your current terminal, please run:"
echo "source ~/.bashrc"
echo "conda activate bert_hw"
echo ""
echo "Next time you log in, you can just run: conda activate bert_hw"