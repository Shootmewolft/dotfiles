// Vim / Neovim cheatsheet, structured after https://vimaster.dev/
// Each section: { title, items }. An item is either a string (subheading)
// or a [key, description] pair. "#" = optional count, {x} = placeholder.
const sections = [
    {
        title: "Motions",
        items: [
            "Basic",
            ["h j k l", "Left / down / up / right"],
            ["gj gk", "Down / up by display line"],
            "Words",
            ["w W", "Next word / WORD start"],
            ["e E", "Next word / WORD end"],
            ["b B", "Previous word / WORD start"],
            ["ge gE", "Previous word / WORD end"],
            "Line",
            ["0", "Line start"],
            ["^", "First non-blank char"],
            ["$", "Line end"],
            ["g_", "Last non-blank char"],
            ["g0 g^ g$", "Start / first char / end of display line"],
            ["gM", "Middle of the line"],
            ["- + _", "Prev line / next line / current line first char"],
            "Screen",
            ["H M L", "Top / middle / bottom of screen"],
            ["Ctrl+u Ctrl+d", "Half page up / down"],
            ["Ctrl+b Ctrl+f", "Full page up / down"],
            "Document",
            ["gg G", "First / last line"],
            ["#gg #G", "Go to line #"],
            "Character search",
            ["f{c} F{c}", "To next / previous {c}"],
            ["t{c} T{c}", "Till next / previous {c}"],
            ["; ,", "Repeat f/t forward / backward"],
            "Pairs & blocks",
            ["%", "Matching bracket"],
            ["[( ])", "Unmatched ( / )"],
            ["[{ ]}", "Unmatched { / }"],
            ["[# ]#", "Unmatched #if / #endif"],
            ["( )", "Previous / next sentence"],
            ["{ }", "Previous / next paragraph"],
            ["[[ ]]", "Previous / next section start"],
            ["[] ][", "Previous / next section end"],
            ["[m ]m", "Previous / next method start"],
            ["[M ]M", "Previous / next method end"],
            "Search",
            ["/{pat} ?{pat}", "Search forward / backward"],
            ["n N", "Next / previous match"],
            ["* #", "Word under cursor forward / backward"],
            ["g* g#", "Same, partial match"],
            "Jump list",
            ["Ctrl+o Ctrl+i", "Older / newer jump"],
            ["''", "Back to last jump line"]
        ]
    },
    {
        title: "Normal mode",
        items: [
            "Insert",
            ["i a", "Insert before / after cursor"],
            ["I A", "Insert at line start / end"],
            ["o O", "New line below / above"],
            ["gi", "Insert where insert mode was last left"],
            ["gI", "Insert at column 1"],
            "Replace",
            ["r{c}", "Replace one char"],
            ["R", "Replace mode"],
            ["s", "Delete char and insert"],
            "Delete / yank / put",
            ["x X", "Delete char under / before cursor"],
            ["D", "Delete to line end"],
            ["Y", "Yank line"],
            ["p P", "Put after / before"],
            ["gp gP", "Put and move cursor after text"],
            "Undo & repeat",
            ["u Ctrl+r", "Undo / redo"],
            ["U", "Undo all changes on line"],
            [".", "Repeat last change"],
            ["~", "Toggle case of char"],
            ["J gJ", "Join lines with / without space"],
            "Visual",
            ["v V Ctrl+v", "Char / line / block visual"],
            ["gv", "Reselect last selection"],
            "Misc",
            ["zz zt zb", "Center / top / bottom cursor line"],
            ["ZZ ZQ", "Save and quit / quit without saving"],
            ["ga", "Show char code"],
            ["K", "Docs for word under cursor"]
        ]
    },
    {
        title: "Insert mode",
        items: [
            "Editing",
            ["Ctrl+h", "Delete char before cursor"],
            ["Ctrl+w", "Delete word before cursor"],
            ["Ctrl+u", "Delete to line start"],
            ["Ctrl+r{r}", "Insert register {r}"],
            ["Ctrl+r Ctrl+r{r}", "Insert register literally"],
            ["Ctrl+a", "Insert last inserted text"],
            ["Ctrl+o{cmd}", "Run one normal-mode command"],
            ["Ctrl+v{key}", "Insert key literally"],
            ["Ctrl+v{digits}", "Insert char by decimal code"],
            ["Ctrl+v u{hex}", "Insert unicode char"],
            "Completion",
            ["Ctrl+n Ctrl+p", "Next / previous match"],
            ["Ctrl+y Ctrl+e", "Accept / cancel completion"],
            ["Ctrl+x Ctrl+f", "Complete file path"],
            ["Ctrl+x Ctrl+]", "Complete tag"],
            ["Ctrl+x Ctrl+n", "Complete from current buffer"],
            "Exit",
            ["Esc Ctrl+[", "Back to normal mode"],
            ["Ctrl+c", "Exit without abbreviations/autocmds"]
        ]
    },
    {
        title: "Visual mode",
        items: [
            "Operators on selection",
            ["d c y", "Delete / change / yank"],
            ["> <", "Indent / outdent"],
            ["=", "Re-indent"],
            ["gu gU g~", "Lower / upper / toggle case"],
            ["gq gw", "Format (move / keep cursor)"],
            ["!{cmd}", "Filter through shell command"],
            "Special",
            ["I A", "Block: insert / append on every line"],
            ["r{c}", "Replace all selected chars"],
            ["u U", "Lowercase / uppercase"],
            ["Ctrl+a Ctrl+x", "Increment / decrement numbers"],
            ["g Ctrl+a", "Increment as sequence"],
            ["o", "Jump to other end of selection"],
            "Exit",
            ["Esc v V", "Leave visual mode"]
        ]
    },
    {
        title: "Operators",
        items: [
            ["d{m} dd D", "Delete motion / line / to end"],
            ["c{m} cc C", "Change motion / line / to end"],
            ["S", "Change whole line"],
            ["y{m} yy", "Yank motion / line"],
            [">{m} >>", "Indent motion / line"],
            ["<{m} <<", "Outdent motion / line"],
            ["={m} ==", "Auto-indent motion / line"],
            ["g~{m} g~~", "Toggle case"],
            ["gu{m} guu", "Lowercase"],
            ["gU{m} gUU", "Uppercase"],
            ["gq{m} gqq", "Format text"],
            ["gw{m} gww", "Format, keep cursor"],
            ["!{m} !!", "Filter through shell"],
            ["g?{m} g??", "ROT13"]
        ]
    },
    {
        title: "Text objects",
        items: [
            ["iw aw", "Inner / a word"],
            ["iW aW", "Inner / a WORD"],
            ["is as", "Inner / a sentence"],
            ["ip ap", "Inner / a paragraph"],
            ["i' a'  i\" a\"", "Inside / around quotes"],
            ["i( a(  ib ab", "Inside / around ()"],
            ["i{ a{  iB aB", "Inside / around {}"],
            ["i[ a[", "Inside / around []"],
            ["i< a<", "Inside / around <>"],
            ["it at", "Inside / around HTML tag"]
        ]
    },
    {
        title: "Search & replace",
        items: [
            "With operators",
            ["d/{pat}", "Delete up to match"],
            ["d/{pat}/e", "Delete through match end"],
            ["gn gN", "Select next / previous match"],
            ["cgn", "Change next match (repeat with .)"],
            ["dgn ygn", "Delete / yank next match"],
            "Substitute",
            [":s/a/b/", "First on line"],
            [":s/a/b/g", "All on line"],
            [":%s/a/b/g", "All in file"],
            [":%s/a/b/gc", "All in file, confirm each"],
            [":%s/a/b/gi", "Case-insensitive"],
            [":5,10s/a/b/g", "Lines 5 to 10"],
            [":%s//b/g", "Reuse last search"],
            [":%s/\\<a\\>/b/g", "Whole word only"]
        ]
    },
    {
        title: "Marks",
        items: [
            ["m{a-z}", "Set local mark"],
            ["m{A-Z}", "Set global (file) mark"],
            ["'{x} `{x}", "Jump to mark line / exact position"],
            ["]' [' ]` [`", "Next / previous mark"],
            ["'' ``", "Back to previous jump"],
            ["'. '^", "Last change / last insert"],
            ["'\"", "Position when file was last exited"],
            ["'[ ']", "Start / end of last change or yank"],
            ["'< '>", "Start / end of last selection"],
            ["d'a y`a", "Operators work with marks"],
            [":marks", "List marks"],
            [":delm a-d", "Delete marks a to d"],
            [":delm!", "Delete all local marks"]
        ]
    },
    {
        title: "Macros",
        items: [
            ["q{a-z}", "Record into register"],
            ["q{A-Z}", "Append to macro"],
            ["q", "Stop recording"],
            ["@{a-z}", "Run macro"],
            ["@@", "Repeat last macro"],
            ["#@{a}", "Run macro # times"],
            [":reg a", "Show macro a"],
            ["\"ap", "Paste macro to edit it"],
            [":let @a='...'", "Set macro by hand"],
            [":%norm @q", "Run macro on every line"],
            ["vip:norm @q", "Run macro on selected lines"]
        ]
    },
    {
        title: "Scrolling",
        items: [
            ["Ctrl+e Ctrl+y", "Scroll one line down / up"],
            ["Ctrl+d Ctrl+u", "Half page down / up"],
            ["Ctrl+f Ctrl+b", "Full page down / up"],
            ["zt zz zb", "Cursor line to top / center / bottom"],
            ["z⏎ z. z-", "Same, cursor to first non-blank"],
            ["zh zl", "Scroll left / right one char"],
            ["zH zL", "Scroll left / right half screen"]
        ]
    },
    {
        title: "Indent",
        items: [
            [">> <<", "Indent / outdent line"],
            [">ip <ip", "Indent / outdent paragraph"],
            [">i{ <i{", "Indent / outdent block content"],
            ["==", "Re-indent line"],
            ["=ip =i{", "Re-indent paragraph / block"],
            ["gg=G", "Re-indent whole file"],
            ["> < (visual)", "Indent selection"],
            ["gv", "Reselect to indent again"]
        ]
    },
    {
        title: "Tabs",
        items: [
            [":tabnew", "New empty tab"],
            [":tabe {file}", "Open file in new tab"],
            [":tabc", "Close tab"],
            [":tabo", "Close all other tabs"],
            ["gt gT", "Next / previous tab"],
            ["#gt", "Go to tab #"],
            ["g Tab", "Last accessed tab"],
            [":tabm #", "Move tab to position #"],
            [":tabm +1 -1", "Move tab right / left"],
            [":tabs", "List tabs"],
            [":tabdo {cmd}", "Run command in every tab"]
        ]
    },
    {
        title: "Diff",
        items: [
            [":diffthis", "Add window to diff"],
            [":diffoff!", "Leave diff mode"],
            [":vert diffsplit {f}", "Diff with file side by side"],
            [":diffu", "Refresh diff"],
            ["]c [c", "Next / previous change"],
            ["do dp", "Diff obtain / put"],
            [":diffget LO/BA/RE", "Take local / base / remote (merge)"],
            ["zo zc za", "Open / close / toggle fold"],
            ["zr zm", "Reduce / more folding"],
            [":windo diffthis", "Diff all windows"]
        ]
    },
    {
        title: "Files, buffers & windows",
        items: [
            "Files & buffers",
            [":e {file}", "Edit file"],
            [":sp :vs {file}", "Open in horizontal / vertical split"],
            [":ls", "List buffers"],
            [":bn :bp", "Next / previous buffer"],
            [":b # / :b {name}", "Go to buffer"],
            [":bd", "Delete buffer"],
            ["Ctrl+6", "Alternate buffer"],
            "Windows",
            ["Ctrl+w s v", "Split horizontal / vertical"],
            ["Ctrl+w q", "Close window"],
            ["Ctrl+w h j k l", "Move to window"],
            ["Ctrl+w w", "Cycle windows"],
            ["Ctrl+w x", "Swap with next window"],
            ["Ctrl+w =", "Equalize sizes"],
            ["Ctrl+w H J K L", "Move window to edge"],
            [":tab ball", "Every buffer in a tab"]
        ]
    },
    {
        title: "Quitting & saving",
        items: [
            [":w", "Save"],
            [":w {file}", "Save as file (stay on current)"],
            [":sav {file}", "Save as and switch to it"],
            [":wa", "Save all"],
            [":q :q!", "Quit / quit discarding changes"],
            [":qa :qa!", "Quit all / quit all discarding"],
            [":wq :x ZZ", "Save and quit"],
            ["ZQ", "Quit without saving"],
            [":cq", "Quit with error code"]
        ]
    },
    {
        title: "Registers",
        items: [
            ["\"\"", "Unnamed (default)"],
            ["\"{a-z}", "Named register"],
            ["\"{A-Z}", "Append to named register"],
            ["\"0", "Last yank"],
            ["\"1 to \"9", "Delete history"],
            ["\"-", "Last small delete"],
            ["\"_", "Black hole (discard)"],
            ["\"+ \"*", "System clipboard / selection"],
            ["\". \": \"/", "Last insert / command / search"],
            ["\"% \"#", "Current / alternate file name"],
            ["\"=", "Expression register"],
            [":reg", "List registers"]
        ]
    }
];
