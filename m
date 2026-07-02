Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CF48124A;
	Thu,  2 Jul 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985187; cv=none; b=qte26H5/tJlUdjWW/KCgDibi+MVXIosJNMmGBz6FVSywaiI3dMAb9bd2F6cLTrVmHzoQ+0i1FegarKflHD9SQGwKikNPmUpRvy9r21AkwuPZFp1MmIX6jbvOdaZy5Ozm3N7S377YQL9ex0dI7izWHjIWrwXUv3KZZtkLyKxdis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985187; c=relaxed/simple;
	bh=Qo30EqWrxVCrRg0xcaCObbpmEEqIF+sHKR0pH6GBq6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/kplg6ERFbErwBKiOkrJyZlVHGGVJezgzrgveCuWPN7kdmtF86Av8a9JDdWXlXlH6hIQ6SyZ0B0yZNBeV6AhIFl7G6fQFImrd2/rT90nby34z8ifRN6HAKVluUI+DQNTniYpX0CwPmIJrjyPXWfmT2HkEto7fwUqZVOUCGskb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZRJuKCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZRJuKCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324681F000E9;
	Thu,  2 Jul 2026 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985186;
	bh=Qo30EqWrxVCrRg0xcaCObbpmEEqIF+sHKR0pH6GBq6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZRJuKCSmZkcnyGB+1Sg/LTcY100vTyBFQgFrO3zLuwj1f73EiOd8xc9vTh0lgoet
	 u3mTY8TVyYOuNiGnK1QnknUXNW9sjIygqrEkwxAn9xMb90IsfSAyTco7vgr6fL0FFH
	 duAKW9EPxy+sKlvW7q+wSZwylY8X6L9pmt5DYym3PW1NWVZ+CDRNdC94Mt+C+FfcMR
	 U4ONb9+lRVDx4a+EDOovjqJPv7ddvv7Esez2gs/EhcH4FYrrV2c0h66HuVVCdSTg8F
	 HQDB6lPFrU/PU5/0Ve7vB0CvURBR/KQPsOYx5Sqs513l4xCkQoWOrBN+Eq22nGLiZ2
	 1V6k/7xCPGtUQ==
Date: Thu, 2 Jul 2026 10:39:36 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYxcpIbVA2w4gzl@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <1468431527.3731104.1782983377190@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468431527.3731104.1782983377190@kpc.webmail.kpnmail.nl>

On Thu, Jul 02, 2026 at 11:09:37AM +0200, Jori Koolstra wrote:
>
> > Op 02-07-2026 10:44 CEST schreef Vlastimil Babka (SUSE) <vbabka@kernel.org>:
> >
> >
> > On 7/2/26 10:12, Jori Koolstra wrote:
> > > Ah, I still reigniting this discussion again :)
> > >
> > > What about a combination of what David and Jeff say? The whole point
> > > seems to me that the salient information is not that an LLM was used (or
> > > are we going to tag Sashiko as well or any other LLM-based code review
> > > tool?), but what is was used to do. This information may be relevant for
> > > how the review is approached. The latter should perhaps only be in the
> > > cover letter and then we can drop the assisted-by tags altogether.
> > >
> > > The question about enforcement remains.
> >
> > It's not possible to enforce it. People can deny it if the tag is missing
> > and you confront them and even though the submission has many signs of being
> > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > proof!) that happen in mm.
> >
>
> Maintainers should be free to ignore what they perceive as slop without needing
> to defend that call. Reputation can be gained by submitting useful work or
> being present in the community, attending conferences, giving talks, etc.
> I am not saying that we should be harsh on beginning contributors (or I would
> have to count myself out as well), but they should be as free as possible to
> only invest their time in the project and people that may become involved in the
> community. And that call is up to them.

Yup agreed, however I have had the experience of doing exactly this and then
being second-guessed enormously, which was exhausting honestly.

So we need total clarity that it's OK to do this.

I guess this is partly a subsystem-by-subsystem thing though.

>
> I try to review fix-up patches of first-time contributors, but if it reeks of
> AI I don't bother. We have the same policy in the kernel mentorship program,
> we invest time to help people get involved with the community and kernel, not
> to let someone strike "kernel contributor" of their list. The whole point is
> not that most of this clean-up work is super useful (and indeed an LLM can do it),
> but to let someone feel excited about contributing and maybe getting them to
> to stick around.

Yup agreed :)

>
> > Such situation then penalizes those who disclose so obviously they won't. We
> > should drop the tag and instead think how we can empower maintainers to be
> > able to use their own judgment and deprioritize dealing with what they
> > perceive as LLM slop, without fearing consequences of not being properly
> > responsible etc, and not rely on any non-enforceable tags for that.

Thanks, Lorenzo
