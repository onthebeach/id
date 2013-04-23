require 'spec_helper'

module Id
  module Model
    module TypeCasts

      describe Cast do
        it 'requires a type' do
          expect { Cast.new(1).type }.to raise_error NotImplementedError
        end

        it 'requires a conversion' do
          expect { Cast.new(1).conversion }.to raise_error NotImplementedError
        end

      end

      describe Date do
        it 'casts strings to dates' do
          Date.new("06-06-1983").cast.should eq ::Date.new(1983, 6, 6)
        end
      end

      describe Time do
        it 'casts strings to Times' do
          Time.new("06-06-1983").cast.should eq ::Time.parse("06-06-1983")
        end

        it 'does nothing if the value is already of the correct type' do
          time = ::Time.now
          Time.new(time).cast.should eq time
        end
      end

      describe Money do
        it 'ints or strings to Money' do
          Money.new("500").cast.should eq ::Money.new(5_00)
          Money.new(500).cast.should eq ::Money.new(5_00)
        end
      end

    end
  end
end
