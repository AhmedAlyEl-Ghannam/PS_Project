%% Function that Reads the User's Choice between Case I and Case II
function choice = case_decider()
    fprintf('\n');
    fprintf('Please Select the Desired Case Output  >>\n');
    fprintf('1)Case I: Efficiency & Voltage Regulation vs Active Power\n');
    fprintf('2)Case II: Efficiency & Voltage Regulation vs Lagging and Leading PF \n\n');
    choice = input('Your Choice: ');
    fprintf('\n\n');
end