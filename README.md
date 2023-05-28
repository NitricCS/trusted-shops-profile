# Trusted Shops Profile Page Tests
Tests to validate profile page properties:
1. **Title Check**: checks if title exists.
2. **Grade Validation**: checks if average grade is visible and avove zero.
3. **Info Popup Validation**: checks if information popup opens and contains relevant information.
⋅⋅* Information is considered relevant if:
⋅⋅⋅* it contains a text about the correct store
⋅⋅⋅* it contains reference about grade calculation
4. **Filter Validation**: checks if clicking on a given number of stars filters out reviews with that number of stars.
5. **Percentage Check**: checks if percentage sum is equal to or less than 100.

## Requirements
Tests require **Robot Framework 6.0.2** and **SeleniumLibrary 6.1.0** for Robot Framework to run.
Packages can be installed through ``pip install -r requirements.txt`` using the included requirements file.

## Tests Execution
Tests can be executed by running ``robot --argumentfile profile_page_tests.robot`` in the root directory.
This command will execute the tests in the order provided above.

The tests can also be executed by running ``robot profile_page_tests``.
This will run the tests in alphabetical order.

Any test can be executed individually: ``robot profile_page_tests/filter_validation.robot``.
This will only run the Filter Validation test.