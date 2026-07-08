Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6940861D
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502170; cv=none; b=R0A2acskkujadPySLIpbb7j51PScCU/EyihERQzfTZg8HPjpGu7z6sM1RfMdsXrMwP+D+t9bMWEAtElKdlajmvQ1M0PyNDxDPcxhZNbDHlfYEnyhUP49hiHMUDT235FsC2v+OhdQFaPL0AtmpxHGU+h10wjB6SKSb/7bXOaDTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502170; c=relaxed/simple;
	bh=sQOlJyYK7iAm5eS9zDGCitM6vWVm4bMYnRlB2QL6l8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY9ncJwX9kYvxkLHrOaXh5jiOs67zY7mSWEHjFBwDv3XeSDNnp1Eln/b1iJKUonIpR08k5FWkWoqw10QeWLVrayrztYxGLTpuaMAirmZQINCZzfGhV1c1R1dchAYHFsbZLLqPcSYdvAXukEp8twnWoz0+DQbly+QjhvWMsShp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGjEPZee; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoTPdlpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGjEPZee";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoTPdlpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783502168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4K/HdwkKVaSF1+rIVNyQiESO9vsDqggAz/6RtbS1nI=;
	b=LGjEPZeemMuviSF8/bhZlfMQTgmkFE+YUdZqkODW5rQPn7C84+mM+ybu9UAzNSmVdnMRv9
	XpuK55P/d2vf4Ku14X/yVVtM10YwR/GVrqogheNr2YMNq4EepfAfu99AbrLaI3VI6J5Cfv
	O6oT1mSLsB6LyChaqjF0HflLVFJY+2E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-tdhi0ITDNG2ZE3SVgUP4sg-1; Wed, 08 Jul 2026 05:16:07 -0400
X-MC-Unique: tdhi0ITDNG2ZE3SVgUP4sg-1
X-Mimecast-MFC-AGG-ID: tdhi0ITDNG2ZE3SVgUP4sg_1783502166
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so41587166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783502166; x=1784106966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4K/HdwkKVaSF1+rIVNyQiESO9vsDqggAz/6RtbS1nI=;
        b=PoTPdlpWkuUHRNm7Ix5YIE4eUzJMeeiOHmm5qyxDErRjPOaCyC0WPG0ikKKbTxIsc2
         7/uPna9Ibuy/sK+WMbv+bZvg463MdRkWlrmtRy0s88APevASmVlSFrCGibNadHOj/jSQ
         ghMVAGozWSjO3RhxTXzeFaee9IuI0c76tDhheKn+c33VTz7VHOsXChgl6dAcBjPzM9vm
         39R6ZHFDDuJo+3Ypte1XFPlpPgn01PFKyYMTZ3fXoEFq7lqmcjetG8M4LVJriU1JLkli
         89j+wjYNOs8SaIRTwfizG4mFLe3Sx4tp3yPBe298LpciCmJidDhE0FLYOUUhvAu4Xjcw
         uMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502166; x=1784106966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4K/HdwkKVaSF1+rIVNyQiESO9vsDqggAz/6RtbS1nI=;
        b=XYLDszOgz5Nh06kFmzYhvQRtWsrkucpNQQnbHLYjUAT2SnakR2m4k4OfPqP3wyaNUY
         yZ7kg6AABA9+xvKwWGWWXXomMe93AWl7jlSl4SsDt4Cxt9CvdLY6/Qb7kNrfESnKnlYR
         qSnreVZjGow4+nfQjoABWsfhgMG6yEy9DcE0dobRHosgmjW1szj0RvA+R9DOWkGvhfR1
         v9mNaoab18s6/Vc/pOrNrjQbBs2dsyt3VHf9gaLdX09xuMKenzMjuvDR6le/2cAWHya8
         w/O+F7ShpimLipvqjWm3zLaSFBzROZvHjdxUjXerdsQ5udCIbkIWHm7LCl6YYRszr3y3
         kA4w==
X-Forwarded-Encrypted: i=1; AHgh+Rr804n6qG3omKhKmw5LNZnvQd7jzkzHownit8pAGpywHbp1jDklpCdBJ/swmSdUKNsKyBcmeDsWCKyNTVD6@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp5LqyiRx2XLeh5+5iTRoaiXq7/CnDT+lrSTmwm0/vZUX++ev
	jpX9UHFqJkB3wa0RduCrDIOVa8cj0rYt5ZRFAWfNvCbmAaQp3jNtl5d+SVPo1jHT4MBgyym4JW4
	KuqHyKJruu7gGguimVkXHAzKvhp4/Tna/jv567NQ4KbZ8dncuErLgTasuptV39mi3JKM=
