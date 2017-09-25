module TableauRestApi
  module ScheduleSubscription
    aspector do
      before :subscriptions, :login
      before :query_subscription, :login
      before :create_subscription, :login
      before :delete_subscription, :login
      before :schedules, :login
    end

    def subscriptions(site_id)
      url = build_url ['sites', site_id, 'subscriptions']
      (get url).subscriptions.subscription.to_a.map { |sub| Subscription.new(sub) }
    end

    def query_subscription(site_id, sub_id)
      url = build_url ['sites', site_id, 'subscriptions', sub_id]
      Subscription.new((get url).subscription)
    end
    
    def create_subscription(site_id, subscription)
      url = build_url ['sites', site_id, 'subscriptions']
      Subscription.new((post url, subscription).subscription)
    end

    def delete_subscription(site_id, subscription_id)
      url = build_url ['sites', site_id, 'subscriptions', subscription_id]
      delete url
    end
  
    def delete_schedule(schedule_id)
      url = build_url ['schedules', schedule_id]
      delete url
    end

    def schedules
      url = build_url 'schedules'
      (get url).schedules.schedule.to_a.map { |schedule| Schedule.new(schedule) }
    end
  end
end
