import matplotlib

matplotlib.use('Agg')
import matplotlib.pyplot as plt

plt.figure(figsize=(6, 4))
plt.plot([1, 2, 3], [4, 5, 6])
plt.savefig('test_plot.png')
plt.close()
print("File saved successfully")
