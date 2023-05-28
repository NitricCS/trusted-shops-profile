from robot.libraries.BuiltIn import BuiltIn

class ProfileTestLibrary(object):
    """ Library includes complex keyword logic
    for *Trusted Shops profile page* testing. """

    def __init__(self):
        pass

    def grade_value_should_be_positive(self):
        """ Verifies that ``${GRADE_VALUE}`` is above zero. """
        value = BuiltIn().get_variable_value("${GRADE_VALUE}")
        value = value.replace(",", ".")
        try:
            num_value = float(value)
        except ValueError:
            raise AssertionError ("Grade %s can't be validated: wrong grade format" % value)
        if num_value <= 0:
            raise AssertionError ("Grade %s is not above zero" % value)

    def extract_store_name(self, span: str) -> str:
        """ Separates store name on profile page from the verification mark. """
        name = span.split("<span")[0]
        return name

    def rating_should_have_stars(self, rating: str, stars: int):
        """ Verifies that a review ``rating`` has a given number of ``stars``.
        Example: ``Rating Should Have Stars   ${RATING}   ${3}``
        Use ``Ratings Should Have Stars`` to verify a list of ratings instead.
        """
        span = rating.split("</span>")
        for i in range(0, stars):                                                                     # check stars in order one by one
            if ("color:#FFDC0F" not in span[i]) and ("color: rgb(255, 220, 15)" not in span[i]):      # otherwise *--*- would be a correct rating
                raise AssertionError ("Rating has incorrect number of stars.")
        for i in range(stars, 5):
            if ("color:#FFDC0F" in span[i]) or ("color: rgb(255, 220, 15)" in span[i]):
                raise AssertionError ("Rating has incorrect number of stars.")

    def ratings_should_have_stars(self, stars: int):
        """ Verifies that all ratings in ``${RATINGS_LIST}`` have a given number of stars.
        Example: ``Ratings Should Have Stars   ${3}``
        """
        ratings = BuiltIn().get_variable_value("${RATINGS_LIST}")
        if len(ratings) == 0:
            raise AssertionError ("List of ratings is empty")
        for page in ratings:
            for rating in page:
                try:
                    self.rating_should_have_stars(rating, stars)
                except AssertionError as e:
                    raise AssertionError ("At least one rating is wrong.")

    def percentage_sum_should_be_valid(self):
        """ Verifies that the sum of values in ``${PERCENTAGES}`` is less than or equal to 100. """
        percentages = BuiltIn().get_variable_value("${PERCENTAGES}")
        sum = 0
        for percentage in percentages:
            number = percentage.split("<span>")[1]
            number = number.split("</span")[0]
            sum = sum + int(number)
        if sum > 100:
            raise AssertionError("Percentage sum is %s, but should be equal or less than 100" % sum)