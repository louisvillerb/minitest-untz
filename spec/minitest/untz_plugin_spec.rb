require 'spec_helper'

module Minitest
  describe UntzIO do

    100.times do
      it 'does some passing stuff' do
        true.must_equal true
      end
    end

    10.times do
      it 'does some skipping stuff' do
        skip
      end
    end

    if ENV['UNTZ_FAIL']
      10.times do
        it 'does some failing stuff' do
          false.must_equal true
        end
      end

      10.times do
        it 'does some erroring stuff' do
          raise
        end
      end
    end

  end
end
