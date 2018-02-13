module Salesnavot
  class ScrapMethods
    # -> Click when Available
    # -> Click First when Available
    # -> Click Last when Available
    # -> Click Nth when Available
    # -> Fill when Available

    def click_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      if @session.all(item_selector).count == 1
        puts "--- Clicking on element"
        @session.find(item_selector).click
      else
        puts "/!\\ Ambiguous selector, more than one result"
      end
    end

    def click_first_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      puts "--- Clicking on element"
      @session.all(item_selector).first.click
    end

    def click_last_when_available(item_selector)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      puts "--- Clicking on element"
      @session.all(item_selector).last.click
    end

    def fill_when_available(item_selector, item_value)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      if @session.all(item_selector).count == 1
        # puts "--- Sleeping an extra 1s"
        # sleep(1)
        puts "--- Filling element"
        @session.find(item_selector).set item_value
      else
        puts "/!\\ Ambiguous selector, more than one result"
      end
    end

    def click_nth_when_available(item_selector, n)
      while(@session.all(item_selector).count == 0)
        puts "--- Waiting for element, sleep 1s"
        sleep(1)
        count = count + 1
        puts "/!\\ Waited 90s, something might be wrong, breaking" if count == 90
        break if count == 90
      end
      puts "--- Clicking on element"
      @session.all(item_selector)[n].click
    end
  end # End of Class
end # End of Module
