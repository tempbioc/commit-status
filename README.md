# Action: commit status

This action runs at the beginning and the end of the [build workflow](https://github.com/r-universe-org/workflows/blob/master/build.yml) and attempts to set a commit status (e.g. green checkmark or red cross) in the upstream git repository. This is only possible if the upstream user has the r-universe app installed for the given git repository.

If this action fails, there is usually a permission problem with the app. One common reason is that the user has the app installed but only given it permission for selected repositories.

<img width="940" alt="screenshot" src="https://user-images.githubusercontent.com/216319/177286815-c83df041-5669-4e16-901c-2a2e9f654480.png">
