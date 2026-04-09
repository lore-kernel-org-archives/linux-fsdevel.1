Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD617745
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753331; cv=none; b=Mts4EiCVSSebymF7th5uTcLmCSM9G+FRo/zrQeztctwnOKh2LnprW4hK2QEZRy3NnYsUswllGf4jP+wwx8hlXiJ8SHfLRz4wMyTNpmqMcyRWQo44OQ7JG0mXu/WKbTFLcxGRX6bte5/vf7eQs1U6z/qAs4riFoDaSROQP0fyMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753331; c=relaxed/simple;
	bh=xyjCTVRn3juQWJ45+e0XD4CrI8qBUG65MBG2rC/VppQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUwJEhA9oXYCP+HtKvhz4N6f4yggtHvKFebD+F1finXIy87ocAwcfVFNV+HqaZNgxfkQXb5WubLaFPH3Gm5jiaLS8sPV0QT1txZCT8ZCf8WVD+2NFVY/IuAsJZPHshymDhsYNvZP/xQCzDtw47CNlhMY2lAAnPNQR0hgq/1XRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JBa2iyPy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jFdnhQ0j; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JBa2iyPy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jFdnhQ0j"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 179837A00DE;
	Thu,  9 Apr 2026 12:48:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 09 Apr 2026 12:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775753327;
	 x=1775839727; bh=d3IP8RghDZznaGjEmBTDPbOMMDpuWMs623Nter0+ozU=; b=
	JBa2iyPyBSx865Vm57yQ9EewtxMcG+eG7Jgc9CSUH8jaIINA093WZQry+7gh2yl+
	aNz9zY/SRV79rLLr+1mmE68CBMOyouIrKLQia8AEuNk0TMnwPihLwDa6ihvyPCb/
	jKiYLcCuQr3aWV9qVfOaaJEseShsB9YcdNfafnHicgJNxjfgiFkPNi29yQNBQNQv
	Djofhw4vcCmKrSK/kFRJjzvpX6zxmTpzl7DVKJFyfVcxoFbnx6xzZQroFOCbRMaD
	thvra328CsJNvF/RTxouILIt+rIJquR/A0PPk6WYWjedpUMFRDplK4iz8+QzwbcE
	EG+2UQukTp62CjhEyqZCng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775753327; x=
	1775839727; bh=d3IP8RghDZznaGjEmBTDPbOMMDpuWMs623Nter0+ozU=; b=j
	FdnhQ0j8JeFI/3d422WWF0ZdEqWBOoBRxcWGHP0bHR0KsxBFnaKxk5jSGKD+TmbL
	oM9C/T1t5V44YXRg4J39hTbGy34O9CF8LxKmbm3nWhkiZ8Y2s/r2yuYaWC/dTtGD
	wwcpPfILPpNnG+31sNrDrBMIDYUwNXmkJ97LjEkit4CGwpSDGzmyj751Vcirp5d1
	vyOxPrK5gz/mdJMe+O06ED6p+DR4Hx1Ecsp1lpEBSkF06xxUuIQCx0UhIyVdEMkJ
	7xxUCDgQAkbxquK/PeA1AYsQA8UNPwziK8Er77RdaG/L2Td5WUtcOfgHYhXCjlOT
	nWw4wRDmrGk8zWhaU9sAQ==
X-ME-Sender: <xms:btjXaTIj4JALk8eSIe2zHXPgtiJHACUvV4YcL0OVlHL1e24bNSEReg>
    <xme:btjXaQdYE8GcM8qo7oMzKqKioGC009rkLsNv71Emq_s3i1_BUvsfuhPH4IeBiKjpL
    _Z0Y7AUGCOCd0qZUlAkie7zmXKK-uywvw36bnwYuL3Q2iUoY5I4hfc>
X-ME-Received: <xmr:btjXaS-UPDU_F5TXjtUY_b0fTLBHzr1iaGpbcv7QIHXqxJwPPLhRPAuIaVEYKOJBeNNmEXT0EphZC4zeUmHmlZ9ZcsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvle
    dtvdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:btjXadpwcQQ2ZRj4u1tNxPhoPOIG8sKz4_AyTuHyuFNYBuRXnmbFeA>
    <xmx:btjXaXBfsfJdNHtC8jzasYRcUlrByLIrNikW9LO1CT4FgCDXDw8Rjg>
    <xmx:btjXafxGUsuFqAws7MR3oUl9hId454ofOKQlVjkadRXQ8NoCuIEtww>
    <xmx:btjXaU19YmEB3F8nG3286Yh19t264tjA_nQ7pTdeVt33MbyYxuNrQQ>
    <xmx:b9jXaZZXMdY46GcseSt1rTR0bhID00IyipGp6U9DJH22JwFt_009-ZpX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 12:48:46 -0400 (EDT)
