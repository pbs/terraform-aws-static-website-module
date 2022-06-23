package test

import "io/ioutil"

func getFileAsString(fileName string) (string, error) {
	content, err := ioutil.ReadFile(fileName)
	if err != nil {
		return "", err
	}

	text := string(content)
	return text, nil
}
