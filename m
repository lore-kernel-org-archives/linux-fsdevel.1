Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29637360EF4
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829987; cv=none; b=PwPFdOLf3+Qyy/bvIV7tsboi4C7T5prM0VFhctvP2o6JfoKN+JxX4e7JrpI2Ac/IHS22K0USItuUipg6W5n+8GuMMLKBnoTYVb7z3aYzbb8KQcTjhEmuJg5mX68RzcfbZJPzFhHkpZEYzIs8IdhaGwMQKR993yC/CSoQeGDw/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829987; c=relaxed/simple;
	bh=5BMWYzUopKwPRerUPir01Yqp4Hko4DehxQZw5HbCSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugZJl0n4PgqEJMUUBwg2Koxbz/QL4S9ESnSDSabzG1CS4egdM/3dDhyWy1m0z1F4ksP17Ert+szOtDT0X5qgjNcQyJb2qlOGT/oaF4ictvzyGB6AUIAF8dNbC91bsqI3g6uByow1mXRxxiznMPW+M5xndsdYHdqcYhDUcJrW/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O093YLre; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O093YLre"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f6de72faso6573245e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829983; x=1785434783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EtVdhv5gpffErdadsZwOfbEmM4sOAPwJiElZ21IqXVo=;
        b=O093YLreT6nvC0t57+RKLei1L/wjb1xBC1jCkfSPFrbmIsJo+hV83yw+sq2juHlkxm
         /3Rs9h88hB1ihvmempsmW7pstZM4FmNDl+WiqK3gZvxzNY5cH70dE4tCmVbs8N5aF2Lv
         vZE8VbV9BX1x/NOwQ5oeMA2fJ42fUfZAnDzgzKKLhjumTmxYT1D7Et4xNNmNs0Oi0QOk
         RfogORY/jOJMoVmh1oP6aoZD/A9ogWefLVLA4AE4boKGraVoSZ11XMRXKV9i+6oC9h9N
         HkHu7ioE+5C5Delv18NaLn5VV0/P9DZXzAvEbsDei/Kra9p8R4nsbmiT/P//yIn/qSlX
         UR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829983; x=1785434783;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVdhv5gpffErdadsZwOfbEmM4sOAPwJiElZ21IqXVo=;
        b=SUaMrEoPERTDB20POdsZ0+tS3XBgVHnnIW/0Moi3TqA4J+ilbp9fKx6p+n7cQqScRs
         +eCWre1CCZff7xBACz6kfMlDGlWWAfLP+R7QtziwiubHgX2bSiRwMuDjZsssnLMjd7Fk
         q0sHPl5CtTA0cE60IWKaWn1zglrN4dXIoUDKmYz6xNUT92zUbl94w/N2PjSaMPsTfjq6
         my9d0nvnqxYuB8IT20mykCkZ75yqbmYwdriJWq+sXHMl8BCsnx/SuzgSNxcM43df0REU
         UM5XZY3e1HcQh7wJ6Ex2SHrx+Ho8lPLTJYrCc8IZYwxb5NshGhlrvW8/A3InXlVb9mSt
         HzKg==
X-Forwarded-Encrypted: i=1; AHgh+RpyIUtoPh7OV683iiLf3kAUIixzuxpn7Aj1qgOOuNr0vTfQd3prcef7jqoDXGJ3uWIbtt1jEaJiaor5/cC6@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeYkEu93+fgf76j8rKhVIWdJLfSmcdOrUF7LKUixlKK9Y+uvJ
	C1mYkBUa4neR91XQQuXAO7S+rdo5AuyXMErCfLFmq7d7cpXTfOqw6L5T
