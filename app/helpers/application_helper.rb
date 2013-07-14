module ApplicationHelper
    def currency_to_symbol(currency)
        if currency.downcase.eql?("gbp")
            "&pound;"
        else
            "$"
        end
    end
end
