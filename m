Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E813C9C4;
	Tue, 21 Apr 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771076; cv=none; b=YCT7VgtpT1OfZtqikPE3daW5Dq7iFPw/0ReiiVbEWAgGNNpXPutyogILIOjTXk2v5IaVg+PCrsmdM6xPIzOZb0zZNsuer04PjubQX1px+4xgRqmQurFOtfJ38W46qk6ewsUduNce+b48LaZ3lsnFj9GJjuTrNvUT66Dp82hO/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771076; c=relaxed/simple;
	bh=d5vdQkGGjELQ0CdD1OQ2FWcGk8F0T7Q9jpHTOkud/r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCIrvPvLfEaVMZOjhXZLc9Hia4gjjWromTzxYrxSPZfsGX4J9NdsPOQp2lw1gwuloi6f2Nbzt5Gqu5T+M8OCUfglp2PK+njioMLlzY8g0Uo9KpimeflMTpDHz6Fn5Sr0Ul+cGGYCtCYxWnfWKTRlMKL0n5VQ5GFV8rojaWhphbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKCOAH1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKCOAH1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B87C2BCB0;
	Tue, 21 Apr 2026 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771075;
	bh=d5vdQkGGjELQ0CdD1OQ2FWcGk8F0T7Q9jpHTOkud/r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKCOAH1pB2B/whWQZ/ugsLTngXNEslfTRViaBmE329eGWThvmtUGi9uUWdv3G6njf
	 UojT11xDgEDeki0rDNgbKVlbcjqAyhQy2znLIuM1ejfmOfiApNNsIVjQVyzXkB1IQi
	 W8IXbIN76CmwZlUd2IeRqZVXSKo9ugA2k37DGmwU9cK2QsogBvstxRlF/cGGxlMxpP
	 h42j7QJXUrfItDF+d7lFDq/tfLBb3ia5Bg6abFjqejOFTSCfdibnh/gaRCJKXMQH7P
	 gXvT0zLdTVg1x1Wh/9iiRev+srOgXVY7b44bgS62ItivY/EgYAYhQ9PpAI4QR1GLnZ
	 FAKu57nMvoP0w==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Samuel Page <sam@bynar.io>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Zijun Hu <nightu@northwestern.edu>
Subject: Re: [PATCH] fuse: reject oversized dirents in page cache
Date: Tue, 21 Apr 2026 13:31:10 +0200
Message-ID: <20260421-tricksen-trinken-ada351b5e4c8@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420090139.662772-1-mszeredi@redhat.com>
References: <20260420090139.662772-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=brauner@kernel.org; h=from:subject:message-id; bh=d5vdQkGGjELQ0CdD1OQ2FWcGk8F0T7Q9jpHTOkud/r8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+j/8vsijVw+72TNGlUoZZHuv+fnS/J7DW9f6+3TMSU zOeMNzt7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIbGdGhul/SwQEeI4c8/pZ GxT6mOFW1QL1WN477kw+dVx8OQWXVjAyLDL8qT37gNLRqlXepoXz9cVT13XuY1b79ubi2u93t9l YMAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 11:01:37 +0200, Miklos Szeredi wrote:
> fuse_add_dirent_to_cache() computes a serialized dirent size from the
> server-controlled namelen field and copies the dirent into a single
> page-cache page. The existing logic only checks whether the dirent fits
> in the remaining space of the current page and advances to a fresh page
> if not. It never checks whether the dirent itself exceeds PAGE_SIZE.
> 
> As a result, a malicious FUSE server can return a dirent with
> namelen=4095, producing a serialized record size of 4120 bytes. On 4 KiB
> page systems this causes memcpy() to overflow the cache page by 24 bytes
> into the following kernel page.
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

[1/1] fuse: reject oversized dirents in page cache
      https://git.kernel.org/vfs/vfs/c/5c3b2e242190
