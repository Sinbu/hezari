FROM swiftdocker/swift:latest

RUN mkdir /app
WORKDIR /app

COPY . /app

RUN swiftc main.swift SSCardLibrary.swift -o hezari

CMD ["./hezari"]