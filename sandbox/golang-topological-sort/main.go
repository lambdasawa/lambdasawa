package main

type (
	Mark int

	ID int

	Node struct {
		ID      ID
		DestIDs []ID

		mark Mark
	}

	Graph = []*Node
)

const (
	markUnknown Mark = iota
	markTemporary
	markPermanent
)

// https://ja.wikipedia.org/wiki/%E3%83%88%E3%83%9D%E3%83%AD%E3%82%B8%E3%82%AB%E3%83%AB%E3%82%BD%E3%83%BC%E3%83%88
func topologicalSort(graph Graph) Graph {
	sorted := Graph{}

	var visit func(node *Node)
	visit = func(node *Node) {
		switch node.mark {
		case markUnknown:
			node.mark = markTemporary

			for _, destID := range node.DestIDs {
				visit(findNodeByID(destID, graph))
			}

			node.mark = markPermanent

			sorted = append(sorted, node)

		case markTemporary:
			panic("cycle detected")

		default:
			return
		}
	}

	for _, node := range graph {
		visit(node)
	}

	reversed := make(Graph, len(sorted))
	for i := 0; i < len(sorted); i++ {
		reversed[i] = sorted[len(sorted)-1-i]
	}

	return reversed
}

func findNodeByID(id ID, graph Graph) *Node {
	for _, node := range graph {
		if node.ID == id {
			return node
		}
	}

	panic("node not found")
}
