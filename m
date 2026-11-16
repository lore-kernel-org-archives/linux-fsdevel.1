Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839851;
	b=h0IBAL8Jm4e9P318kMP7bJaQOTz84NSipDnL0Mm83dyuwqHrpIwPZaP2Rcg9ykDnY6GY
	 BpsiOFwgEapqhImlymGL6rRnlSCqZsDasIFUj8cWJWBObNzBWLYaXeKkdLbZ04KM5ZMvK
	 F9wSRhLWEWdpg7Di+V82ujBXq4vG6ygImaz2fcthDHwd7BQ2N3+D/5/wYf0pJBxbxHSQk
	 nkUBg0idptNlnEnGzR3sUi+9WkUcCt4255M2oDkyegDNz1oavLaQsrE1xLHMxJ9vV3dKJ
	 ScqZ38oDiGnNiUxIWQ1UtN8xHepI+sdyEXMqh3t1lfW6M+h8OGojV5DkiA301lQPiCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839851;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cnLyN3SDo42Ts0cPpeRwTJ3OQjij9Avhcc7a74dY1sU=;
	b=Uz6JLzyiKWb2MLeBU/CUli5uC8nE14CZrpeoZl4apCjkT6XRCeyDAY1HSBUQ5ooC66d7
	 p9iR6KKhEfYmPOMQF8f3m+Q7Cfo4Afw1oL4BscHguKBxOrzfxOFAMiiMqKJYtj8qvOc69
	 5ko3lCdoK0IcDkWITvXuxmSMjl+YTn4mP9nqOxPdD4apY0ntXOtwVbYDdaQciZ7PSroeA
	 WmwwPPmBIwSMjysokqTPjDN0SWhUGvL9mWSOI41mneEz/rAc2jLHsVIzjpbgPDYkdeR17
	 m8XzXV/3+WPyXPnBAU0vLL5OiYMyhtUpaeMAJq2tcgf5mbIjjCjfp39S7ErMuPTUH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsk7ivH4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580D606A33A;
	Mon, 16 Nov 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsk7ivH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD51F000C8;
	Mon, 16 Nov 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839850;
	bh=cnLyN3SDo42Ts0cPpeRwTJ3OQjij9Avhcc7a74dY1sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nsk7ivH4zkm3sL2aLEVd/NzHmTQ+e8khI0RzK2WdOavqoW3b/h9TAN2I9ALOjFQ/O
	 ZqA9jAR3LTdYwOI8tLdKz8BZMMTvDGXOxJGpDa8jFGgrLVgzWpZNdc9U9J7Tj46MW9
	 xEXFO38a7FUvY4lVKOneFogrww7QliuaboAQ5Iut1kxQQQPkdIjFMqeWt6kHeyEbpz
	 Em/Ka2DBF+heM1tTcfE3WWBDO9AltOwNOGfKgqCVu1SnCicLeJnrmym4/RoZ6d5eyn
	 UYxN1N17hzF9Hu8qd+ZraIi0Rz8rXtFAaGFp/3qF8AystJhelYUbykvkXI/Vn/lAmU
	 eumRjTEyOTfWw==
Date: Mon, 16 Nov 2026 14:37:25 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ahuang12@lenovo.com
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
Message-ID: <avsQKLgi9bqD51W8@gremlin>
References: <20261112140101.647-1-adrianhuang0701@gmail.com>
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
In-Reply-To: <20261112140101.647-1-adrianhuang0701@gmail.com>

On Thu, Nov 12, 2026 at 10:01:01PM +0800, Adrian Huang (Lenovo) wrote:
> Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> per-vma lock") introduced the possibility of returning -EINTR
> from proc_get_vma() when the VMA lookup is interrupted.
>
> When this happens in m_next(), proc_get_vma() returns an error
> pointer without updating the position index. Consequently,
> seq_read_iter() reports:
>
>   seq_file: buggy .next function m_next did not update position index

What does seq_read_iter() 'reporting' something mean? It feels like you're
trying to make this into something bigger than it is.

What you mean to say is a rate-limited pr_info() output occurs, and when a
process that _has received a fatal signal_ (!!) somehow continues long
enough to try to output more data, you get an pr_info().

The relevant code from seq_read_iter():

		if (pos == m->index) {
			pr_info_ratelimited("buggy .next function %ps did not update position index\n",
					    m->op->next);
			m->index++;
		}

Anyway you should mention the fatal signal requirement clearly.

>
> The above buggy message is reproduced by the following command:
>
>   # stress-ng --vma 0 -t 60

OK I could reproduce the output locally. It seems that this run results in
fatal signals being sent to the processes triggering this output.

> Update the position index when VMA lookup fails, as required by
> the seq_file interface. Also save the original position in
> priv->last_pos so that subsequent iteration can restart from
> the correct address without skipping or repeating a VMA.

We don't really care about skipping or repeating a VMA for a process that's
about to die :)

We may as well do this but better to just hoist that to share code.

>
> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")

This isn't really a bug, it's really cosmetic to be honest. So not sure if
we need a cc: stable hmm.

> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

See attached suggested patch that makes the comment sane + hoists the shared
bit (dropping a silly existing comment).

With that and an updated commit message should be ok.

> ---
>  fs/proc/task_mmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d..164b4efc5e09 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -221,6 +221,16 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
>  		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
>  			goto retry;
>
> +		/*
> +		 * seq_file checks that the position advanced before it looks at
> +		 * the returned pointer, so an error return that leaves *ppos
> +		 * alone is reported as a buggy ->next. Advance it, and keep
> +		 * last_pos at the pending position so m_start() would resume
> +		 * the lookup from there.
> +		 */

We don't want (schloppy?) comments that go into painful detail about super
specific elements of the code.

This is asking for bit rot and is too complicated to be in any way useful.

> +		priv->last_pos = *ppos;

This is duplicative with code below and strictly not necessary for the fix,
better to hoist I think.

> +		(*ppos)++;
> +
>  		return vma;
>  	}
>
> --
> 2.43.0
>

Suggested:

----8<----
From 860d936c61bb641b72135e95c291aa6dfbf5fb0f Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 16 Nov 2026 14:33:12 +0000
Subject: [PATCH] tmp

---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..564e52f7ddc6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -216,16 +216,17 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)

 retry:
 	vma = get_next_vma(priv, *ppos);
-	/* EINTR of EAGAIN is possible */
+	/* Store previous position to be able to restart if needed */
+	priv->last_pos = *ppos;
 	if (IS_ERR(vma)) {
 		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
 			goto retry;

+		/* Advance to avoid spurious buggy seq warning in dmesg */
+		(*ppos)++;
 		return vma;
 	}

-	/* Store previous position to be able to restart if needed */
-	priv->last_pos = *ppos;
 	if (vma) {
 		/*
 		 * Track the end of the reported vma to ensure position changes
--
2.56.0
