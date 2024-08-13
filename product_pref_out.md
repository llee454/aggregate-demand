<h1><center>Modeling Aggregate Demand for Products and Services based on Consumer Preferences for Product Features</center></h1>

<center>Larry D. Lee Jr.</center>

<center>August 9, 2024</center>

> Abstract: This article presents a model of aggregate demand for products and services based on consumer preferences for product features. Organizations offering services and products and can use this model to prioritize feature development and service improvement initiatives by estimating the potential impact of product changes on aggregate demand.

## Introduction

In this article, we present a mathematical model of aggregate demand for products and services based on consumer preferences for product features. We then show how to use this model to estimate the potential impact that changes to product features will have on consumer demand. Using these techniques, organizations can prioritize product development and service improvement efforts.

## The Model

We start by assuming that there is a set of products $A_i$ and potential consumers in a marketplace. We characterize the products using a set of common feature dimensions, such as weight, cost, and performance. Thus, every product is associated with a vector listing its feature values $[x_{j,i}]$. Every potential consumer assigns a different weight to each feature dimension. These weights are represented by the consumer's preference vector $[k_{l,j}]$. Consumers assign a quality score to each product $s_{l,i} = sum_{j=0}^n k_{l,j} x_{j,i}$ that is a linear combination of the product's feature values and the consumer's feature weights.

We assume that, for every feature dimension $j$, consumer preference weights $k_{l,j}$ are normally distributed and that preferences across dimensions are independent.[^1] Because the quality scores are linear combinations of independent normally distributed variables, the quality scores for each product will also be normally distributed. 

Let $mu_j$ and $sigma_j$ represent the mean weight and standard deviation of weights that consumers give to feature dimension $j$. The distribution of consumer quality scores $s_i$ for a product $A_i$ will equal [^2][^Soch, J.]
$$
begin{align}
s_i sim mathcal{N} (sum_{j=0}^n x_{j,i} mu_j, sum_{j=0}^n x_{j,i}^2 sigma_j^2).
end{align}
$$
When presented with two products $A_i$ and $A_j$, a potential consumer will prefer $A_i$ over $A_j$ when $s_i > s_j$. If $s_i = s_j$, the consumer will be indifferent between $A_i$ and $A_j$ and will choose one of them randomly with probability $frac{1}{2}$.

Let the quality scores $s_i$ for product $A_i$ be normally distributed with mean $mu_i$ and standard deviation $sigma_i$. Additionally, let the quality scores $s_j$ for another product $A_j$ be normally distributed with mean $mu_j$ and standard deviation $sigma_j$. We can calculate the probability $p_{i,j}$ that a consumer will choose $A_i$ over $A_j$ as
$$
begin{align}
p_{i,j} = int int_0^{infty} varphi(frac{s - mu_j}{sigma_j}) varphi (frac{s + delta - mu_i}{sigma_i}) ddelta ds.
end{align}
$$
(1) is equivalent to
$$
begin{align}
p_{i,j} = Phi (frac{mu_i - mu_j}{sqrt{sigma_i^2 + sigma_j^2}}).
end{align}
$$
The derivation is presented in Appendix 1.

Let $p$ represent the probability that a randomly selected consumer chooses either product $A_i$ or $A_j$. Then, if there are $n$ consumers, in $np$ times, a consumer will choose either $A_i$ or $A_j$. Let $n_i$ and $n_j$ represent the number of times that a consumer chooses products $A_i$ and $A_j$ respectively.
$$
begin{align*}
np p_{i, j} &= n_i\
np p_{j, i} &= n_j.
end{align*}
$$
Equating both equations gives:
$$
begin{align*}
np = frac{n_i}{p_{i,j}} = frac{n_j}{p_{j,i}}
end{align*}
$$
Rearranging gives the relative frequency $k_{i,j}$ with which the consumers choose $A_i$ over $A_j$.
$$
begin{align*}
k_{i,j} = frac{p_{i,j}}{p_{j,i}} = frac{n_i}{n_j}
end{align*}
$$
Let $p_i$ represent the absolute probability that a consumer will choose product $A_i$. Then, assuming that every consumer chooses a product, we can form the equation:
$$
begin{align*}
p_0 + p_1 + cdots + p_n = 1.
end{align*}
$$
We can substitute the likelihood ratios into this equation to form:
$$
begin{align*}
& p_0 + k_{1,0} p_0 + cdots + k_{n,0} p_0 &= 1\
& cdots\
& k_{0,n} p_n + k_{1,n} p_n + cdots + p_n &= 1\
end{align*}
$$
We can easily solve these equations to calculate the absolute probability that a consumer will choose a each product. For example:
$$
begin{align*}
p_0 = frac{1}{1 + k_{1,0} + cdots + k_{n,0}}.
end{align*}
$$
Thus, we can calculate the proportion of customers who will choose each product offered within a market place based on their preferences for product features. Using these equations, we can calculate the effect that feature changes will have on aggregate demand for various products.

