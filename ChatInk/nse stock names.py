from nsepython import nse_eq
def nse_equity():
    # Fetch the list of stock names
    stock_list = nse_eq("TCS")
    print(stock_list)


if __name__ == "__main__":
    nse_equity()
