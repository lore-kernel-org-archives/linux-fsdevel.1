Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B0374A0C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452771; cv=none; b=NxmGei3gwE65PhhG18gPbio5vAgYLYpdSgwWpqOiHwyfBfmOxcEhw1gp9rDfnAF2iJUebfe2mCnzrStgw31SYgiSqKZBX2mBgJb9vC/a0Z68YncIuI6ZEJaIS3+a0l7KVICKpR6lM3V19kh1smIiZ9HWUo++Z05+OYaYufWmNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452771; c=relaxed/simple;
	bh=GCFa/EGRir/SGPnCH71IKTYnXPPpRa9/eIZJUWju1Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzGNKf8SKEpSGBP6PktAYA5lax68O8ezCbM1G9Jx8RXn+w3i/bv6HfEWKJu3xoGecvr1vT3Hhu+uylMHr+cDScSZZoI6OQ0V4Mx0pnfg2UiQV4TgLCUwh9XknEGTJBvQz2TIz215LCzUiGshb82KbJsJyuDfSk2m98W+h4K1G48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5ElvzbZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQ1FRqSK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5ElvzbZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQ1FRqSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783452768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXZp/HypJus1dyeVVJpONiQNeq38HK6Hd4EzEcMoqME=;
	b=c5ElvzbZGmQpwIrD8qJVocWYiss+MOuUsGfvH8r6wsSdJQISPZBelx+BBG4lYhUFGCxi2r
	/ZVIYDhDuxxmQ5GwY3dU4kQKaJGRMoTVRiCg9XfonVXrFqTdMUr6SIxxI4Gu9EUPBt7oTe
	8YQX/qqYVLbMtHkP7AGJTl0pOYVWd18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-nvvPnqggP2qW_Iw--NuPyA-1; Tue, 07 Jul 2026 15:32:47 -0400
X-MC-Unique: nvvPnqggP2qW_Iw--NuPyA-1
X-Mimecast-MFC-AGG-ID: nvvPnqggP2qW_Iw--NuPyA_1783452766
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso24507645e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783452766; x=1784057566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXZp/HypJus1dyeVVJpONiQNeq38HK6Hd4EzEcMoqME=;
        b=AQ1FRqSKa2B9e7zIne6csKjJqyizEzEiMAIgUee+K9YpsINytm0ixC8OA6Z91E6eXo
         Acd8bdJbbaHtrPiDjWLNcbjHGhMk35bbLG2wKgFB5StAqlvSrAze5Vd/ljLbCZq9+eZ+
         nj8P+hi8NWOvHA0aYesHc4Hh7CgiAO4E0vV8OUWKY51zbUnSfQItRq7nl8IASAFRx1BV
         NLRseMT/nIf4hf/4N7FH0NfsLllKzJEch6vjGpA16lvYbjEiyRfqtJhlN6LULa/HVBQX
         8P03iXBxTq20gWzPiEeJrhjFbaJS7IEYOUJXUMGAGL3wZicR0oAX9ugbZ/fVdDyXRvUs
         a9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452766; x=1784057566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UXZp/HypJus1dyeVVJpONiQNeq38HK6Hd4EzEcMoqME=;
        b=aKsZPEBNMQ+NVo+UZQ3Bcf3nfMocV758F7WcEHzh61qnRdNCQ9DBdCtEeI/axuTyao
         zJE6bfVS1SMcFSDDGNtu8ETjpwyr5Bx04ACkdcC4Yw6COynf+m0S7p4OaguFJBaVnZO9
         aUfk5tLqgGO7hYV4mZVN3d1iB660S27ylBxRrWU6XEh39G3r00TviRuTB35WjPwTVlId
         WASpqKwcAnzjMPJrO2I9Td/ZAZuFceDp9qm7qXKbsh8ett7B1rweJz6IMXskpycrvcNQ
         wdWW5qUr0nNgVdLoknB20mbCO1IlhMdOhWEHTUVMieXN2z8kt4fKGOJAUR88wjcRbOqz
         VVJA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1OjCZzX635fu9wme7wqhu/Ct0J6ybW7ZuLkXSBX0mgBHBMi7b+cm715q5aTFufTvwlO7FpX7v46uSn3J1@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeejjLBu1pAZTi+e0RY46X77WMuYGd9ffAIRCswqySMdx8l3u
	ThXTARhwtpFTNHAXsGEucUs7K7OS1tPBkX89tO1IH1yvAm0dWnYmygLRmlnveV2kvlLCb8eePMM
	wCM1SEjNv1wiGWUCeuB09KnjFEQH4Kislu1JAPKXStx85EPY4Vh4JrSv92MJZ8T4mnqo=
