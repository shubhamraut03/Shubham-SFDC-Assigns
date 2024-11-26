public with sharing class Collections{
    
    // Create a map where the keys are strings and the values are lists of strings. Add some data representing a department (key) and the list of employees (value) in each department. Print the map.
    public void mapMeth(){
        Map<String, List<String>> departments = new Map<String, List<String>>{
            'HR' => new List<String>{'Rajat', 'Rohit'},
            'Engineering' => new List<String>{'Aman', 'Manan', 'Urvish'},
            'Marketing' => new List<String>{'Mayur', 'Piyush'}
        };
            System.debug('Map Result');
        
        for (String department : departments.keySet()) {
            System.debug(department + ': ' + departments.get(department));
        }
        
    }
    
    
    
    
    //Create two sets of strings representing two different groups of students. Find the union, intersection, and difference of the two sets.
    public void setMeth(){
        Set<String> group1 = new Set<String>{'Rajat', 'Rohit', 'Aman'};
        Set<String> group2 = new Set<String>{'Aman', 'Manan', 'Urvish'};
        
        Set<String> unionSet = new Set<String>(group1);
        unionSet.addAll(group2);
        
        Set<String> intersectionSet = new Set<String>(group1);
        intersectionSet.retainAll(group2);
        
        Set<String> differenceSet = new Set<String>(group1);
        differenceSet.removeAll(group2);
        
        Set<String> differenceSet1 = new Set<String>(group2);
        differenceSet1.removeAll(group1);
        
        Set<String> allDifferences = new Set<String>(differenceSet);
        //allDifferences.addAll(differenceSet);
        allDifferences.addAll(differenceSet1);
        
        System.debug('Set Result');
        System.debug('Union of groups: ' + unionSet);
        System.debug('Intersection of groups: ' + intersectionSet);
        System.debug('Difference of groups: ' + allDifferences);
        
    }
    
    
    
    //Create a list of integers and add ten random numbers to it. Sort the list in ascending order and print the sorted list.
    public void listMeth(){
        List<Integer> numbers = new List<Integer>();
        for (Integer i = 0; i < 10; i++) {
            numbers.add(Math.round(Math.random() * 100));
        }
        
        numbers.sort();
        System.debug('List Result');
        System.debug('Sorted List of Random Numbers: ' + numbers);
        
    }
    

}