Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606836921C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060812; cv=none; b=BnbXEpTSkGWBagpH4fxAu7g3R4lI7fcNxIlK+Re/Hd4u0JOe8D0t4BOyRPVS6u2KlYscw61bxsGKP7BiPkNmx8cWyq2yL6FaFLc821X8NMKbeiZ/w23V1D6ezXMAusepIRae0m+vLmWwsayORvpj0PR4WvTtTl4cVDd4XWpKcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060812; c=relaxed/simple;
	bh=SAH6DfdUPSmFa7qKfS14gWSdLrFa3eaySmOQ/dPeb/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL8TerbWW/z2FK65HhOdTXHVRtRc3orIceePiTq7c15OhQ228C5FzoIT5qtIdaKApZM/fDl8fsQRvEkuxoLCka9rMl6Uq8DL/tKWgrT4FTeIUdpjXxS0d2SixhVK19Peym36UX+D2hLg0VKTYOop212jhgfJfXO2JXaiFN7Af4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Z2cD4cqN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Z2cD4cqN"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fb1932b62so39382421cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1777060809; x=1777665609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKqBvQFy0haKdUtjK97pLXW69B86nqbjxH3fSUsXZ54=;
        b=Z2cD4cqNQvPqiy3HbIMpBuIGkfdJZzeWCX9OwzT4r5j0QQ8fooqbgA9PEqN7q32uGD
         LW4Rcz5WHyIHJcaoHvAKqTlVO+dN0mchRxPKwkPU7lC1Zxb5ixR7ctjCZ9FH1PSud5d7
         M9bjDn2Uox5h6oKIKY7LqX3D2HONs5GKnMBLKEpBIirZ0SOBNf7f0vk6JeOGUB3tM76r
         DUZjaTZahtrO3XDiPwW/sv8NxlMMcjEhguGhoPs/SC+OLV9x864LN0zyjAmbSe8NkCvm
         +H20rM81qQV8y2qdn9XnBeBJyVwiiHeUUDgY2sY5MGKyjuR5mOqZaLiWPuZU5r22cK4k
         fn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060809; x=1777665609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKqBvQFy0haKdUtjK97pLXW69B86nqbjxH3fSUsXZ54=;
        b=L+UShcIp9VT632EFfIV1B9EO/DlGiFfj+IwrrO5CEovVrxVEQyhG5yxGj5GVLKV3mM
         wRKu96f2lmC+LO6leDm1p3MlnvdIlc3sqKmjQB5hqtlR3t4Nc93RnebNuYHfFzQSkvfv
         L4AK/1tDWCClD6UAUmxr4Nnwxe/8vtTHeOLYm1Y9WmT3/cnKIScHS1P9B2SNVZVRMOin
         fmyWT/Chou1y8yaJuhjQQOHaO8WsHVxlCHq4F6d1h/yv/04mxOWRPpTuuOv16+6x9JbL
         FxrO3+WJFtRTzqQe7xkDk18g6KYktxO/uXm2G8Kf1LbBfHgs9cRhNLIhKlEa8JGElc8s
         nrPA==
X-Forwarded-Encrypted: i=1; AFNElJ8hlzw2Iu49semeQ0wPM4+A7oSx857MxyEZsibprJI/t9s4IOyHCb9wXdCzlwC2GFHbFxHbsQXVOaBLKH4X@vger.kernel.org
X-Gm-Message-State: AOJu0YweoM3fVx7W+2Q4e3JY62kB1/91IhzBdWF9PCb40Vxb4v5/uMMM
	5DnVhK4yKcJqcxh7RYB7HJ8NOXly3olbk6iclokdCnZZ6t7UwGTu131bE5OHh9grJjA=
X-Gm-Gg: AeBDietzlQURXnJ63W78TGYRhuz+gZ/TDVuH8vGo+VudP4pdoAICYiFXPmAVByWYKqG
	vH1/azqBRLXRtABbVIe32NTSRDoS9E2tcY23FvSbR3EbM8Dj4FaybHhwJ1QZtlOeTcvtGaZwypq
	164lKCqGvWdNB6LakcwVUPNBYvTV+AFDnBwfIJ0VIscZVCwjNei+JPSWvhM/g3Mh8Cd6ZKgAg3c
	XJf/h39Z2OEoI6n1CM/eep9ocIo/7IzVeCgwDrkkBkaQTSvnIcOgmVa+zqmusUzUD3DfpIMEjL7
	yHjK4XYT11NHi0R66G2SFlqdgJPN2D820aVRYIjpK+i2CdJfzGaSOMEEEXEmdj3vyf+S0mGt4Ik
	HuH+8b534r9eTWvLvExcdNpZj8n+DBpEkDqSY+s28qFIDFzG/sNTF7p5ZcJboEE0hZFhauvIKZr
	DIuu7Nzko9RhQx2TOfPgMavqRtzJq3sicX
X-Received: by 2002:a05:622a:848e:b0:50e:5cc3:6f42 with SMTP id d75a77b69052e-50e5cc37bedmr276335431cf.59.1777060808338;
        Fri, 24 Apr 2026 13:00:08 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50f13ba2509sm129707921cf.8.2026.04.24.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 13:00:07 -0700 (PDT)