X-Gm-Gg: AfdE7cmLjHIcjH8Lh8M2BtuthVZJci/w/j0PV30E+1okIpYw6csXxjOVSn8XTDzw/kc
	Is48lI/UjTuuz+imujIvtMhU4wb+ZeU6HEfJhE/W7A0pk2dmQhw/THa/a4rWSJpb8SLRBbq0IXM
	2io6w2AphofGc0NzzbkzELCoEDFoSj2ZSjTJ7HYGxZhCJJjHoBN5K7YZHCXFAN2KaElfx+zDEii
	L4dWxijU5H3dVLafM3l8hQPkY8OVJaigOTTR9Uu5AxwK5FCwNsNpyiT8Bmssh59gz9GInI8OXB8
	6eHa18VBOlMaC4Yp88kGznWWCm/FUYBrzjnxwyWIMo+l3bl+VjhTrlp4Jc3v/QaeHesGdla0N5e
	GMNhIsmIbeeWtJV6foxczQE60Bxm3JSds
X-Received: by 2002:a05:600c:8286:b0:493:c412:b806 with SMTP id 5b1f17b1804b1-493df04241amr74640015e9.0.1783452766064;
        Tue, 07 Jul 2026 12:32:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8286:b0:493:c412:b806 with SMTP id 5b1f17b1804b1-493df04241amr74639615e9.0.1783452765524;
        Tue, 07 Jul 2026 12:32:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a572c3sm2863305e9.1.2026.07.07.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:32:44 -0700 (PDT)
Date: Tue, 7 Jul 2026 15:32:41 -0400
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
Message-ID: <20260707152755-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
 <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>
 <akzZr2jfJ0J8zox4@lucifer>
 <20260707095843-mutt-send-email-mst@kernel.org>
 <ak0xWgpJPSaNWPsl@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak0xWgpJPSaNWPsl@lucifer>

