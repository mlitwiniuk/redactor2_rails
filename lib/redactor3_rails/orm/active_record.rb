require 'redactor3_rails/orm/base'

module Redactor3Rails
  module Orm
    module ActiveRecord
      module AssetBase
        def self.included(base)
          base.send(:include, Base::AssetBase::InstanceMethods)
          base.send(:extend, ClassMethods)
        end

        module ClassMethods
          def self.extended(base)
            base.class_eval do
              self.table_name = 'redactor3_assets'

              belongs_to :assetable, :polymorphic => true, required: false
              belongs_to Redactor3Rails.devise_user, :foreign_key => Redactor3Rails.devise_user_key, required: false

              if defined?(ActiveModel::ForbiddenAttributesProtection) && base.ancestors.include?(ActiveModel::ForbiddenAttributesProtection)
                # Ok
              elsif defined?(ActiveModel::MassAssignmentSecurity) && base.ancestors.include?(ActiveModel::MassAssignmentSecurity)
                attr_accessible :data, :assetable_type, :assetable_id, :assetable
              end
            end
          end
        end
      end
    end
  end
end
