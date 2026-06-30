Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21383425CC3
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829261; cv=none; b=qFn7ImKWst5YfALVr7hE2+u73xDzxakWkP55VHmm2hPrvVA3ugrsvIee0v6JvVOJ3ppZ7s/ZJzmSLHwDirzxttVgHy6WxA8XtF6l+9lfOSHIMx3mucSRk8OZrYpkXhDMumgv87oAV1rHKBb6IljhDBz36vIk2ePOzgM1AD+JaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829261; c=relaxed/simple;
	bh=GUfWAk/Iu+o28Jm2Jsc2MPGx2WvkboiOI7+DjKmbAA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqkmq86EdGt9dUi1Sejy0/ESC/u4M7bJk90mRiRCpA8mA0u924a5GqA/9s/8iah3JMzeNTl53GFNh8siA+p6BgIvE+1qBizjBoIf8gF1eeaEScJgs5B20npF4Y8ucoGrQvCvjzRAekx1KFh/yVvY65BNrpjFR1AXKCTESoI7agw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIOAp6Wf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIOAp6Wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C3D1F00A3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829259;
	bh=FsHH/rIbzY63WIs8koj7WGP4b4Da5zQrgwZR74L+O4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EIOAp6WfIIoKY8QRmJcJdVBwsqTa+qTq90tEqwz2Sv2bzIIUTcsiBjQGLOCTIrqPm
	 j0oYywLt69c1YD3UdJm+YrecfNEfIRZsO0Iwa8NfegVnnW8NTEhFyss2oo16ujH5xk
	 BOuS1yPoREVXB1n223rhCSMZBSW7/W/JoyCdW6A3ExgEAkG2VIYmt4EMueVq3T/0EJ
	 b23IQfk0YORz1U6ay4olPJAPofdsv+BeHQ/IVag1Wv9WiTjwFtGgrdTpckE2RDd0JK
	 vd2HWWiVVhyrzDobU/UR1tcQtPQni7M5e7bWnhGGCSOQnQ7Xu/zj7YgnWjUdd8ndsk
	 /EuqzGaEXoueA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c125c082ee2so263572966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 07:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqVbc1fZiJ15rj1ld9CDCzvYszMJZ0jMq2qlAoZ83VdNtaD5oRNUQFhZKYq2wGrRSfFlyT8wgL3SY2fliWt@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRzWn3A8B6Xse6j4I+NyUYCwQU4txC699T8Olukkwfo0HH4IH
	D7VFUJX1HIxCQ5+cfh2zcYqM+ATw7rsLI7dss1t8QMyy5MJJUf231rRRqTt+out0qGWuaCfoEVx
	9hOv2i98YEfq+nyuZgMMP+sxUCKYmvTQ=
X-Received: by 2002:a17:906:f298:b0:c12:22ea:4967 with SMTP id
 a640c23a62f3a-c1287109bbbmr131730766b.1.1782829258368; Tue, 30 Jun 2026
 07:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627042758.2841821-1-zzzccc427@gmail.com>
In-Reply-To: <20260627042758.2841821-1-zzzccc427@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Jun 2026 23:20:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0PzhVGN7y7=o37s2Je6W+q3+HmeyOSwqBXRs2V8E0Uw@mail.gmail.com>
X-Gm-Features: AVVi8CeE7TpMk4Z7q_bdTtGx3hNRfEE34Y0Pv1wxRbf9L56NV4JRg1V7hOA1WZM
Message-ID: <CAKYAXd_0PzhVGN7y7=o37s2Je6W+q3+HmeyOSwqBXRs2V8E0Uw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: avoid stale runlist element dereference in fallocate
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 1:28=E2=80=AFPM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> ntfs_attr_fallocate() allocates holes and delayed allocations inside
> initialized size by looking up the current runlist element under
> ni->runlist.lock. The returned struct runlist_element is only a borrowed
> pointer into ni->runlist.rl. A writer can replace and free that array
> after the read lock is dropped, so later reads of rl->lcn, rl->length and
> rl->vcn can touch freed memory.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> ntfs_attr_fallocate():
>   1. Take ni->runlist.lock for read.
>   2. Get rl from ntfs_attr_find_vcn_nolock().
>   3. Drop ni->runlist.lock.
>   4. Read rl->lcn, rl->length and rl->vcn.
>
> mmap page_mkwrite:
>   1. Enter ntfs_filemap_page_mkwrite().
>   2. Reach __ntfs_write_iomap_begin() and ntfs_attr_map_cluster().
>   3. Merge allocation state with ntfs_runlists_merge().
>   4. Reallocate ni->runlist.rl in ntfs_rl_realloc(), freeing the old arra=
y.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in ntfs_attr_fallocate+0xbb8/0xd00
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x630
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x20d/0x410
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  kasan_report+0xe0/0x110
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  ntfs_attr_fallocate+0xbb8/0xd00
>  ? lock_acquire+0x2b8/0x2f0
>  ? __pfx_ntfs_attr_fallocate+0x10/0x10
>  ? 0xffffffffc0000095
>  ? down_write+0x10d/0x1e0
>  ntfs_fallocate+0x5c9/0x1d00
>  ? __pfx_ntfs_fallocate+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_file_permission+0x3a7/0x510
>  vfs_fallocate+0x29d/0xd30
>  __x64_sys_fallocate+0xc7/0x150
>  ? do_syscall_64+0x81/0x6a0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Allocated by task 410:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kvmalloc_node_noprof+0x353/0x920
>  ntfs_rl_realloc+0x3f/0x110
>  ntfs_runlists_merge+0xaa3/0x3010
>  ntfs_attr_map_cluster+0x4e5/0xf80
>  ntfs_attr_fallocate+0x53f/0xd00
>  ntfs_fallocate+0x5c9/0x1d00
>  vfs_fallocate+0x29d/0xd30
>  __x64_sys_fallocate+0xc7/0x150
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 424:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x307/0x580
>  ntfs_rl_realloc+0x6f/0x110
>  ntfs_runlists_merge+0x7b1/0x3010
>  ntfs_attr_map_cluster+0x4e5/0xf80
>  __ntfs_write_iomap_begin+0x8cd/0x2280
>  iomap_iter+0x6de/0x11e0
>  iomap_page_mkwrite+0x391/0x650
>  ntfs_filemap_page_mkwrite+0x1ac/0x400
>  do_page_mkwrite+0x15c/0x280
>  __handle_mm_fault+0xd6d/0x1ca0
>  handle_mm_fault+0x19c/0x470
>  do_user_addr_fault+0x23b/0x9c0
>  exc_page_fault+0x5c/0xc0
>  asm_exc_page_fault+0x26/0x30
>
> Fix this by copying the needed runlist fields while the read lock is stil=
l
> held and using only those scalar snapshots after unlocking.
>
> After the snapshot, ntfs_attr_map_cluster() can also find that the range
> is already mapped and return balloc=3Dfalse. Only call ntfs_dio_zero_rang=
e()
> when new clusters were allocated, matching the write iomap path and
> preserving the zero-newly-allocated-holes behavior.
>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Applied it to #ntfs-next.
Thanks!