X-Gm-Gg: AR+sD10cvH/U1RhnkSY5Wn2Q9UWSgofSwkuxMk4qVEov75oUQXbfOdHVkx5vo6sDX+b
	SM2YhrOcu7LJ6ZRQo7c6CkN/XB6BinrzWkDkXkdTOl/wj8UOlworMLffczdnXb+jm7CdMQYzTs+
	xNbJ1fO+0Xqc4arKoBUp0tP6dAqdf7MWi8NGXYCo9waruO07V0uZQxzkLAgts+WRyzD5uPaDerq
	t49ujmMNYn58jJBkWhjRUovj9Bf9mVqc/wGJify8Mo/TcwevhRFe7VF9ziHqgWtTG6d6ExwlcEX
	oCrFRzYdCam/TG9vnKkVvbp5a52juBT1PdBfmS5sHDk6fQgY9Kv2MYJENXy47ocm36dK3rvTIaO
	ER3PFgnWDfCNWK9NF+3DUWumra1nX/p7Qx8+as/DT1SpC/C0LY+c8fHlcmBtHzBt0ooXST11wSZ
	Ns6qsxftUnjJB7Kw1KF5hRJhJZ9piZRcTPR1WAW3p4ASq1MRcV8w==
X-Received: by 2002:a05:600c:a211:b0:495:6b4c:fccc with SMTP id 5b1f17b1804b1-4957459d682mr24250855e9.10.1784829983076;
        Thu, 23 Jul 2026 11:06:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm16386126f8f.21.2026.07.23.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:06:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:06:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guidong Han <2045gemini@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jann Horn
 <jannh@google.com>, Qi Tang <tpluszz77@gmail.com>, Junxi Qian
 <qjx1298677004@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
Message-ID: <20260723190621.51e6e4ac@pumpkin>
In-Reply-To: <20260718104406.27897-1-2045gemini@gmail.com>
References: <20260718104406.27897-1-2045gemini@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 18:44:06 +0800
Guidong Han <2045gemini@gmail.com> wrote:

> Commit 319c15174757 ("epoll: take epitem list out of struct file")
> intentionally removed temporary file references from the reverse path
> check list. At the time, both epitems and their files were freed after
> an RCU grace period, so unlist_file() could obtain file->f_lock through
> an epitem while clear_tfile_check_list() held rcu_read_lock().
> 
> Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
> struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
> RCU still protects the epitem, but no longer keeps the referenced file
> from being freed and reused. A concurrent close can therefore make
> unlist_file() lock or unlock f_lock in a recycled file object.
> 
> This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
> reference before acquiring an object's lock. The race was reproduced,
> causing a wild unlock of f_lock in a recycled file and breaking its
> mutual exclusion.
> 
> Add ->file to epitems_head to remember the pinned file independently of
> ->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the head  
> is unlisted, leaving no epi->ffd.file from which to drop the reference.
> 
> In list_file(), acquire the reference before adding the head to the
> check list. The caller either owns a reference or holds the ep->mtx for
> the epitem leading to the file. In the latter case, file_ref_get() can
> fail after the last reference is dropped, but eventpoll_release_file()
> must acquire the same mutex before the file can be freed. The dying leaf
> can be skipped because removing links cannot increase the reverse path
> count.
> 
> In unlist_file(), epnested_mutex excludes another list_file() or
> unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL from
> freeing the head. Save head->file locally, clear it with head->next
> under f_lock, and drop the reference after the RCU-protected operation.

That seems to hold a reference to 'file' that persists after EPOLL_CTL_ADD
returns.
That breaks the requirement that the final close() will automagically
remove an fd from any epoll lists.

	David

