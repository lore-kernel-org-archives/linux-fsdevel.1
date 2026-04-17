Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5813126C02
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397779; cv=none; b=OqH06z+8Ux1oqgei3ZzrTaYvqT23IcXN2SL26pF/FpU94wePRE/fzGVE9uO1JmbuWnFKnmmucSXzfekKcwrZRxqPpT1RrBkoayPFqvYNGqaFXZrYe1msvhsnHsk1YbV3YoFLY4ia1THA8eStjCnRvUG33d6XvwGFPynRCJRzSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397779; c=relaxed/simple;
	bh=0B5H2P8mBfGSUUI0p0aDJZX85KBZrWwukS/PjfMEs5c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=GPJkYKMbhYvS4vn9mNWTSGQv0/JSo5m6fUiZDRq+6wM90Ovxurcd6xcgVQA1CrI37vn2Nuj6+0eSc9o3BxdkX5wBWxDxySp/0iTAN3ZFjqtD/2mS2tcFfVsQOpWL4PjCwUIxB0bezYwZZRs+zmL3ywLIFXa9m+aINWTSecBpmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P98dDbUO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P98dDbUO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3591cc98871so107148a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776397778; x=1777002578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOIYn6Vs3t3hB4T19aQ0W0U21onG5fYSXjKIJbShOas=;
        b=P98dDbUOSXADXTgICZlLDQimU1yWb2pvDptFjQzh/u2cB5v7K4ZMLYWkwM0MDPNmjK
         h922I9REjS/eYYzmODrjjvsN0ymb1Ycn31NhsEvNfKSgDorhfxFj+4tzHphZnZfkhu2W
         ISYvEVpl9LeQlDXw/QFsjnHfWMLut6QC9JPFqSKnQzFRhDMBzZMyrmWpUwixELm2s2BY
         6qQguO+qtcdh0qMFF6x78bPdy2TDrBAocwq9LkuvnIt+hpg596uXM/ErMDEmvMfBVxo7
         KnwZlLASjPnICAD/mWI9BVz32nlNgnBsdVt5odMhluVzgcyTqtuDAM9k0wmqbcOIVXXk
         sjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776397778; x=1777002578;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOIYn6Vs3t3hB4T19aQ0W0U21onG5fYSXjKIJbShOas=;
        b=iRSbhw8S5CrdDSP4Ry8TWoE1ZBejKdgzfyXizW9LUvg+dhrP8TVfRWUfZx12Nd+Px1
         B7iThfIijrDmS6zTCQuODzehOtZkkkPnUIBmcIZwyKkqVOQnReXzCkeEt2qBg1N1wKT1
         zr/7U7PfN9qrKjbJsrWykyK9qDG1a5PwcPPc0EA0hu7uR/FZDAjdK2E1GdB4qPPwZByU
         +GpuJX9o45QeMcgxiY5x7gTgTnFZsRYaDeEfcJBUtV8K+Ada4lLU0AYGQKOhXz6ful5z
         uFJqgwpOjAaFnMINSuI2aBWP5hpW6G84TBk8XVxnhJo0x6HR5FBT6UtcCRSCWLVzfGPA
         c+2Q==
X-Gm-Message-State: AOJu0Yx5yR1EW1MYu+U9p9YY/CQVMuKy1/x1qFOuZWzXV6T5PWUfRKuZ
	isJFvTcSHBQgSgt+gKBLe0Uq5vBhwWjF/JNCLxqc0fO6RFaSKQudPFzo
X-Gm-Gg: AeBDieuxk00TzJzWtsPcD/9EFAz7LepplPbyhDSVJxfLJ5MiMulWFB4NpPqQDv6ilx8
	FA9aLDUu6Rb4iOKSMThVvfEgdy6hqC8oM15vW9PjnErk/MmRnbELjJ9GlEK5gItBgi+x7LkjLmy
	aXh6mJNpqREplHNIzGmuWmoxr2ho7Ge+zarQvMqaBxRVprFDSd4e87yrTXvlUzN59hM66UaPf3N
	fxh8j78LyD/GeQBNykFZap11ZNAYNOlgpnAC7Gc4Se36jT9+M7B/FViRHVEJKv3/KGSkemI1LC/
	KYCqeVM4WiiI+OItaAxZ/5q3Puz+e/t/noc3jGA2U5TzPSFJQm4CS6/THrvTn9f5gjri3IsYmfD
	g+BoDZoIofw6c9udpk46TpjsJfa6QvUlk1WflDw8yOyVnVqSJZg+p6NyM+hQDq8oYlANlgKleIV
	dDTyXW0plDw1EJk5Um102f0DCMvdhdwrpa
