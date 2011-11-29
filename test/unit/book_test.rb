require 'test_helper'

class BookTest < ActiveSupport::TestCase

    test "googlebooks" do
        assert GoogleBooks.book_for_isbn('9780545010221')
    end

end
