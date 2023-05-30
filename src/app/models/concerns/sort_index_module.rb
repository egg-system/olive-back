module SortIndexModule
  extend ActiveSupport::Concern

  self.included do |klass|
    klass.extend RebuildIndexes

    validates :index, presence: true
    validates :index, numericality: { only_integer: true, greater_than: 0,  }
    validate :validate_max_index

    default_scope { order(:index, :id) }
  end

  module RebuildIndexes
    def rebuild_indexes(id, before_index, after_index)
      return if before_index === after_index

      query = self.where.not(id: id)
      if before_index.nil?
        query.where(index: after_index..)
          .update_all("#{table_name}.index = #{table_name}.index + 1")
        return
      end

      if after_index.nil?
        query.where(index: before_index..)
          .update_all("#{table_name}.index = #{table_name}.index - 1")
        return
      end

      if before_index < after_index
        query.where(index: before_index..after_index)
          .update_all("#{table_name}.index = #{table_name}.index - 1")
        return
      end

      query.where(index: after_index...before_index)
        .update_all("#{table_name}.index = #{table_name}.index + 1")
    end
  end

  def validate_max_index
    max_index = self.class.maximum(:index)
    max_index += 1 if self.new_record?
    return if self.index <= max_index
    self.errors[:index] << "は#{max_index}以内の値にしてください。"
  end
end
