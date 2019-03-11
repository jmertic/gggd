#!/usr/bin/python
from email.utils import parsedate
import mailbox
import sys

mbox_name = './'+sys.argv[1]+'.mbox'

def extract_date(email):
    date = email.get('Date')
    return parsedate(date)

the_mailbox = mailbox.mbox(mbox_name) # Replace with the actual .mbox name
sorted_mails = sorted(the_mailbox, key=extract_date)
the_mailbox.update(enumerate(sorted_mails))
the_mailbox.flush()
