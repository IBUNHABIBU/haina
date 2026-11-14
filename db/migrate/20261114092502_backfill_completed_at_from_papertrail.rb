# db/migrate/XXXX_backfill_completed_at_from_papertrail.rb
class BackfillCompletedAtFromPapertrail < ActiveRecord::Migration[7.0]
  def up
    say_with_time "Backfilling completed_at from PaperTrail versions..." do
      Activity
        .where(status: %w[completed delivered])
        .where(completed_at: nil)
        .find_each do |activity|
          # Tafuta version ya kwanza ambapo status ilibadilika kuwa completed (4) au delivered (5)
          version = activity.versions
            .where(event: "update")
            .order(created_at: :asc)
            .find do |v|
              changes = parse_changes(v.object_changes)
              status_change = changes["status"]
              status_change.is_a?(Array) && [4, 5].include?(status_change[1])
            end

          if version
            # Tumia updated_at ya version (sio created_at) kama completed_at
            # Kwa sababu updated_at ni wakati halisi mabadiliko yalifanyika
            changes = parse_changes(version.object_changes)
            updated_at_after = changes.dig("updated_at", 1)
            completed_at = updated_at_after || version.created_at

            activity.update_column(:completed_at, completed_at)
            say "  Activity ##{activity.id}: completed_at = #{completed_at}"
          else
            # Fallback: tumia updated_at ya activity
            activity.update_column(:completed_at, activity.updated_at)
            say "  Activity ##{activity.id}: completed_at = #{activity.updated_at} (fallback)"
          end
        end
    end
  end

  def down
  end

  private

  def parse_changes(yaml_string)
    return {} if yaml_string.blank?

    YAML.safe_load(
      yaml_string,
      permitted_classes: [Time, Date, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone],
      aliases: true
    ) || {}
  rescue Psych::SyntaxError, ArgumentError, Psych::DisallowedClass => e
    say "  Parse error: #{e.message}"
    {}
  end
end