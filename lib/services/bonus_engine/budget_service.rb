module BonusEngine
  class BudgetService
    def initialize(event, user)
      @user = user
      @event = event
    end

    def available_update_budget?(quantity, id)
      (balance == 0 && point(id).quantity >= quantity) ||
        (balance > quantity) ||
        (event_maximum_points >= quantity && event_minimum_points <= quantity)
    end

    def available_budget?(quantity)
      balance >= quantity &&
        event_maximum_points >= quantity &&
        event_minimum_points <= quantity
    end

    private

    def balance
      @event.stats_for(@user)[:balance]
    end

    def point(id)
      BonusEngine::Point.find id
    end

    def event_maximum_points
      @event.maximum_points || @event.cycle.maximum_points
    end

    def event_minimum_points
      @event.minimum_points || @event.cycle.minimum_points
    end

  end
end
