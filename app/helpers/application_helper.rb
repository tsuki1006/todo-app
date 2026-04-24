module ApplicationHelper
  def turbo_stream_flash
    turbo_stream.update 'flash' do
      render 'layouts/flash'
    end
  end
end
