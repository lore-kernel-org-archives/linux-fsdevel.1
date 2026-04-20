Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81041A6834
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716299; cv=none; b=fBFalKrjAPztrMva66RYn6dUW7e8uJDTHvm6XXRVGSKBNaxP5Ev5XxExQ4Ckm0BrLWRNDbdi//Rj450gfaxIV2gcos5G0SGqdiitl4nFK0aj0jtpu1IfOfRkVZQXsQubiD3xscNhFT1s6hUVq0+Ic7c/UKo4FBTJ9EAMYZd1AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716299; c=relaxed/simple;
	bh=ZbEig6PHhcPQ6Wi/gABcEfI1wg5GE0NqX4M/ywjWY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf1fdUoRGiBsF0HKr/pZfbIq1UK80Sv5svQt1jnkYTNtjFB9BaacOSGCP85AMeEGUcExCJ7L2prPOaSXXsEJLSTnF+xKIa8JwKrEfnDtN9YcpBEiTnt8RxNLcxcl+RVTRz7Vep5XZPD1hV3rJZa/Yom9uKxFQjiQPP5CqgkAEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=B6LxEf1X; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="B6LxEf1X"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca2726f61so42922576d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1776716295; x=1777321095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu0T6TGCkXYKWwEMylQaN73AMHLmcLO/paZjNPSUEYQ=;
        b=B6LxEf1X+UlNovGzr5kLIIji03sdJ4Vq3j4cdC/L6OA0ub9OdtJtppxnIX3+MwnSS3
         EHiueZzx+R/es/QND8HAWho6yqqfpRWhcD8Fs1/LdgFy+gwGeYsq8cBR6iSWSbwRXiND
         58JDR5/sAkxHI9ElFmrzYtjZxm+rcmvJakqeKE68ugN07v2aYNA6QYE4WGjNfC5HbJ6J
         EWRtwDfv3yS/GS/2Y83WhrHv0ySZm/y7p5+F3mh6Ge4BmIrth8lhK+WnRMPmaahzRetm
         9mEKeRsqDJqjjja333qM88xgxKUWV/mU8m7p/YYh970tEgqUNMMQ1vzV9IBTXXhOAXWI
         +ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716295; x=1777321095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu0T6TGCkXYKWwEMylQaN73AMHLmcLO/paZjNPSUEYQ=;
        b=IiULMKRpO72vrTfAS0ky23je78/z8E90kUPFcCpmNIZZnv7e/6wZQlFL1WVMhls++9
         q+dQaJIYmHLWkErRNRjMooDo/5VCCCvHwcN3AyZlzrlQu0TUUWNIUH/ncfDQiElD5Eoy
         uD+q2FKyaIQVGocFiHgxlJDSCBidIpez7rwjbwIan24K5g3RFE/eE1/frj7ziUSwmbKv
         LgyCYhLGK6pSGCDU12RcubYr/+kojj1AWFNoK5leHl9ER64MEcu2pTghBfx2hDRc0ovD
         L9QTJEFH8TrLelVd97GLZegyUQ+O2fknoxtPkfabeFjeGt3XZgueHEVURRhHPQPJVTXb
         3sYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9vw2ewRUYWfYKMwwuiMZgqJicZ4tBPoKmApuXgzMS3aGqxN+FjlChUCRyExRj0TdCE/z5okCsEpuZvMmV@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFxJ1k9d/sTHwpDjX0EpxWrnDSBiTv3pQsOTHeKElyCkm36BV
	Dz/iGsTN7mt2Tb1FX8fuFrTGM2nXIQKGgt6N29BayXRSJpO2r/7/Quv/2HPl6Ke2mQFzvq+B20t
	24pWz
X-Gm-Gg: AeBDiesbJxKGM3GNiYrgzwWCp2hVYbvS7Qh0X5dldaox+HGVI4KqqdjNGpM+zpHzAFl
	3fuyRZuwqUmL01mhOyzHSxYN8+Pia7ewl4All44n7kbVPL3SSZL10Y2HijURniAXJES/uFvarMN
	7+XNR67Ln9nJpiHOyOEPm/No24c4/aRbfi2ghE4nrAakixyZgLGB/SVO0X6t5NjKflbg7YrW2r/
	F+8u+icJK1p+Ji5Eme6rvv56lPjqJ1r3X+U1aoVlpT+rOpNd8Rc2c9Al4pZdhUYkLAqotJFAUYO
	kuQHrlSQRN5UVb1CybH7lnjX0o232vJ2Xw9N/2whY598VTMlsloPAdp42RnyNtbonLC8+px3rhr
	UjQ9HJx3G1ioFyX+RAJmUAvb7PhlYVoAB3fJYCua57rzC383pOmArfi+/DzEadPVzpAFx2tAgte
	FUt4At+TdmgPp7elBar56qkAiE8Qpn/XZMKzbS97nMv5M=
