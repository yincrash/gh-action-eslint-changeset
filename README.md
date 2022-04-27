# Github Action Eslint Changesest

Github action that lints only the files within a particular commit to a branch, when a pull request is established.

### Notes:
  - Github workflow **must** be configured with Checkout V3.
  - This action currently only supports [ESLint](https://eslint.org/).
  - ESLint must be part of the [devDependencies](https://docs.npmjs.com/specifying-dependencies-and-devdependencies-in-a-package-json-file) section of the `package.json` file.

### Inputs
  - main-branch *(default: 'master')*
  - file-extension *(default: 'js')*

### Example usage
In order for this action to work properly, it must be set up along with [Checkout V3](https://github.com/marketplace/actions/checkout#checkout-v3). Also make sure you include the `run` section which is used to include the main repo branch to perform the comparison.

###### .github/workflows/main.yml:
```yml
on:
  pull_request:
    types: [opened, edited, reopened]
    paths: # make sure this action only runs when specific file extensions have been added/modified
      - '**.js'
      - '**.jsx'

jobs:
  test_job:
    runs-on: ubuntu-latest
    name: A job to test eslint-changeset action
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
          ref: ${{ github.head_ref }}
      - run: |
          git fetch --no-tags --depth=1 origin main
          git checkout main 
          git checkout ${{ github.head_ref }}
      - name: Eslint Changeset Step
        uses: actions/gh-action-eslint-changeset@v1
        id: eslint-changeset
        with:
          main-branch: 'main'
          file-extension: 'js'
```

In essence, you could copy/paste the above sample and only change the following according to your repo config:
```yaml
main-branch: 'your_main_repo_branch'
file-extension: 'ts|tsx|json' #make sure you divide by '|' with no spaces in between
```