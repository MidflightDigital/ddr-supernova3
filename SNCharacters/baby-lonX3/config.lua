return {
    --version must be 1.
    version = 3,
    --color must be a table or string.
    --You can't use the color() function here because this file runs in an
    --empty environment, but you don't need to since the config loader does
    --that for you.
    color = "#ff0000"
}
