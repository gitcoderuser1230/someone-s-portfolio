#!/bin/bash
# Script to split Tower of Hanoi HTML into index.html, style.css, and script.js

INPUT="portfolio.html"   # your current file
HTML_OUT="index.html"
CSS_OUT="style.css"
JS_OUT="script.js"

# Extract CSS inside <style> ... </style>
sed -n '/<style>/,/<\/style>/p' "$INPUT" | sed '1d;$d' > "$CSS_OUT"

# Extract JS inside <script> ... </script>
sed -n '/<script>/,/<\/script>/p' "$INPUT" | sed '1d;$d' > "$JS_OUT"

# Copy HTML, but remove inline CSS/JS and replace with external links
sed '/<style>/,/<\/style>/d; /<script>/,/<\/script>/d' "$INPUT" \
| sed 's#</head>#<link rel="stylesheet" href="style.css">\n</head>#' \
| sed 's#</body>#<script src="script.js"></script>\n</body>#' > "$HTML_OUT"

echo "✅ Split complete!"
echo "- HTML: $HTML_OUT"
echo "- CSS:  $CSS_OUT"
echo "- JS:   $JS_OUT"