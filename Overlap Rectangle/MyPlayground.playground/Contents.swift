//: Playground - noun: a place where people can play

let r1 = [ (10,10), (10,40), (40,10), (40,40) ]
let r2 = [ (30,30), (30,50), (50,30), (50,50) ]

let max_x_r1 = r1.map { $0.0 }.max()!
let min_x_r1 = r1.map { $0.0 }.min()!
let max_y_r1 = r1.map { $0.1 }.max()!
let min_y_r1 = r1.map { $0.1 }.min()!

let max_x_r2 = r2.map { $0.0 }.max()!
let min_x_r2 = r2.map { $0.0 }.min()!
let max_y_r2 = r2.map { $0.1 }.max()!
let min_y_r2 = r2.map { $0.1 }.min()!

let area_r1 = (max_x_r1-min_x_r1) * (max_y_r1 - min_y_r1)
let area_r2 = (max_x_r2-min_x_r2) * (max_y_r2 - min_y_r2)

let interW = min( max_x_r1, max_x_r2 ) - max( min_x_r1, min_x_r2 )
let interH = min( max_y_r1, max_y_r2 ) - max( min_y_r1, min_x_r2 )
print( "the area is \(area_r1+area_r2-interH*interW)")