## Example Use

In this section, we illustrate how the model that we introduced above can be used to represent the relative impact of product features on aggregate demand and to estimate the potential impact of feature improvements on demand.

Imagine that we want to model the aggregate demand for three computer processors. Each processor is characterized by myriad features such as price, power usage, area, heat generation, and performance. However, we determine that four factors, price, power, area, and performance, explain most consumer preference. We conduct a series of surveys and determine that the weights assigned to these factors are independent and normally distributed.

| $j$  | Factor      | Mean $mu$ | Standard Deviation $sigma$ |
| ---- | ----------- | ---------- | --------------------------- |
| 0 | Price | -3 | 1 |
| 1 | Power | -2 | 3 |
| 2 | Performance | 4 | 3 |
| 3 | Area | -1 | 2 |

>  **Table 1: Example Factor Weights for Computer Processors.** This table presents example factor weights to illustrate how product features influence consumer product preferences.

We then measure three computer processors along each of these four dimensions and produce the following measurements.

| Product | Price $x_{0,i}$ | Power $x_{1,i}$ | Performance $x_{2,i}$ | Area $x_{3,i}$ |
| ------- | --------------- | --------------- | --------------------- | -------------- |
| $A_0$ | 1 | 1 | 1 | 1 |
| $A_1$ | 10 | 3 | 5 | 3 |
| $A_2$ | 2 | 2 | 3 | 2 |

> **Table 2: Example Product Factor Values.** This table presents example factor measurements for three hypothetical computer processors to illustrate how the aggregate demand model can be used.

Based on these factor values, we can use (1) to calculate the score distribution for each product.

| Product | Mean Score $mu$ | Score Standard Deviation $sigma$ |
| ------- | ---------------- | --------------------------------- |
| $A_0$ | -2 | 4.7958 |
| $A_1$ | -19 | 21.0238 |
| $A_2$ | 0 | 11.7047 |

 Once we have derived the distributions for the product quality scores, we can calculate the probability $p_{i,j}$ that a randomly selected consumer will choose one product over another for each pair of products $A_i$ and $A_j$ using (3). We can record these probabilities in a matrix like the following
$$
begin{align*}
P := begin{bmatrix}
0.5000 & 0.7848 & 0.4372\\
0.2152 & 0.5000 & 0.2149\\
0.5628 & 0.7851 & 0.5000\\

end{bmatrix}
end{align*}.
$$
Dividing along the diagonals, we can calculate the likelihood ratios $k_{i,j}$ for each pair of products
$$
begin{align*}
K := begin{bmatrix}
1.0000 & 3.6459 & 0.7768\\
0.2743 & 1.0000 & 0.2737\\
1.2874 & 3.6538 & 1.0000\\

end{bmatrix}
end{align*}.
$$

Adding elements within each column, we can calculate the probability that a randomly selected consumer will choose each product
$$
begin{align*}
$A_0$ &= frac{1}{ 1.0000 + 0.2743 + 1.2874 } = 0.3904\\
$A_1$ &= frac{1}{ 3.6459 + 1.0000 + 3.6538 } = 0.1205\\
$A_2$ &= frac{1}{ 0.7768 + 0.2737 + 1.0000 } = 0.4877\\

end{align*}
$$
However, we can do more than calculate relative market share for each product. We can go further and calculate the impact that changes to product features will have on market share. For example, we can use this model to calculate the price that maximizes the gross earnings for the company that produces the second product $A_1$.

Let's assume that the market size consists of 10 million units and that the following function is used to convert price scores into actual prices
$$
begin{align*}
price = 5 (e^{priceScore/10} - 1)
end{align}
$$
Then each product has the following gross earnings

| Product | Gross Earnings |
| ------- | -------------- |
| $A_0$ | $2,052,795.88 |
| $A_1$ | $10,351,453.05 |
| $A_2$ | $5,398,845.97 |

However, our model indicates that the company that manufactures $A_1$ will actually maximize their gross earnings if they can reduce their price from $8.59 to $6.56.
Doing so will increase their market share to 16.06% and increase their gross earnings to $10,529,874.61.

Thus, the company that produces $A_1$ would be able to invest $178,421.56

## Conclusion



## Appendix 1: Solving the Choice Equation

