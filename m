Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E412F7EF8;
	Thu,  4 Jun 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574058; cv=none; b=sWSx46rsDAkmDeV4XRo1aF9eyDjn5L9FkWS4e7smWqOLdCHMlxjwQgBwBQ9WZFQ+GmSdlODsMQp+GN+Hme1GvEjFeFzOspaCttqTUa/ZKmfY33I7JQB5OJgf/lzSn0SS4tbwi3qK45BpKtR8lHf/9+VmSe6WgUVUz8vq6tTSrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574058; c=relaxed/simple;
	bh=tkRNBsPsLLVI+kct8IDelTy/WP/ldFVTkmuTcES2YPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1CJJDO31mI/9nswga3hPU49tZGKJxa1iag+yNMCgtPaA9syHppbrVy+WH59AHNClwbSvwYOkDVQs15nyFp5Knz2+Pz/cXii2ugh1acEdlx8YKjtPdKb7AAr71QW6lZhP9EljjtQT7j4O5eTumDTis35RPoq4NMpS3RTkWDvxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHOXWYqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHOXWYqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263561F00893;
	Thu,  4 Jun 2026 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780574057;
	bh=5Qq6GJhyKGtHbFu09KmmMAC7z1sgjGWJIkBgTTUBCmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHOXWYqgYZVHo2i9uPEd0GMWiSw6g6N5viOUgifFbtTi5/Z0hYWbadQ4ejfw8hDlC
	 r68sPlwzVEkyOe92urKre/wCDs6uv0UXVEdfltO8eJ7BsFZ6kq/Nu8gr3xIELGkU/L
	 oUTBMv3CIVrXyoLkul7cRWnNWQQtXo1KuUkMtccU1N8UxCgzCalttk//MmCbpGudJ/
	 bxnn6Oa7HB0+a6llB4LU30p240+Vk/p75Hus8idS1pPVdUjCQ3AIvDgBzxreS26NAb
	 JZoHvc1nFBF0jcDTMmkN0M4FhcIcZfhjN70qFNoKo7BMhDqmHG+2eDg3eheB8Z/v14
	 Ab78Qd6daLSlQ==
From: Christian Brauner <brauner@kernel.org>
To: Zhan Wei <zhanwei919@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e70e1b6cba8714543f7c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] eventpoll: restore EP_UNACTIVE_PTR sentinel for ctx->tfile_check_list
Date: Thu,  4 Jun 2026 13:54:05 +0200
Message-ID: <20260604-sodbrennen-buhlen-trugbild-7c9fca205113@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529142533.23696-1-zhanwei919@gmail.com>
References: <20260529142533.23696-1-zhanwei919@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=brauner@kernel.org; h=from:subject:message-id; bh=tkRNBsPsLLVI+kct8IDelTy/WP/ldFVTkmuTcES2YPE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQppqc8qDS5fvTSq5ING+U6qo9sfeZr9535Xp1f+1a3K xM/untf6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIQQaGf3arc98qSy+0NQ+S Z/XzOC9gb7Vk+mU3cZlUTxH/75MCMhkZNk1oLkhhL/20d9ralBb+e3dOa/rncfsJX45yVfHQSFv DDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 22:25:33 +0800, Zhan Wei wrote:
> Commit e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into
> struct ep_ctl_ctx") moved tfile_check_list from a file-scope global into
> the stack-allocated struct ep_ctl_ctx, and in doing so replaced the
> EP_UNACTIVE_PTR sentinel with NULL on the grounds that "NULL is the
> obvious 'empty' value and zero-init handles it for free", describing the
> change as "No functional change". It is not.
> 
> [...]

Applied to the vfs-7.2.eventpoll branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.eventpoll branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.eventpoll

[1/1] eventpoll: restore EP_UNACTIVE_PTR sentinel for ctx->tfile_check_list
      https://git.kernel.org/vfs/vfs/c/a1e9718b406b
