require 'test_helper'

class MatchListingsTest < ActionDispatch::IntegrationTest
    fixtures :users, :listings, :books, :numbers

    def teardown
        Delayed::Worker.new.work_off
    end

    test "match_buy_listing" do
        buy_listing = listings(:ryan_buy_harry_potter)
        buy_listing.match
    end

    test "match_sell_listing" do
        sell_listing = listings(:george_sell_harry_potter)
        sell_listing.match
    end

end
