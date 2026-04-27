Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1530B533;
	Mon, 27 Apr 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289511; cv=none; b=bEOF8Zhen54kYCAF6DCiWla+xoZUzM6Ztj2j2onMyU8UYXyFTQRHFP8f/toitWhwcG3dWp8Hjut3ufrNxVusxE9RBsYkox73sDUKLr3c5sMTpnWf1yMoWYFv+U7wwkQxZy7Jy/Z3KF1yW8BA5aGy4YyfdwNM9GjxVjObbx96xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289511; c=relaxed/simple;
	bh=iNslZoTyQAg0rKSwDznTtdERDBUeqpLTEMT5UjUqXQ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mQ9RMaq8haWPeov2MSVXH9FjK6XkPS4i86dtaqRGKqu8gFd8Tyi5noxrFAeIGDq8oilat/j1q5L+SGHDp1whwpvAQQoBfSk/ePmf2YA8Zzf+iA0Q+eU1xUPEAKx8wkJIkaheOvbDi0pLQBhT6nz2La9rvVs0N8TRHAbnOMRg6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YgCAbI5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YgCAbI5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD5C19425;
	Mon, 27 Apr 2026 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777289510;
	bh=iNslZoTyQAg0rKSwDznTtdERDBUeqpLTEMT5UjUqXQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgCAbI5/49351SMViTuoAykJaAlMsQGsGGuhnM1gQBqXu9W/qJxHJse/OfV2NQiKe
	 r1a1bGncfNUOi3K7DzPUclTfGl5L0gt0BgDd4ieGd6NbozoFUXpgGeb4uRZPu9YXWm
	 Os/Sya5U/QdzAngUigeVrTP8Zsix0Fm3LC2mF/Bc=
Date: Mon, 27 Apr 2026 04:31:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org,
 syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] rhashtable: give each instance its own lockdep class
Message-Id: <20260427043149.e8fe46494d92d561175861ca@linux-foundation.org>
In-Reply-To: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
References: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:09:57 +0200 Christian Brauner <brauner@kernel.org> wrote:

> syzbot reported a possible circular locking dependency between
> &ht->mutex and fs_reclaim:
> 
>   CPU0 (kswapd0)                    CPU1 (kworker)
>   --------------                    --------------
>   fs_reclaim                        ht->mutex
>     shmem_evict_inode                 rhashtable_rehash_alloc
>       simple_xattrs_free                bucket_table_alloc(GFP_KERNEL)
>         rhashtable_free_and_destroy       __kvmalloc_node
>           mutex_lock(&ht->mutex)            might_alloc -> fs_reclaim
> 
> The two halves of the splat refer to two different events on
> &ht->mutex.
> 
> The kswapd0 path is unambiguous: shmem_evict_inode at mm/shmem.c:1429
> calls simple_xattrs_free(), which calls rhashtable_free_and_destroy()
> on the per-inode simple_xattrs rhashtable being torn down with the
> inode.
> 
> The previously-recorded ht->mutex -> fs_reclaim edge comes from
> rht_deferred_worker -> rhashtable_rehash_alloc ->
> bucket_table_alloc(GFP_KERNEL) -> __kvmalloc_node ->
> might_alloc -> fs_reclaim. That stack stops at generic library code:
> there is no subsystem-specific frame above rht_deferred_worker, so
> the splat does not identify which rhashtable's worker recorded the
> edge -- only that some rhashtable in the system did.
> 
> Whether or not that recording happened on the same simple_xattrs ht
> that is now being destroyed, the predicted deadlock cannot occur:
> rhashtable_free_and_destroy() does cancel_work_sync(&ht->run_work)
> before taking ht->mutex, so the deferred worker cannot be running on
> the instance being torn down. If the recording was on a different
> rhashtable instance, the two ht->mutex acquisitions are on distinct
> mutex objects and cannot deadlock either.
> 
> Lockdep flags a cycle regardless because mutex_init(&ht->mutex) lives
> on a single source line in rhashtable_init_noprof(), so every
> ht->mutex in the kernel shares one static lockdep class. Lockdep
> matches by class, not by instance, and collapses all of these into
> one node.
> 
> Lift the lockdep key out of rhashtable_init_noprof() and into the
> caller. The user-visible rhashtable_init_noprof() /
> rhltable_init_noprof() identifiers become macros that declare a
> per-call-site static lock_class_key.
> 
> Reported-by: syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/69e798fe.050a0220.24bfd3.0032.GAE@google.com

Thanks.

Is this related to https://lore.kernel.org/202604211323.fac1b29e-lkp@intel.com

Are we able to identify a Fixes: target?

In the above-linked thread Herbert had
Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")


