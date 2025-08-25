# align-data

Version-controlled ICL (In-Context Learning) examples for align-system ADMs, packaged as a Python library.

## Installation

### As a Python Package

Install directly from GitHub using pip or poetry:

```bash
# Using pip
pip install git+https://github.com/PaulHax/align-data.git

# Using poetry
poetry add git+https://github.com/PaulHax/align-data.git
```

### Usage as Python Package

```python
from align_data import get_icl_data_paths, get_config_path

# Get all ICL data file paths
icl_paths = get_icl_data_paths()
print(icl_paths)
# {
#   'medical': '/path/to/site-packages/align_data/data/phase2_icl/MU-train.json',
#   'affiliation': '/path/to/site-packages/align_data/data/phase2_icl/AF-train.json',
#   'merit': '/path/to/site-packages/align_data/data/phase2_icl/MF-train.json',
#   'personal_safety': '/path/to/site-packages/align_data/data/phase2_icl/PS-train.json',
#   'search': '/path/to/site-packages/align_data/data/phase2_icl/SS-train.json'
# }

# Get a specific config file path
config_path = get_config_path('hydra_overrides/phase2_comparative_regression.yaml')
```

### Integration with Applications

For applications like `align-app`, simply add align-data as a dependency:

```toml
# pyproject.toml
[tool.poetry.dependencies]
align-data = {git = "https://github.com/PaulHax/align-data.git"}
```

Then use it in your code:

```python
from align_data import get_icl_data_paths

# Configure your ADM with dynamic paths
config_overrides = {
    "step_definitions": {
        "regression_icl": {
            "icl_generator_partial": {
                "incontext_settings": {
                    "datasets": get_icl_data_paths()
                }
            }
        }
    }
}
```

## Manual Download

### Latest Release

See [Releases](https://github.com/PaulHax/align-data/releases) for the latest version.

### Download Specific Version

```bash
# Download v1.0.0
wget https://github.com/PaulHax/align-data/archive/refs/tags/v1.0.0.tar.gz
tar -xzf v1.0.0.tar.gz
# Note the extracted directory path for use below
```

### Download Latest Release

```bash
# Using the provided script
./scripts/download_latest.sh

# Or manually with curl
curl -s https://api.github.com/repos/PaulHax/align-data/releases/latest \
  | grep "tarball_url" \
  | cut -d '"' -f 4 \
  | xargs wget -O align-data-latest.tar.gz
```

### Use with align-system (Manual Paths)

Use Hydra's command-line overrides to point to your local ICL data:

```bash
# Run with individual overrides (adjust path to your align-data location)
run_align_system +experiment=YOUR_EXPERIMENT \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.medical=/path/to/align-data/align_data/data/phase2_icl/MU-train.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.affiliation=/path/to/align-data/align_data/data/phase2_icl/AF-train.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.merit=/path/to/align-data/align_data/data/phase2_icl/MF-train.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.personal_safety=/path/to/align-data/align_data/data/phase2_icl/PS-train.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.search=/path/to/align-data/align_data/data/phase2_icl/SS-train.json

# Or create your own config file using the examples in align_data/configs/hydra_overrides/
# (remember to replace /path/to/align-data with your actual path)
```

See `align_data/configs/hydra_overrides/` for complete override configuration examples.

**Note:** The data files are now located in `align_data/data/` instead of the root `data/` directory.

## Package Structure

```
align-data/
├── pyproject.toml              # Python package configuration
├── README.md                   # This file
├── align_data/                 # Main Python package
│   ├── __init__.py            # Package initialization with helper functions
│   ├── data/                  # ICL training data
│   │   └── phase2_icl/
│   │       ├── AF-train.json  # Affiliation examples
│   │       ├── MF-train.json  # Merit examples
│   │       ├── MU-train.json  # Medical examples
│   │       ├── PS-train.json  # Personal safety examples
│   │       └── SS-train.json  # Search examples
│   └── configs/               # Configuration examples
│       └── hydra_overrides/
│           └── phase2_comparative_regression.yaml
└── scripts/
    └── download_latest.sh     # Legacy download script
```

## Contributing

When adding new ICL datasets:

1. Add files to appropriate directories under `align_data/data/` using descriptive names (e.g., `AF-train.json`, `MU-train.json`)
2. Update this README and any relevant config examples
3. Update the `data_mapping` in `align_data/__init__.py` if adding new categories
4. Create a pull request to main branch

### Releases

Releases are automated! When your PR is merged to main:

- A new git tag is automatically created with semantic versioning (e.g., v1.0.1)
- GitHub releases are created with downloadable archives
- Use git tags for version tracking rather than dates in filenames

Version increment hints (optional):

- Include `[major]` in commit message for breaking changes (v1.0.0 → v2.0.0)
- Include `[minor]` in commit message for new features (v1.0.0 → v1.1.0)
- Default: patch increment for fixes and updates (v1.0.0 → v1.0.1)
