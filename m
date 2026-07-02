Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6184ADD99;
	Thu,  2 Jul 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000042; cv=none; b=DgV/wntGmgl3Y/sSGDU0oM7NatzX6maUQGOE0/GW++FUjWyj7vIrtndR0XewIWlcOmCT4WuDXmXTW+pLk/+PlVvJnsn1iZyt00YTywRS/yetgBH6bG3G+oaFKMs700+8WayhBmKIrDLVGQO1RzQUTQ2Ts5zWRMUis76MRSiRR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000042; c=relaxed/simple;
	bh=n09cj7cPx8KQUIL6g1a+zXbPFn2KMr5i+2BwmtPK2/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXD6Cy/ZZx3qIjigdK8C81yW2/5VhfI744iUJRF8KFJxtBow0Ua9pJ0QqzmVFsiLY+xTnKRVwDw+UkLeHFi3EX4O04pp4CnMa19dGIq3ob4J+lW2MpX+8eWkvXTJvp53un8SL4W/oiTwe+bJf4JWksA4oF9Rj/Hoo5ZVV1KXotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lfLrGJDD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lfLrGJDD"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15D483A2;
	Thu,  2 Jul 2026 15:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782999994;
	bh=n09cj7cPx8KQUIL6g1a+zXbPFn2KMr5i+2BwmtPK2/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfLrGJDDhKKwccuDURGjslmu4ZE2MMHlP4PYbtMCv1+MaUulL8VCgQu0PjYaTYbAB
	 ImyRnazFsgaF/X+UZzp/WRLwSeysKp9mdpesf/QZF2/nkPQbWgVBF++HYiOS1zrrph
	 KKyJNS+yZ9kSpwoU5GDAiw6gUYQtF2GhapzTd8og=
Date: Thu, 2 Jul 2026 16:47:18 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702134718.GF3534761@killaraus.ideasonboard.com>
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
Content-Type: text/plain; charset=utf-8
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
> 
> > > And is it really that egregious to include a tag? You can ignore it if you don't
> > > care.
> > 
> > I hate the current tags as they are. The question I am asking myself: assume we
> > stop using the Assisted-by for LLM stuff. What to do with the other tools? Why
> > are LLMs suddenly no longer a tool to mention there.
> 
> Tbh, I think that's equally pointless. There are also very few instances
> of non-AI attribution with Assisted-by.
> 
> If the tool mattered to what was done significantly then it should just
> be disclosed in an appropriate paragraph in the commit message. The tag
> itself is imho equally useless for this. I really don't need to know
> that you used grep or git-sed or tcpdump and it certainly doesn't need
> to spam the trailers.

We've dealt with coccinelle-generated code changes for ages without
Assisted-by tags and without any issue. Submitters typically include the
semantic patch in the commit message, or just mentioned coccinelle was
used. I personally feel that the apparent generic scope of the
Assisted-by trailer tag, and the fact that this is documented in a file
named generated-content.rst, is an attempt to pretend generative AI is
"just another tool" comparable to coccinelle or checkpatch.

-- 
Regards,

Laurent Pinchart