Date: Thu, 9 Apr 2026 09:48:34 -0700
From: Boris Burkov <boris@bur.io>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <20260409164834.GA3472346@zen.localdomain>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>

On Thu, Apr 09, 2026 at 02:57:47PM +0200, Amir Goldstein wrote:
> On Thu, Apr 9, 2026 at 11:17 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > This is a recurring topic Matthew has been kicking forward for the last
> > year so let me maybe offer a fs-person point of view on the problem and
> > possible solutions. The problem is very simple: When a filesystem (ext4,
> > btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
> > complex cleanup - like trimming of preallocated blocks beyond end of file,
> > making sure journalling machinery is done with the inode, etc.. This may
> > require reading metadata into memory which requires memory allocations and
> > as inode eviction cannot fail, these are effectively GFP_NOFAIL
> > allocations (and there are other reasons why it would be very difficult to
> > make some of these required allocations in the filesystems failable).
> >
> > GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> > trigger warnings - and for a good reason as forward progress isn't
> > guaranteed. Also it leaves a bad taste that we are performing sometimes
> > rather long running operations blocking on IO from reclaim context thus
> > stalling reclaim for substantial amount of time to free 1k worth of slab
> > cache.
> >
> > I have been mulling over possible solutions since I don't think each
> > filesystem should be inventing a complex inode lifetime management scheme
> > as XFS has invented to solve these issues. Here's what I think we could do:
> >
> > 1) Filesystems will be required to mark inodes that have non-trivial
> > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > whatever :)). Usually I expect this to happen on first inode modification
> > or so. This will require some per-fs work but it shouldn't be that
> > difficult and filesystems can be adapted one-by-one as they decide to
> > address these warnings from reclaim.
> >
> > 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> > kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> > performance reasons. I expect this to be a significant portion of inodes
> > on average and in particular for some workloads which scan a lot of inodes
> > (find through the whole fs or similar) the efficiency of inode reclaim is
> > one of the determining factors for their performance.
> >
> > 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> > per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> > to process them.
> >
> > 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> > inode, doing the hard work.
> >
> > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > and they can work on freeing memory needed for freeing of hard to reclaim
> > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > they should really be addressed.

One question that pops in my mind (which is similar to an issue you and
Qu debugged with the btrfs metadata reclaim floor earlier this year) is:
what if the hard to reclaim inodes are the *only* source of significant 
reclaimable space?

> >
> > One possible concern is that s_hard_reclaim_inodes list could grow out of
> > control for some workloads (in particular because there could be multiple
> > CPUs generating hard to reclaim inodes while the cleanup would be
> > single-threaded). This could be addressed by tracking number of inodes in
> > that list and if it grows over some limit, we could start throttling
> > processes when setting I_RECLAIM_HARD inode flag.

Anything that pushes back on the "villains" sounds very good to me :)

> >
> > There's also a simpler approach to this problem but with more radical
> > changes to behavior. For example getting rid of inode LRU completely -
> > inodes without dentries referencing them anymore should be rare and it
> > isn't very useful to cache them. So we can always drop inodes on last
> > iput() (as we currently do for example for unlinked inodes). But I have a
> > nagging feeling that somebody is depending on inode LRU somewhere - I'd
> > like poll the collective knowledge of what could possibly go wrong here :)
> >
> > In the session I'd like to discuss if people see some problems with these
> > approaches, what they'd prefer etc.
> 
> Hi Jan,
> 
> Is this expected to be a FS+MM session or only FS+Matthew?
> 
> Boris,
> 
> Is this related to the Direct Reclaim Scalability topic you wanted to discuss?
> We are still waiting for posting on this topic.

Very much related. Thank you for the message. I (and others at Meta) are
working on this general class of problems, so I will send out a separate
message right after this email, but I don't want that to suggest I am
not interested in this particular aspect!

Sorry for the delay with the topic, Amir.

Thanks,
Boris

> 
> Thanks,
> Amir.
