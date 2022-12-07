local Translations = {

        need_chips = 'Vous avez besoin de %{Chipsamount} jetons pour tourner la roue!',
        You_Won = 'Vous avez gagné %{prize}',
        pistol = 'un calibre .50!',
        cash = '$300,000 en Cash!',
        Marked = 'des billets marqués!',
        chips = '25,000 jetons de casino!',
        sandwich_water = '.... des Sandwich et de l\'eau?',
        money = '$ %{money_amount}!',
        car = 'une voiture!',
        Spin_Wheel = 'Tourner la roue: %{wheel_amount} jetons',
        sender = 'The Diamond Casino',
        subject = 'Votre nouvelle voiture!',
        message = 'Votre nouvelle voiture vous attend au Parking du Motel!'
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
