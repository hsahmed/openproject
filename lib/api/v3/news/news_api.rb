#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module API
  module V3
    module News
      class NewsAPI < ::API::OpenProjectAPI
        resources :news do
          get &::API::V3::Utilities::Endpoints::Index
                 .new(model: ::News,
                      self_path: :newses)
                 .mount

          post &::API::V3::Utilities::Endpoints::Create
            .new(model: News)
            .mount

          route_param :id, type: Integer, desc: "News ID" do
            after_validation do
              @news = ::News
                      .visible
                      .find(params[:id])
            end

            get &::API::V3::Utilities::Endpoints::Show
                   .new(model: ::News)
                   .mount
            patch &::API::V3::Utilities::Endpoints::Update.new(model: ::News).mount
            delete &::API::V3::Utilities::Endpoints::Delete.new(model: ::News, success_status: 204).mount
          end
        end
      end
    end
  end
end
