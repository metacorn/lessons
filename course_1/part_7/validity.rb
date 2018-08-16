module Validity
  def valid?
    $validator.check_out!(self)
  rescue
    false
  end
end
