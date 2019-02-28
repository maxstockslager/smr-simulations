function extracted = extract_structure_data(structure)
names = fieldnames(structure);
for fieldNumber = 1 : numel(names)
    fieldName = names{fieldNumber};
    if numel(structure(1).(fieldName)) == 1
        extracted.(fieldName) = transpose(extractfield(structure, fieldName));
    end
end
   
end