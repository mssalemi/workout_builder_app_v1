class Exercise < ApplicationRecord
    self.inheritance_column = 'sti_type' 

    belongs_to :user, optional: true
    validates :body_part_main, presence: true
    validates :category, inclusion: { in: %w[upper lower full] }

    def add_accessory_body_part(body_part)
        self.body_part_accessory ||= { body_parts: [] }  # Initializes if nil
        self.body_part_accessory['body_parts'] << body_part unless self.body_part_accessory['body_parts'].include?(body_part)
    end
end
