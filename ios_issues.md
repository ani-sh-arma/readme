# iOS Issues

This file tracks platform gaps and workarounds for the ReadMe app on iOS.

## Known gaps

- File system access is sandboxed. Users can only access files through the Files app or app-specific containers, so the Android-style real directory model is limited.
- CBR/RAR extraction is not planned for iOS v1 because there is no open-source RAR library available without licensing concerns.
- MOBI/AZW native parsing is not planned for iOS v1 because the Android Kotlin/Java parser approach has no Swift equivalent in this plan.
- Volume-button page turning is not supported because iOS does not expose hardware volume buttons to apps.
- Background directory scanning is heavily restricted on iOS.
- There is no iOS equivalent to Android's broad MANAGE_EXTERNAL_STORAGE access.
- DJVU support is out of scope for v1.

## Notes

- Use `file_picker` with Files app integration for user-selected documents and folders.
- Prefer app-local storage for cached metadata, covers, and extracted content.
