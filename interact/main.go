package main

// https://gist.github.com/jamesrr39/c45a1aff4d3fd9dc2949
import (
	"bufio"
	"bytes"
	"io"
	"log"
	"os"
	"os/exec"
	"strings"
	"time"
)

type domains struct {
	domain string
	key    string
}

func waitPropagation(propagation chan bool) {
	log.Println("Wait for propagation")
	time.Sleep(1 * time.Second)
	propagation <- true
}

func parseTopic(topic string) (domains, error) {
	keyName := ""
	keyValue := ""
	for i, item := range strings.Split(topic, "\n") {
		if i == 3 {
			keyName = strings.Split(item, " ")[0]
		}
		if i == 5 {
			keyValue = strings.Split(item, " ")[0]
		}
	}
	return domains{keyName, keyValue}, nil
}

func callLestencrypt(domains []string) {
	cmd := exec.Command("./subprocess.sh")
	cmd.Stderr = os.Stderr
	stdin, err := cmd.StdinPipe()
	if nil != err {
		log.Fatalf("Error obtaining stdin: %s", err.Error())
	}
	stdout, err := cmd.StdoutPipe()
	if nil != err {
		log.Fatalf("Error obtaining stdout: %s", err.Error())
	}
	reader := bufio.NewReader(stdout)
	// wait for propagation
	propagation := make(chan bool)
	go waitPropagation(propagation)
	// Parse stdout
	go func(reader io.Reader, topics int) {
		parced := 0
		defer stdin.Close()
		var newBuf []byte
		scanner := bufio.NewScanner(reader)
		scanner.Split(bufio.ScanBytes)
		for scanner.Scan() {
			txt := scanner.Bytes()
			newBuf = append(newBuf, txt[0])
			// Header
			if bytes.Contains(newBuf, []byte("(Y)es/(N)o:")) {
				newBuf = []byte{}
				io.WriteString(stdin, "Y\n")
			}
			// Topic
			if bytes.Contains(newBuf, []byte("Press Enter to Continue")) {
				parced++
				dom, err := parseTopic(string(newBuf))
				if err == nil {
					log.Println(dom)
				}
				if parced >= topics {
					<-propagation
				}
				newBuf = []byte{}
				io.WriteString(stdin, "\n")
			}
		}
	}(reader, len(domains))
	// Wait
	if err := cmd.Start(); nil != err {
		log.Fatalf("Error starting program: %s, %s", cmd.Path, err.Error())
	}
	cmd.Wait()
}

func main() {
	domains := []string{
		"example.com",
		"console.example.com",
		"metrics.example.com",
		"logs.example.com",
		"node.example.com",
	}
	callLestencrypt(domains)
}
