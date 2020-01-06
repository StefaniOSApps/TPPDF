//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF

class ExperimentFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        let table = PDFTable(rows: 50, columns: 4)
        table.widths = [0.1, 0.3, 0.3, 0.3]
        table.margin = 10
        table.padding = 10

        for row in 0..<table.size.rows {
            table[row, 0].content = "\(row)".toPDFTableContent()
            for column in 1..<table.size.columns {
                table[row, column].content = "\(row),\(column)".toPDFTableContent()
            }
        }

        for i in stride(from: 0, to: 48, by: 3) {
            table[i...(i + 2), 1].merge(with: PDFTableCell(content: Array(repeating: "\(i),1", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }
        for i in stride(from: 1, to: 47, by: 3) {
            table[i...(i + 2), 2].merge(with: PDFTableCell(content: Array(repeating: "\(i),2", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }
        for i in stride(from: 2, to: 48, by: 3) {
            table[i...(i + 2), 3].merge(with: PDFTableCell(content: Array(repeating: "\(i),3", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }

        document.add(table: table)

        let singleCellTable = PDFTable(rows: 1, columns: 1)
        singleCellTable[0,0].content = (0...100).map { "\($0)" }
            .joined(separator: "\n")
            .toPDFTableContent()
        document.add(table: singleCellTable)

        return [document]
    }
}
