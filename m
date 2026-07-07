Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652271C84BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432925; cv=none; b=dosUsZ1xV/PFULpZGx91O8A3YNDNPKtEVJ52zA7MtrxaVrJwciIg29Hc3/3IQgF8/ShP7aKEomEsoyfKseAWfytpxa+IhSdVl5rZAV94Pk2+XAr7/FxWuxrC4qeeSkYMaHxvhZ8iSbA6I6D9bL6laWAymmHRduP2dtatkFZOaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432925; c=relaxed/simple;
	bh=MJKZMdNzs5NYzNY696wPqhLLq50VnJ6AsyX8VhbYT/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN+/cN4SHiKn8ushdQhRtdurWxLxQAfFVjfp+rgAoO0U9lWfL2w0XcoF2mCdlmUN8dYmY73Y8hJY0j9n//U4Hl66q2v3DgMnKfB7FmPvzl8HDmAQfmwNKcdycRKGBWvO1qawBVA5CoDXC18KkqGJQGmo3cBjXf+T5G/2QNkBTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6pTFk4I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRSLEy2d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6pTFk4I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRSLEy2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783432923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDvld2BXpFSwdt9ItbR9zFXv+7W3dhSsVabE1vNaiZo=;
	b=h6pTFk4IYH123/K/KTC7KimTVl1BYb/sJW1NtNarASBYiJeCudKCx4J13GF4445H0YAy5S
	n1KJyrGOLdbhqvTPLvGsIYD1mp+Xu/gQiv+PvnPZmzpSP6TCqcTLjdjUPq+pOy6S5T6iJP
	OdRfa9DwsuoCls/clrfJ7VrTgrpeXoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-IcQY1PG2M4aQFYfA-eFReg-1; Tue, 07 Jul 2026 10:02:02 -0400
X-MC-Unique: IcQY1PG2M4aQFYfA-eFReg-1
X-Mimecast-MFC-AGG-ID: IcQY1PG2M4aQFYfA-eFReg_1783432921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so29215175e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783432921; x=1784037721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WDvld2BXpFSwdt9ItbR9zFXv+7W3dhSsVabE1vNaiZo=;
        b=FRSLEy2d41x5QTGW6Q28zHdpB5yLQcoiwqgij5su0NoywF2LEULjSufCjBeoMrss8W
         sGNyltT5xY5lqpNbQuvZg/V1xtaBS0v7JOnzxNkuDtpjgIl6yDDOgpz7Gm2Z8OHGkp0Z
         jmNjJNOjqohFWEtvqS1RjL4FG4CEhdVyVSkiWxj66RhrvN18Fd82dpCe67qb8UcJ1uU1
         EgTdWtNcQSpvy3C6qT+YZTjxSWW7BpNuMHaUU2NhndJHldDhnqPYtxLsoF8Co3iIJOTm
         FBGaEzxEZbk5JX2mldfht/xh1RWS27AirOPah2cAEsJkY0grGUhZXfbcuGLNIeHDPYke
         9UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432921; x=1784037721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDvld2BXpFSwdt9ItbR9zFXv+7W3dhSsVabE1vNaiZo=;
        b=hkF3/udsBHtwra8SIaIsl4FAo11CfYGgKPmHSfLfafeYiD6iOoWSp3z8AtVdyQw+sV
         /0pPjyxAgxP4ssobrMSlZXHne0jdAqNBX0l44gwHU3V2ogtYfsX4ZTeB74EhCKjdpDOb
         6tY0kiuZSuY+L+aq52iCtxbQQBW/AoNWFVu3ksYu/DV41P4D1NA/xKGNjFF7XnIA4qC5
         UvvXblb+VdZU/BJrOAsEeJ0PUlAt8pzZDO65h0sxPQ+AqmqdgEO2nCcVSIdEfcbe4fov
         CHov81PRMb82jqHRpIepcL/VWDvdnLDMQb8m03TcuzvcZ2WYbDBdixb7xE8idstTj2Nl
         ocNg==
X-Forwarded-Encrypted: i=1; AHgh+RpFrfTP9rQqvCWAWU1/IZOPLJK3iA0b4KqNms4bu0bbbGkATOcVhRoit34TseSQ64yLSvx2+7tjTCu1FVVz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxl6SHkhW/SmjuNtpSIZymk7YcX0OB0Ina48hUICOBKJ4yyQmf
	+10R1Z7YjZppqCic759e2LXiLl/7H1IJHRRuNXmx0vMXQf4IolIN8d0Yf9US0yfHN1Hlb2n7WEF
	uq1LWdH4kN8lXmwARh/urxAeCNnRqO9GezZcyIXYqUS72a9J6uPJdeU3WYreAUa9r9Mc=
