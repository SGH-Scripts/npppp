local Translations = {
    need_chips = 'You Need %{Chipsamount} Chips To Spin!',
    you_won = 'You Won %{prize}',
    pistol = 'A .50 Pistol!',
    cash = '$300,000 in Cash!',    
    marked = 'Marked Bills!',    
    chips = '25,000 Casino Chips!',    
    sandwich_water = '....Sandwich and Water?',    
    money = '$ %{money_amount} !',    
    car = 'a car!',
    Spin_Wheel = 'Spin Wheel %{wheel_amount} Chips',    
    sender = 'The Diamond Casino',
    subject = 'Your new car!',    
    message = 'Your new car is waiting for you at the Motel Parking!',
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