X-Received: by 2002:a05:6214:2a46:b0:8b0:2d20:ff79 with SMTP id 6a1803df08f44-8b02d2100femr237889216d6.27.1776716295400;
        Mon, 20 Apr 2026 13:18:15 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97347sm84300596d6.41.2026.04.20.13.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:18:14 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:18:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <aeaKAxrAUtfwM9ns@cmpxchg.org>
References: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
 <aeKO6bKupHa2bgWt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeKO6bKupHa2bgWt@casper.infradead.org>

On Fri, Apr 17, 2026 at 08:50:01PM +0100, Matthew Wilcox wrote:
> On Tue, Feb 24, 2026 at 12:10:26PM -0500, Liam R. Howlett wrote:
> > The Maple Tree needs some enhancements:
> >  - Support for purging shadow entries from the page cache
> 
> Liam and I hd some preliminary discussions yesterday around this
> and we'd like some feedback if anyone has time before LSFMM.
> 
> For those who aren't aware, when a folio falls off the end of the
> LRU list, we store a shadow entry in the page cache in its place
> so that if we access that page again, we know where to put its folio in
> the LRU list.
> 
> But this creates a problem (documented in mm/workingset.c) where
> we can fill up memory with shadow entries.  Currently, we embed a
> list_head in xa_node and add nodes which contain only shadow entries
> to a list which can be walked by a shrinker when we're low on memory.
> Ideally we wouldn't do that with the maple tree.  There are a few
> options.
> 
> The first question we have is whether it's best to keep nodes around to
> wait for a shrinker to kick in.  Was any experimentation done to
> see whether eagerly freeing a node that contains only shadow entries
> has a bad effect on performance?

Hm, I'm not sure how that could work.

The LRU order created by readahead makes it highly likely that all the
folios in a cache node are reclaimed/made non-resident at once. Going
this route would destroy a large part of the non-resident cache the
moment it is created.

The goal is to garbage-collect the oldest shadow entries whose
distances are too long to be actionable at this point. Specifically,
their distance to lruvec->nonresident_age (per-cgroup, per-node).

In the current scheme, we just go in the order in which nodes became
all-shadow - oldest first. And we only do so lazily when the
non-resident cache is far into that territory (cache set vastly larger
than available memory). That gives us confidence that we're mostly
dropping very old entries without having to look at them one by one.

We don't have to stick with that design, but whatever replaces it
should meet the goal, or approximate it well enough.

> The second idea we talked about is that the maple tree is much more
> flexible than the radix tree.  Having even a single folio in a node pins
> the entire node, so it's "free" to keep the shadow entries in that node
> around.  But with the maple tree, we can be much more granular and
> delete shadow entries in arbitrary positions.  So we could (for example)
> keep track of inodes which contain shadow entries and purge shadow
> entries when they reach, say, 10% of the number of pages.  Or 1000
> entries, or some other threshold.

It's not the volume or the concentration of shadows, it's their age
that makes them good candidates for garbage collection.

Searching the tree for all-shadow nodes should be possible, but you'd
still have to filter for age. Naively, that would be unpack_shadow()
-> workingset_test_recent() for each one, but that's likely too heavy.

What might work is a monotonic ID counter for each node that becomes
all-shadow, then search the trees with quick comparisons for any IDs
below a certain cutoff?

> The third idea is that instead of having an injected list_head that we
> keep a tree pointing to inodes (or even just maple tree nodes which
> contain a lot of shadow entries).  That's not how list_lru works today,
> so a certain amount of development work would need to be done.

Ah, so you don't need storage inside the inode or maple tree node.

That could work well with the monotonic ID counter, you'd just scan
and reclaim through that tree, oldest node first.
