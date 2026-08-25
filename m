Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F423E1D12;
	Tue, 25 Aug 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661802; cv=none; b=cHKGFuVLUURxpyCZWdgIfEUAuZQnNICjdasHGl/JL25GsHfc7m/3ZslnHpFkAsPvUgUJ1TrUZNXb7WVgJ+CXt444fVjt1Dc2b5j19uMVB7JGTfC+zIune96RefWSTAMd02g6TgmnxcFGpL+ZV05hPyGESxwpOppOc1jINDNLiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661802; c=relaxed/simple;
	bh=zegv0uOIQTVJbBusBTSz0+Tjiwn4WVIJQn7nyFTtERE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq4avQ1we4JKo/5ch3Q7lpnd359X2mqBj4oMRczTgj4WR/MueZ93Bsj1bzGEC+yurd2/jM/4tlmhNQ/ZUL+EuLUkqYtY6EAi0HmFiREysSafoGwBBmQw2sje1bNr9cWaryKB7vDc7dap36mm+sFq6FU1D0Q2GbWzD5PdxhpPt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfQa6Aj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfQa6Aj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51D51F00A3F;
	Tue, 25 Aug 2026 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661800;
	bh=3cFyiRkDuno4XggQEQ13JwTounrejiAqkhC+uFERJm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfQa6Aj+DORQF+Wxk1KdA+UcaW7ZLXuNMgjtoa8DCVvyR38P7wh+DqSdWP5Scw0f8
	 S0JKErw58QhmMfRff6z3mVNatnzmyn4LMUXaipcLcKH/C2PNpYtiCtbtfmwg5i9KsS
	 311BmNob7wIAiv7JZldvyoN7/YZZP00KtpD93ZiBRY1YgjrJ/hvH2hia6Z+WQ9/3G5
	 L820/QyNc8K6zpJwbFF3FKEb5XERtLgNipinufRjy7oFHiT7GXB47SCg5VEPlmEos3
	 8szjmN8kdXK9h7Fk+7gOTyQ0hzLglbW8JakQD0av1AMxXFTZCp6baT8du4QCxA+dN3
	 ZiawLCmTlm4WQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ufs: harden the mount path against malformed images
Date: Tue, 25 Aug 2026 14:42:40 +0200
Message-ID: <20260825-andocken-beglichen-taktieren-fb2e887d14cc@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801071306.59484-1-ali@iusegentoo.com>
References: <20260801071306.59484-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=brauner@kernel.org; h=from:subject:message-id; bh=zegv0uOIQTVJbBusBTSz0+Tjiwn4WVIJQn7nyFTtERE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT19t4NuGfMOcE5QE52keSGlw89DaanT7C4EjklPqrA4 74gi+7yjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYTmFkuJpi+dJSViMte+/m VwV/cjYfawvmtpv69vVOhTN/Jm+V3M7wv2r6ugtT2nbbGmeWtDmGfrq3/MFOZ0bJObf26/xKcZL N4gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 10:12:56 +0300, Ali Ahmet Memis wrote:
> Two robustness fixes for the ufs mount path, both reachable by mounting
> a crafted UFS image.
> 
> Patch 1 reorders ufs_fill_super() so the root dentry is created after the
> cylinder group metadata is loaded. Today a failure while reading the
> cylinder groups drops UFS_SB(sb) but leaves s_root installed, so the
> generic teardown oopses on a NULL pointer in ufs_sync_fs() and the
> put_super operation.
> 
> [...]

In the future, please cut down and rewrite LLM generated cover letters and
commit messages.

---

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

[1/2] ufs: create the root dentry after loading cylinder metadata
      https://git.kernel.org/vfs/vfs/c/55a4c98abb96
[2/2] ufs: validate cylinder group metadata before caching it
      https://git.kernel.org/vfs/vfs/c/c9d263be2680
