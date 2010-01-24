# TabsForRails
module TabsHelper

  def self.included(base) # base is the class that included the module
    base.extend(ClassMethods)
  end

  #
  # Example:
  #
  #   # Controller
  #   class DashboardController < ApplicationController
  #     current_tab :mydashboard
  #   end
  #
  #   # View
  #   <% tabs do |tab| %>
  #     <%= tab.account 'Account', account_path, :style => 'float: right' %>
  #     <%= tab.users 'Users', users_path, :style => 'float: right' %>
  #     <%= tab.mydashboard 'Dashboard', '/' %>
  #     <%= tab.projects 'Projects', projects_path %>
  #   <% end %>
  #   The HTML Result will be:
  #   <ul id="tabs">
  #     <li><a href="/accounts">Account</a></li>
  #     <li><a href="/users">Users</a></li>
  #     <li><a href="/" class="current">Dashboard</a></li>
  #     <li><a href="/projects">Projects</a></li>
  #   </ul>

  module ClassMethods
    def current_tab(name, options = {})
      before_filter(options) do |controller|
        controller.instance_variable_set('@current_tab', name)
      end
    end
  end

  module Helpers    
    module ViewHelpers
      class Tab

        def initialize(context)
          @context = context
        end

        def current_tab
          @context.instance_variable_get('@current_tab')
        end

        def current_tab?(tab)
          current_tab.to_s == tab.to_s
        end
        
        def create_tab(tab, content)
          css_class = "class='current'" if tab.to_s == current_tab.to_s
          "<li #{css_class}>#{content}</li>".html_safe!
        end
        
        def method_missing(tab, *args, &block)
          if block_given?
            options      = args.first || {}
            html_options = args.second || {}
            link_content = @context.capture(&block)
            link         = @context.link_to (link_content, options, html_options)
            
            @context.concat create_tab(tab, link)  
          else
            name         = args.first
            options      = args.second || {}
            html_options = args.third || {}
            link         = @context.link_to (name, options, html_options)
            
            create_tab(tab, link)
          end
        end

      end

      def tabs(options={}, &block)
        raise ArgumentError, "Missing block" unless block_given?
        concat("<ul class='#{options[:class]}'>".html_safe!)
        yield(Tab.new(self))
        concat('</ul>'.html_safe!)
      end

    end
  end
end
