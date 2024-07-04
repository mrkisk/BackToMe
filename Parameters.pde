void setParameterGlobal(String data) {
    parameters = new HashMap<String, Object>();
    String[] lines = loadStrings(data);
    for (String line : lines) {
        String[] parts = line.split(": ");
        if (parts.length == 2) {
            String key = parts[0].trim();
            String valueStr = parts[1].trim();
            Object value = parseValue(valueStr);
            if (value != null) {
                parameters.put(key, value);
            }
        }
    }
}

Object parseValue(String valueStr) {
    try {
        return Integer.parseInt(valueStr);
    } catch (NumberFormatException e0) {
        try {
            return Float.parseFloat(valueStr);
        } catch (NumberFormatException e1) {
            return null;
        }
    }
}
