# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# [Multipurpose modmap] Give a key two meanings. A normal key when pressed and
# released, and a modifier key when held down with another key. See Xcape,
# Carabiner and caps2esc for ideas and concept.
define_multipurpose_modmap(
    # Enter is enter when pressed and released. Control when held down.
    #  {Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]}

    # Capslock is escape when pressed and released. Control when held down.
    {Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],
     Key.RIGHT_SHIFT: [Key.HENKAN, Key.RIGHT_SHIFT],
     Key.LEFT_SHIFT: [Key.MUHENKAN, Key.LEFT_SHIFT]}
)
