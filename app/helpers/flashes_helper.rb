module FlashesHelper
  def user_facing_flashes
    flash.to_hash.slice("alert", "error", "notice", "success", "secondary").
      tap do |hash|
      hash["primary"] = hash.delete "notice"
      hash["warning"] = hash.delete "error"
    end.compact
  end
end
