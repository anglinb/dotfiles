import yaml
from os import listdir
from os.path import isfile, join, dirname

# Generates .sh files from yml files

YAML_EXTENSION = '.yml'

def load_config(filename):
  with open(filename, "r") as stream:
    try:
        return yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

def to_bash_alias(alias):
  return 'alias '+ alias['alias'] + '=' + "'" + alias['command'] + "'"

current_dir = dirname(__file__)
yaml_files = [join(current_dir, f) for f in listdir(current_dir) if isfile(join(current_dir, f)) and f.endswith(YAML_EXTENSION) ]



all_aliases = []

for yaml_file in yaml_files:
  config = load_config(yaml_file)
  generated_aliases = [to_bash_alias(alias) for alias in config['aliases']]
  generated_config = "\n".join([
    "# Generated file, don't touch!",
    "",
    *generated_aliases
  ])
  all_aliases.extend(generated_aliases)
  with open(yaml_file.replace(YAML_EXTENSION, '.sh'), "w") as f:
    f.write(generated_config)

with open(join(current_dir, "..", "dotfiles", ".aliases"), "w") as f:
  f.write("\n".join([
    "# Generated file, don't touch!",
    "",
    *all_aliases
  ]))



