Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FC3BD225
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419951; cv=none; b=hIeJBgD1y3D0Rx/vUImDHjDLSAr4hVWg//nlVgori9GvFql/uUM+8yOMd7be1KvxMxhC4KBMZ6FRPxjeOxvP/PCJ9hU3Xd2c4UkVl7dqx55JBoFVxLypdnhPW3t7Pj/CYYX8BdDJsMht/FYhv4U5tW+PISsW7A2LPn+pTEM3mCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419951; c=relaxed/simple;
	bh=gqOFLV/X0owYRcnHzvrsp/DH0uPVs/VkzGR4wK4JoEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXj+nc2McgLxZd+nplgQVe3Npv1mwd38WvPiM1DQzG2kMxl7NrAfDAUZf4UbBfWtNAtvpVsVTLJgyyX1z3DNetiXjAT23BcDRMANMBJIfSQEmAjksK0XspzwnSA+Qnt+Ws1pRgAk+vdo88hOx0Bt6+wqUHbWZmBv22PE/Rtw2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CosTi2hp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H80CHPz7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CosTi2hp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H80CHPz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783419946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VR1L8Tfvs37DPjneOYKS8+jqtMz73BhJHMeN7x0oADU=;
	b=CosTi2hpCzSkvSZZrCmpw95mibtDmdwOVSHWDvx1pp0cLhllPd4sFcgDLxeCwPhQgMy0gf
	BV31sVf2ZwlviwtAei81BFKZVoHXywBf1smbi2I+HbSnO9iDeqIuruFzOaWx3yHKQfmIqx
	LvS31DOstIiiyGiimCIfSSuzNHqk9Dk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-boSt3-o5MQeQsrIW0ylrIA-1; Tue, 07 Jul 2026 06:25:45 -0400
X-MC-Unique: boSt3-o5MQeQsrIW0ylrIA-1
X-Mimecast-MFC-AGG-ID: boSt3-o5MQeQsrIW0ylrIA_1783419944
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c20d0468so54496585e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783419944; x=1784024744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VR1L8Tfvs37DPjneOYKS8+jqtMz73BhJHMeN7x0oADU=;
        b=H80CHPz7hdZ4YxDRwymNtvbd3cxqfw38gmdOX40ME8Rs8xS0s30rtLGkA3/gAyWU5z
         ViHr0FeMjbWGPnJebiWzyIai/YOlhaB4x6JWlHYF0/sEo65hQyIU4C9P2UdJ1TaO2to3
         /elUZ/mCHYw2b45lIQlpjJmmue/vNZ+5lOCowJSJs/qWIVAR3n8Anubep6loai3m5aL5
         +rf+t8+E7mLtnIu3FQc8+KYZbvGfPKvaA/R9WtV+dmSNCG6c7qeDVCMKM+gL76mxBFkW
         w+J73PL/kNmNriEUzhq4LV7eaHzI12BLNAvfdZouzws66GzhUSSZ8t9dbtyNTcj8n1jO
         6wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419944; x=1784024744;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VR1L8Tfvs37DPjneOYKS8+jqtMz73BhJHMeN7x0oADU=;
        b=AAegLwJ5EDR/oNqNV5B8IqIAipG7BLrDk01ZGmAj6XbzbdmwcGIXr9fiK4UE5Pi+Gl
         eN+EHRP86wRF8dAMOnnZ6dopmOYkp2rRWxrE5UqBAdd+aXZU3K0/iPctWfbJRMxX7LI8
         iYAVk/n6Hf+pqU5ViEYkqwkdFfjTOTnzlE8IPjLnXOH6QkquOBnSSG8e5mSIOdcVygu/
         5B7Vn2sYVge5TVgGprPI8vDUURA2TItPio3uvfzRqai3S95BAj4rSaE/63vbxvHWubaQ
         cCk2o9chLq+lOwSvX90czmz+rGDvbrIj7YGZAUKEPw4rtw4fDPrMdBi60DaU8UnN3Jdn
         3Fgg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+V5uh8D/CeVersdgB9H4lHLZj0UxxhPvI8mR/TRHwjs/l4qQrz/mCZ3tWLD8YS6sQRZ1hJMuohPNXcZjs@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkmzHM095SSn510hHRxAhAScMgU5XqhtAxhouf7AlqdezxcY5
	HncR3srrRfjBK592xjnFJVNRF7TgwIabvjEjQQ4DH6ii1CbVEnxUCrn/SxYNxmC+7KqxzNIysTB
	mp6Rcytsh8NykjMKYjzQeEr8D1KOOb3IR8uGj30HsJsKapK9YWj+qHzwf+x2teCXi22M=
X-Gm-Gg: AfdE7clT+FKUE+Zj+41gAlJ0B/T7mOak0aGeil/hr/a46yiZf825fL3ncHeURb4rl2M
	uj7YcFFT80LyqTFWPpqx6mxIlos8tSO6miPv3VfvF6T9qy/q0+kDQw4XqXhNdWkkQlaxxiN4m9o
	r41Gxa9KVW3EX1aLgU2/65xSJjeg9Od4Ek6+5oQ8aUsDbYrgxrUKLeY+RFywUgCkoWkE7muAfxE
	u3A+sSSzytDh5tQsFeAAVShz1TxC2HbNTtojzyZx5LHaa4ayz9lGewXHckbl6+LDm/McIOGlYxt
	XnxjhJHC2Rje4xvLaI6uKhOkIjrdhnUevDfl70l9gvu1irWhZLIazpRspyHuKHuG9kdPhentZfz
	Cg7GMZsCzMV2fLsZl00HkkC44pY09uxQ4
X-Received: by 2002:a05:600c:1383:b0:493:b647:1acd with SMTP id 5b1f17b1804b1-493df090a95mr49449445e9.36.1783419942328;
        Tue, 07 Jul 2026 03:25:42 -0700 (PDT)
X-Received: by 2002:a05:600c:1383:b0:493:b647:1acd with SMTP id 5b1f17b1804b1-493df090a95mr49448105e9.36.1783419940603;
        Tue, 07 Jul 2026 03:25:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm32286020f8f.24.2026.07.07.03.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:25:40 -0700 (PDT)
Date: Tue, 7 Jul 2026 06:25:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sourav Panda <souravpanda@google.com>, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mhklinux@outlook.com,
	fvdl@google.com, gthelen@google.com, mike.kravetz@oracle.com,
	pasha.tatashin@soleen.com, rientjes@google.com, riel@surriel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
Message-ID: <20260707062428-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>

On Tue, Jul 07, 2026 at 09:29:07AM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 08:42, Sourav Panda wrote:
> > Overview
> > This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> > backed by a kernel shrinker to safely return memory under pressure, and
> > integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> > specifically targeting gigantic (1GB) hugepages. The goal is to solve
> > the tradeoff between allocation latency and memory
> > fungibility in virtualized and heterogeneous cloud environments.
> 
> Hi,
> 
> in general, we consider hugetlb nowadays to be mostly in feature freeze, as we
> realized a while ago that adding more special casing on top of something too
> special for all of MM is only going to hurt us more in the long run.
> 
> We want to have less special casing and less special sauce, not more.
> 
> Now, there is nothing wrong in making hugetlb be less special, by making it use
> more of core infrastructure etc.
> 
> But optimizing for surplus hugetlb pages by teaching hugetlb about new caches
> and its custom free-page-reporting support rather looks like the wrong direction
> for me?
> 
> -- 
> Cheers,
> 
> David


It is currently bypassing free-page-reporting completely.
Making existing free lists not ignore free-page-reporting would
maybe considered "making it be less special"?

