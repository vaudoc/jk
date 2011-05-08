require "mephisto_immc"

Liquid::Template.register_filter MephistoImmc::LiquidFilters
Section.send :include, MephistoImmc::Section
Section.send :include, MephistoImmc::LiquidModels
SectionDrop.send :include, MephistoImmc::LiquidSectionDrop

# allow reloading for this plugin
Dependencies.load_once_paths.delete(lib_path)