X-Received: by 2002:a17:90b:2e90:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-3614046e0b8mr1021853a91.17.1776397777891;
        Thu, 16 Apr 2026 20:49:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm392590a91.3.2026.04.16.20.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:49:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline flush for IOCB_DONTCACHE
In-Reply-To: <52b81c4d1fb2ad0e07b3b3b4dfbd3d36e8ee3e7d.camel@kernel.org>
Date: Fri, 17 Apr 2026 08:25:52 +0530
Message-ID: <ik9qthvr.ritesh.list@gmail.com>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org> <20260408-dontcache-v2-1-948dec1e756b@kernel.org> <tstklxm7.ritesh.list@gmail.com> <52b81c4d1fb2ad0e07b3b3b4dfbd3d36e8ee3e7d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2026-04-09 at 07:10 +0530, Ritesh Harjani wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > The IOCB_DONTCACHE writeback path in generic_write_sync() calls
>> > filemap_flush_range() on every write, submitting writeback inline in
>> > the writer's context.  Perf lock contention profiling shows the
>> > performance problem is not lock contention but the writeback submission
>> > work itself — walking the page tree and submitting I/O blocks the
>> > writer for milliseconds, inflating p99.9 latency from 23ms (buffered)
>> > to 93ms (dontcache).
>> > 
>> > Replace the inline filemap_flush_range() call with a
>> > wakeup_flusher_threads_bdi() call that kicks the BDI's flusher thread
>> > to drain dirty pages in the background.  This moves writeback
>> > submission completely off the writer's hot path.  The flusher thread
>> > handles writeback asynchronously, naturally coalescing and rate-limiting
>> > I/O without any explicit skip-if-busy or dirty pressure checks.
>> > 
>> 
>> Thanks Jeff for explaining this. It make sense now.
>> 
>> 
>> > Add WB_REASON_DONTCACHE as a new writeback reason for tracing
>> > visibility.
>> > 
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/fs-writeback.c                | 14 ++++++++++++++
>> >  include/linux/backing-dev-defs.h |  1 +
>> >  include/linux/fs.h               |  6 ++----
>> >  include/trace/events/writeback.h |  3 ++-
>> >  4 files changed, 19 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> > index 3c75ee025bda..88dc31388a31 100644
>> > --- a/fs/fs-writeback.c
>> > +++ b/fs/fs-writeback.c
>> > @@ -2466,6 +2466,20 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>> >  	rcu_read_unlock();
>> >  }
>> >  
>> > +/**
>> > + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
>> > + * @mapping:	address_space that was just written to
>> > + *
>> > + * Wake the BDI flusher thread to start writeback of dirty pages in the
>> > + * background.
>> > + */
>> > +void filemap_dontcache_kick_writeback(struct address_space *mapping)
>> 
>> This api gives a wrong sense that we are kicking writeback to write
>> dirty pages which belongs to only this inode's address space mapping.
>> But instead we are starting wb for everything on the respective bdi.
>> 
>> So instead why not just export symbol for wakeup_flusher_threads_bdi()
>> and use it instead?
>> 
>> If not, then IMO at least making it... 
>>    filemap_kick_writeback_all(mapping, enum wb_reason)
>> 
>> ... might be better.
>
> I did draft up a version of this -- adding a way to tell the flusher
> thread to only flush a single inode. The performance is better than
> today's DONTCACHE, but was worse than just kicking the flusher thread.
>
> I think we're probably better off not doing this because we lose some
> batching opportunities by trying to force out a single inode's pages
> rather than allowing the thread to do its thing.
>

So, if I understood it correctly, Christoph might be talking about a
different approach here.
Instead of kicking flusher thread to writeback pages for a single inode,
if we can track the number of dontcache pages
(get_nr_dontcache_pages()), then we can kick the flusher for those many
target pages. I think this way we are still reducing the dirty page
cache pressure - the problem which RWF_DONTCACHE is supposed to solve.
But I guess, that doesn't necessarily always mean that only dontcache
marked folios will get written.

If we implement that then, this should still help with the batching
problem you mentioned and hopefully should not cause a major regression
for the workload which Jan mentioned.

Feel free to correct my understanding here please.

-ritesh
