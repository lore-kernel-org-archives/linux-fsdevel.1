Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE373A542D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892374; cv=none; b=ukszpIym9xZEyxfyKMA4hpaYaagSGC6I5sELcUQzEkckOdmhTX6K90KL69eIosq1a8y9+glynPTaAD8xdJFWtJp/tqxmqzhVcHFJf03V68Q3n7FykaEd3NmG8b3FEBbr/y08bNkgGrPOj8eBZqmsLnFbLUEi01IfT30n5Zqq0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892374; c=relaxed/simple;
	bh=m/u/VoyAusjVlbdz1OILbEQ3mGIGcmH5qGi+KVujbAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Pr8oxwiT6fZ9gooOJv4t9X/0oDSmSvUECUPGdXi4WyVC1UW4OUfxJTj7wAWdhzCwimvR2ftWZnm2Mk/4WpyT73duOtEh4M+q6ZHlckQXf0rClSYbhBqP7rNWtRbjjh7AZueAurhoxu0ylczWczz3rhqnh/LmFX/j2vgdPi7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjDFHU+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjDFHU+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21421C2BCB8
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 10:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892374;
	bh=m/u/VoyAusjVlbdz1OILbEQ3mGIGcmH5qGi+KVujbAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RjDFHU+KtdfV0Gyg/B/XEKLaAZ9n5BJY3XyP9fI1c7sJuSHkQXITa22PTh9ygyDKi
	 AW0ANQ+zy76609afJgWkncEzrQTE4pEAT3MDeXJM2eN4rv0fOApMZrdGmeGok3J2w6
	 0UrL41Ht5AuhdXDu4KTPxK6TSat9pcWJTyUhSeWbnKCObL7tSOGIjl1NzUenK8xtiq
	 /UgExKLq8ao+IFea3q4ebtmXiz2zAoTF56ldrOOtiURAdbs6GnNPCx4fHREnCvtdqh
	 3TNpWtXpLuQRFEdXxXf/iIR/jZttFeFXEupNYzcPtfUh3eIZzKwULmabkK9utgliEJ
	 gxrHfIy9h21IQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso4268113a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 03:59:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8AVNDAlfCb97y+4UbwnX/++oQ3mRM8dXR3MZ9BFVFIs6gcMbP+hfY3c7PchMBP/uaxgdrByHHxXXfeonMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfQLdHXIX0oGyEnEeIvH23r0yDaujAevlqjag5qqXfTM+1CH4
	6EwmnaA/7u9Te0ttSl1CwJZwEw8wyStd1lrJh3D2o2Q4/nFjMEx4ZWTyhW7XdaRWrcSDBjhdrFJ
	Poxu6mrUn78tNcZPPzN+OqO0kXfsoqcY=
X-Received: by 2002:a05:6402:60b:b0:678:f83d:e435 with SMTP id
 4fb4d7f45d1cf-67c1b4ad217mr2681581a12.26.1777892372663; Mon, 04 May 2026
 03:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502004916.492207-1-charsyam@gmail.com>
In-Reply-To: <20260502004916.492207-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 May 2026 19:59:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_u6sbm2AMDXijoZWU88Ro31aA0nNkTSfcTOv7Tdr5=3Q@mail.gmail.com>
X-Gm-Features: AVHnY4KLz6EFQadDJZhZSROZ0mFSyUbCRODgPguL0M3kfH9GxHw9TPoauewyd2E
Message-ID: <CAKYAXd_u6sbm2AMDXijoZWU88Ro31aA0nNkTSfcTOv7Tdr5=3Q@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid use-after-free of index inode in ntfs_inode_sync_filename()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 9:49=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> w=
rote:
>
> ntfs_inode_sync_filename() walks every FILE_NAME attribute and, for
> each one that points at a different parent, opens the parent index
> inode with ntfs_iget() and locks index_ni->mrec_lock.  All three error
> branches (NInoBeingDeleted, ntfs_index_ctx_get failure, ntfs_index_lookup
> failure) drop the parent reference before unlocking:
>
>         iput(index_vi);
>         mutex_unlock(&index_ni->mrec_lock);
>         continue;
>
> index_ni is NTFS_I(index_vi), so the ntfs_inode (and its mrec_lock) is
> embedded in the inode allocation.  If the parent directory is not held
> outside the icache - no open dentry, recently evicted from dcache, no
> other concurrent lookup - ntfs_iget() returns with i_count =3D=3D 1 and
> our iput() drops the last reference.  evict_inode() then runs and
> destroy_inode() schedules the slab object for RCU free, while
> mutex_unlock() on the next line is still touching index_ni->mrec_lock.
>
> Swap the order so the mutex is dropped while index_vi is still alive,
> matching the success path at the bottom of the loop which already
> unlocks before iput().
>
> Reproduced under KASAN with a debug build that forces
> ntfs_index_ctx_get() to fail when the parent index inode has been
> opened with i_count =3D=3D 1.  KASAN reports a slab-use-after-free read
> on the parent's mrec_lock from mutex_unlock() on the writeback worker:
>
>   BUG: KASAN: slab-use-after-free in __mutex_unlock_slowpath+0xb5/0x970
>   Read of size 8 at addr ffff8880014b7598 by task kworker/u8:0/12
>   Workqueue: writeback wb_workfn (flush-253:0)
>   Call Trace:
>    mutex_unlock
>    ntfs_inode_sync_filename
>    __ntfs_write_inode
>    ntfs_write_inode
>    __writeback_single_inode
>
>   Allocated by task 103:
>    ntfs_alloc_big_inode
>    ntfs_iget
>    ntfs_lookup
>    __x64_sys_mkdir
>
>   Freed by task 12:
>    ntfs_free_big_inode
>    i_callback
>    rcu_do_batch
>
>   Last potentially related work creation:
>    call_rcu
>    destroy_inode
>    evict
>    dispose_list
>    evict_inodes
>    ntfs_inode_sync_filename
>    __ntfs_write_inode
>
>   The buggy address belongs to the object at ffff8880014b7440
>    which belongs to the cache ntfs_big_inode_cache of size 1800
>
> The freed object is the parent directory inode itself: allocated by
> mkdir(2) via ntfs_iget(), then released through call_rcu(i_callback)
> that destroy_inode() scheduled when evict_inodes() ran from inside
> ntfs_inode_sync_filename().  Re-running the same workload with
> mutex_unlock() moved before iput() runs cleanly under KASAN.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next
Thanks!
