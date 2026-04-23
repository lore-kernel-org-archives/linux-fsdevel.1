Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DB3845BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960799; cv=none; b=kwBVVtsZuK/Fnq3KY00R8/3FT6zw4zf391wMqB8VbIbbpWlLUXvwHG/wyaLKMZ6XbZgfuWcS/G7Q3GeCBVM+kgqsHjiE6Q4082FWhZsa5AiiNUwl2U5F9+9fVm9d75JRojQMwEeiWhAj3+jHCqpdfO1R8EXxtLEMpNt7oaq8IdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960799; c=relaxed/simple;
	bh=fKB6gCyOLYLrhwAUsqBd+g5sVfW+71hhyWakIaqB8Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omciyZAh6cwRv1REbbtqT6SGhpo+XheJ4X+pbdNPBHEKACPL4tnOzEKAKyoc504I58YMhuEFvqs2nZWxNxmwVH4j8wP/efAYdpFeeNMHY5+Jh14D9rU4AeRRyqmYuxfVeYeKVUqzmgyShAmqfzyMJ4ClCDL5oO4ULFuFL2Nhoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8Xfq2li; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z//OpV5u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8Xfq2li";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z//OpV5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776960796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPpcyNNw5A670ehN8KSLpk7tEoT3MHJiCv2Fb9unNrI=;
	b=h8Xfq2liX4Xok7NL4MrP11tHYLoduTroi1Rw5cFy50R3Uaot6fyuxYnrUUTel+E/6eRSRS
	7oZKHpjXuLwV70WFoWw6D0XA8wMhqseY0FJ4i3HhqFD5pLjpuwV1XB2Wkzrwq1J9tsNjls
	IfAFVYEaoV6gNu9T9UGS1qyfvdmeVPI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-iC_v7kjjPqu8Ig7cp7ghjQ-1; Thu, 23 Apr 2026 12:13:12 -0400
X-MC-Unique: iC_v7kjjPqu8Ig7cp7ghjQ-1
X-Mimecast-MFC-AGG-ID: iC_v7kjjPqu8Ig7cp7ghjQ_1776960791
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so53128635e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776960791; x=1777565591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPpcyNNw5A670ehN8KSLpk7tEoT3MHJiCv2Fb9unNrI=;
        b=Z//OpV5ul8B0izuI4FoJqtTgeB1AiLoZdrmCkLQxbTJ8Wb8pzg+wI5tRRXIe4x27Gk
         2sdEkWU71jw5CqtcynvlgvckWFx1awofT0Aelm9PRYFYwAl3sLc/Z0UX9YfuNMRzJvw6
         1Gz3QPNb5dD6g5kU9RGRh94Q8K27kYx9DpDkIsF0deDU5341sRecvXNiV5ulZRANaG1b
         kSBP6W7z5OuQadOrG3q7Q9mfxkkj0zvOHd9Hbol4LH9f99RgnviFzWz5DTxH23IR5KRi
         xsKu8W6w7in2u8iYeNmLCPcmYU5wmjJjFCvn+WlUAOsj826W73JpfsNwV86lyutPEJet
         ujtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960791; x=1777565591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPpcyNNw5A670ehN8KSLpk7tEoT3MHJiCv2Fb9unNrI=;
        b=a44+uB2R05njmm3rNXrRfAx/ELcjGkTcRNLmnm7Jmtsp8UjMvb6ysafRp4A5uDt+iy
         3XcF8MqSsmEAbvq712/y6vfNHiUM0YQUjgSK3slqC1C4msgWPjMMkr8LctWpjIEN++9s
         1iTXcfzCZVPuUpZ1hdktbTAfqiWi/y+iHx9przZ4Z4kkqzB+93aLtsZXZLo3ubS/xRXu
         qfhOnr/M7Y5FnUJWJeqgUmCtj20b+QSkG8DFP4pVM3cXjMJWUmxW6BgIc9ci+TBK0yD6
         4uJfM7RhmOOSaRfetH6jpWZS/lrpMT0QOPAVHspaWP6cf0I/b7RevhYWzTYXzBWC2Phy
         V1KA==
X-Forwarded-Encrypted: i=1; AFNElJ9N3a/upnFEVPRad9l+cIO0PvPRlr4nfNr5CQELvnAEsYCQoD/RYl2tbf9nCvNZi6rhXkzqcTZvuC6uM/Wh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TBJBr1fKLJdBTQ0cBFX9xrmrqg0B97fvA1QfOqHNxvvAFYtz
	5OIOJNXB9qXVapY9HR/5kj4SyBhL/0az1rPk5fGFGSt3j48fbXkRjaNSpd+Tx0X883S90iVcUYY
	RTbRFwdf1Pdj2nXXnNaDltumpvB8fpAamdwGruc0eLwYuy7pP8Dy9p592HqnsvkrXKro=
X-Gm-Gg: AeBDiesXq60/M5sHMopEA/CWELEFmjVtaZdRWNev21Taau9ESTa0GQ3c7NmCU8lDUW9
	0SW2NtAoXFkfMc9bWaTcwGx/UffceXo10/V08+zIyDfWPNB9RbChnMk7lRXAecDMdOTDp8+gALv
	MYhxBbRlIe8LNK2JiXm9B6SKhjsH9AjcJHKVSel9l3z9WubEZ8dVUoivfv5ZqbT2s8pvDJOesbY
	Xz0tE70RFsviBDc8EuQICvWJ1w46Izpk2T80N0ifx71fcOrPxCx+tb/SWAmk90+EnXGfUErUw5E
	7/lY2mURymqx44Z39w6NtmraRy1ruKFV/Ux6n43zo2PRJSfVwRjwM9gz4aidDqK4aL0RdB+E0Cm
	4+TMuxdNUdv+Ybf1F/CJgBOqfYgvf5qVyLjjXqRsLiHCJPIYZuTlM8A==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr438077375e9.27.1776960790545;
        Thu, 23 Apr 2026 09:13:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr438076745e9.27.1776960789978;
        Thu, 23 Apr 2026 09:13:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm122342895e9.9.2026.04.23.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:13:09 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:13:03 -0400
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
Message-ID: <20260423121222-mutt-send-email-mst@kernel.org>
References: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <20260423104120-mutt-send-email-mst@kernel.org>
 <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>

On Thu, Apr 23, 2026 at 05:54:26PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 16:46, Michael S. Tsirkin wrote:
> > On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> >> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> >> alone on a v1, and focusing on non-hugetlb first.
> > 
> > I just dislike it when things are non orthogonal.
> > People are used to: hugetlb = same perf as THP but more predictable at the cost
> > of being harder to use and using more resources.
> > Here, suddenly, we have an optimization but only for THP.
> 
> Note that we also didn't care about user_alloc_needs_zeroing() with hugetlb so far.


You mean, that it stays because of the reserved pool?

> It's not that it cannot be done with hugetlb, it's just a question about how it
> can be done more cleanly; and that requires more work to clean the hugetlb part up.
> 
> Best done separately.
> 
> -- 
> Cheers,
> 
> David

