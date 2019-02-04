public class MyStack {
	
    public static List<Object> stackImp=new List<Object>();
    
    public static List<Object> push(Object data){
        stackImp.add(data);
        return stackImp;
    }
    
    public static Object pop(){
        if(!isEmpty()){
            return stackImp.remove(stackImp.size()-1);
        }
        else{
            System.debug('stack is empty');
            return null;
        }
    }
    
    public static Object peek(){
        if(!isEmpty()){
            return stackImp.get(stackImp.size()-1);
        }
        else{
            System.debug('stack is empty');
            return null;
        }
    }
    public static Boolean isEmpty(){
        return (stackImp.size()==0);
    }
}