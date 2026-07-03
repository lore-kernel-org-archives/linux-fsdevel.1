Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1043CAA57
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079437; cv=none; b=kqKMkXtgU1LMTASuv7uv/U/Mnsny7uleSzeJ7dq1/JudUPzVmROdkLqB+xGPMLn8F4mMCsJnN0n/zh1oAKPTYCTaWgRdnROVhIc9aIQoEzmjUao+P2W3Tel/FlU6JXBu/0aQK/6rlL2XX3kbItDcxd30vfJ2EsK5U/RwJ5/jp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079437; c=relaxed/simple;
	bh=Q/6dlt78NaEXeED6i3DLDaGFD9U6vLH2J96PCO9F388=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tXbPJO7rKEHk/lA81LLcpXGZUo1nhtSp+QPdjVFDsQvvS8LHkNuZacwG77aizBOR2JINXYlxMIDBqCaF69ILt9SUqjANJmu6paSwhPYgYFpUJekguLwxkEo4mk4XhYD/BBq4ma3Se4MNp4hnK2d4pbm8lfSpBUP4XgQxD1c8tR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=X3Oj5Iro; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="X3Oj5Iro"
X-KPN-MessageId: 661a3516-76d5-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 661a3516-76d5-11f1-a59f-005056994fde;
	Fri, 03 Jul 2026 13:50:33 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 6618dfba-76d5-11f1-ae68-0050569981f5;
	Fri, 03 Jul 2026 13:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=zYAPAZo9AEw6S98ZXl5oEdhdn2uVZwRn94QHg/qLykQ=;
	b=X3Oj5IroZIg4l2MNnL0Z6/Ww+eSkhLwciX9tjHunWELf4fQGKkndKccVjiL30hlnPmZfHjYPS9Scj
	 ck+fnWmPSOFFl4rbHwSTWUrZC5uBo3Ozs8uHk0pVtaKdft2hL+Ebk2/TeBqoFp++3m9Ca31ciNNti4
	 N3UCBXHdRfmdAfDe7Z+SuManGDV8QEcREYAhEccBAW30eXVYgpqBNLHTg+cakO6EzqJH6hqUdQEpuS
	 J80KnGCbc4eFk8eXpDLTlbRebQ0EBDWLmgaSTe+1MkmNcj9KQnoJijzN0CCNrM7pVknrZ0nWGTzuHy
	 wKDbo8XicdARNzTmhNJMzlT4e7W3tVQ==
X-KPN-MID: 33|i6gomIxEawBeKoBLoEbNigVfC++/JFbje3EEQP7ShatBd2mrn3JS6+tekYQ/YBP
 JpgPQT9qdAv5k52lBpPxXBkZLdrV5yZEvYH4lIhChBZY=
X-CMASSUN: 33|FTtagk2aGYIBwh6+n4RmkU5m6qpRgMd19lFNEQDGRwQbeb/YbQTqdiIy6YiV6B9
 PQeLYubTlYiRwOIrt93/3Qw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 660ad342-76d5-11f1-916a-005056995d6c;
	Fri, 03 Jul 2026 13:50:33 +0200 (CEST)
Date: Fri, 3 Jul 2026 13:50:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>
Cc: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <692060611.3935473.1783079433726@kpc.webmail.kpnmail.nl>
In-Reply-To: <akcji3OuxXz3FqSD@mit.edu>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh> <87cxx5l900.fsf@trenco.lwn.net>
 <7C39A5C8-EA03-4C8D-9BE5-5097101B71D6@dilger.ca> <akcji3OuxXz3FqSD@mit.edu>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 03-07-2026 04:57 CEST schreef Theodore Tso <tytso@mit.edu>:
> 
>  
> On Thu, Jul 02, 2026 at 12:46:19PM -0500, Andreas Dilger wrote:
> > It would make sense IMHO to address the ignorance in the most expedient manner,
> > namely by telling the *LLM itself* to add this tag when it generates the commit
> > message and/or reviews the code.
> > 
> > This could be achieved by adding a statement in "AGENTS.md" in the root of the
> > source tree to this effect, or telling the agent to reference and follow rules
> > in Documentation/process/coding-assistants.rst regarding the Assisted-by: tag.
> 
> This presupposes a particular workflow where the developer allows the
> LLM to generate git commits.  I don't do that.  I'll ask the LLM to
> modify the code, but then I'll generally fix it up --- very often by
> hand because I can edit the sources than entering a prompt and waiting
> for the LLM to figure out how to make the change.  I'll often run the
> test cases myself, since if it takes 24 hours of VM time, and 2 hours
> of wall clock time, I'm going to kick off the regression tests myself,
> and verify the test results.
> 
> And I almost always write the commit description myself.  So when I
> say, "Assisted-by" it literally is "Assisted by".  It is not "vibe
> coded where the LLM generates thousands of lines of code that the
> human being doesn't understand before sending ta pull request."  And
> that's probably why you'll see people asserting that LLM generated
> code can't possibly be accepted due to copyright reasons.  There's a
> big difference between asking an LLM to modify already existing code
> to add a feature, or to fix a bug, and to vibe code a new OS from
> scratch.  One is far less likely to be a copyright violation than the
> other.
> 
> 						- Ted

Just curious if you know about any quantifiable insight into this. I do know
that the issues also plays up in smaller requests. I once asked an LLM to
give me boilerplate for a FUSE fs, and it took almost verbatim the example
hello.c from the repo (which I only recognized because I had looked at that code)
but stripped the copyright info. And this is only like 100 lines of code or so.

Best,
Jori.
