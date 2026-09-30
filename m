Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2350B41B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782406; cv=none; b=q8iui0cOogubpuWvCql3eHDU+IiGYdH4WpARWaTgGG9kmSvLLUdWGTmTrttDLH/b/VlwMYSmfBM4AzD0Fxrmt18MOxlvpsPrsxVerbgZVHrzySlBCAiw2Hw+U/T6l/ilgqug7RCH/VLOZYeLOYhd2WLqC/eQNfgN7dccZexW9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782406; c=relaxed/simple;
	bh=pjsxlzcaP4Jz8G1QUkQ1Gl14XgeIyzw5zbr0od9rBc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPLZvohl/CNMgJfntBWNEcApb7SwK/Ucpn1iOM5jMfieZd0nVSr8m9EVT90D+S4o/JYv1xzq49o5FVNQjsKKpP5rcCAV3ju0I4DaanLLKCsFTtnJViSaYRZ2GMoETex5U+Dvheiq3JelazRtB4us2SmNAbSxfvtLYJLzRhdzrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTD5D1us; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTD5D1us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E3A1F0089D;
	Wed, 30 Sep 2026 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782396;
	bh=p2flYhRhbQtLQjkb4F9DovxNqyIJkhi/OOFcNtiaROM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTD5D1usKNsB+hEJiS2kC3xYC5Pggxaus6texvtAHrKHVEm9Qy1GdmOWiNqmwlXw1
	 thw4oVXOYj4r3gZ3PJfRJZlZcAEdq+OygbVJRcxw3zsZtE0fzxfm4IXIHomHuFcRLt
	 M2SIj0we2XT0p64oY/gNwLn9japMMnUGrtmOBswxWvbh+FeV7XBFgGYcPcbc/tOeSM
	 VhrDg5qZsaQiAC3pi/LGMN602vTsG7f/1uTVxwYn3jqjx/BA/olzBepyT+Tyqlhxqp
	 qoIH+nUzb8m5uzzMp8SeLqS8gXql1IZnfqZbr2Mex/erIz9pCduosu417Qhm6zmFlt
	 Ya9va1Jmf+ncA==
Date: Wed, 30 Sep 2026 16:33:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <ar0mdJKLC0cHBoKM@gremlin>
References: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
 <arz8Plu6J4YOTi0a@gremlin>
 <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <ar0a9y2E0nDTIC8V@gremlin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar0a9y2E0nDTIC8V@gremlin>

On Wed, Sep 30, 2026 at 03:24:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> I strongly recommend you look at a shmem solution.

To expand upon that:

The general structure would be something like a minimal process, with an
oom_score_adj set such that it can't be killed (or is at least very unlikely).

Have it do something like allocate a memfd.

Then have that be as minimal as possible - it sets things up, it hands off
memfds over a UNIX socket for instance, and is set up to periodically write
back to disk.

That way you have something that should never crash/exit which gives you the
guarantees you need.

You can then also control how to synchronise things between processes, when to
write back and how much, etc.

You can keep it in a cgroup as well to isolate it from the rest of the system
too, potentially.

Then have anything that does anything non-trivial be clients of that.

Everything works as before, you can ensure that intermediate state doesn't get
written back through whatever mechanism you want to employ, and you avoid all of
the pitfalls of writing to a MAP_SHARED file-backed mapping.

If the memfd isn't enough for you, you could also have it establish a tmpfs file
which is then shared between all of the processes. That will survive even the
establishing process dying.

The main win here is that you can choose when and how to writeback using any
mechanism you like.

For instance, you could have a dirty bitmap be part of the shared memory and
atomically update the relevant bit when it's ready to be written back.

That kind of approach gives you total control over when and how things are
written back.

And avoids the known issues with writing to a MAP_SHARED file:

* Terrible error handling - random SIGBUS's, network file systems in particular
  are very problematic, writeback errors are hard to obtain (fsync(), msync()
  needed to even get them) - note the tmpfs compromise mentioned above has this
  issue too.

* No control over writeback - Exactly your issue. This is what you're trying to
  work around.

* Writeback stalls - as above. The dirty writeback balancing bites there.

* Reclaim - dirty pages can't be reclaimed until written back.

* Fault overhead - every fresh dirtying write is a page fault (that's how dirty
  tracking works) and you have that overhead throughout. Once written back it's
  cleaned and causes the same cost again next time.

The TL;DR is you're trying to manipulate logic whose whole job it is to
writeback to not do that.

So stop doing that :) and life is much easier.

--
Cheers, Lorenzo
