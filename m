Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675C3C943C;
	Fri, 10 Apr 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829025; cv=none; b=IRqn06n8f737QS1v4ckvOi+5sGkUvHVShUhMA+x2GWOZM/PBiTHrLUB9/DJU8NWKl/WFGJr/bmoufmsV29yWWAhXgDz+S6EsqsZTyOweHkviyaaHCNJbjDvtBnAk06yDyuIXMSyPkU3ttXqKj92xUttufl7WtwRRKyTWgEmMRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829025; c=relaxed/simple;
	bh=39NAX6pobMDiRW03bJAv0Hw/rcf7l7+Va+PozAyLXsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlNHz+oMdh/gBnCR8iQH+zAXGfobayEU1u99s831Gi5O8ep4P6BXJA7jYlUB2E9JGNXB39cU9fx2HlrYqhdmFZIuXgC+YiLS2SBMnTIHg+JZDN44jzKB2gus/KaKA9oEmSnhYMqL5MmmWD3G0avW3tNK2tC/Tm5csDmgf2h8SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPqER8zB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPqER8zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53559C19425;
	Fri, 10 Apr 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829025;
	bh=39NAX6pobMDiRW03bJAv0Hw/rcf7l7+Va+PozAyLXsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPqER8zBALj1mdN+bTW+ENjK3Iz9tCxXSiON1IrcWMBqckqHOkL8gmJsZHFDpoSn3
	 fNnkNhnuM8YALPABGCBGy1pGA3Enr10HET+x/Id1HYgTr9mx/LOETSJmhxv0gYAGug
	 uUPS20jrknJe95xMg9xHnK4DfOg6cHnr4oAgLSJPSYAxGvd1jsK7ROVuYyMsTxCE/v
	 cVyf89R3C32BrRXnmutnmp/+5Z35DNV3USKJol8er2b/ZJcfGJ+QIngV6CVQWKmw+e
	 1glwA8bGhawBmt7WXCthBv4XrTFKn8hGxRGo7w4aCbqGZJsaZOcatLYCgiHmhrWemJ
	 HT08plIvK5jhA==
Date: Fri, 10 Apr 2026 14:50:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, willy@infradead.org, ryan.roberts@arm.com, 
	linux-mm@kvack.org, r@hev.cc, jack@suse.cz, ajd@linux.ibm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org, 
	catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com, 
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, 
	Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, 
	shakeel.butt@linux.dev, leitao@debian.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Message-ID: <adj_SXXEwyi3bxum@lucifer>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
 <adjkCOiLgZ_-zovg@lucifer>
 <adjllNan2vgBNBHJ@lucifer>
 <5f99b289-629c-47c4-bef0-966d6678a2a8@linux.dev>
 <adjrKwgiZwXR9epk@lucifer>
 <40f31e5a-7161-4b17-af03-52b3a28a113e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f31e5a-7161-4b17-af03-52b3a28a113e@kernel.org>

On Fri, Apr 10, 2026 at 03:29:12PM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/10/26 14:24, Lorenzo Stoakes wrote:
> > On Fri, Apr 10, 2026 at 01:19:08PM +0100, Usama Arif wrote:
> >> >> Thanks, Lorenzo
> >> >
> >> > (Note that we're in a 'quiet period' from here until -rc1 of next cycle and
> >> > won't be taking anything new until then. We plan to do this from around rc5 or
> >> > rc6 of each cycle in future).
> >>
> >> Thanks! Just wanted to check, as I am always confused about this. Is it ok
> >> to send patches for review for next release at this time? So that they
> >> are in a good state when rc1 comes. I wanted to send PMD swap entries
> >> for review after I am finished testing, but I want them for review for
> >> next release.
> >
> > I think different people have different views on that :)
> >
> > I mean it's debateable whether having a glut of new material on day one of -rc1
> > is preferable to having a bunch come in that might or might not get lost along
> > the way :)
> >
> > I personally feel it'd be better to send during the cycle window rather than
> > before but I suspect others disagree with that!
> >
> > So from your point of view, feel free to do what you like, but maybe David +
> > others would want to chime in with their opinions?
>
> For me the more important part of the quiet period is that patches can't be
> merged, so there's less urgency to review them immediately. So I think it's
> fine to still send patches, but not having expectations about quick
> response, as people might be taking time off.
>
> On the other hand it would be better if new series could mature in this
> quiet period, so there would be less work after rc1. But the key to making
> that possible I think is to feel less urgency/being overwhelmed also in the
> non-quiet period (rc1-rc5/6). Then it's should be less necessary to take
> time off during the quiet period. So hopefully we'll get there through
> involving more reviewers, and by having more submaintainers agency.

Yeah I sympathise with that.

But until we for-sure have <you know what :))> signoff, I worry about the risk
of series 'just being taken' at -rc1 because it maybe seems easier to do that,
and then we have a series from 5 weeks ago you forgot about suddenly crop up.

So I guess the more nuanced take I have is:

Once we have a robust set up end-to-end _that can handle_ having series that are
deferred to next cycle without risk of things getting mixed up - then that makes
sense, yes.

But while there's still a bit of uncertainty around that, then I'd rather not.

But I think if people DO just resend their stuff in -rc1 then we're OK and it
addresses my concerns.

One thing we could do here is to tag series appropriately like:

[PATCH v7.2] 00/42

To make it clear where it's intended to head to.

P.S. Having the 'quiet period' REALLY REALLY helps. So thanks for that Andrew!

>
> Vlastimil

Thanks, Lorenzo
