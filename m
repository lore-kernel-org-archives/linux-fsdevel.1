Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5B2E173D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095169; cv=none; b=dvtj2pk11q5CNcyCYfldQm5DD+z9QmUpHqL2n94D+b5i7To7J+KI1+SVGxYZJ5Uv4OE+qmIQgX9uSz7HruqGWBFlfSkVq2alJmRfAmSgV6kB4/Fb1Q0OezdHFUT+qzVSXBYawcco/fPZZW+EUNxVa1KS39Cj7eGpBuzijjJTnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095169; c=relaxed/simple;
	bh=DDlppR72ZofS0gwf7T++swSGldaFduoIiD3WPtJRbEY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n134BcoHj4TmAcWAvT3+QyJur8B5ikkHxyhqGF8lDbjyVrRXfYfnIelkD/SGJ3bh1l0g41mjBOlN6Lzfn8Ug0VhgSApVM2meZog4QHU5s/Zi+WeoHkYbLbM3Pirnf3o8YKxD8kkh/wmqPQEO4rpPl3zuwpH6ri0bXs6+X7TwDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=S+Oes1Aj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="S+Oes1Aj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3812c718debso580185a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1783095167; x=1783699967; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuYdqZO6P8sYYUQnX9Vmulsb3aoIphpVLP6QakGqXqA=;
        b=S+Oes1Ajap0efry0Bu0qQXu9w1jj2g7qfPWJBpzSsuKaT/q/2ke5vxfs9dt9wfLFS8
         CPt/5W4b4k7wU8qqpDRwQkTZH1EAS1ZROM1f69lKWKazWdOwajOixfQq+lWL4Cmf53Ko
         qZ9fRuG2tsDXbKtDXyRvjZK6mx7fyc/xLVfexT9c+TS1Cn+Pqc6fenniyzFiHzHz7rTK
         TaRvgEGKOhVDEVDD+Rl9In7gVcfFYRaFeeyUydLXmmxLnWR+/eFPyOVqtlFx6um/mpaE
         c7zbDfepqqOXVijMJBXhsBVKaoYJaa5uCXi7yBNNFwMWw/Z1JUgez52KxtkZ6LYzWE6C
         moLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095167; x=1783699967;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuYdqZO6P8sYYUQnX9Vmulsb3aoIphpVLP6QakGqXqA=;
        b=PZ4uB7z4VKkOs8rgwkxA8+rA7vvTEWWy3lZQ/dnWcM5gRqg6eAjYhGys48LPphifKt
         0Dipg2iwTo2dGwWHFzv/fBUY27TtHt039uTr1J4JBYf6mAlreIzYGZFG5WIvvh1mJQoA
         um0KP+JRYHIXOY8rSY0u3ZYYqbK52y9bxcq1oaowT+5fLa6katB1+SpJZi351eV950Xi
         DQQOxrSVgdprVwGbDrlC/z/AQ2qhEmdrwQjoN+WeF9pSAT0+CjGUFSFK0NmxOAvQVakW
         0oG+gp6RtJ/dspZTN8oq86tA2/Pka9mwkKsVaqx/kGCkdy8u4yDHSO2GgnMnIQjrYcMI
         ma9w==
X-Forwarded-Encrypted: i=1; AHgh+RpHFXrLdhu1HVyEEZwlPq9TPAAuFSk0VYHIf+dTZDjHGlxAvWMPTclQaVtfzX7vtz13UoSyGwo15a8h4C6p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67ZiLz2mkVb4g+08MUQLhGE7+Ums7d22hh41Rwm5WeQbe6z8s
	zQrdHIYmvg96nXL1IbeXOWgJqI2k0hUO39je080o/za3+ZlcQcVwgx2KhEfPq7aVsCE=
