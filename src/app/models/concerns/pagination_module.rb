module PaginationModule
  extend ActiveSupport::Concern

  included do
    scope :paginate, ->(page = 1, page_count = 10) {
      # includeされたクラスの定数により、1ページの件数を分岐する
      page_count = self.class::PAGE_COUNT if self.class.const_defined?('PAGE_COUNT')

      page(page).per(page_count)
    }
  end
end
