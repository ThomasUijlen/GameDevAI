using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class Astar
{
    /// <summary>
    /// TODO: Implement this function so that it returns a list of Vector2Int positions which describes a path
    /// Note that you will probably need to add some helper functions
    /// from the startPos to the endPos
    /// </summary>
    /// <param name="startPos"></param>
    /// <param name="endPos"></param>
    /// <param name="grid"></param>
    /// <returns></returns>
    private List<Node> nodeList = new List<Node>();
    private List<Node> availableNodes = new List<Node>();
    private List<Vector2Int> checkedPositions = new List<Vector2Int>();

    public List<Vector2Int> FindPathToTarget(Vector2Int startPos, Vector2Int endPos, Cell[,] grid)
    {
        ResetPathfinding();
        Node finalNode = null;

        AddToAvailableNodes(startPos, grid, endPos, null);
        while(availableNodes.Count > 0 && finalNode == null) {
            finalNode = ExploreNode(GetNodeWithLowestScore(), grid, endPos);
        }
        
        return ((finalNode != null) ? CollectPath(finalNode) : null);
    }

    private Node ExploreNode(Node node, Cell[,] grid, Vector2Int endPos) {
        availableNodes.Remove(node);
        if(checkedPositions.Contains(node.position)) return null;
        checkedPositions.Add(node.position);

        if(node.position == endPos) return node;

        if(!(GetCell(node.position, grid)?.HasWall(Wall.UP) == true)) AddToAvailableNodes(node.position + Vector2Int.up, grid, endPos, node);
        if(!(GetCell(node.position, grid)?.HasWall(Wall.DOWN) == true)) AddToAvailableNodes(node.position + Vector2Int.down, grid, endPos, node);
        if(!(GetCell(node.position, grid)?.HasWall(Wall.LEFT) == true)) AddToAvailableNodes(node.position + Vector2Int.left, grid, endPos, node);
        if(!(GetCell(node.position, grid)?.HasWall(Wall.RIGHT) == true)) AddToAvailableNodes(node.position + Vector2Int.right, grid, endPos, node);

        return null;
    }

    private Node GetNodeWithLowestScore() {
        float lowestScore = 0.0f;
        Node lowestNode = null;

        foreach (Node node in availableNodes)
        {
            if(lowestNode == null || node.FScore < lowestScore) {
                lowestNode = node;
                lowestScore = node.FScore;
            }
        }

        return lowestNode;
    }

    private void AddToAvailableNodes(Vector2Int coord, Cell[,] grid, Vector2Int endPos, Node parent) {
        Cell cell = GetCell(coord, grid);
        if(cell == null) return;

        int h = Mathf.CeilToInt(Vector2Int.Distance(cell.gridPosition, endPos));
        Node node = new Node(
            cell.gridPosition,
            parent,
            (parent != null) ? Mathf.RoundToInt(parent.GScore) + 1 : 0,
            (parent != null) ? Mathf.RoundToInt(parent.HScore) + h : h
        );
        nodeList.Add(node);
        availableNodes.Add(node);
    }
    
    private Cell GetCell(Vector2Int coord, Cell[,] grid) {
        bool cellExists = coord.x >= 0 &&
               coord.y >= 0 &&
               coord.x < grid.GetLength(0) &&
               coord.y < grid.GetLength(1);
        
        if(cellExists) {
            return grid[coord.x, coord.y];
        }
        return null;
    }

    private void ResetPathfinding() {
        checkedPositions.Clear();
        availableNodes.Clear();
        nodeList.Clear();
    }

    private List<Vector2Int> CollectPath(Node finalNode) {
        List<Vector2Int> path = new List<Vector2Int>();
        Node currentNode = finalNode;
        while(currentNode != null) {
            path.Add(currentNode.position);
            currentNode = currentNode.parent;
        }

        path.Reverse();
        return path;
    }



    /// <summary>
    /// This is the Node class you can use this class to store calculated FScores for the cells of the grid, you can leave this as it is
    /// </summary>
    public class Node
    {
        public Vector2Int position; //Position on the grid
        public Node parent; //Parent Node of this node

        public float FScore { //GScore + HScore
            get { return GScore + HScore; }
        }
        public float GScore; //Current Travelled Distance
        public float HScore; //Distance estimated based on Heuristic

        public Node() { }
        public Node(Vector2Int position, Node parent, int GScore, int HScore)
        {
            this.position = position;
            this.parent = parent;
            this.GScore = GScore;
            this.HScore = HScore;
        }
    }
}
