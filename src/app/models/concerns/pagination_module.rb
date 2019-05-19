module PaginationModule
  extend ActiveSupport::Concern

  included do
    scope :paginate, -> (page) {
      # includeされたクラスの定数により、1ページの件数を分岐する
      page_count = 10
      if self.class.const_defined?('PAGE_COUNT')
        page_count = self.class::PAGE_COUNT
      end

      page(page).per(page_count)
    }
  end
end