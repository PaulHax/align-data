"""align-data: Version-controlled ICL examples for align-system ADMs"""

__version__ = "0.1.0"

import pkg_resources


def get_icl_data_paths():
    """Get paths to ICL data files"""
    icl_paths = {}
    data_mapping = {
        "medical": "MU-train.json",
        "affiliation": "AF-train.json",
        "merit": "MF-train.json",
        "personal_safety": "PS-train.json",
        "search": "SS-train.json",
    }

    for key, filename in data_mapping.items():
        resource_path = f"data/phase2_icl/{filename}"
        path = pkg_resources.resource_filename("align_data", resource_path)
        icl_paths[key] = path

    return icl_paths


def get_config_path(config_name):
    """Get path to a config file"""
    resource_path = f"configs/{config_name}"
    return pkg_resources.resource_filename("align_data", resource_path)
