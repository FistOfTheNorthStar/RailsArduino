module HomeHelper
  def create_payload(sql_result, timescale)

    payload_t = []
    payload_h = []
    if sql_result.present?
      sql_result.each do |a|
        payload_t << a[0]
        payload_h << a[1]
      end
    end
    if payload_t.length < timescale
      xl = timescale - payload_t.length 
      for i in 1..xl do
        payload_t << 0.0
        payload_h << 0.0
      end
    end
    { "data-t" => payload_t, "data-h" => payload_h }
  end
end