On Tue, Jul 07, 2026 at 07:46:28PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 10:01:55AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 07, 2026 at 12:06:34PM +0100, Lorenzo Stoakes wrote:
> > > On Tue, Jul 07, 2026 at 12:28:44PM +0200, David Hildenbrand (Arm) wrote:
> > > > On 7/7/26 12:25, Michael S. Tsirkin wrote:
> > > > > On Tue, Jul 07, 2026 at 09:29:07AM +0200, David Hildenbrand (Arm) wrote:
> > > > >> On 7/7/26 08:42, Sourav Panda wrote:
> > > > >>> Overview
> > > > >>> This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> > > > >>> backed by a kernel shrinker to safely return memory under pressure, and
> > > > >>> integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> > > > >>> specifically targeting gigantic (1GB) hugepages. The goal is to solve
> > > > >>> the tradeoff between allocation latency and memory
> > > > >>> fungibility in virtualized and heterogeneous cloud environments.
> > > > >>
> > > > >> Hi,
> > > > >>
> > > > >> in general, we consider hugetlb nowadays to be mostly in feature freeze, as we
> > > > >> realized a while ago that adding more special casing on top of something too
> > > > >> special for all of MM is only going to hurt us more in the long run.
> > > > >>
> > > > >> We want to have less special casing and less special sauce, not more.
> > > > >>
> > > > >> Now, there is nothing wrong in making hugetlb be less special, by making it use
> > > > >> more of core infrastructure etc.
> > > > >>
> > > > >> But optimizing for surplus hugetlb pages by teaching hugetlb about new caches
> > > > >> and its custom free-page-reporting support rather looks like the wrong direction
> > > > >> for me?
> > > > >>
> > > > >> --
> > > > >> Cheers,
> > > > >>
> > > > >> David
> > > > >
> > > > >
> > > > > It is currently bypassing free-page-reporting completely.
> > > > > Making existing free lists not ignore free-page-reporting would
> > > > > maybe considered "making it be less special"?
> > > > >
> > >
> > > You have this completely backwards.
> > >
> > > You're advocating making hugetlb _more special_ by duplicating functionality that
> > > core mm already supports.
> > >
> > > I mean:
> > >
> > > mm/hugetlb.c                                 | 590 ++++++++++++++++++-
> > >
> > > Tells the whole story right?
> > >
> > > The whole issue with hugetlb is the very fact that it's a parallel
> > > implementation of a bunch of mm stuff in its own little world.
> > >
> > > We make it less special by mm/hugetlb.c smaller and smaller and implementing
> > > what it does sanely elsewhere in _core mm_.
> > >
> > > >
> > > > Depends. We don't really want an orthogonal implementation of something we have
> > > > in core-mm.
> > >
> > > Yes, exactly.
> > >
> > > Feature freeze means feature freeze, not 'feature that core mm doesn't support
> > > feature freeze'.
> > >
> > > Hugetlb is a poster child for poor decision making in mm that has left us
> > > saddled with maintenance nightmares because we allowed 'just one more feature
> > > in' (TM) with little to no thought to the future.
> > >
> > > And we've all learned from that and don't want to repeat these kinds of
> > > mistakes, nor make existing mistakes worse.
> > >
> > > And work to improve hugetlbfs and make changes like the above are VERY welcome
> > > :)
> >
> > Fair enough.
> >
> > > Laying a foundation for hugetlbfs to be more of a sane mm citizen through rework
> > > series is really the asking price for stuff like this in my opinion.
> >
> > Lorenzo, do you know *how* you want it reworked? Could you write it up
> > at a high level?
> > Because if not, it's not really practical to make it the asking price.
> 
> Michael, you're an experienced maintainer, I'm surprised I have to tell you that
> the burden for that lands on the submitter.

Oh sure, "fix bugs A,B,C before you add to this mess" is a classic way
to actually not end up with even more of a mess.  But I usually do try
to be explicit of what are specific issues I want submitter to address.
I don't really feel figuring that out lands on the submitter.

> Nor does a no from a maintainer require an alternative be provided.
> 
> In any case, I felt I was clear above but to reiterate - do the opposite of what
> the issues are:
> 
> - Implement things in core mm without it being treated as a separate entity.
> 
> - Reduce the propagation of if (hugetlb) { ... something specific ... } strewn
>   through the code base.
> 
> - De-duplicate the appalling parallel implementations — and not by pulling
>   things out 'just for hugetlb', but by making it ordinary.
> 
> There are a WHOLE HOST of issues and problems and difficulties with doing all of
> that. But that's just the reality of it - again, the burden of figuring that out
> is on the submitter.

Thanks, I hope the above is specific enough for Sourav.

> So the price for entry is high, very high, but that doesn't make the no any less
> emphatic - we're not going to accept the problem being made any worse.
> 
> Note that I'm currently working on reworking the anon rmap which is similarly
> problematic. I didn't get nor expect detailed guidelines on how to do so. The
> burden's on me, and it's equally a high price to pay.
> 
> But setting the bar such that the codebase is as good and robust as it can be
> both now and in the future is what maintainership is about.
> 
> Thanks, Lorenzo

