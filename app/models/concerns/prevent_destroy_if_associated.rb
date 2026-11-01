# app/models/concerns/prevent_destroy_if_associated.rb
module PreventDestroyIfAssociated
  extend ActiveSupport::Concern

  class_methods do
    # Tumia hii kwenye model yoyote:
    #
    #   prevent_destroy_if_associated :activities
    #
    # au kwa models nyingi:
    #
    #   prevent_destroy_if_associated :activities, :spare_requests
    #
    def prevent_destroy_if_associated(*associations, message: nil)
      before_destroy prepend: true do
        errors_found = []

        associations.each do |association|
          records = send(association)
          count = records.respond_to?(:count) ? records.count : 0

          if count.positive?
            label = association.to_s.humanize.downcase
            errors_found << "#{count} #{label}"
          end
        end

        if errors_found.any?
          custom = message || "Cannot delete this #{model_name.human.downcase} because it has #{errors_found.to_sentence} linked."
          errors.add(:base, custom)
          throw :abort
        end
      end
    end
  end
end