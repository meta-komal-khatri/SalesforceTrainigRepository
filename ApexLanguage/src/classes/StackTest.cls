@isTest
private class StackTest {
	
    @isTest
    static void testStackClass(){
        MyStack.push(1);
        MyStack.push(2);
        MyStack.push(3);
        
        System.assertEquals(3,MyStack.peek());
        
        System.assertEquals(new List<Integer> {1,2,3,4},MyStack.push(4));
        
        System.assertEquals(4,MyStack.pop());
        
        MyStack.pop();
        MyStack.pop();
        MyStack.pop();
        
        System.assertEquals(null,MyStack.pop());
        
        System.assertEquals(null,MyStack.peek());
        
        
    }
}