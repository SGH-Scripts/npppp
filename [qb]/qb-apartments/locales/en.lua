local Translations = {
    error = {
        to_far_from_door = 'Too far from the door',
        nobody_home = 'Nobody is home..',
    },
    success = {
        receive_apart = 'You got am apartment',
        changed_apart = 'You changed apartments',
    },
    info = {
        at_the_door = 'Somebody is at the door!',
    },
    text = {
        enter = 'Enter',
        ring_doorbell = 'Ring Doorbell',
        logout = '[E] Logout',
        change_outfit = '[E] Outfits',
        open_stash = '[E] Stash',
        move_here = 'Move Here',
        open_door = '[E] Open Door',
        leave = '[E] Exit',
        close_menu = 'Close Menu',
        tennants = 'Tennants',
        enter_move = '[E] Enter',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