> 
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Junxi Qian <qjx1298677004@gmail.com>
> Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guidong Han <2045gemini@gmail.com>
> ---
> SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU reader
> still holds its old address. Once that address contains a new live
> struct file, KASAN sees valid, unpoisoned memory and cannot distinguish
> the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
> instead.
> 
> The failing interleaving is:
> 
> CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
> ------------------------------------   ---------------------------------
> p = hlist_first_rcu(&head->epitems)
> epi = container_of(p, ...)
>                                        close(victim)
>                                          __fput()
>                                            eventpoll_release_file()
>                                            file_free(victim)
>                                        // the slot is free; f_lock remains
> spin_lock(&epi->ffd.file->f_lock)
>                                        open() reuses the slot as new_file
>                                          spin_lock_init(&new_file->f_lock)
> spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's lock
> 
> CONFIG_DEBUG_SPINLOCK reports:
> 
> BUG: spinlock already unlocked on CPU#0, poc_unlist/150
>  lock: 0xffff8880067fb200, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
> CPU: 0 UID: 1000 PID: 150 Comm: poc_unlist Not tainted 7.2.0-rc3-dirty #22 PREEMPTLAZY 
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x64/0x80
>  do_raw_spin_unlock+0x75/0xb0
>  _raw_spin_unlock+0xe/0x30
>  clear_tfile_check_list+0x88/0xe0
>  do_epoll_ctl_file+0x519/0xcf0
>  ? __pfx_ep_ptable_queue_proc+0x10/0x10
>  do_epoll_ctl+0x8f/0x100
>  __x64_sys_epoll_ctl+0x6f/0xa0
>  do_syscall_64+0xdc/0x520
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x42034e
> Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 e9 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007a657ff3c198 EFLAGS: 00000202 ORIG_RAX: 00000000000000e9
> RAX: ffffffffffffffda RBX: 00007a657ff3ccdc RCX: 000000000042034e
> RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
> RBP: 00007a657ff3c2f0 R08: 0000000000000000 R09: 00007a657ff3c6c0
> R10: 00007a657ff3c1a4 R11: 0000000000000202 R12: 00007a657ff3c6c0
> R13: ffffffffffffffb8 R14: 000000000000000d R15: 00007fffb7de0210
>  </TASK>
> ------------[ cut here ]------------
> 
> unlist_file() does not appear as a separate frame because it was inlined
> into clear_tfile_check_list(). This report was obtained with mdelay()
> instrumentation immediately before spin_lock() and spin_unlock() in
> unlist_file() to widen the two race windows.
> 
> More importantly, this is a wild unlock. The stale unlock can target
> f_lock of a different live file and invalidate mutual exclusion for
> state protected by that lock. Turning this into a reliable exploit
> would require precise scheduling and same-slot reuse and is likely
> difficult, but the primitive is potentially exploitable.
> 
> Qi Tang and Junxi Qian helped identify this issue and are therefore
> credited by the Reported-by tags above.
> ---
>  fs/eventpoll.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 0e65c7431dfc..eed8cecd94e3 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -459,11 +459,14 @@ static struct kmem_cache *pwq_cache __ro_after_init;
>   * Wrapper anchor for file->f_ep when the watched file is not itself an
>   * eventpoll; for the epoll-watches-epoll case, file->f_ep points at
>   * &watched_ep->refs directly. The ->next field threads
> - * ctx->tfile_check_list during one EPOLL_CTL_ADD path check.
> + * ctx->tfile_check_list during one EPOLL_CTL_ADD path check. The ->file
> + * field holds a reference to the associated file while the head is on
> + * the list.
>   */
>  struct epitems_head {
>  	struct hlist_head epitems;
>  	struct epitems_head *next;
> +	struct file *file;
>  };
>  
>  static struct kmem_cache *ephead_cache __ro_after_init;
> @@ -480,6 +483,16 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
>  
>  	head = container_of(file->f_ep, struct epitems_head, epitems);
>  	if (!head->next) {
> +		/*
> +		 * The caller owns a reference to @file or holds the ep->mtx for the
> +		 * epitem that led here. The latter blocks eventpoll_release_file()
> +		 * before the file allocation can be freed and reused. A dying leaf
> +		 * can be skipped since removing links cannot increase the reverse
> +		 * path count.
> +		 */
> +		if (!file_ref_get(&file->f_ref))
> +			return;
> +		head->file = file;
>  		head->next = ctx->tfile_check_list;
>  		ctx->tfile_check_list = head;
>  	}
> @@ -489,15 +502,18 @@ static void unlist_file(struct epitems_head *head)
>  {
>  	struct epitems_head *to_free = head;
>  	struct hlist_node *p = rcu_dereference(hlist_first_rcu(&head->epitems));
> +	struct file *file = head->file;
>  	if (p) {
>  		struct epitem *epi= container_of(p, struct epitem, fllink);
>  		spin_lock(&epi->ffd.file->f_lock);
>  		if (!hlist_empty(&head->epitems))
>  			to_free = NULL;
>  		head->next = NULL;
> +		head->file = NULL;
>  		spin_unlock(&epi->ffd.file->f_lock);
>  	}
>  	free_ephead(to_free);
> +	fput(file);
>  }
>  
>  #ifdef CONFIG_SYSCTL

