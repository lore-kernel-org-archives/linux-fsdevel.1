Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184A2F12C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236888; cv=none; b=pwLVw0RkeTLwFnq7gZ9f0KqtAt3akTQPTf7jVg95+MyGeuPkY5Wu7ZwrBLg6uwtBIV0RiNpWk1Y8K0Ty7YMGyml0eMwLJwcLKrOjmC0ZzCXPDkdW9s30ZB1HlCw+uiOLi+qZxnUoZroY8rbh0CP1JdgwUl406up7LBBYfM6HGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236888; c=relaxed/simple;
	bh=jNoc5WheHY4CCYh5RHGgtSgYu68JyP4sZul+uV4WPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDoLSAdUNFKkNsE6zRPWZsmvVmQiGPzQ3WGGhW2tN3weulcQdclWD2XwTf5mqwAErujP++xHOT4WWP5nAJoViVfGAgei43z4W7/EEwMXlYlu13O+HfV/3lHqgjxFwz7alHh6Og+3Re8gmaTzyvKiJegtoOZbWX/LcD+qrFuwn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsIJj3Bl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LX3BsBgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsIJj3Bl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX3BsBgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777236885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7ngkkoYTFNaoszFfXjnqMQHnCI7xfB39TzmshJL6/Q=;
	b=AsIJj3Bl4555v1QiDKCLiynDZxxG/s/bmorNrGecz2yWnz7lwFcJ4SrgikwC1IwqiVH75M
	/CYGnfaHsTZTjSlV55RRPY7ZiIE1VdhD9LrEendEdL69cORZtC0LSfkobWmBYs7hQlcWxf
	cTzI0y+gr1RqC+laD4NW4FBZ4C7SRUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-gWFntLZ2M2-14RxxJ7uxqA-1; Sun, 26 Apr 2026 16:54:44 -0400
X-MC-Unique: gWFntLZ2M2-14RxxJ7uxqA-1
X-Mimecast-MFC-AGG-ID: gWFntLZ2M2-14RxxJ7uxqA_1777236883
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso87272765e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777236883; x=1777841683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7ngkkoYTFNaoszFfXjnqMQHnCI7xfB39TzmshJL6/Q=;
        b=LX3BsBgRyQwVz8AxrLY7Cw0ITSzvopTpKBU/i6A03sR87lS/dQg4lgmyR9I/SkTrDJ
         UJP8Z8h0N/dxaxpBEETxsWwhjcwJpERGvIeF36XDMSxBFps8MjdTdtWXKx0VicYlSrVy
         7+HqF+mNZu29yPadCT1haDncVB7vfYhl+coNSw1d11B8lI8rd3fshsw3DU+niXRENcNM
         jrxgtgixKW6KEcpv/KyM89OLkIKV5ctVBf2XJIPApmKn3zvuejrH9SZB5uar/JgWv4s5
         BidQL0b/zOlWHPdcjCpbf9Q4Uo/dGHa3tmKr+5O0aPkvUdBpaaUoeF7b9uLbhxyh+wk4
         V21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777236883; x=1777841683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7ngkkoYTFNaoszFfXjnqMQHnCI7xfB39TzmshJL6/Q=;
        b=lPaP5z4HHO0F7GjIE7+5tvnBmdcFQWdRq8RIStfDGzzFtrs2kvMkqAyGYNdEFHI2h/
         CoXoZgDE2arTp+iq3dM0rbPPwwVBrydNJJZ+ZU0RCvC51dEnVKSFPYnvX434OgAu+JVk
         VwhTdOOrzVQm9GIbvuZFKyKmbcWyJ5EeSa0x530HR3O2D/dlJ/AM+57WhAQ7jMzOJUsg
         eFJodRlRZ0bMmuw8byxsGidKOY6KtSmIVbQhx9DVP5mCI5Uke9fDZiJgVNdIIuKteL0H
         mRRakBzBhVYJCNCvaABcn95tk7BdgatS6y1HGmq+LKoLDaOyIsG/TMyYUi4Las7qFcV9
         BWow==
X-Forwarded-Encrypted: i=1; AFNElJ9KU0tdYAjk6kZg5zO05uYko8KyhzDbipBE45amxDAvk4T3HpxzmbEetunXmWcxIwst5oTLv5ZN2ffCOuJP@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMINTBToVmO8K7q0viIuQUofIVLZCRVPFkaWuD7hqT4uyXfCg
	GiCf+uepuETAfpw52MAao1XGqgi1u0xOGGZ+XSF01efhjvjQhcdgNa4vteJ7B+BqtIo3B/AkDOd
	c7RI6A+HcNtlLss8qiXJlFFwhVkl9DhSEwApOoAk5pKupmeHh+v3KLUP95qFs4NKNj1U=
X-Gm-Gg: AeBDiet+gcdWzGP+BCDqxwCMc9uswgiUbHDkUACyG0wZccg7Z+EpnU++UidcC/rQ+n2
	/o+2/Mo0rTUZOu5SQ7/Nr0ZGONZnzTXJe1rRnXY9DL6qoRVSfLBGZVB2Qz6e0jZtQ6XAG9GrCds
	EGiyRDPU3YzN5tDJILV5XCkKWBQSS3cHmFzqYklASHQgz+YFcE+J/9oC/Tjj10KnElMWAznZ6bY
	iOOSszALRzClARGVB6O+fJWsATib7GP2sjwQYOJmq6zUW+Elew8hydxA0FFtrVueQM/640zF0ZP
	5vS8XxxGJiKhZxdmCEX4vx5dpDbNDuJr8SvJ4kyBvry4E7zZqUagl8Kja3fK4cDZy0bFJZT53aA
	2W8wi08QtN20ZQWc8/v2Ro9W6tocJMU2G/aV6yARzrAl2qWi1adbkIcNo
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id 5b1f17b1804b1-4896c28dd4emr413474395e9.31.1777236882624;
        Sun, 26 Apr 2026 13:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id 5b1f17b1804b1-4896c28dd4emr413473955e9.31.1777236882086;
        Sun, 26 Apr 2026 13:54:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c24d82asm164063795e9.7.2026.04.26.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:54:41 -0700 (PDT)
Date: Sun, 26 Apr 2026 16:54:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260426165330-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aeu5P1bZW3yEH54t@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeu5P1bZW3yEH54t@casper.infradead.org>

On Fri, Apr 24, 2026 at 07:41:03PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> > Thread a user virtual address from vma_alloc_folio() down through
> > the page allocator to post_alloc_hook().  This is plumbing preparation
> > for a subsequent patch that will use user_addr to call folio_zero_user()
> > for cache-friendly zeroing of user pages.
> > 
> > The user_addr is stored in struct alloc_context and flows through:
> >   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
> >   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
> >   post_alloc_hook
> 
> I don't like this.  I think we should instead lift the zeroing from
> post_alloc_hook() to the callers of __alloc_frozen_pages().

can you and david agree somehow? I don't like being caught betweem
maintainers like this.

> I don't understand why you want to remove the double-zeroing of memory
> when the user has asked for zero_on_alloc.  They asked for stupid things,
> let them bear the cost.

it's just a side effect. I did not even test what effect it has.
what I care about is the overhead with
reporting.

