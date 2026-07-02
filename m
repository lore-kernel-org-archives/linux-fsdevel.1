Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7927081A;
	Thu,  2 Jul 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034256; cv=none; b=prIydl6ykZ8JeLrss9/gs8/6/NVI75lpHkZbGB1Y0Z0Fm275MaCTF1ZXQLsXp7w1UpoPVBu65t0sqQRRran5wXBJ+EFQYIVgyvjDb4S2D4IXALUkcH0vAjmlTTOs00yfGddhQmVdNK6PgduFJbTmOYiwHXOfc9FUw+C5uF29RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034256; c=relaxed/simple;
	bh=cT8AyhY7JWuaZs69LTvoJKmftuQNwK7BMww8UDz+/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkiTTvvdOcMQMEKUT0gwqm4fwgHCl7fctcmyKYBRZ0iy7joBWT38lSiCTMUtQghsgqD7CunumDWTkg9aviUCOzUHDhITaCCRxhqyM4/AvrGjFupqL9/0ujMUweg4jETMmcuFbIrxbS195sesOIbTddcE342oqHoyPQMimuQsoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evTCO1hL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evTCO1hL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6811F000E9;
	Thu,  2 Jul 2026 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783034254;
	bh=hDwam3fmQOD0OndXrrxBHKZfoVPeKMR23BCOLG8w6hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evTCO1hLX2aRSpHCDVxeEu3lPRsE788HbHOAj0nNRze/m7XIir9gM5oMnQCjdB8Yd
	 Twwdy5EdK1K76OEHXdgaWuMnd88mNT3beuzRmgpwraVKgfDOsrwn1HMCOqUpxE8aqB
	 aqwnS1QbR26VwI4aY7+ueVc3wtm3bi9sOJ5bPt31T/gYXC29PWPS1zUwN26mLHYb+8
	 eNABArTSEWMMS1GRLCwFxe5dLVFlHtSnIjL8zbE2CDfg7VcZCK0EAkFb7sjs9e171t
	 pPQgxn2oMpLMeK4VtSTV+DDUeaLmzrOPvEG4SbvG/55q8sNr0U0mw1Vjz3oZzfy0aY
	 GupgEWKS6OGvg==
From: SJ Park <sj@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
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
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Date: Thu,  2 Jul 2026 16:17:29 -0700
Message-ID: <20260702231729.98319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702211740.GA639365@zen.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jul 2026 14:17:40 -0700 Boris Burkov <boris@bur.io> wrote:

> On Thu, Jul 02, 2026 at 05:50:15PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
> > > On Thu, 2026-07-02 at 18:19 +0200, Greg KH wrote:
> > > > On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > > > > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > > > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > > > > We've had this requirement in place in the Documentation for several
> > > > > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > > > > is quite low.
> > > > > > > >
> > > > > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > > > >
> > > > > > > Then let's move to get people to follow it.
> > > > > > >
> > > > > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > > > >
> > > > > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > > > > not reporting that, I can ask for them to properly attribute it and if
> > > > > > > they lie, well, that's on them.
> > > > > > >
> > > > > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > > > >
> > > > > > > We want to know if a LLM is being used.
> > > > > >
> > > > > > But why? What do you intend to do with this information?
> > > > > >
> > > > > > Do you mean to use it as an indicator that the patch should receive
> > > > > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > > > > it to generate some sort of statistics at a later time?
> > > > >
> > > > > I use the information to decide how to review the patch, and what level
> > > > > of priority to give it. For that usage I don't need a tag, but I need
> > > > > the information in some human-readable form at patch submission time.
> > > >
> > > > Same here.  I don't care about stats, I care about "how do I review this
> > > > patch" and this gives me that signal that I need if faced with a
> > > > llm-helped patch.
> > > >
> > > >
> > >
> > > Do we need a tag for this though?
> > >
> > > This seems like the kind of information that we would always require in
> > > the cover letter of a series (or the little place in an individual
> > > patch for comments that don't get merged). That would also allow you to
> > > convey a lot more nuance about how it was used.
> > >
> > > ISTM asking people to disclose LLM usage in a cover letter would give
> > > everyone what they want: Information about whether and possibly how an
> > > LLM was used, and it also wouldn't clutter up the changelogs with these
> > > tags.
> > 
> > It's much much clearer and easier to just have a standardised tag for that.
> > 
> > You can see that (and grep for that) immediately, vague paragraphs not so much.
> > 
> 
> At the risk of being pedantic on a point where I think the document is
> kind of lacking:
> 
> What level of assistance crosses the bar for an "Assisted-by: LLM" tag?
> 
> Some sample levels of assistance to illustrate the point:
> 
> 1. I used an llm to one-shot vibe-code a patch
> 2. I used an llm to write a patch but carefully reviewed every line
> 3. I used an llm to explore the design space for a patch but wrote it
> manually
> 4. I used an llm to debug or reproduce a kernel issue but then wrote the
> fix manually after fully understanding the defect
> 5. I used an llm to review a patch I wrote
> 6. I used an llm to research some chunk of code while writing a patch
> 7. I used Google while writing a patch and learned something valuable
> from the AI overview at the top
> 
> I personally would 100% use the tag for 1 or 2, and have already done
> so. I have not been doing it for 3-5, as I think that will basically
> make every patch llm-assisted to the point of the distinction being
> meaningless. If we should be doing it for 3-5 (or some subset thereof)
> then my mistake and I will certainly start doing so. I would hope most
> people agree 6-7 and similar need no tag.

I think 3-7 don't need the tag.

> 
> Similar questions abound if you use an llm to help with writing the
> English text in the patch or emails.

I think this doesn't need the tag, too.  Like patches, the user should
completely reviewed and understand the text, though.  Without the complete
review, it should not be submmitted at all, regardless of the tag.

> 
> I have a feeling that this ambiguity is part of the reason we aren't all
> agreeing on the value of the tag?

I'm not very sure...  I don't really feel the question is that difficult and
ambiguous to answer.  I may be biased.


Thanks,
SJ

[...]
