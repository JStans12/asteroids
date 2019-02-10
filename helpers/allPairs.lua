local function allPairs(fctn, table)
  for i = 1, #table do
    for j = 1, #table - i do
      fctn(table[i], table[i+j])
    end
  end
end

return allPairs
