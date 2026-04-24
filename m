Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF93DA7E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055823; cv=none; b=Fa36BgI5cf+ZIi4cMskvvhAEyxG75b/8Aury1/bHlIhoLb+e8Kdi/FbRqT/zOrptnESbl3ipuPuS3tpn9C81n2BE2OLfYN4ywdIiR7arOOJPtkdyKn7YExbfhZREQh0n9edNmXc+u120fVqSVb9+ypOErT4Buf1Kt2MRvrSHrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055823; c=relaxed/simple;
	bh=X3unbKjXkfIxpZgPYPCXBXdaO16pNyP21Y+UN+3Q6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGU10si2wYxO6d0VVutbne/QoxiEBAixyvaMIcpZmZyVTSntSSK0ZqLnIS5eZuK47A9THJ2Dyx8yM8Pxf/CrkhMbSX1MH4Ir8zrWFYXAWA7f3K0Lj6muHNh0oKRR9wB7HG46OFEZ5hMnLQ6O6vP1D/y3J9+yuTXYPFSVFhOykug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMOERr44; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmoZwR+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMOERr44";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmoZwR+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777055821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzZh79GGJvnyX3o1poX9T4TAY2qDXkiWPDaOxeNq0iQ=;
	b=cMOERr44959ZKRtT3iBHg1lbI744oSBkdhPb6bH876rwyvwlcs/3sWkwSTuc/+Sc9Tbjua
	7XyVT3aloxXpaUiu7bdJxud1uvsxqpAot++XlYyPHWaOyFArErNp3tIZr5xzVvfnA7CDdy
	M/cPSaEQRt7/EUAA6fTXtAFUnW4EXF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-MUmPpBY_MH6X5rKY6NgZGg-1; Fri, 24 Apr 2026 14:37:00 -0400
X-MC-Unique: MUmPpBY_MH6X5rKY6NgZGg-1
X-Mimecast-MFC-AGG-ID: MUmPpBY_MH6X5rKY6NgZGg_1777055818
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso88514845e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777055818; x=1777660618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzZh79GGJvnyX3o1poX9T4TAY2qDXkiWPDaOxeNq0iQ=;
        b=VmoZwR+8qNCS5ayDiD8bEvlao+vNn22bv9z5IBWm0nX95FjA+oYnMLKlYgxJgEAWOs
         0tCcUGfG/6OsH4yqKlJAYBVdObPA+wj0jlBOSaf+I6ei0RL8MlPbsWv4k3yeq6qRBX6m
         jDwcaqF4+xbdKSEjRoBfl4CLwXYe7mcfuWnY+QKg4gCoAVMJJiR5qReIT/o3kE5oy0UC
         rBuv/jr6Vzcz5C9bLTzeJHjAgPUVK8L6F6L5XvtV2Y4OoXCy/VBMKc9p5Xv21RpPbcrG
         tGvIkzLhHiYxWPqA0x4V4td2KofSd0C8RqxJxVc1sZEFTvi3hSVvncl+JMb5deYw78BB
         X26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777055818; x=1777660618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzZh79GGJvnyX3o1poX9T4TAY2qDXkiWPDaOxeNq0iQ=;
        b=eNAK2X2I1VzeuRwouNtDOAtBgz+42MgrJvbVfe3y8OIpB8RXw7WLls9gFfdINecqjU
         VrHnxdcGOCQchDrl4HOCchgP6eSU5XWenb+2eJRi7dV6L05PPCgMUO8oixDBenu6fulD
         Fo4LkpFXit3AQbF4TgKvUNJb5UpQ9drcx2AnpmLTyV8r6VPUXOzOBsHenFsXI+Bjc0Yb
         CL/k6HOavZoYtdnOIluMHLcvkWRoY/7EwL3j/nDuD6kEdw0sN8mpMnUjw4s/pq4QyWG3
         q+RlSPn0KifZ6lJGLQWZNnW7pY0iYC+tK22roEfKCJ75OIZvwJU6zo+rk96j2rAqJ6pV
         jMMg==
X-Forwarded-Encrypted: i=1; AFNElJ/eyM62PfzTEg3s1x1HEeL/4Ppcus+VgfNtsHC3RRc860XOrKKcGhbH/ujTmmUsjqMzbXEpY0ZzxxwN1+Hl@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7qrfgx9BX7LcGSudM4SqEpWxKENpJ70B/bzA/x757Z4/dHES
	et1W2m6OGQAjD1c6qb7RCNHqhGxXyutvET5Hhdac/VdKI1uyRKJINyEoBN1FkPIxTQUisbt12PL
	q978SptWgDlARtuZiBe57H4JO8CR7cqklHqcEtsr65ylVAZkb87cCP8R+F+4vrRhzFtE=
X-Gm-Gg: AeBDieudAOlnXtQzNzeStk5zOJCgk7ND5OwE4oI5sxE9Uh5h8BY+ceJDvNRyjk6IiRl
	7XQkKaG7tBmv/fIlcz8+9SVkja74h1eFk7l8nEnXRYWIG9LrZP86p+1hqLc2Ej0g32KfG8aVo0Z
	XeVb1xb3wlwHYQYX34hPgZQKOQIBjVkZYh+V+0KNGDo1Ery9s0FCMxaUYqddJ1rOiJ4Y0leLmT1
	hyORwXxbV7A2M/XOE3XJlUDofFg0FCBmz4mPbFbv+tlSrLbpnxtCotTDsXM58Yl+n+Lzczw+cCk
	nELpl2TqLsvIuxz51YYmZyYBMMVlQRwtYkc9QlHHUTd7NHl0bz+rPMOrPk5T63HeKlR2ySFzJap
	3IHx9oXNp/O8RTdAh+y1ZvWDcoEEjTPVuyZoHBMSIFSXPxMZMOys2O/cYECDz9HU=
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr466165675e9.21.1777055817632;
        Fri, 24 Apr 2026 11:36:57 -0700 (PDT)
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr466165305e9.21.1777055817177;
        Fri, 24 Apr 2026 11:36:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-147.red.bezeqint.net. [79.177.155.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm607291535e9.6.2026.04.24.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 11:36:56 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:36:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Message-ID: <20260424143541-mutt-send-email-mst@kernel.org>
References: <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <20260423104120-mutt-send-email-mst@kernel.org>
 <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>
 <20260423121222-mutt-send-email-mst@kernel.org>
 <4e12d67b-60e3-4bf5-a229-43c0d2c62cfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e12d67b-60e3-4bf5-a229-43c0d2c62cfb@kernel.org>

On Fri, Apr 24, 2026 at 08:33:45PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 18:13, Michael S. Tsirkin wrote:
> > On Thu, Apr 23, 2026 at 05:54:26PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/23/26 16:46, Michael S. Tsirkin wrote:
> >>>
> >>> I just dislike it when things are non orthogonal.
> >>> People are used to: hugetlb = same perf as THP but more predictable at the cost
> >>> of being harder to use and using more resources.
> >>> Here, suddenly, we have an optimization but only for THP.
> >>
> >> Note that we also didn't care about user_alloc_needs_zeroing() with hugetlb so far.
> > 
> > 
> > You mean, that it stays because of the reserved pool?
> 
> I meant, that if we are running with init_on_free or init_on_alloc, that we end
> up double-zeroing right now upstream. So nobody cared to optimize that part so far.

on the aliasing arches you mean? that double zeroing?


> -- 
> Cheers,
> 
> David

