Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDD3570DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955607; cv=none; b=kpJrklobF+RiqCZIM3W9tCi+Gkvrw9tI9pNbr1deSRq7mQx9Kuffa1/2S1xc3poprV1juQc/u1UtbBf1epBvMsRerNduLQDZCtj/9RzVapKko9yWPT+g92bTazq2ezylW4Yox2A469+r3CA0i603JSoaL9/tg1NSPanwfzk2FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955607; c=relaxed/simple;
	bh=FVJvwM5KEFZLpNLphp/KsAxO7UvuDFjnyOYTqZVS/Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjoqKB8Jhi75V927v6xn6s1PjsmSRdLV3jppLrfZ/1NDcxzcPp1eRV5gpjJpEn22NcfX7W0i6DejF/3Zko6r7IFuP9VgpheZgxtY2a98QwYml88wK3he3LPmKRrFP0vwNSpixh/FkfhdCBlpQU7H6vaHyBgdD07c93VOspALRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJrHBp1v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhXu9Cgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJrHBp1v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhXu9Cgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776955604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8MfwEpFW90pOYwmA/usmJLfbbJthitR1+FeR/wvevQ=;
	b=JJrHBp1vvZqx8y4oj+Mm37/zXNiW/9eqa6I53poZSxqFnfFw52Sgx/kNhWwEtAquP39VUt
	PFTQXNCJP8TaadVpbVayHf+67K5gXEk0BIr0+J4ckS7ypaM6ZRBy9rEkA1SYLB75q1jx2s
	XLkkivgkUhl2xBtaIR2g1XQeBdCElrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-oZfpCuCGPiCFKZh5pHn7CQ-1; Thu, 23 Apr 2026 10:46:42 -0400
X-MC-Unique: oZfpCuCGPiCFKZh5pHn7CQ-1
X-Mimecast-MFC-AGG-ID: oZfpCuCGPiCFKZh5pHn7CQ_1776955601
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso63362115e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776955601; x=1777560401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8MfwEpFW90pOYwmA/usmJLfbbJthitR1+FeR/wvevQ=;
        b=BhXu9Cglmq/Jt+etzMmbFne0pcCkGNnUFX9JUTQftaw5DHTnIyrkuHCUUsp3EAx0ro
         T4U++Exi1LeCdESyiVaImHV2bCB2XA1jDmYOM5Dx0ThbbbEIDVWC3a/iJxnWeqvSKyVy
         Fu+VC5wmtqt/ZOh6nrPoyHlqYOjJdOUUcXzkO34t/RRq+PO6NAeuvYuInafy7Ep/lcc8
         RvQWitiH4HF3Ez4U3w281495Gm+kzniSta7EAaj4VP/JjkqoaKn1vsYJ7RIU00cq59cc
         JiXmZZTWjOzM58C+oDLjoLlA25gavEbd8VzVycVMq4VEQvcEVkSxPtBzTUkMmSTpPRs0
         R2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776955601; x=1777560401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8MfwEpFW90pOYwmA/usmJLfbbJthitR1+FeR/wvevQ=;
        b=dJV4TXx+d34Kr8SFZGAXcEk94omNEaJ+LvL9l1xXrLV0OkOH2ZCtiexhWHUQmNqf62
         bgGsPRIid5At5la37k1TAUg/j0QqrcJbTayzofjn2OT8orVbSC/vAW9J0LEIWblLKttw
         VGTUArO8Bso9mL9LFtRidma6px7JWjEhrCSd5ytnQR/KlbM60ABnQkZui+f0e0zlSTWF
         JSELx9zsvz+mOVUNwRSk+8WO8BCVFdpHa9pqy3+qRjskH6Dx7GusJW07mZRd6+BZFVha
         1IeIJfwH6y0i5nBGbNNONckzYVIxYbO7vj35YLY4+eStxztzV/7Cf57+OIemguni6MgY
         YIUA==
X-Forwarded-Encrypted: i=1; AFNElJ+tULmWl5xgWsTzOfqn4un9RFHcnOIXi9HTp6J8JFZY6kKM9wslO2SYJAvlz/fA2INcsZ4/8OHOC1Bt+B2R@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKAl6vAJcLQFJokozDCcL3vjG2MTPhc99TUKW0lrgcpcexuxA
	MI9buYkbwuIdAXy5Wmx0MMi77rV/EeJDjo4G5SbXu+u/KrjSFPFAErpujwwhyYVATxLgn5j9uMG
	VMyjpQxb2wEjM1inJTzOEqz4kdReMTqnDsl9zJCYuav/36nYycmAOS8uKLTm/VOvCwsY=
X-Gm-Gg: AeBDievfZtH9Fyb2RcMqGU83zQ2RltVcBarGQTZPDm2A59587+BaDB6+OdNolXMLA0v
	URAtOsxgxulljabH+YjwRoFCHZkH4nGm70x5RZpFHJtK99/jHIvYe90PVPilqvOitPbJUs2wX24
	r3bdtrzM5EIFr3oEg9FC4g56UNGikfvduZ0x8qtfww0vHnK+1/ih8lksQ6hKJJ2m1OPdaJMoLKl
	yvO/XZiO5raVeTnQTvJyC1p77FssFHZXlUyzpccltAdORfil5VlHH5mzpS0Zfx66ycoYrt2EwNA
	cengC5UzR1Pb8Za/4hPXTGTbMW6EyaDw4Gj/OP6xdH2SAi0BLoBRU30F9VMYY4sBwla2tTIHws1
	gJpzX+PHMH5naVjN0KRMTW7ANP9EKGl9imwGbTOlJX6m9F2YfgqiUiw==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48a52f2a5f0mr200255595e9.18.1776955601352;
        Thu, 23 Apr 2026 07:46:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48a52f2a5f0mr200255085e9.18.1776955600835;
        Thu, 23 Apr 2026 07:46:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm540787515e9.5.2026.04.23.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:46:40 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:46:34 -0400
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
Message-ID: <20260423104120-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>

On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> alone on a v1, and focusing on non-hugetlb first.

I just dislike it when things are non orthogonal.
People are used to: hugetlb = same perf as THP but more predictable at the cost
of being harder to use and using more resources.
Here, suddenly, we have an optimization but only for THP.

But sure, we can merge a part of it first.

-- 
MST

