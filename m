Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B243E4B0;
	Fri, 25 Sep 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344496; cv=none; b=LK/4ixk4/kipNa0u1PH4hGF/7lcqaTmHRHMsdcIRkrx1pkO/bHOwOeapyUXSxnOonROdyvw1RsxBI8JJQ12Zej1aIGbT1sKySVlNrBT8Gzpxg/G+1f/4Ok89+hAaP8I9qUwXhTDUcPRAmF4jAUlm2tSMZxSmy+bhdFQm90PgUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344496; c=relaxed/simple;
	bh=ZfrYS2WTeMsNs+GSk0cpEOhAzDTnSJUNI/kUQEeDUmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQNCbcfptBAJLzpKlpUPVsQiebcltfVBRvwPEw/YI7+uQY+fYG8Xe5iVxscsWOF048XiDcK308i/fB3Wikueef8QiV/kl9q48vdDvUXpRfTMj88bwAvtPdYR5LwrZpdlHGOVSwEMFfEBd6Ouq+1r0qTLoCEVBmSZeXVOg50nnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuIyFa63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuIyFa63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9871F000FF;
	Fri, 25 Sep 2026 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344492;
	bh=3CiaD0JwMnRkdkXPv9RgnkUr346Q/CQ2NX+6j/Shhrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iuIyFa63QqWli/aBh8oJkvCMK14unz0FpnaO8CLFb90QQVpHEPBSidM6yGyBZQCg3
	 xS5BwAadr7cIzzVGI3vG4DPn45mmKq7OGToeSnFpCZivjVKF189YORUgSL+fG5OVJL
	 ZyvEipjRtt+t78UNfseUIWhvTzIW+yoJP+qmWZyzypUmXGTvLxzsSUgcjRTvx8RdxW
	 Mfh8fiuWGTel8HlwKXBLsdG/XFDUcTzd6xXOA4K8Skyjn5yIXxIGMI7Zc/dCv9if3o
	 OjS8dZ+Vn3H5+anngTA6NO9hjN4e+Eadl2bT9rHZ0NWhUa+94j88pxnblJXw/g37R/
	 9s6DnZxVgBtYw==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com,
	glider@google.com,
	dvyukov@google.com
Subject: Re: [PATCH v3] dcache: unpoison the inline name buffer in __d_alloc()
Date: Fri, 25 Sep 2026 15:54:46 +0200
Message-ID: <20260925-demografie-mitgift-explosionsartig-8acf4cf829a0@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918224204.3056-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20260918224204.3056-1-drifabdelmalekmohamedsaid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=brauner@kernel.org; h=from:subject:message-id; bh=ZfrYS2WTeMsNs+GSk0cpEOhAzDTnSJUNI/kUQEeDUmg=; b=kA0DAAoWkcYbwGV43KIByyZiAGq2fSeh3zJDVOH+7F3omkkJxVMx8fOfWjw8t2DNK2j0G8vKN Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmq2fScACgkQkcYbwGV43KJCLwD8CV4c e+CmrVhdih99WZ74Pg4svE2QmLO8TIxSB+BQF+YBAJAIrKpnAPbdJ7WhhUwLZoxr4CVd3HrqxpV N8gVvAYQE
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 23:42:04 +0100, Drif Abdelmalek Mohamed Said wrote:
> syzbot reported:
> 
>     BUG: KMSAN: uninit-value in dentry_string_cmp fs/dcache.c:291 [inline]
>     BUG: KMSAN: uninit-value in dentry_cmp fs/dcache.c:322 [inline]
>     BUG: KMSAN: uninit-value in __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522
> 
>      dentry_string_cmp fs/dcache.c:291 [inline]
>      dentry_cmp fs/dcache.c:322 [inline]
>      __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522
>      lookup_fast+0x194/0xa40 fs/namei.c:1854
>      lookup_fast_for_open fs/namei.c:4545 [inline]
>      open_last_lookups fs/namei.c:4579 [inline]
>      path_openat+0x9ef/0x6540 fs/namei.c:4856
>      do_file_open+0x2aa/0x680 fs/namei.c:4888
>      do_sys_openat2+0x17c/0x390 fs/open.c:1395
>      do_sys_open fs/open.c:1401 [inline]
>      __do_sys_openat fs/open.c:1417 [inline]
>      __se_sys_openat fs/open.c:1412 [inline]
>      __x64_sys_openat+0x240/0x300 fs/open.c:1412
>      x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:258
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] dcache: unpoison the inline name buffer in __d_alloc()
      https://git.kernel.org/vfs/vfs/c/76d8e697242e
