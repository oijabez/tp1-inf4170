
/**
 * Write a description of class TP1 here.
 *
 * @author (Jabez Adasz)
 * @version (20181104-17:12)
 */

import java.util.Scanner;
public class TP1 {

    static int[] a;
    static int[] b;
    static Scanner sc = new Scanner (System.in);

    /**
     *
     * @param i
     * @param j
     */
    static void swap(int i, int j) {
        int temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }

    /**
     *
     * @param index
     * @return
     */
    static int getLeftChildIndex(int index) {
        return Math.max(2 * index + 1, a.length-1);
    }


    /**
     *
     * @param index
     * @return
     */
    static int getRightChildIndex(int index) {
        return Math.max(2 * index + 2, a.length-1);
    }


    /**
     *
     * @param a
     */
    static void afficherTableau(int[] a, int n){
        System.out.println("Voici le contenu du tableau: ");
        for(int i=0;i<n;i++){
            System.out.print(a[i] + "  ");
        }
    }


    /**
     *
     * @param a
     * @param par_taille
     */
    public static void sort(int[] a, int par_taille) {

        heapify(a);
        for (int i = par_taille-1; i > 0; i--)
        {
            swap(0, i);
            par_taille = par_taille-1;
            maxheap(a, 0);
        }
    }


    /* Function to build a heap */
    public static void heapify(int arr[])
    {
        int N = arr.length-1;
        for (int i = N/2; i >= 0; i--)
            maxheap(arr, i);
    }



    /**
     *
     * @param rootIndex
     * @param lastIndex
     */
    static void fixHeap(int rootIndex, int lastIndex){
        b = new int[lastIndex - rootIndex + 1];
        int j = 0;

        for(int i = rootIndex ; i < lastIndex; i++){
            b[j] = a[i];
            j ++;
        }

    }
    


    /* Function to swap largest element in heap */
    public static void maxheap(int arr[], int i)
    {
        int N = arr.length-1;
        int left = getLeftChildIndex(i) ;
        int right = getRightChildIndex(i);
        int max = i;
        if ((left <= N) && (arr[left] > arr[i]))
            max = left;
        if ((right <= N) && (arr[right] > arr[max]))
            max = right;

        if (max != i)
        {
            swap(i, max);
            maxheap(arr, max);
        }
    }




    /**
     *
     * @param args
     */
    public static void main (String args []) {


        System.out.println("Veuillez saisir la taille du tableau: ");
        int n = sc.nextInt();

        while(n<=0){
            System.out.println("Vous devez saisir un entier positif! Recommencez ... ");
            n = sc.nextInt();
        }

        a = new int[n];
        for(int i=0;i<n;i++){
            a[i] = (int)(Math.random()*1000);
        }

        afficherTableau(a, n);

        //Appels des méthodes pour le numéro 1
        System.out.println("\n\n*** Échange du contenu des éléments du tableau ***");
        System.out.println("Veuillez saisir deux entiers i et j qui représentent les positions des deux éléments a echanger dans le tableau:");
        System.out.println("i et j doivent être compris entre 0 et " + (n-1));
        int i = sc.nextInt();
        int j = sc.nextInt();

        while((i<0) || (j<0) || (i>=n) || (j>=n)) {
            System.out.println("Vous devez saisir deux entiers entre 0 et " + (n-1) + " ! Recommencez ... ");
            i = sc.nextInt();
            j = sc.nextInt();
        }

        swap(i, j);
        afficherTableau(a, n);


        System.out.println("\n\n*** Retourner l'indice de l'enfant a gauche ***");
        System.out.println("Veuillez saisir un entier qui représente un index d'un élément dans le tableau:");
        System.out.println("index doit être compris entre 0 et " + (n-1));
        int index = sc.nextInt();

        while((index<0) || (index>=n)) {
            System.out.println("Vous devez saisir un entier entre 0 et " + (n-1) + " ! Recommencez ... ");
            index = sc.nextInt();
        }

        int gauche = getLeftChildIndex(index);
        System.out.println("l'indice de l'enfant gauche est = " + gauche);



        System.out.println("\n\n*** Retourner l'indice de l'enfant a droite ***");
        System.out.println("Veuillez saisir un entier qui représente un index d'un élément dans le tableau:");
        System.out.println("index doit être compris entre 0 et " + (n-1));
        index = sc.nextInt();

        while((index<0) || (index>=n)) {
            System.out.println("Vous devez saisir un entier entre 0 et " + (n-1) + " ! Recommencez ... ");
            index = sc.nextInt();
        }

        int droite = getRightChildIndex(index);
        System.out.println("l'indice de l'enfant droite est = " + droite);


        //Tri du tableau
        sort(a, n);
        afficherTableau(a, n);

        sc.close();
    }
}
