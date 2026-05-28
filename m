Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36C3EF662;
	Thu, 28 May 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971673; cv=none; b=Mfi03hW/ZPKB7FzdkKFKade4/QHrOwVSlwYXW224QwN7oEBEoJaDCx3pXI50xDsIyaORDooEjk2Ct9/DWS5tR2NiZfe9SRZH/AbkLx2yTiohfe/V2u7eXslINmS+0Zbb/bs0YBdG0RfUHdbeJnSssYaPXpog/VNshT/ZhhYvH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971673; c=relaxed/simple;
	bh=uXWSHVlF02I2A0q4yLFDMtvkUFws4Oc0FNH9quvURY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQ8fB8Ia8FHqfal3mZe6XZFsCCRwBSmH/64pmf6FBVO6ZwUz5C/Zm7SUGHE3vx0dBx8t1/z6IUYhEvHAN/EKCanZwpSsc/0zQ1PdjSysN3V64vCBxR4Gsd0UuDVbiRTgDe7FGAbRTC+jyERMAcHlxtxqxHjflF+0J+rBMmLcIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPQwmoK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPQwmoK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC99A1F000E9;
	Thu, 28 May 2026 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971672;
	bh=U8JSLNh9NLiyozn0XtPjiOYWo2Uhn0139XzTdtciAkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPQwmoK37akyhoZQ0HLCbxgM5kSQtHsPHjYwZs+zKfh2/FUqsgiBcZN2abGlJZCfw
	 4X+5UBkVAKPghoiF9BAOlTOv7LOUZJM6++rjIpV3QyEOaPi6+8JX4660vBH+4nJVIe
	 PhzqffG4J/H3JBUeMSZJzQLBnb5CHwAgqZKnsrPOYUdn3ILcGMGCcYJahuL/i2nYR4
	 Cvbg5OR0y1zUmYtI4aqTo+0XDdaG78xkw6uy7TdHnaD2feS1GHWcNYiEzoMMyMZQbj
	 H9LTfPu09SzWDwDiS2j0++ydNjRmIapGFf1HdQHKSfBdleQ8qbQawcLXc+KJtO6UlV
	 /wR7ixi7v8MZA==
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	oleg@redhat.com,
	axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by pre-allocating outside the lock
Date: Thu, 28 May 2026 14:34:18 +0200
Message-ID: <20260528-laufarbeit-vielleicht-gesehen-8793848ca178@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=brauner@kernel.org; h=from:subject:message-id; bh=uXWSHVlF02I2A0q4yLFDMtvkUFws4Oc0FNH9quvURY0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJmAXKCamX+N6fnOHXUvSNe1LOD7Wbi/YIWP1Z3CTwX PqQs+2TjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlcPcTwP6YwYHvDn328Ivue H8svyt881WbbVOlpHoWuv8vrTTaJhzMy3Flmv+TAPM898lWKLyXbTO9MvnRQ2ewo57x7cXY9G2+ 0sQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 07:44:57 -0700, Breno Leitao wrote:
> While profiling Meta's caching code[1], I found pipe->mutex contention
> on the hot path. anon_pipe_write() currently calls alloc_page() once
> per page while holding pipe->mutex. The allocation can sleep doing
> direct reclaim and runs memcg charging, which extends the critical
> section and stalls any concurrent reader on the same mutex.
> 
> This series pre-allocates pages outside pipe->mutex in
> anon_pipe_write(): for writes that span more than one full page, up
> to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> then drains the prealloc array first, falls back to the per-pipe
> tmp_page[] cache, and only enters the allocator under the mutex for
> the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
> writes that skip prealloc, or shortfalls when the prealloc loop
> fails). Leftover prealloc pages are recycled into tmp_page[] before
> unlock and any remainder is put_page()'d after unlock, keeping the
> allocator out of the critical section on both sides.
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/2] fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
      https://git.kernel.org/vfs/vfs/c/212ed884a1ae
[2/2] selftests/pipe: add pipe_bench microbenchmark
      https://git.kernel.org/vfs/vfs/c/d29bd8efe162
