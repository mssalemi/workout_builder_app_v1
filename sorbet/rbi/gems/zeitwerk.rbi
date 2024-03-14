# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/zeitwerk/all/zeitwerk.rbi
#
# zeitwerk-2.6.12

module Zeitwerk::RealModName
  def real_mod_name(mod); end
end
module Zeitwerk::Internal
  def internal(method_name); end
end
module Zeitwerk::Loader::Helpers
  def cdef?(parent, cname); end
  def cget(parent, cname); end
  def cname_for(basename, abspath); end
  def cpath(parent, cname); end
  def crem(parent, cname); end
  def dir?(path); end
  def has_at_least_one_ruby_file?(dir); end
  def hidden?(basename); end
  def log(message); end
  def ls(dir); end
  def ruby?(path); end
  def strict_autoload_path(parent, cname); end
  def walk_up(abspath); end
end
module Zeitwerk::Loader::Helpers::CNAME_VALIDATOR
end
module Zeitwerk::Loader::Callbacks
  def __on_dir_autoloaded(dir); end
  def __on_file_autoloaded(file); end
  def on_dir_autoloaded(dir); end
  def on_file_autoloaded(file); end
  def on_namespace_loaded(namespace); end
  def run_on_load_callbacks(cpath, value, abspath); end
  extend Zeitwerk::Internal
  include Zeitwerk::RealModName
end
module Zeitwerk::Loader::Config
  def __ignores?(abspath); end
  def __roots; end
  def actual_roots; end
  def collapse(*glob_patterns); end
  def collapse?(dir); end
  def collapse_dirs; end
  def collapse_glob_patterns; end
  def dirs(namespaces: nil, ignored: nil); end
  def do_not_eager_load(*paths); end
  def eager_load_exclusions; end
  def enable_reloading; end
  def excluded_from_eager_load?(abspath); end
  def expand_glob_patterns(glob_patterns); end
  def expand_paths(paths); end
  def ignore(*glob_patterns); end
  def ignored_glob_patterns; end
  def ignored_path?(abspath); end
  def ignored_paths; end
  def ignores?(abspath); end
  def inflector; end
  def inflector=(arg0); end
  def initialize; end
  def log!; end
  def logger; end
  def logger=(arg0); end
  def on_load(cpath = nil, &block); end
  def on_load_callbacks; end
  def on_setup(&block); end
  def on_setup_callbacks; end
  def on_unload(cpath = nil, &block); end
  def on_unload_callbacks; end
  def push_dir(path, namespace: nil); end
  def recompute_collapse_dirs; end
  def recompute_ignored_paths; end
  def reloading_enabled?; end
  def root_dir?(dir); end
  def roots; end
  def tag; end
  def tag=(tag); end
  extend Zeitwerk::Internal
  include Zeitwerk::RealModName
end
module Zeitwerk::Loader::EagerLoad
  def actual_eager_load_dir(dir, namespace, force: nil); end
  def eager_load(force: nil); end
  def eager_load_child_namespace(child, child_name, root_dir, root_namespace); end
  def eager_load_dir(path); end
  def eager_load_namespace(mod); end
  def load_file(path); end
end
module Zeitwerk
  def self.with_loader; end
end
class Zeitwerk::Loader
  def __autoloaded_dirs; end
  def __autoloads; end
  def __namespace_dirs; end
  def __shadowed_file?(file); end
  def __shadowed_files; end
  def __to_unload; end
  def autoload_file(parent, cname, file); end
  def autoload_path_set_by_me_for?(parent, cname); end
  def autoload_subdir(parent, cname, subdir); end
  def autoloaded_dirs; end
  def autoloads; end
  def cpath_expected_at(path); end
  def define_autoload(parent, cname, abspath); end
  def define_autoloads_for_dir(dir, parent); end
  def dirs_autoload_monitor; end
  def initialize; end
  def mutex; end
  def namespace_dirs; end
  def promote_namespace_from_implicit_to_explicit(dir:, file:, parent:, cname:); end
  def raise_if_conflicting_directory(dir); end
  def register_explicit_namespace(cpath); end
  def reload; end
  def run_on_unload_callbacks(cpath, value, abspath); end
  def self.all_dirs; end
  def self.default_logger; end
  def self.default_logger=(arg0); end
  def self.eager_load_all; end
  def self.eager_load_namespace(mod); end
  def self.for_gem(warn_on_extra_files: nil); end
  def self.for_gem_extension(namespace); end
  def setup; end
  def shadowed_file?(file); end
  def shadowed_files; end
  def to_unload; end
  def unload; end
  def unload_autoload(parent, cname); end
  def unload_cref(parent, cname); end
  def unloadable_cpath?(cpath); end
  def unloadable_cpaths; end
  def unregister; end
  extend Zeitwerk::Internal
  include Zeitwerk::Loader::Callbacks
  include Zeitwerk::Loader::Config
  include Zeitwerk::Loader::EagerLoad
  include Zeitwerk::Loader::Helpers
  include Zeitwerk::RealModName
end
class Zeitwerk::GemLoader < Zeitwerk::Loader
  def initialize(root_file, namespace:, warn_on_extra_files:); end
  def self.__new(root_file, namespace:, warn_on_extra_files:); end
  def self.new(*, **); end
  def setup; end
  def warn_on_extra_files; end
  include Zeitwerk::RealModName
end
module Zeitwerk::Registry
  def self.autoloads; end
  def self.gem_loaders_by_root_file; end
  def self.inception?(cpath); end
  def self.inceptions; end
  def self.loader_for(path); end
  def self.loader_for_gem(root_file, namespace:, warn_on_extra_files:); end
  def self.loaders; end
  def self.on_unload(loader); end
  def self.register_autoload(loader, abspath); end
  def self.register_inception(cpath, abspath, loader); end
  def self.register_loader(loader); end
  def self.unregister_autoload(abspath); end
  def self.unregister_loader(loader); end
end
module Zeitwerk::ExplicitNamespace
  def self.__register(cpath, loader); end
  def self.__registered?(cpath); end
  def self.__unregister_loader(loader); end
  def self.cpaths; end
  def self.disable_tracer_if_unneeded; end
  def self.mutex; end
  def self.register(cpath, loader); end
  def self.registered?(cpath); end
  def self.tracepoint_class_callback(event); end
  def self.tracer; end
  def self.unregister_loader(loader); end
end
class Zeitwerk::Inflector
  def camelize(basename, _abspath); end
  def inflect(inflections); end
  def overrides; end
end
class Zeitwerk::GemInflector < Zeitwerk::Inflector
  def camelize(basename, abspath); end
  def initialize(root_file); end
end
module Kernel
  def self.zeitwerk_original_require(path); end
  def zeitwerk_original_require(path); end
end
class Zeitwerk::Error < StandardError
end
class Zeitwerk::ReloadingDisabledError < Zeitwerk::Error
  def initialize; end
end
class Zeitwerk::NameError < NameError
end
class Zeitwerk::SetupRequired < Zeitwerk::Error
  def initialize; end
end
