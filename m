Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF17081A;
	Thu,  2 Jul 2026 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027151; cv=none; b=r0swLnZ+bGz9iRyTIzvOuxq9OIb6IocA3Fx2prGCfFRqvJT9T6Sg+Ztswpxy1e6u7vY+1xdKmCntV87ISc69tUWyL90oUHCl0/BAkwBKgiD9RziIC1fAvxbIuzlJC7vWEC6esDZwZMuBSiSBjUh2r/J1viqptxaE9sGhuVDArZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027151; c=relaxed/simple;
	bh=aqNVV0HCR43fW0eY92WLuQTYh9Su8zsMr5WaEtRuQgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6gOqgrl7S3L+gFugOFpKjWOk8JIwT/bDeIEzrMpjihsnBoGZIaS9rtLb921gM0KFUgtakxHqGNJxls4HXwoN6Jqee2vVa8BNuDkyYt2uz2BF20ZxySYKsUDp/h4Ut0Z09hJpZitngxSkJ534LDCYJokhXKg+odNGH0ZIwVuO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XwmrH1rA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vt1sKQx0; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XwmrH1rA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vt1sKQx0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 52EFF13004F5;
	Thu,  2 Jul 2026 17:19:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 17:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783027148; x=1783034348; bh=qzhRIeK/Ek
	oxd3iE3sNHSfh7hFaqvZqLxYp4BwVTxdU=; b=XwmrH1rAWZgCHH83a1ztriwujh
	dazqGyUt65PIObvAkfZnPWjkiV3A5mFNkn8gQNFu8NxBUeM16WmcMjUwKVs717CA
	9gHSHvDPVnB5yXMhPYWsH5U2qHOe3l9H6/UH74lVADDbc1e3hNaScnLyKOLG2+Mz
	E9xbLjNbnUSVpGxXhtX/MJ2b7w+lIET2Ut6zONx1WunG0BHHgp//mjWRjyjzAkwX
	8MsJ5IHktsAhT4pSg7m3FWAB13oD3ZD5u71h+DLe8Lmo0ovtKActQXm4kGisF7+7
	ch2T+ebVyTOKSvaF1bS3bKRo4BoTwyl+3Fri67ezU1yKgInmX1CgROkGckyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783027148; x=1783034348; bh=qzhRIeK/Ekoxd3iE3sNHSfh7hFaqvZqLxYp
	4BwVTxdU=; b=Vt1sKQx0zje/JOkfjYin0hhT7Pjbpfyglc5u6UzFaTo+vNpOKbJ
	w1MotkBt6OKTbRGgupYu330TaNJatnY1FcTElhikJ9j8FuofJztx65xGI8kirffc
	hwML0iDtKQ26a1V7/jOKyIlHvGBL8UlowoOBarLMlw9emSgKl/tq3LjJfHPulZbo
	04H1hqCbC6zDIAr6teZWLAtjKEQNOfWlSiAPZxAXUsNy0cf8FFUq12UDzYpcXkbk
	eLdK2AH5d6QBFsSu94lyjiOZ/cfwFpwQeQ/rEP4pJzeJ1Re9ia6lTEtCICSkG1Ax
	dpmHAFr9lHr0y6wRV51P41o7EnK8d0jJNag==
X-ME-Sender: <xms:ytVGave9ACG3vKQByx4ju9B-RzsPh0PLMbnVyFTX2LABkl2d8hiR-w>
    <xme:ytVGapIT29fgM3p-jXg9Ry21ZEHZyhVwo3MoMB9oyMT6CAtZArS3hBVirjay8uB1C
    ch4wRUD6MlvnTQmtSFocJbB9BWxhrPQxFKiWcVUopIt4uRUQ54qtKY>
X-ME-Received: <xmr:ytVGahDBMas_Iy0y9bVsMrjhiXguUEjqUkujWjjU5HGpub0yof4AV5FMBZWdEdZz9gDcRhMhoWo_uBwM4OPFK2_sE8M>
X-ME-Proxy-Cause: dmFkZTF1eCpXYCUVd3Pqpr3O9LIGq74CQAvS9RGvDCHwPfDhAaXXsYNtoivpHnlIrFH927
    2YCz5NqVaCZ6DJCus+e7OARXYNVw08yRE+wZgR2V39XVkkq1rpLp+hnY8WfWo6IARh6R7Q
    Y2zk03eMgZolaDci/PPwbISduxT1DbWIcJh4HJeiKFwzwFKjzp6Di3TgOmOjmhoEwvNQiH
    3YJEi4YVqe5M1kfSalcj0sLU7zAITmK7LlDXlHDFi/gukjETu8ljfhMlkdMTxCGI+2MpE2
    4nPyUwDewkCfrv57xonamSAqsUOKx6xXNWZ3a623/BzRH3zaVmWV7viqbLhmQYvyA/LKdE
    1UQquPfYVcg0XA+cI3DhFPYNQVtueJsuWx2tZ+0Sx0hvBa2UBmmlbqUF6ssj5flrKFaOI3
    pniDj/c8kbaXzG7o+I5B5EMvp2kbpzcy/j6U8/g7PUBsd9CpVzujsC4KRIzLDQgQoUNHgg
    VZS0jB30TRonPHBC2uP94GC2ZyCJTPaBiETnup6K/prikj/9I+jZ5KKHlDrQN6BHsoIddq
    N3ECyp/s1HNo8TDoTXCZYCm3v7XmJrCC2FHpmMTNdG86WcF1Rt091v33IO4pKuYXAs0cSh
    VmlmTX3bQMqqvt4YzYTMwKe6ZtR/uLqMUVPSUO4pprM5jtC8pY3hiyz4iQaw
