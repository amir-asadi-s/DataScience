import numpy as np

def calculate(data):
    # Check if the data has exactly 9 elements
    if len(data) != 9:
        raise ValueError("List must contain nine numbers.")
    
    # Reshape the data to a 3x3 NumPy array
    data_array = np.array(data).reshape(3, 3)

    # Define dictionary 
    output = {
        'mean': [
            data_array.mean(axis=0).tolist(), # across each column
            data_array.mean(axis=1).tolist(), # across each row
            data_array.mean().tolist()
        ],
        'variance': [
            data_array.var(axis=0).tolist(), # across each column
            data_array.var(axis=1).tolist(), # across each row
            data_array.var().tolist()
        ],
        'standard deviation': [
            data_array.std(axis=0).tolist(), # across each column
            data_array.std(axis=1).tolist(), # across each row
            data_array.std().tolist()
        ],
        'max': [
            data_array.max(axis=0).tolist(), # across each column
            data_array.max(axis=1).tolist(), # across each row
            data_array.max().tolist()
        ],
        'min': [
            data_array.min(axis=0).tolist(), # across each column
            data_array.min(axis=1).tolist(), # across each row
            data_array.min().tolist()
        ], 
        'sum': [
            data_array.sum(axis=0).tolist(), # across each column
            data_array.sum(axis=1).tolist(), # across each row
            data_array.sum().tolist()
        ]
    }

    return output