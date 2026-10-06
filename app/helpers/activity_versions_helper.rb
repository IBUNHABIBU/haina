module ActivityVersionsHelper
  def version_user(version)
    return "System" if version.whodunnit.blank?

    user = User.find_by(id: version.whodunnit)

    return "User ##{version.whodunnit}" unless user

    name = [user.first_name, user.last_name].compact.join(" ").strip

    name.present? ? name : user.email
  end

  def version_changes(version)
    return {} if version.object_changes.blank?

    YAML.safe_load(
      version.object_changes,
      permitted_classes: [
        Time,
        ActiveSupport::TimeWithZone,
        ActiveSupport::TimeZone,
        BigDecimal,
        Symbol
      ],
      aliases: true
    ) || {}
  rescue Psych::Exception
    {}
  end

  def version_field_name(attribute)
    {
      "customer_id" => "Customer",
      "tv_brand_id" => "TV Brand",
      "tv_size_id" => "TV Size",
      "tatizo_id" => "Problem",
      "price" => "Price",
      "labour_charge" => "Labour Charge",
      "gross_profit" => "Gross Profit",
      "status" => "Status",
      "date_in" => "Date In",
      "date_out" => "Date Out",
      "model_no" => "Model Number",
      "remarks" => "Remarks",
      "returned_count" => "Returned Count"
    }.fetch(attribute.to_s) do
      attribute.to_s.humanize
    end
  end

  def version_value(attribute, value)
    return "Empty" if value.blank?

    case attribute.to_s
    when "customer_id"
      Customer.find_by(id: value)&.name || "Customer ##{value}"

    when "tv_brand_id"
      TvBrand.find_by(id: value)&.name || "TV Brand ##{value}"

    when "tv_size_id"
      size = TvSize.find_by(id: value)
      size ? "#{size.size.to_f.to_s.sub(/\.0$/, '')}\"" : "TV Size ##{value}"

    when "tatizo_id"
      Tatizo.find_by(id: value)&.name || "Problem ##{value}"

    when "price", "labour_charge", "gross_profit"
      number_to_currency(
        value,
        unit: "TSh ",
        precision: 0
      )

    when "status"
      Activity.statuses.key(value.to_i)&.humanize || value

    when "date_in", "date_out"
      begin
        value.in_time_zone("Africa/Dar_es_Salaam")
             .strftime("%d %b %Y, %H:%M")
      rescue NoMethodError, ArgumentError, TypeError
        value
      end

    else
      value
    end
  end
end