X-Gm-Gg: AfdE7ckI7OL9GMsFtXvs6PX0mU+BtKh1CT9zmJOkZdfOx5PVRM49KnQ0d68Ktk2ppBu
	TLuEZdu0aLth6R/NkCA+Ua/n4CTxn1Ome6y8E/0XFAubrZSUh0ETsDG03WmR09sWg7tE4R3vV6J
	f2WUvukY4h5x3AGSJL778RvhJIHiwEQclwtTsMlWlfEB0rG7HWgMVlaxQYiuXyR3Mi/2gK0f2qK
	NDSBDRnkOQXiRkiFalSXTGhJJUyHGLcEpNOixSfrk3ckaMJKcNFQ+xR4ZLaL1+tw/Bpv7TKotZz
	xD/CIvM7wIc2RAgsHPkyKCsIV81vPUDBdotkSsYZxHOWkshQ2GPkGvXu/xEEttbGW948ADzWNBR
	i7W1z5iqoillQKurRPc3W6ndQsnAKCsGL
X-Received: by 2002:a05:600c:198e:b0:493:bed6:85e6 with SMTP id 5b1f17b1804b1-493df0711f9mr63762705e9.15.1783432920483;
        Tue, 07 Jul 2026 07:02:00 -0700 (PDT)
X-Received: by 2002:a05:600c:198e:b0:493:bed6:85e6 with SMTP id 5b1f17b1804b1-493df0711f9mr63761815e9.15.1783432919826;
        Tue, 07 Jul 2026 07:01:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm33176455f8f.33.2026.07.07.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:01:59 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:01:55 -0400
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
Message-ID: <20260707095843-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
 <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>
 <akzZr2jfJ0J8zox4@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akzZr2jfJ0J8zox4@lucifer>

On Tue, Jul 07, 2026 at 12:06:34PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 12:28:44PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/7/26 12:25, Michael S. Tsirkin wrote:
> > > On Tue, Jul 07, 2026 at 09:29:07AM +0200, David Hildenbrand (Arm) wrote:
> > >> On 7/7/26 08:42, Sourav Panda wrote:
> > >>> Overview
> > >>> This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> > >>> backed by a kernel shrinker to safely return memory under pressure, and
> > >>> integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> > >>> specifically targeting gigantic (1GB) hugepages. The goal is to solve
> > >>> the tradeoff between allocation latency and memory
> > >>> fungibility in virtualized and heterogeneous cloud environments.
> > >>
> > >> Hi,
> > >>
> > >> in general, we consider hugetlb nowadays to be mostly in feature freeze, as we
> > >> realized a while ago that adding more special casing on top of something too
> > >> special for all of MM is only going to hurt us more in the long run.
> > >>
> > >> We want to have less special casing and less special sauce, not more.
> > >>
> > >> Now, there is nothing wrong in making hugetlb be less special, by making it use
> > >> more of core infrastructure etc.
> > >>
> > >> But optimizing for surplus hugetlb pages by teaching hugetlb about new caches
> > >> and its custom free-page-reporting support rather looks like the wrong direction
> > >> for me?
> > >>
> > >> --
> > >> Cheers,
> > >>
> > >> David
> > >
> > >
> > > It is currently bypassing free-page-reporting completely.
> > > Making existing free lists not ignore free-page-reporting would
> > > maybe considered "making it be less special"?
> > >
> 
> You have this completely backwards.
> 
> You're advocating making hugetlb _more special_ by duplicating functionality that
> core mm already supports.
> 
> I mean:
> 
> mm/hugetlb.c                                 | 590 ++++++++++++++++++-
> 
> Tells the whole story right?
> 
> The whole issue with hugetlb is the very fact that it's a parallel
> implementation of a bunch of mm stuff in its own little world.
> 
> We make it less special by mm/hugetlb.c smaller and smaller and implementing
> what it does sanely elsewhere in _core mm_.
> 
> >
> > Depends. We don't really want an orthogonal implementation of something we have
> > in core-mm.
> 
> Yes, exactly.
> 
> Feature freeze means feature freeze, not 'feature that core mm doesn't support
> feature freeze'.
> 
> Hugetlb is a poster child for poor decision making in mm that has left us
> saddled with maintenance nightmares because we allowed 'just one more feature
> in' (TM) with little to no thought to the future.
> 
> And we've all learned from that and don't want to repeat these kinds of
> mistakes, nor make existing mistakes worse.
> 
> And work to improve hugetlbfs and make changes like the above are VERY welcome
> :)

Fair enough.

> Laying a foundation for hugetlbfs to be more of a sane mm citizen through rework
> series is really the asking price for stuff like this in my opinion.

Lorenzo, do you know *how* you want it reworked? Could you write it up
at a high level?
Because if not, it's not really practical to make it the asking price.


> >
> > --
> > Cheers,
> >
> > David
> 
> Thanks, Lorenzo

