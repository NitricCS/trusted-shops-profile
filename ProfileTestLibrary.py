class ProfileTestLibrary(object):
    def __init__(self):
        pass

    def rating_should_have_stars(self, rating: str, stars: int):
        """Verifies that a review ``rating`` has a given number of ``stars``.
        *Not suitable* to check ratings with a decimal point (avg rating on profile).

        Example:
        ``Rating Should Have Stars   ${RATING}   ${3}``

        Use ``Ratings Should Have Stars`` to verify a list of ratings instead.
        """
        span = rating.split("</span>")
        star_counter = 0
        for star in span:
            if ("color:#FFDC0F" in star) or ("color: rgb(255, 220, 15)" in star):
                star_counter = star_counter + 1
        if star_counter != stars:
            raise AssertionError ("Rating has %s stars instead of %s" % (star_counter, stars))

    def ratings_should_have_stars(self, ratings: list, stars: int):
        """ Verifies that all ratings in the `list` have a given number of stars.

        Example:
        ``Ratings Should Have Stars   ${RATINGS}   ${3}``
        """
        for page in ratings:
            for rating in page:
                try:
                    self.rating_should_have_stars(rating, stars)
                except AssertionError:
                    raise AssertionError ("At least one review has a rating different than %s" % (stars))

    def percentage_sum_should_be_valid(self, percentages: list):
        """ Verifies that the sum of percentage values is less than or equal to 100.
        Takes percentage div contents list as an argument.

        Example:
        Percentage Sum Should Be Valid ${PERCENTAGES}
        """
        sum = 0
        for percentage in percentages:
            number = percentage.split("<span>")[1]
            number = number.split("</span")[0]
            sum = sum + int(number)
        if sum > 100:
            raise AssertionError("Percentage sum is %s, but should be equal or less than 100" % (sum))