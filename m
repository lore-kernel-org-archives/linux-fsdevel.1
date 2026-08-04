Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFE136672
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876482; cv=none; b=ktnDWOBNYgywTUQ9mwf9BRmVHEkwg3alg9kLEonXv/b98TtYFpe91U6rx9uk8DESfm40ezmf9pUAh74822qlCaCyBISm0uwnHeEkOTqYOeVjkJcUXD84vHCyW6Ge3NxBATyNgjkCWNOkI0fgOGc0TbNXpogEA3BliIXnKBgvYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876482; c=relaxed/simple;
	bh=kmuAZ9Ris9NMBoZaQyNLzWeokx01MIrR6jilxPT3MoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/UNedbPtIHNS4UkPCP1SnwXxZihDXyYBbwT0tzKLH8oKEzxDbn7rxC3O22HiPVEbBCP8ocDGkJzJzg6BK2cfGcQGCcCr39w/mWBv9mcQivCFjYpJk9oYp3a/N1KYhpOCtKv05wgBskcS3B0lUa11SuyeYMKwJMG4bMPrhOXSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=qZ9lLAB8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="qZ9lLAB8"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0a81d286so9871331cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785876479; x=1786481279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5nyhXmOrB2zUXHw11JnHUdAjL9ArQB4qSPGcWi6REo=;
        b=qZ9lLAB8tomBY8FiU3vmOks2etMtr215xozPJq38Akxzif7pVBNgiZei1Q5GJfWDTW
         PhxLt6EAU23LbaCnnovsmSqtKk8kUk4oDkx9q4nSgOicsIJSb3H5QaMtQfteyTI5twed
         WdGRRWj/grm1Hawq2Y/KZ5onyuZZJDLbtPfcrj1qLummHUXerNwU21iZvxZEvE4BECl4
         zmdOwrn8qDRrI1HX1AX/KVyJvDmzsSJW2v3TqhYaWznxYavHRB6Lx+4Mn1bE9RNRmZiK
         gckf9zyg6pgRPtJYoajVEQFd7X0C7h5w0c8rKQ3YLcF08Tu/MR3ef9pYv/4UYiy+ZabF
         A2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876479; x=1786481279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5nyhXmOrB2zUXHw11JnHUdAjL9ArQB4qSPGcWi6REo=;
        b=UfId3qxgCpP1CPxD5HZLjmNbULEM/k7pl7babhIKlzu05dPTrvw/emzhZ1s8q3WkkQ
         vRvFbXYcRag8vQwA3NEYZ+kqPQifdDxqYChmFR11t0/tc60/99ilUK858K4LjAEie1aq
         +U2NKfbftiTm4s1CJTPkUQGz7Usk8AQy/TAKGmCeunBe9OCVYuv6Fjb50UGFbHgXmtZc
         FdmjYkkFIz4aac/y7hAbOGf6d+z8hNeytEIeq+TxOdzaRr8SY3ezJvItKhClhmkeyNj/
         LsiHUloHPawk1v+lAz06/CsWtf6quz9gW+i2+xd4YapKGshsqJ/N3Ck7ks6x/6qTBFRs
         nKBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXihJRkzCjbZk1F6UMzWKV3lxois7o7iO6+TxTSnjNVWxrTQE/FnYsITTavkYKGXQ8ZEys74ZT7UCfbV/S@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBM4K3pA50fe7a2W7VGbSIXYvI6LtHkj+D7BgWNvuOLEyBAP5
	+x3BIJ3Wx3p9QmxoWJuoT4UBsWu2xmF5jrWPbUWZsPZ+Hu1Yy/h0KP3sl3D9iE2HAiQ=
X-Gm-Gg: AR+sD12I7NPncy1u8C9WXgrCSkJJzItt0MCdGhdBdB1ZAv9vdTdwonFyH09oeQQfB3k
	p4+GNCnNUeSTHXEbn3X9gv6FESmzcvMlVGyhF+6FiIc3caKytn7qKi5U4NKumoGjaJRk9laa/iR
	Q0MSPFXui314hfyzTqT6yyLuZ9bc3PzyINKk3q1gCk6B+WIRxVV9xi1tPMXbVllCLEFv4j8Pl7C
	1yxrQYn19G3YLqso2ELFCPc1JCRODkVAA1H3u9xgB1WplYsMmLO+yHuDz9R9Sn8Bkm3oLmDl9a9
	CkhjlNOgAbGeHQKwWKmFy9UPCF21kfSymLG/CH5ZLCZNprmkJK4O6Hizs75LG25qmlJIhjfLkIp
	Z1HbKGx8qgBuglcYJDvKNnnUm7+5Wx3C2RyOEHcWYCMMXHWdtEr0j2BErC+1GABQJeoI8PAAagh
	r3IiJT8NFBSabPw0VSbYu/dUbkeFGpCo7G6mypuNrK+OkW3l5OgE0du1qk+Hk=
X-Received: by 2002:a05:622a:1448:b0:51c:1ea:e290 with SMTP id d75a77b69052e-52ce5d43adbmr22028211cf.17.1785876479124;
        Tue, 04 Aug 2026 13:47:59 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce87aa1a3sm1446391cf.6.2026.08.04.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:47:56 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:47:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-ID: <anJP-FXqH3iNjTJ_@cmpxchg.org>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer>
 <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>

On Mon, Aug 03, 2026 at 11:02:30AM -0400, Zi Yan wrote:
> On Sat Aug 1, 2026 at 5:36 AM EDT, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Jul 30, 2026 at 10:18:00PM -0400, Zi Yan wrote:
> >> During a pagecache folio split, an xarray node allocation can happen and
> >> needs to charge at folio's memcg instead of folio split invoker's memcg,
> >> because for example folio split can happen during reclaim and reclaim's
> >> active memcg might not be folio's memcg. Switch to folio's memcg at the
> >> beginning and switch back afterwards.
> >
> > I assume this is the only allocation? I guess in general it makes sense to have
> > the folio's memcg be active here regardless.
> >
> >>
> >> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> >
> > Cc: stable?
> 
> Like you said above, only xas_split_alloc() is affected. And we have not
> seen related workingset regression report (like what Johannes reported
> in commit 7b785645e8f13 ("mm: fix page cache convergence regression")).
> It might be OK to not backport.
> 
> Johannes, what is your take on this?

Yeah, let's Cc stable.

It would be a bear to debug if you ran into this at scale. Which I
think you could with certain workloads.

The patches are straight-forward enough. It favors a backport.