X-Gm-Gg: AfdE7cnVCNYUgw+QV4VowHjLpAe55HDjCJ+nnl45dWzbfL/+5+h+gZF850ZRVilaf2Y
	NCbWp0JcGvsuAGedgE5RHB6cNUvqGTBK0PfldNvxY6dTouiPmXrw63OOuJB9GgOBzD6wy36ucd7
	1FMKcGQREAw18MCl5HWQYC0zwz2jBaIfZ6pzzHPW5SkWJmGCJDFsMjZ4M5ot20aEmjtRpYoZJ5w
	LDjc7c6ORpIloRTEtFo2V43W3IxsT0UQccK/7fTLd9AfGCj4vtpIpDlXmnoShSXuR8cY5XeOhXT
	62EudyOKcb5arirqZxwx0L/2ixFWnODg0EJk5ULyQLZMU1cH6gx+XqnVQeGVOyJWjG/Us+vyux3
	0U+LcWpVhlVj6Zscsrws/HOflyhgN22Bx
X-Received: by 2002:a17:907:1003:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c15ce0f880emr64101366b.44.1783502166156;
        Wed, 08 Jul 2026 02:16:06 -0700 (PDT)
X-Received: by 2002:a17:907:1003:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c15ce0f880emr64098866b.44.1783502165600;
        Wed, 08 Jul 2026 02:16:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bca25sm286808266b.35.2026.07.08.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:16:04 -0700 (PDT)
Date: Wed, 8 Jul 2026 05:16:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Sourav Panda <souravpanda@google.com>, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, mhklinux@outlook.com, fvdl@google.com,
	gthelen@google.com, mike.kravetz@oracle.com,
	pasha.tatashin@soleen.com, rientjes@google.com, riel@surriel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
Message-ID: <20260708050547-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
 <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>
 <akzZr2jfJ0J8zox4@lucifer>
 <20260707095843-mutt-send-email-mst@kernel.org>
 <ak0xWgpJPSaNWPsl@lucifer>
 <20260707152755-mutt-send-email-mst@kernel.org>
 <f9bad4b3-93ee-4daf-84d5-97f6ca305240@kernel.org>
 <ak4JiBcvi29sYx0v@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak4JiBcvi29sYx0v@lucifer>

On Wed, Jul 08, 2026 at 09:26:18AM +0100, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 09:46:14PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/7/26 21:32, Michael S. Tsirkin wrote:
> > > On Tue, Jul 07, 2026 at 07:46:28PM +0100, Lorenzo Stoakes wrote:
> > >> On Tue, Jul 07, 2026 at 10:01:55AM -0400, Michael S. Tsirkin wrote:
> > >>>
> > >>> Fair enough.
> > >>>
> > >>>
> > >>> Lorenzo, do you know *how* you want it reworked? Could you write it up
> > >>> at a high level?
> > >>> Because if not, it's not really practical to make it the asking price.
> > >>
> > >> Michael, you're an experienced maintainer, I'm surprised I have to tell you that
> > >> the burden for that lands on the submitter.
> > >
> > > Oh sure, "fix bugs A,B,C before you add to this mess" is a classic way
> > > to actually not end up with even more of a mess.  But I usually do try
> > > to be explicit of what are specific issues I want submitter to address.
> > > I don't really feel figuring that out lands on the submitter.
> >
> > Sometimes it's certainly easier. With things like hugetlb there often just isn't
> > a feasible way to integrate it nicely into core-mm. It's just too special.
> 
> Yeah exactly :) once you reach a certain level of 'specialness' it is more like
> pointing at a flaming trash pile and crying ;)
> 
> >
> > --
> > Cheers,
> >
> > David
> 
> Cheers, Lorenzo

Well as long as I'm not the one being asked to put it out ... it is just
hard for me to get motivated to do cleanups if there's no actual bug to
fix, or a feature to develop somewhat proportional in size to the
cleanup.  But for example, and without calling anything trash, after poking
at memory-failure.c, *I* want to cry, because either there's multiple
races, or I just don't understand the code.  Some of these we discussed
here already.

It seems to boil down to the fact that when people start getting lots of
these errors they rush out and buy a new system, so hey. But maybe with
RAM prices spiking it will become less practical. I'll put together an
email with a list later, maybe.

-- 
MST