Assume that a population of consumers have to choose between two products $A_i$ and $A_j$. Every consumer assigns a quality score $s_i$ and $s_j$ to products $A_i$ and $A_j$ respectively. These quality scores are normally distributed with means $mu_i$ and $mu_j$ and standard deviations $sigma_i$ and $sigma_j$ respectively. A consumer will choose $A_i$ over $A_j$ if $s_i > s_j$. If $s_i = s_j$ the consumer will be indifferent and will choose one of them randomly with probability $frac{1}{2}$. The probability that a randomly selected consumer will choose $A_i$ over $A_j$ is given by
$$
begin{align}
p_{i,j} = int int_0^{infty} varphi(frac{s - mu_j}{sigma_j}) varphi (frac{s + delta - mu_i}{sigma_i}) ddelta ds
end{align}
$$
In this section, we will show that (4) equals
$$
begin{align}
Phi (frac{mu_i - mu_j}{sqrt{sigma_i^2 + sigma_j^2}}).
end{align}
$$

To prove this equality, we will calculate the Fourier transform for (2) and (3) and show that they are the same.[^3]

Recall that the Fourier transform for the Normal cumulative density function (CDF) is
$$
begin{align}
k(xi) := int Phi (frac{x_0 - mu}{sigma}) e^{-2 pi i xi x_0} d x_0 = frac{e^{-2 pi i xi mu} e^{-2(pi xi sigma)^2}}{2 pi i xi} + frac{1}{2}delta(xi)
end{align}
$$
where $delta (x)$ is the Dirac delta function. In Appendix 2, we show how we can derive (6). From this equation, we can use the Inverse Fourier Transform to express the Normal CDF as
$$
begin{align}
Phi (frac{x_0 - mu}{sigma}) = int frac{e^{2 pi i xi (x_0 - mu)} e^{-2(pi xi sigma)^2}}{2 pi i xi} d xi + frac{1}{2}.
end{align}
$$
From (6) we see that the Inverse Fourier Transform for (4) equals
$$
begin{align}
Phi (frac{mu_i - mu_j}{sqrt{sigma_i^2 + sigma_j^2}}) = int frac{e^{2 pi i xi (mu_i - mu_j)} e^{-2(pi xi sqrt{sigma_i^2 + sigma_j^2})^2}}{2 pi i xi} d xi + frac{1}{2}.
end{align}
$$
We will show that the Fourier transform for (4) has the same form as (8). Let $k(xi)$ represent the Fourier transform for $varphi (frac{s - mu_j}{sigma_j})$ and replace this term in (3) with its Fourier transform:
$$
begin{align*}
p_{i,j} &= int int_0^{infty} varphi(frac{s - mu_j}{sigma_j}) varphi (frac{s + delta - mu_i}{sigma_i}) ddelta ds\
&= int int_0^{infty} (int k(xi) e^{2 pi i xi s} dxi) varphi (frac{s + delta - mu_i}{sigma_i}) ddelta ds\
&hspace{2em}(substitute the inverse Fourier transform)\
&= int k(xi) int_0^{infty} int e^{2 pi i xi s} varphi (frac{s + delta - mu_i}{sigma_i}) ds ddelta dxi\
&= int k(xi) int_0^{infty} e^{2 pi i xi (mu_i - delta)} e^{-2(pi xi sigma_i)^2} ddelta dxi hspace{3em}\
&hspace{2em}(similar to the derivation for the Fourier transform of the Normal PDF) \
&= int k(xi) e^{2 pi i xi mu_i}  e^{-2(pi xi sigma_i)^2}int_0^{infty} e^{-2 pi i xi delta} ddelta dxi\
&= int frac{k(xi) e^{2 pi i xi mu_i}  e^{-2(pi xi sigma_i)^2}}{2 pi i xi} dxi\
&= int frac{e^{-2 pi i xi mu_j} e^{-2(pi xi sigma_j)^2} e^{2 pi i xi mu_i}  e^{-2(pi xi sigma_i)^2}}{2 pi i xi} dxihspace{3em}\
&hspace{2em}(expand k(xi))\
&= int frac{e^{2 pi i xi (mu_i - mu_j)} e^{-2(pi xi sqrt{sigma_i^2 + sigma_j^2})^2}}{2 pi i xi} dxi\
& square
end{align*}
$$
All that remains is to set the constant of integration, which in this instance is $frac{1}{2}$. Thus, we see that the Fourier inverse transform for (2) is equivalent to the inverse transform for (3).


## Appendix 2: The Fourier Transforms of the Normal PDF and CDF