X-ME-Proxy: <xmx:ytVGaqikP-QUwukweJPCSDUI-5aStrfhOecjooA2rq8ReUEjXRrgnA>
    <xmx:ytVGajNesKaA_yfx3Ra5gEvwFXLRspmEtiVpjMeYICMSPzVl8Bi7qw>
    <xmx:ytVGapb_Bn7UUl_gP6Ilfll8QDCCNA1jy9tvGVJ3sit9hyQf5F5zEA>
    <xmx:ytVGag-91PTcxVDTssZEvmqDaPwm1TQN1hWNSxo2lFR9QLKMkVas8A>
    <xmx:zNVGaqqGpib5b2Xu6sm3xTMjPhVHbLq25vNwhwJVfBIpnOFVSMV3Sm8g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 17:19:06 -0400 (EDT)
Date: Thu, 2 Jul 2026 14:17:40 -0700
From: Boris Burkov <boris@bur.io>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
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
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <20260702211740.GA639365@zen.localdomain>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akaWnQ5Pkg_676B-@lucifer>

On Thu, Jul 02, 2026 at 05:50:15PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
> > On Thu, 2026-07-02 at 18:19 +0200, Greg KH wrote:
> > > On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > > > We've had this requirement in place in the Documentation for several
> > > > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > > > is quite low.
> > > > > > >
> > > > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > > >
> > > > > > Then let's move to get people to follow it.
> > > > > >
> > > > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > > >
> > > > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > > > not reporting that, I can ask for them to properly attribute it and if
> > > > > > they lie, well, that's on them.
> > > > > >
> > > > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > > >
> > > > > > We want to know if a LLM is being used.
> > > > >
> > > > > But why? What do you intend to do with this information?
> > > > >
> > > > > Do you mean to use it as an indicator that the patch should receive
> > > > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > > > it to generate some sort of statistics at a later time?
> > > >
> > > > I use the information to decide how to review the patch, and what level
> > > > of priority to give it. For that usage I don't need a tag, but I need
> > > > the information in some human-readable form at patch submission time.
> > >
> > > Same here.  I don't care about stats, I care about "how do I review this
> > > patch" and this gives me that signal that I need if faced with a
> > > llm-helped patch.
> > >
> > >
> >
> > Do we need a tag for this though?
> >
> > This seems like the kind of information that we would always require in
> > the cover letter of a series (or the little place in an individual
> > patch for comments that don't get merged). That would also allow you to
> > convey a lot more nuance about how it was used.
> >
> > ISTM asking people to disclose LLM usage in a cover letter would give
> > everyone what they want: Information about whether and possibly how an
> > LLM was used, and it also wouldn't clutter up the changelogs with these
> > tags.
> 
> It's much much clearer and easier to just have a standardised tag for that.
> 
> You can see that (and grep for that) immediately, vague paragraphs not so much.
> 

At the risk of being pedantic on a point where I think the document is
kind of lacking:

What level of assistance crosses the bar for an "Assisted-by: LLM" tag?

Some sample levels of assistance to illustrate the point:

1. I used an llm to one-shot vibe-code a patch
2. I used an llm to write a patch but carefully reviewed every line
3. I used an llm to explore the design space for a patch but wrote it
manually
4. I used an llm to debug or reproduce a kernel issue but then wrote the
fix manually after fully understanding the defect
5. I used an llm to review a patch I wrote
6. I used an llm to research some chunk of code while writing a patch
7. I used Google while writing a patch and learned something valuable
from the AI overview at the top

I personally would 100% use the tag for 1 or 2, and have already done
so. I have not been doing it for 3-5, as I think that will basically
make every patch llm-assisted to the point of the distinction being
meaningless. If we should be doing it for 3-5 (or some subset thereof)
then my mistake and I will certainly start doing so. I would hope most
people agree 6-7 and similar need no tag.

Similar questions abound if you use an llm to help with writing the
English text in the patch or emails.

I have a feeling that this ambiguity is part of the reason we aren't all
agreeing on the value of the tag?

Thanks,
Boris

> > --
> > Jeff Layton <jlayton@kernel.org>
> 
> Thanks, Lroenzo
