package main

import (
	"testing"

	"github.com/stretchr/testify/require"
)

func Test_topologicalSort(t *testing.T) {
	type args struct {
		graph Graph
	}
	tests := []struct {
		name string
		args args
		want Graph
	}{
		{
			args: args{
				graph: Graph{
					{ID: 2, DestIDs: []ID{}, mark: markUnknown},
					{ID: 3, DestIDs: []ID{8, 10}, mark: markUnknown},
					{ID: 5, DestIDs: []ID{11}, mark: markUnknown},
					{ID: 7, DestIDs: []ID{8, 11}, mark: markUnknown},
					{ID: 8, DestIDs: []ID{9}, mark: markUnknown},
					{ID: 9, DestIDs: []ID{}, mark: markUnknown},
					{ID: 10, DestIDs: []ID{}, mark: markUnknown},
					{ID: 11, DestIDs: []ID{2, 9}, mark: markUnknown},
				},
			},
			want: Graph{
				{ID: 7, DestIDs: []ID{8, 11}, mark: markPermanent},
				{ID: 5, DestIDs: []ID{11}, mark: markPermanent},
				{ID: 11, DestIDs: []ID{2, 9}, mark: markPermanent},
				{ID: 3, DestIDs: []ID{8, 10}, mark: markPermanent},
				{ID: 10, DestIDs: []ID{}, mark: markPermanent},
				{ID: 8, DestIDs: []ID{9}, mark: markPermanent},
				{ID: 9, DestIDs: []ID{}, mark: markPermanent},
				{ID: 2, DestIDs: []ID{}, mark: markPermanent},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			require.EqualValues(t, tt.want, topologicalSort(tt.args.graph))
		})
	}
}
