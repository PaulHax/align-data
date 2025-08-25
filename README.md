# align-data

Version-controlled ICL (In-Context Learning) examples for align-system ADMs.

## Latest Release

See [Releases](https://github.com/PaulHax/align-data/releases) for the latest version.

## Usage

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

### Use with align-system

Use Hydra's command-line overrides to point to your local ICL data:

```bash
# Run with individual overrides (adjust path to your align-data location)
run_align_system +experiment=YOUR_EXPERIMENT \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.medical=/path/to/align-data/data/phase2_icl/July2025-MU-train_20250715.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.affiliation=/path/to/align-data/data/phase2_icl/July2025-AF-train_20250715.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.merit=/path/to/align-data/data/phase2_icl/July2025-MF-train_20250715.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.personal_safety=/path/to/align-data/data/phase2_icl/July2025-PS-train_20250715.json \
  adm.step_definitions.regression_icl.icl_generator_partial.incontext_settings.datasets.search=/path/to/align-data/data/phase2_icl/July2025-SS-train_20250715.json

# Or create your own config file using the examples in configs/hydra_overrides/
# (remember to replace /path/to/align-data with your actual path)
```

See `configs/hydra_overrides/` for complete override configuration examples.

## Integration with Downstream Applications

For applications like `align-app`, you can:

1. Clone this repository as a submodule or download a release
2. Use the Hydra override patterns shown in `configs/hydra_overrides/` (remember to adjust the paths)
3. Create your own config files with the appropriate paths to your local align-data directory

## Contributing

When adding new ICL datasets:

1. Add files to appropriate directories under `data/`
2. Update this README
3. Create a new release with semantic versioning
