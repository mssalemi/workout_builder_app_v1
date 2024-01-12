# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ActiveStorage::AnalyzeJob`.
# Please instead update this file by running `bin/tapioca dsl ActiveStorage::AnalyzeJob`.

class ActiveStorage::AnalyzeJob
  class << self
    sig do
      params(
        blob: T.untyped,
        block: T.nilable(T.proc.params(job: ActiveStorage::AnalyzeJob).void)
      ).returns(T.any(ActiveStorage::AnalyzeJob, FalseClass))
    end
    def perform_later(blob, &block); end

    sig { params(blob: T.untyped).returns(T.untyped) }
    def perform_now(blob); end
  end
end
