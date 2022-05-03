#include <stdio.h>

struct vector3
{
	int x, y, z;
};

extern "C" int vecProduct(vector3 first, vector3 second, vector3 * res);
extern "C" int stringConv(char* buffer, int number);
extern "C" int intConv(char* buffer);
extern "C" int getBin(int number, char* pointer);
extern "C" double expt(double power, double prec);
extern "C" double approx(double base, double prec);

int main()
{
	printf("Real function approximations\n");

	double power;
	printf("e^");
	scanf_s("%lf", &power);

	double exponent = expt(power, 0.000001);
	printf(" = %.5lf; \n\n", exponent);

	//

	double sqrtarg;
	printf("sqrt(");
	scanf_s("%lf", &sqrtarg);

	double root = approx(sqrtarg, 0.00001);
	printf(") = %.5lf; \n\n", root);

	//

	printf("Vector product");

	vector3 alpha = { 2, -5, 1 };
	vector3 beta = { 3, 1, -1 };
	vector3 result;

	int magnitude = vecProduct(alpha, beta, &result);

	printf("[%d, %d, %d] * [%d, %d, %d] = \n", alpha.x, alpha.y, alpha.z, beta.x, beta.y, beta.z);
	printf("x: %d y: %d z: %d magnitude^2: %d\n\n", result.x, result.y, result.z, magnitude);

	//

	printf("Enter an integer: ");

	char buffer[31] = {};
	scanf_s("%s", buffer, 31);
	
	int integer = intConv(buffer);

	//

	char binary[33] = {};
	int ones = getBin(integer, binary);

	printf("\nBinary: ");
	printf(binary);
	printf(" (%d ones)\n", ones);

	//

	integer -= 20;
	stringConv(buffer, integer);

	printf("\ninteger - 20 = ");
	printf(buffer);

	return 0;
}
