Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57E3264FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396861; cv=none; b=cadpWaVjxjB4iMxX9dfHwy2C0Om7Xuj8/vgRqymNlwxImJVysNVotfcUxlzHc7T52uP4u9x1fpVUQ3jSdIe3I17oPNGZjzjISN84Eq7cfwn2QdFa6/Fz4xdvmNUtkVWwtxaylXPO0FbqHE/SblNlU3mrh/SbCSy4BLDNAE/jksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396861; c=relaxed/simple;
	bh=aOZpEhi8zYUAMtivyKPbhUMVXOrv7t7zVCorY5K9xKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzMqDTwzT7YmNItN2Ok/wZewJjsP7cCee/k5BWwNhGQTef7XclqbdLPfY3nunqwToTW0FpBvg5AWB07orq4OFBWIp192yPgswxlcRlEkf8++8txPSEOkajJRdk4LhBYY1/JacgLQBgQP015lazDXqH+P2oNydYPiovsjtbIrZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yan6qnWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yan6qnWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287A61F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396860;
	bh=tNwjveFq3g+KTegkWxHWHcT2VCBrA4LID1jw/StHbB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Yan6qnWW0KBlzdH66vdOWeAeGSlQPH+BkzDWOJd8SmvtbQCla8BlENuScszYQpZ4R
	 tC0e4W3RWhAPZJjdHsbDvUU3Kwd88oktC/HO/TDMmVYGJdEmaV9LsdHOTZmEOz59zw
	 uVKYeB6o7bNOZIoPb8swPKVneY3QxWQyQrnke506yZ4xlPizWXNQJoB6z7GfKSFZ9J
	 zc8mBIel42TrgAtQOwf/OWFdKpGfn4ho/zW2AyMJm6WaOtpp52DrnR2Fxt59xmWT2L
	 T4nMIGh68nTOFvvtQUvP48qZNGgSYYzQ8jTKCxoCxwelwg05+ptgwNdvD5I576JMQP
	 U46HsPUkCexWg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c029505b389so344480466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 07:14:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq4Ax+YOa89OimY7OEDX5J0Qn3Do6w0n+lTqOLBwZQZVsHdf4Lq1ZJ4hDuE4xGNSw8exdWgKuvKRLfvaZ0N@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRtCQ+cM+knSjrhiLaHU9Tl6D4PjiE0MLCfVT72t2xMGDbqdQ
	qLbp3kWrQGirAgCxlwTpMDGOQvvFkm99GnYFXZGejIQ0G42vK5JQqSzIG9FA/W4zxa50iudN2mY
	0eLnNccdE6SLbwifIq13y4qEbtHhuLK4=
X-Received: by 2002:a17:907:6e8b:b0:c11:3fc9:ef68 with SMTP id
 a640c23a62f3a-c1204294675mr187809366b.8.1782396858897; Thu, 25 Jun 2026
 07:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625044547.3729183-1-zzzccc427@gmail.com>
In-Reply-To: <20260625044547.3729183-1-zzzccc427@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 25 Jun 2026 23:14:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_qReG7QVOt1Xi1XDzW=C-iEd5wcjewM3VYi7DzN+F6Jw@mail.gmail.com>
X-Gm-Features: AVVi8CeGSMYMDrPo6H6OXwM-xbmpd_5iGTOvj3uiRrU_pKBL4Z8RSoGlGV1zZCY
Message-ID: <CAKYAXd_qReG7QVOt1Xi1XDzW=C-iEd5wcjewM3VYi7DzN+F6Jw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid stale runlist element dereference in MFT writeback
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 1:45=E2=80=AFPM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> ntfs_write_mft_block() maps each $MFT record through the $MFT data
> runlist. For sub-folio clusters it looks up a struct runlist_element unde=
r
> ni->runlist.lock, drops the lock, and later uses rl->length and rl->vcn
> when choosing folio_sz.
>
> That pointer is only borrowed from ni->runlist.rl. Concurrent $MFT
> allocation extension can merge a replacement runlist under the same lock,
> and ntfs_rl_realloc() can free the old backing array. If that happens
> between the lookup and the later folio_sz decision, writeback can
> dereference freed runlist storage.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> MFT writeback path:               $MFT allocation extension:
> 1. Look up rl under               1. Extend the $MFT data allocation.
>    ni->runlist.lock.              2. Publish a replacement runlist.
> 2. Drop ni->runlist.lock.         3. Free the old runlist array.
> 3. Read rl->length and rl->vcn
>    to choose folio_sz.
>
> Compute the remaining run length while ni->runlist.lock is still held, an=
d
> use that scalar after unlock. This preserves the existing folio sizing
> decision without carrying a borrowed runlist_element across the lock
> boundary.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in ntfs_mft_writepages+0x1c8d/0x1fb0
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x630
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x20d/0x410
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  kasan_report+0xe0/0x110
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  ntfs_mft_writepages+0x1c8d/0x1fb0
>  ? __pfx_ntfs_mft_writepages+0x10/0x10
>  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? iput+0x92/0xa80
>  do_writepages+0x219/0x530
>  ? __pfx_do_writepages+0x10/0x10
>  __writeback_single_inode+0x117/0xf50
>  ? do_raw_spin_lock+0x130/0x270
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  ? __pfx___writeback_single_inode+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  writeback_sb_inodes+0x65b/0x1810
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? __pfx_writeback_sb_inodes+0x10/0x10
>  ? lock_release+0x1e0/0x280
>  ? _raw_spin_unlock+0x23/0x40
>  ? move_expired_inodes+0x2b8/0x850
>  __writeback_inodes_wb+0xf4/0x270
>  ? __pfx___writeback_inodes_wb+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? queue_io+0x2e4/0x410
>  wb_writeback+0x666/0x880
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_wb_writeback+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? get_nr_dirty_inodes+0x1c/0x170
>  wb_workfn+0x75e/0xbb0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? _raw_spin_unlock_irqrestore+0x27/0x60
>  ? __pfx_wb_workfn+0x10/0x10
>  ? __pfx_debug_object_deactivate+0x10/0x10
>  ? lock_acquire+0x2b8/0x2f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_release+0x1e0/0x280
>  process_one_work+0x8d0/0x1870
>  ? __pfx_process_one_work+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  worker_thread+0x575/0xf80
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x2e7/0x3c0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x576/0x810
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __switch_to+0x57e/0xe10
>  ? __switch_to_asm+0x33/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 970:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kvmalloc_node_noprof+0x353/0x920
>  ntfs_rl_realloc+0x3c/0x80
>  ntfs_runlists_merge+0x1212/0x3010
>  ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
>  ntfs_mft_record_alloc+0x1ab4/0x4f10
>  __ntfs_create+0x680/0x2e50
>  ntfs_create+0x1e6/0x3a0
>  path_openat+0x2b55/0x3c10
>  do_file_open+0x1f4/0x460
>  do_sys_openat2+0xde/0x170
>  __x64_sys_openat+0x122/0x1e0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 1294:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x307/0x580
>  ntfs_rl_realloc+0x66/0x80
>  ntfs_runlists_merge+0x1212/0x3010
>  ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
>  ntfs_mft_record_alloc+0x1ab4/0x4f10
>  __ntfs_create+0x680/0x2e50
>  ntfs_create+0x1e6/0x3a0
>  path_openat+0x2b55/0x3c10
>  do_file_open+0x1f4/0x460
>  do_sys_openat2+0xde/0x170
>  __x64_sys_openat+0x122/0x1e0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Applied it to #ntfs-next.
Thanks!
