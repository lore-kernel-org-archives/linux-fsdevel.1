Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A33E6DEE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945298; cv=none; b=OXS1Xo6o2qQXndw3qrsFwy1Aml3XDai2eTcPTWvLgvMsF28Q+IHEEXMZCH61pBIKBeclZ9p07DnxDJgotTLZ+Xl2X8kUq2M2pZFGbd+hSFAFktQCRYQg9vgdQXnQDyvPgAUYm1sZWaIhWQ9kUilM/PdgLq1L3V5eFPOA3tbbjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945298; c=relaxed/simple;
	bh=wd6kpVzP5llv2iK5wlvnd3//o81oxTSbkB31VS6SybY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogNIwZKn7FbCfjOAGDRA77iinUWjqo3iFgRKiLlYYAgsprienoppcfzGVB9Si2qrIBhuKzxvrq0PhTIQQsaWG76Mk2hWmlwnLIHeFzL5J5RCSyxq3RxrfUY+Ja05QRdrrFQFjwwP5gSiS4nALGlCD25t53n+5532Gj2pwLAUC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWqqcQ85; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWqqcQ85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0A0C2BCAF;
	Thu, 23 Apr 2026 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776945298;
	bh=wd6kpVzP5llv2iK5wlvnd3//o81oxTSbkB31VS6SybY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWqqcQ85l+gTi0LYB7ogbmAgAZW7hywPXpchQwej/Om5qHnHAkQiUbTlilBDOQ7ij
	 +YKOI9tBMjzlNix5EOEXyQB0J5YwtLGvtVztwafJSpbXX8cMxm2m0aZ+5FInVDkxqo
	 1oaMrcScl4qzHQbAHuLVPQ0sLTtJYjMTcnGB4DsSrwU/h/zMNEQH8WRQcwtG83W/I5
	 qW10YuSS/ZFB/uE5Q8HwA5OgAfIucF3WeIVc9wJ0rVs2Tn5RpcxRVYhsBE0NPjswPe
	 6fNyhXQdOdi0Z9O5ERZ8ZH8adPSmpgtYQx57jTpQIdAd+/3K+mJS63Vb/WMlPQmNL5
	 0d76Pzssnc0zQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Ruikai Peng <ruikai@pwno.io>
Subject: Re: [PATCH v2] fs: Handle multiply claimed blocks more gracefully with mmb
Date: Thu, 23 Apr 2026 13:54:53 +0200
Message-ID: <20260423-relevant-zaungast-6ab72fecb116@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423090311.10955-2-jack@suse.cz>
References: <20260423090311.10955-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=brauner@kernel.org; h=from:subject:message-id; bh=wd6kpVzP5llv2iK5wlvnd3//o81oxTSbkB31VS6SybY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+4ug9WpAt/yd2ywWTAx7rojxj4lLZZ13Y/O9LQvFHl pLPvsLCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxVmVkOHJb4aXVsuzZGXsj ZThPLF/toq1teXBvPcf3LtuDnPyT6hn+8AUrSaxavODs+cn889bEeUstDnnauutBzc1dhZyati5 CPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 Apr 2026 11:03:12 +0200, Jan Kara wrote:
> When a metadata block is referenced by multiple inodes and tracked by
> metadata bh infrastructure (which is forbidden and generally indicates
> filesystem corruption), it can happen that mmb_mark_buffer_dirty() is
> called for two different mmb structures in parallel. This can lead to a
> corruption of mmb linked list. Handle that situation gracefully (at
> least from mmb POV) by serializing on setting bh->b_mmb.
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

[1/1] fs: Handle multiply claimed blocks more gracefully with mmb
      https://git.kernel.org/vfs/vfs/c/85cd1b6eda78
