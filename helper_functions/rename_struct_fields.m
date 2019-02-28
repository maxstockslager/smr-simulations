function new_struct = rename_struct_fields(old_struct, old_names, new_names)

new_struct = struct();
for peak_num = 1:numel(old_struct)
    for k=1:numel(old_names)
      new_struct(peak_num).(new_names{k}) = old_struct(peak_num).(old_names{k});
    end
end

end