In this section, we will show how we can calculate the Fourier Transform for the Normal probability density function (PDF) and cumulative density function (CDF).

We can calculate the Fourier Transform for the PDF by expanding terms and completing the square as follows:
$$
begin{align*}
k(xi) &:= int varphi (frac{x - mu}{sigma}) e^{-2 pi i xi x} dx \
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{(x - mu)^2}{s sigma^2}} e^{-2 pi i xi x} dx\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}(x^2 - 2 mu x + mu^2) - 2 pi i xi x} dx\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}(x^2 - 2 mu x + mu^2 + 4 pi i xi sigma^2 x)} dx\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}(x^2 - 2x (mu - 2 pi i xi sigma^2) + (mu - 2 pi i xi sigma^2)^2 - (mu - 2 pi i xi sigma^2)^2 + mu^2)} dx hspace{3em}\
&hspace{2em}(complete the square)\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}((x - (mu - 2 pi i xi sigma^2))^2 - (mu - 2 pi i xi sigma^2)^2 + mu^2)} dx\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}((x - (mu - 2 pi i xi sigma^2))^2 + 4 mu pi i xi sigma^2 + 4(pi xi sigma^2)^2)} dx\
&= frac{1}{sigma sqrt{2 pi}} int e^{-frac{1}{2 sigma^2}((x - (mu - 2 pi i xi sigma^2))^2}e^{-2 mu pi i xi - 2(pi xi sigma)^2)} dx\
&= e^{-2 mu pi i xi - 2(pi xi sigma)^2} int varphi(frac{x - (mu - 2 pi i xi sigma^2)}{sigma}) dx\
&= e^{-2 mu pi i xi - 2(pi xi sigma)^2}\
& square
end{align*}
$$
We can then use this equation to calculate the Inverse Fourier transform for the Normal PDF.
$$
begin{align*}
varphi (frac{x - mu}{sigma}) &= int k(xi) e^{2pi i xi x} dxi\
&= int e^{-2 mu pi i xi - 2(pi xi sigma)^2} e^{2pi i xi x} dxi\
&= int e^{2 pi i xi (x - mu) - 2(pi xi sigma)^2} dxi\
end{align*}
$$
From these calculations, we see that the Inverse Fourier transform for (3) must equal
$$
begin{align}
varphi(frac{mu_i - mu_j}{sqrt{sigma_i^2 + sigma_j^2}}) = int e^{2 pi i xi (mu_i - mu_j)} e^{-2(pi xi sqrt{sigma_i^2 + sigma_j^2})^2} dxi.
end{align}
$$

We can use the Integration Property of the Fourier Transform to calculate the Fourier Transform for the Normal CDF. Given a continuous differential function $f (x)$, the Integration Property says
$$
begin{align}
mathcal{F} (int_{-infty}^{x_0} f (x) dx) = frac{mathcal{F (f(x))}}{2 pi i xi} + c delta(xi)
end{align}
$$
Where $mathcal{F}$ denotes the Fourier Transform operator, $delta$ represents the Dirac delta function, and $c$ is a constant that depends on $f$. In the standard proof the integral in (8) is represented by a convolution of $f$ and the step-function. We then use the Convolution Property of the Fourier Transform to express the Fourier Transform as the product of the Fourier Transform of $f$ and the step function. The Fourier Transform of the step function reduces to a sum involving the Dirac Delta function. A detailed derivation can be found in [^Bevelacqua, P.].

Applying the Integration Property of the Fourier Transform to the Normal CDF gives
$$
begin{align}Phi (frac{x_0 - mu}{sigma}) = int frac{e^{2 pi i xi (x_0 - mu)} e^{-2(pi xi sigma)^2}}{2 pi i xi} d x_0 + frac{1}{2}.end{align}
$$

## Footnotes

[^1]: In general, preferences will not be independent across feature dimensions. For example, the importance that a consumer assigns to the weight of a product might correlate with the weight that they assign to its size. Thus, in practice, we will typically need to perform factor analysis such as Principal Component Analysis (PCA) to identify a set of independent feature dimensions that characterize products.  
[^2]: Note that the second argument to $mathcal$ gives the distribution's variance.
[^3]: Whenever two functions have identical Fourier transforms, we know that they are equal. 

## References

[^Bevelacqua, P.]: Bevelacqua, P. (n.d.). *The Integration Property of the Fourier Transform*. The Fourier Transform.com. https://www.thefouriertransform.com/transform/integration.php
[^Soch, J.]: Soch, J. (2021, June 2). Proof: Linear combination of independent normal random variables. The Book of Statistical Proofs. https://statproofbook.github.io/P/norm-lincomb.html 