Date: Fri, 24 Apr 2026 16:00:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <aevLw0DsPOEeRd-J@cmpxchg.org>
References: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
 <aeKO6bKupHa2bgWt@casper.infradead.org>
 <aeaKAxrAUtfwM9ns@cmpxchg.org>
 <oi2kit3a2qulr53c7j3h4g3cjjgbss4kd2djdqota2sriiaaov@7uewnraaq4gk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oi2kit3a2qulr53c7j3h4g3cjjgbss4kd2djdqota2sriiaaov@7uewnraaq4gk>

On Fri, Apr 24, 2026 at 12:45:32PM -0400, Liam R. Howlett wrote:
> On 26/04/20 04:18PM, Johannes Weiner wrote:
> > On Fri, Apr 17, 2026 at 08:50:01PM +0100, Matthew Wilcox wrote:
> > > On Tue, Feb 24, 2026 at 12:10:26PM -0500, Liam R. Howlett wrote:
> > > > The Maple Tree needs some enhancements:
> > > >  - Support for purging shadow entries from the page cache
> > > 
> > > Liam and I hd some preliminary discussions yesterday around this
> > > and we'd like some feedback if anyone has time before LSFMM.
> > > 
> > > For those who aren't aware, when a folio falls off the end of the
> > > LRU list, we store a shadow entry in the page cache in its place
> > > so that if we access that page again, we know where to put its folio in
> > > the LRU list.
> > > 
> > > But this creates a problem (documented in mm/workingset.c) where
> > > we can fill up memory with shadow entries.  Currently, we embed a
> > > list_head in xa_node and add nodes which contain only shadow entries
> > > to a list which can be walked by a shrinker when we're low on memory.
> > > Ideally we wouldn't do that with the maple tree.  There are a few
> > > options.
> > > 
> > > The first question we have is whether it's best to keep nodes around to
> > > wait for a shrinker to kick in.  Was any experimentation done to
> > > see whether eagerly freeing a node that contains only shadow entries
> > > has a bad effect on performance?
> > 
> > Hm, I'm not sure how that could work.
> > 
> > The LRU order created by readahead makes it highly likely that all the
> > folios in a cache node are reclaimed/made non-resident at once. Going
> > this route would destroy a large part of the non-resident cache the
> > moment it is created.
> 
> Not the moment it is created, but the moment the entire node only has
> NULLs or shadow entries.  Meaning it's removed the moment the last
> entry becomes a shadow entry.

I'm saying they can be often the same event. Readahead means LRU order
matches file index / node range order. So there is a good chance that
reclaim batches will create all shadow entries in a node in one go.

> Still much sooner, but not as extreme as just dropping them immediately.
> 
> > 
> > The goal is to garbage-collect the oldest shadow entries whose
> > distances are too long to be actionable at this point. Specifically,
> > their distance to lruvec->nonresident_age (per-cgroup, per-node).
> > 
> > In the current scheme, we just go in the order in which nodes became
> > all-shadow - oldest first. And we only do so lazily when the
> > non-resident cache is far into that territory (cache set vastly larger
> > than available memory). That gives us confidence that we're mostly
> > dropping very old entries without having to look at them one by one.
> > 
> > We don't have to stick with that design, but whatever replaces it
> > should meet the goal, or approximate it well enough.
> 
> The goal of garbage collecting the oldest shadow entries based on the
> nonresident_age.  That's a broad target, which I think is made more
> specific within the implementation to 'groupings of 64 shadow entries',
> which I bring up later.
> 
> Besides the locking improvements that we can bring, is there anything
> that you have found doesn't work optimal in the current solution that
> may be nice to fix?
> 
> > 
> > > The second idea we talked about is that the maple tree is much more
> > > flexible than the radix tree.  Having even a single folio in a node pins
> > > the entire node, so it's "free" to keep the shadow entries in that node
> > > around.  But with the maple tree, we can be much more granular and
> > > delete shadow entries in arbitrary positions.  So we could (for example)
> > > keep track of inodes which contain shadow entries and purge shadow
> > > entries when they reach, say, 10% of the number of pages.  Or 1000
> > > entries, or some other threshold.
> > 
> > It's not the volume or the concentration of shadows, it's their age
> > that makes them good candidates for garbage collection.
> 
> Maybe I'm reading this wrong but it seems workingset_update_node() adds
> nodes to the list that is composed of all shadow entries (or removes it
> if we have changed one to resident).
> 
> Doesn't that mean there is a concentration of shadow entries since the
> entries in the tree are in order?
> 
> That is, reclaim is at node level granularity, and the nodes are sorted
> sets.  I think, sibling entries aside, it's fair to call that a grouping
> of 64 shadow entries?
> 
> This also means that with today's code we are keeping older entries over
> newer entries because the node has at least one resident entry.  But
> that's fine, because we can't gain anything by removing them today.

Yes that's a great catch.

It's the last eviction, i.e. the very youngest shadow entry at this
point, that suddenly demotes the whole node to the "old" set. And
there could be much older entries in circulation that just happen to
still be next to a resident entry.

But I think this would require a pretty spectacular breakdown in
access locality. More likely you get mixed nodes when individual
entries refault. And yes, not much we can or need to do about it,
since the resident entries pin the whole node anyway.

So the question, I think, is still: in what order do you reclaim a
gazillion all-shadow nodes when the time comes. And the answer to
that, IMO, is still best approximated by going in the order in which
they became all-shadow.
