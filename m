Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706557;
	b=SDbcJae09UiPkDrB99rya+G9cMMUAbT1nf5j+387tl89Jt84Hr2cOrfMqabvU1CirIzy
	 Lyl57KVdJdR1jbZ1CrJSlCbA3VDY9rqZRvwdxteuX1GmVkkfo2L7XVuHCJ7kqWboLHj7d
	 ysOHegWGsod61H2nB7Z44xwx1amV0P2VYpEDLNEzqVR6mIfZ5+fT7WZrRAEFLX3GLECmx
	 VrjphMny3wSDosRqPDicnKUODHyOtiJ0pk+Yn5Ar0y0A4ijK0vOkiJGgmJ17uiAhgF91F
	 7R1/kN0wDr6B6HVkahG2aQmv8jp+7T2rHhb0bemkxoKedTlcQcjp9k13fqlaTDD0deQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706557;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZvT7tk3P1HeqkH7Q6Z2/RmsaVAZjfaSe3LTozOquko0=;
	b=G0zJJAVdPmnkiqHpL7mNkOpdmP9aY95CqgfAiI4FmCQ8da724a9/04lJAwQyJrLu4zM2
	 OAoU95KMlfPgOMb+JZu1hAvRHYu81GJ9B9ndg84paBFSu9x+hVrIyc6lCC+3+8N+eIkbC
	 tGgEF4tfyYhV19PNuuNZy4AcyvJ0JYomvk+2JLx/qG4hMZvsMJxLV5fkLXRFOH8rICOmM
	 jZCxPzrV5B1OsHOttpRiipvmQWQsqRMA1JoK2ZKr4j7yZQ/l3Zux50lYKttWJ8eq7iKYx
	 iURtb3wB8EtEmLshM2bgVltaxO47IT5zZ1rraineX6oYYcJLKd5Jd8wXYgnZs0KlF5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ks17Enb5;
	arc=none smtp.remote-ip=91.218.175.187
Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B0606A329
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 15:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79B0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ks17Enb5
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XxWyPvAJ0IroYsLOy5V5ybJak6wZ0/ht/VqjPuOuhjc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706554; v=1; x=1796311354;
 b=Ks17Enb5Bv5JBp2cuKuvKzhoShVMZG4mRbSJwl7OZUw3wz/j843U/gHujp3PmAtYu5LSdZi0
 s0bhcvYbkh0XYprknwYneLk9cjUKIWo2y2SAW3gL9AnfJe10PfxWWYIdfm9z+nUut/o1Amh33/a
 sqlnI4/DUwy6GFey0+Qrx30M=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c2ce6ddd70b19568;
	Thu, 26 Nov 2026 15:22:34 +0000
X-Mizu-Trace-ID: c2ce6ddd70b19568
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 07:22:26 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Greg Thelen <gthelen@google.com>, 
	Greg KH <greg@kroah.com>, Ming Lei <tom.leiming@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/vmscan: Fix legacy memcg reclaim deadlock
 against filesystem freeze
Message-ID: <20261126152137.GA738059@shakeel.butt@linux.dev>
References: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>

On Thu, Nov 26, 2026 at 02:08:56AM -1000, Tejun Heo wrote:
> Legacy memcg reclaim has no dirty throttling, and shrink_folio_list() waits
> for a folio that is under writeback and already marked for reclaim (case 3
> in its comment). That wait can deadlock against a filesystem freeze:
> 
> 1. A task in write() to filesystem B holds freeze protection on B, enters
>    memcg reclaim and waits for writeback of a folio of a filesystem on a
>    loop device backed by a file on B.
> 
> 2. A freeze of B waits for the task to drop its freeze protection.
> 
> 3. The loop worker has to take freeze protection on B to write the folio out
>    and blocks behind the freeze.
> 
> The same applies to any driver that writes to a file on a local filesystem
> to serve block I/O and takes freeze protection for it.
> 
> Reclaim can't tell which filesystem a writeback depends on. Count the
> superblocks that are being frozen and make the wait time out after 15
> seconds. If one is being frozen at that point, warn and give up. Until none
> is, treat such folios like case 2 and skip the legacy writeback throttle, so
> that the task a freeze may be waiting for isn't held up.
> 
> This trades the deadlock for premature memcg OOM kills during such a freeze.
> The wait also no longer hits the folio_wait_writeback tracepoint, and the
> hung task detector no longer reports a task stuck in it for another reason
> as the task wakes up every 15 seconds.
> 
> Fixes: e62e384e9da8 ("memcg: prevent OOM with too many dirty pages")
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
