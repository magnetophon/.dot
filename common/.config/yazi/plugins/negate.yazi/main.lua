local M = {}
local flag = Url("/tmp/yazi-screen-inverted")
local xdg = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")
local cache_dir = xdg .. "/yazi-negate"

local VIDEO_EXTS = {
    mp4=true, mkv=true, avi=true, mov=true, wmv=true, flv=true,
    webm=true, m4v=true, mpg=true, mpeg=true, ts=true, ogv=true,
    vob=true, mts=true, m2ts=true,
}

local function inverted()
    return fs.cha(flag) ~= nil
end

local function is_video(job)
    local ext = tostring(job.file.url):match("%.([^%.]+)$")
    return ext and VIDEO_EXTS[ext:lower()] or false
end

local function neg_cache(job)
    local hash = ya.hash(tostring(job.file.url) .. ":" .. tostring(job.skip))
    return Url(cache_dir .. "/" .. hash .. ".png")
end

local function ensure_cache_dir()
    fs.create("dir_all", Url(cache_dir))
end

local function negate_image(src, dest)
    local status = Command("magick")
        :arg(tostring(src))
        :arg("-negate")
        :arg(tostring(dest))
        :status()
    return status and status.success
end

local function negate_video(src, dest, skip)
  local output = Command("/run/current-system/sw/bin/ffprobe")
    :arg("-v"):arg("error")
    :arg("-show_entries"):arg("format=duration")
    :arg("-of"):arg("default=noprint_wrappers=1:nokey=1")
    :arg(tostring(src))
    :stdout(Command.PIPED)
    :output()

    if not output or not output.status.success then
        return false
    end

    local duration = tonumber(output.stdout:match("[%d%.]+"))
    if not duration or duration == 0 then
        duration = 1
    end

    local percent = math.min(5 + (skip or 0) * 5, 95)
    local seek = duration * percent / 100

    local status = Command("/run/current-system/sw/bin/ffmpeg")
      :arg("-y")
      :arg("-ss"):arg(string.format("%.3f", seek))
      :arg("-i"):arg(tostring(src))
      :arg("-frames:v"):arg("1")
      :arg("-vf"):arg("negate")
      :arg(tostring(dest))
      :stderr(Command.NULL)
      :status()

    return status and status.success
end

function M:peek(job)
    if not inverted() then
        if is_video(job) then
            return require("video"):peek(job)
        else
            return require("image"):peek(job)
        end
    end

    local cache = neg_cache(job)
    if fs.cha(cache) then
        return ya.image_show(cache, job.area)
    end

    ensure_cache_dir()

    local ok
    if is_video(job) then
        ok = negate_video(job.file.url, cache, job.skip)
    else
        ok = negate_image(job.file.url, cache)
    end

    if ok then
        ya.image_show(cache, job.area)
    end
end

function M:seek(job)
    if is_video(job) then
        require("video"):seek(job)
    else
        require("image"):seek(job)
    end
end

function M:preload(job)
    if not inverted() then
        if is_video(job) then
            return require("video"):preload(job)
        else
            return require("image"):preload(job)
        end
    end

    local cache = neg_cache(job)
    if fs.cha(cache) then
        return 1
    end

    ensure_cache_dir()

    local ok
    if is_video(job) then
        ok = negate_video(job.file.url, cache, job.skip)
    else
        ok = negate_image(job.file.url, cache)
    end

    return ok and 1 or 2
end

return M
