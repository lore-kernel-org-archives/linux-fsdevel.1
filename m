Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D047DD7A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983380; cv=none; b=ali5Wis19m4IsF8aQkYfTD658fRhlVZioiPLwl9CMmi1cigwkGMXXSZ3uDqEe675C1GCBhF0viAvIGepvIJpF271wd9kNMTUyXk4dcILqOQiPMT4ea3drnhLFOZ4Q11DeQkXDynSyJmiRBNF6kfuB/T8RKMG0qUTNMmKDeQTTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983380; c=relaxed/simple;
	bh=X4lWb4Zgyq9kDtHYjOqT/HcpzyRjjLI0DNIX1c5jUaM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IqImIRHxjO3yIjapvHo/BkhmjDGOfp+xFeNFSaYRktfFKljtz+irKkiY4sxsAWwo/KfwUqy8Tj40I4w6IYliAQltb76AAdyA3WyWQA0EOBKnXRAzoZfZZLCYAUDw+juvWFAuzLTkbmYR9Xjj30+GFBuogwYgmNEN/cvah6lVC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZEiDPTGN; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZEiDPTGN"
X-KPN-MessageId: bff4b762-75f5-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bff4b762-75f5-11f1-9e8e-005056999439;
	Thu, 02 Jul 2026 11:09:37 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id bff2e651-75f5-11f1-91b1-00505699891e;
	Thu, 02 Jul 2026 11:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=PqYWlkDcCBR62HicUulD+ZvvBxbrhHpWKTkTuPcmOVk=;
	b=ZEiDPTGNBOsEJe7MBRiZA+HoZfQoCwumR1bRMcSFV5e9HqtGX/AvhvfHYteM5cMrTBkGUKpL+yN63
	 4KuIx7VOlkYtRDupf3JnPqFpzA2x9PbhcodHS8OYX9WbobOI+rJl0ZU/Dsex1PqFnQ+sPxHn7Da9ZM
	 zstxb371hUTwEpUOUun9fryUYtOkWO5iusVSXdi1KlEbSUrKXZsiBeAqdI3L7c5WYrb3TQvreaF/5L
	 NVaR4sFh1jnQYgVbWA5xjXLOJ9yjShdLbhjGw5lBYtWjDhu+bp6JU+Yh/cVAFlA1jnRtKcaW3rZSuB
	 2P0rGauZpugbjh6TmrbjqNb7DNqbfGg==
X-KPN-MID: 33|A06hq9/OspSCblDEB2XsEAaS5PUjMJ/PvGk4O1z0S/ckLTliPawVDjQhJtQvp7M
 bC1I6m8Et6gUXIjvcKmMYL13UY3qYJ2f+ajB4taehJ64=
X-CMASSUN: 33|xV5+ZKyjGAqrRMlg92btei7Fl/lSCjGxTWwji/cF8+tpZaRdc5GIqoJHUqUCdfC
 j3Qw633Ao3CXiKU7+omMp5A==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id bfe2ba4c-75f5-11f1-916a-005056995d6c;
	Thu, 02 Jul 2026 11:09:37 +0200 (CEST)
Date: Thu, 2 Jul 2026 11:09:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
Message-ID: <1468431527.3731104.1782983377190@kpc.webmail.kpnmail.nl>
In-Reply-To: <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
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


> Op 02-07-2026 10:44 CEST schreef Vlastimil Babka (SUSE) <vbabka@kernel.org>:
> 
>  
> On 7/2/26 10:12, Jori Koolstra wrote:
> > Ah, I still reigniting this discussion again :)
> > 
> > What about a combination of what David and Jeff say? The whole point
> > seems to me that the salient information is not that an LLM was used (or
> > are we going to tag Sashiko as well or any other LLM-based code review
> > tool?), but what is was used to do. This information may be relevant for
> > how the review is approached. The latter should perhaps only be in the
> > cover letter and then we can drop the assisted-by tags altogether.
> > 
> > The question about enforcement remains.
> 
> It's not possible to enforce it. People can deny it if the tag is missing
> and you confront them and even though the submission has many signs of being
> obviously LLM, there is no definite proof. We've seen (likely, as there's no
> proof!) that happen in mm.
> 

Maintainers should be free to ignore what they perceive as slop without needing
to defend that call. Reputation can be gained by submitting useful work or
being present in the community, attending conferences, giving talks, etc.
I am not saying that we should be harsh on beginning contributors (or I would
have to count myself out as well), but they should be as free as possible to
only invest their time in the project and people that may become involved in the
community. And that call is up to them.

I try to review fix-up patches of first-time contributors, but if it reeks of
AI I don't bother. We have the same policy in the kernel mentorship program,
we invest time to help people get involved with the community and kernel, not
to let someone strike "kernel contributor" of their list. The whole point is
not that most of this clean-up work is super useful (and indeed an LLM can do it),
but to let someone feel excited about contributing and maybe getting them to
to stick around.

> Such situation then penalizes those who disclose so obviously they won't. We
> should drop the tag and instead think how we can empower maintainers to be
> able to use their own judgment and deprioritize dealing with what they
> perceive as LLM slop, without fearing consequences of not being properly
> responsible etc, and not rely on any non-enforceable tags for that.
