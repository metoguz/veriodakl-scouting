hyperlink <- c(
  "function(data, type, row){",
  " if(type === 'display'){",
  # row[0]: 1. degiskende URL oldugunu soyler. URL degiskeni neredeyse indeksi ona gore ayarlamak lazim
  "  var a = '<a href=\"' + row[2] + '\">' + data + '</a>';",
  "  return a;",
  " } else {",
  "  return data;",
  " }",
  "}"
)