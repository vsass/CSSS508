str_subset # Returns all elements that contain matches of the pattern.

str_which # Returns numeric indices of elements that match the pattern.

str_count # rather than a true or false, it tells you how many matches there are in each string

str_replace #replaces the first match

str_replace_all # Performs multiple replacements simultaneously

str_remove and str_remove_all # handy shortcuts for str_replace(x, pattern, "") (natural with mutate)

separate_wider_regex # need to construct a sequence of regular expressions that match each piece. If the match fails, you can use too_short = "debug"

