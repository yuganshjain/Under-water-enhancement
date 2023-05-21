function dark_channel = get_dark_channel(image, window_size)
    if any(size(image) < window_size)
        dark_channel = min(image, [], 3);
    else
        dark_channel = min(imboxfilt(image, window_size), [], 3);
    end
end
