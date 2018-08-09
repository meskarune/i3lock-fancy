#!/usr/bin/env lua

function os.capture(cmd)
    -- run a program in a seperate process and return the output as a string
    local file = assert(io.popen(cmd, 'r'))
    local string = assert(file:read('*a'))
    file:close()
    return string
end

displays = os.capture('/usr/bin/xrandr')

current = string.match(displays, 'current%s(%d+%sx%s%d+)')

resolution = string.gsub(current, '%s+', '')

lock = ""

for result in string.gmatch(displays, 'connected.-(%d+x%d+[%+%-]%d+[%+%-]%d+)') do
    local width = string.match(result, '(%d+)x%d+')
    local height = string.match(result, '%d+x(%d+)')
    local Xoffset = string.match(result, '[%+%-](%d+)[%+%-]%d+')
    local Yoffset = string.match(result, '[%+%-]%d+[%+%-](%d+)')
    local centerX = (width / 2 + Xoffset)
    local centerY = (height / 2 + Yoffset)
    local MIDXi = (centerX - 30)
    local MIDYi = (centerY - 30)
    local MIDXt = (centerX - 142.5)
    local MIDYt = (centerY + 160)
    local magic = "-font Bitter -pointsize 26 -fill white -annotate +%g+%g 'Type password to unlock' /usr/share/i3lock-fancy-dualmonitor/lock.png -geometry +%g+%g -composite "
    lock = lock .. string.format(magic, MIDXt, MIDYt, MIDXi, MIDYi)
end

image = string.format("%s.png", os.tmpname())

makebackground = string.format("convert -size %s xc:'rgba(0, 0, 0, 0.2)' %s %s", resolution, lock, image)
i3lock = string.format("i3lock -i %s --blur 5", image)

os.execute(makebackground)
os.execute(i3lock)