X-Gm-Gg: AfdE7ckK3v3a4oEEZ5wqED3kmJLShtKYFpkrRgKinCi1DgetIlIlMZhTDCvfDSnSNBy
	eEOmK9JS0G8p4tHeS0m5Y9iGFUeupB9jVWRaqb/jqrMau2byrvc5+1pBwUDHblYbLTxkQFyN0/m
	mSWNwWQoBbaabenj2d+UIvzm5lDiwHcNIzPoyi/vl3aieBpjr2g8rbnDLoTTrTJhhfX+9vAjpVu
	3kJHOZwpJle9pQea6eFePQh80bbeDY+ByWktUNV5CIGmYOAu1A8pyPZG1QBN2DoEAGhfSIxWH6j
	1BJPcPcqXuPF41udCPteuqm6X1vFI/6Iwa02LUcirNbQPWVEOWnf3M9IMy045T95HChojVwg/Hu
	Xqd0iJ/0VJsOHqufIRWJB/gQGMNx3PluK3Yd7PNMyge/lvuVsYUGRxfvhW/6nMnH1zkV7f0VX9a
	bs/QnWMI0QVoP16lKM9a1CJY02vQDk6bqQxH7sxbFwzAWZqXm2l0CrQ9oD3NpOhIQhNQ==
X-Received: by 2002:a17:90b:50:b0:37f:9ce2:348d with SMTP id 98e67ed59e1d1-3829fddab93mr148112a91.30.1783095166730;
        Fri, 03 Jul 2026 09:12:46 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097d81bd9sm3194250a91.1.2026.07.03.09.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2026 09:12:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <akcji3OuxXz3FqSD@mit.edu>
Date: Fri, 3 Jul 2026 10:12:34 -0600
Cc: Jonathan Corbet <corbet@lwn.net>,
 Greg KH <gregkh@linuxfoundation.org>,
 Jeff Layton <jlayton@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Justin Stitt <justinstitt@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Carlos Maiolino <cem@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Brian Foster <bfoster@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 David Disseldorp <ddiss@suse.de>,
 Mark Brown <broonie@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Jens Axboe <axboe@kernel.dk>,
 David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 workflows@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19942440-EB87-4D3E-B37F-3146500BED8C@dilger.ca>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh> <87cxx5l900.fsf@trenco.lwn.net>
 <7C39A5C8-EA03-4C8D-9BE5-5097101B71D6@dilger.ca> <akcji3OuxXz3FqSD@mit.edu>
To: Theodore Tso <tytso@mit.edu>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Jul 2, 2026, at 20:57, Theodore Tso <tytso@mit.edu> wrote:
>=20
> On Thu, Jul 02, 2026 at 12:46:19PM -0500, Andreas Dilger wrote:
>> It would make sense IMHO to address the ignorance in the most =
expedient manner,
>> namely by telling the *LLM itself* to add this tag when it generates =
the commit
>> message and/or reviews the code.
>>=20
>> This could be achieved by adding a statement in "AGENTS.md" in the =
root of the
>> source tree to this effect, or telling the agent to reference and =
follow rules
>> in Documentation/process/coding-assistants.rst regarding the =
Assisted-by: tag.
>=20
> This presupposes a particular workflow where the developer allows the
> LLM to generate git commits.  I don't do that.  I'll ask the LLM to
> modify the code, but then I'll generally fix it up --- very often by
> hand because I can edit the sources than entering a prompt and waiting
> for the LLM to figure out how to make the change.  I'll often run the
> test cases myself, since if it takes 24 hours of VM time, and 2 hours
> of wall clock time, I'm going to kick off the regression tests myself,
> and verify the test results.

Sure, and that holds true for many kernel developers, myself included.
I don't think you or any of the senior maintainers are the audience.

The point of my comment is that this is more likely to help contributors
who do *not* know/follow standard development practices and are more
likely to contribute AI-coded patches, which is AFAICS the main issue
in this discussion.

Also, the effort of doing so is very minimal and has no real downside.
Having the AI contribution policy clearly spelled out where an AI agent
can find it can only have a positive effect, even if not always =
followed.

Cheers, Andreas

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
>=20
> - Ted


Cheers, Andreas





