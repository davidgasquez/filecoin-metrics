import * as Plot from "npm:@observablehq/plot";

export function linePlot(width, data, x, y, yLabel, title, interval = "day") {
    return Plot.plot({
        title: title,
        x: { label: "Date" },
        y: { label: yLabel, grid: true },
        width: width,
        marks: [
            Plot.ruleY([0]),
            Plot.lineY(
                data, {
                x: x,
                y: y,
                interval: interval,
                stroke: "var(--theme-foreground-focus)",
                tip: true,
                curve: "basis",
            }
            )
        ]
    })
}
