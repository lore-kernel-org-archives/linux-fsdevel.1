Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755663F23CF;
	Thu,  2 Jul 2026 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000636; cv=none; b=CDT+2Du7loZiGgkPw3cyQkeHA637X4Ixkhtql6QuVk/JMWuGHRB2xdbMU9FxzCue0AsQK/eSxZdjhCOzDs1WnkDtvX07OZ7zCSUaAp3XM87XjAoAgz5n2ppGjX4AyMTSwu2KEXpoEEL6jhWLISEvqH9lY4cG4HH0jFiohXqlpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000636; c=relaxed/simple;
	bh=L3QtOlq/gwmwSei/jObls2ik9aVi7P89FA668h7o5Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8GcuZX9IVCOG5Z2fKfksmintNcHOrG11QsXkK/AUJU0t+ot5VR99S9ujLIGbEziB23RBKN5J8aUr4h7CKlp1fFos8dqyNAlGmjq8NMx+ttVGQNjL5TQhk+QnwwPWCwhfEWG3BZHIsoFjPN1OJITJZhs9bRusKu+ZKsggh34f0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASInKw60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASInKw60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0E01F000E9;
	Thu,  2 Jul 2026 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783000635;
	bh=L3QtOlq/gwmwSei/jObls2ik9aVi7P89FA668h7o5Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ASInKw60ypiAebpMdsowx/9bur1LFUELoUstVxYbb9rCiZ6/MJsoW8p500L88sxsQ
	 VAq7sseIvrCWA4gaxB306KB5YunDOrG3iWaALmFdVkntSB9WDebmdxo43OekfxaNUj
	 kHm3cUdtf21lGaly0COvXjFr8TS55dnona3+kwa9Hz48SdbM6D8YaDg/TOvCqS3voo
	 Xw4etPGeEbXno728ei7rENmlNQQBUFlF0jXvS8iUjuDn64dWTACukBshf+CLfosmoO
	 aDUHC1lzzWI+0UJRPHMnA0lumzf4jrGgaLrv4jgcHJLRZ24iDn+YzvtbzYB5gkzs0O
	 /Ac8gNrgJrENg==
Date: Thu, 2 Jul 2026 14:57:05 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZqigap0GTOSkyx@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
 <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>

On Thu, Jul 02, 2026 at 03:26:58PM +0200, Christian Brauner wrote:
> On Thu, Jul 02, 2026 at 01:51:10PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/2/26 12:04, Lorenzo Stoakes wrote:
> > > (thanks for the cc-!)
> > >
> > > On Thu, Jul 02, 2026 at 09:46:37AM +0200, David Hildenbrand (Arm) wrote:
> > >> On 7/2/26 09:27, Christian Brauner wrote:
> > >>>
> > >>> I think we should just drop any attribution as a general kernel-wide
> > >>> rule and let subsystems require them as needed. Then you can have all
> > >>> the complexity in mm for this that you think is needed for your
> > >>> workflow to function. This is precisely what the subsystem profiles are
> > >>> for. So maybe just add:
> > >
> > > A single comment is complexity?
> >
> > I think Christian meant more elaborate rules. More than just "If you used LLMs,
> > disclose how you used them."
>
> Yes.
>
> I'm going to follow netdev and start dropping those tags from the
> changelog completely too. After speaking to some bpf maintainers they
> also don't use the tag. So I can safely assume that 3 large subsystems
> don't bother with it.
>
> So seems to me that such requirements should just move into the
> subsystem profiles.
>
> I think as a global policy this has ran its course.

I'm honestly not sure why you sent this patch in the first place if you're
simply going to ignore it (+ people's opinions) anyway :)

Maybe we need a way of figuring out which patches mean something and which don't
(I guess whatever Linus enforces is the real truth of that).

Anyway I guess I'll get back to work, and we can figure out what we'll do in mm
separately I guess.

I'll still send a patch to link the apparently redundant AI doc to the generated
tooling doc because for those who do pay attention it's silly that they're not
connected.

Thanks, Lorenzo
