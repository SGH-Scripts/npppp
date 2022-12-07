local Translations = {
    error = {
        incorrect_amount = "Incorrect amount",
        no_space = "Not enough space in inventory",
        no_slots = "Not enough slots in inventory",
        no_money = "You do not have enough",
        cant_give = "Can't give item!",
    },
    target = {
        browse = "Talk to Laptop Dealer",
    },
    menu = {
        close = "❌ Close",
        cost = "Cost: $",
        weight = "Weight:",
        confirm = "Confirm Purchase",
        -- cpi = "Cost per item:",
        payment_type = "Payment Type",
        cash = "Cash",
        card = "Card",
        amount = "Amount to buy",
        submittext = "Pay",
        blackmoney = "Dirty Money",
        crypto = "xcoin",
     }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
