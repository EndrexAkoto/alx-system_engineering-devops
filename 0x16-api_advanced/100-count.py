#!/usr/bin/python3
"""
100-count
"""
import requests


def count_words(subreddit, word_list, hot_list=[], after=None, word_counts={}):
    if after is None:
        url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    else:
        url = f"https://www.reddit.com/r/{subreddit}/hot.json?after={after}"

    headers = {'User-Agent': 'my_user_agent'}

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        data = response.json()
        if 'data' in data and 'children' in data['data']:
            posts = data['data']['children']
            for post in posts:
                title = post['data']['title']
                hot_list.append(title.lower())

            after = data['data']['after']

            if after is not None:
                return count_words(subreddit, word_list, hot_list, after, word_counts)
        else:
            if len(hot_list) == 0:
                return
    else:
        if len(hot_list) == 0:
            return

    # Count the words in the titles
    for title in hot_list:
        for word in word_list:
            if word.lower() in title:
                if word.lower() not in word_counts:
                    word_counts[word.lower()] = 1
                else:
                    word_counts[word.lower()] += 1

    # Sort and print the word counts
    sorted_word_counts = sorted(word_counts.items(), key=lambda x: (-x[1], x[0]))
    for word, count in sorted_word_counts:
        print(f"{word}: {count}")


if __name__ == '__main':
    import sys

    if len(sys.argv) < 3:
        print("Usage: {} <subreddit> <list of keywords>".format(sys.argv[0]))
        print("Ex: {} programming 'python java javascript'".format(sys.argv[0]))
    else:
        subreddit = sys.argv[1]
        word_list = sys.argv[2:]

        count_words(subreddit, word_list)
