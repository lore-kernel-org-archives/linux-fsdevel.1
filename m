Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897236;
	b=22I1SdeYU6usMtDiwDrXiaCjqPn/Y/CkBxqZYFGL04JshTGnl1w7PbBgBlxvfKtdXHmW
	 hbokga+4VRF1jD1GygGUNYtWB36EMDbWFbyYCKOwV6W6WC9o2x8GFG1SjwmWtkFctn/jE
	 DYId+/xcmo3ZsX5Up7rI6rxHK6nBOJoqeiJWxrDxMaJn+hFCIGtT+rck+Azm4b29htHhe
	 R6B2M/7EbvcuxbEFBcrXBJAoKoaPWw/XIyBKfaaI5qR+lnCMKuE9RvbyuOa4WStKiALT0
	 23iC5GE4ekbc1+gqfZ8IDIhKENR1xLUm93NLhWDYmrK3YfN6lo1AFyZ1s0g9rFuV3+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897236;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=jNG1aps4R+HTumhwe6FbpJKRYYq9ElBPc4aOw7sMsq0=;
	b=4Wz7lu/9C5OpdTyLBK0vMFOstsvao47fv+KzJjFjxUOi3r1nezBfjNZweX/OKYeKz+d1
	 av5c6z6vAnymK0SfefHHfUR/3qmfuuqJaaGNut9uAEOvdOkCA8gUreznloIr7bs/kVrTH
	 37ehXv7Ks+gQKEsMehrEA8FdMxcl/lp2WQ2lnIxBZQEwxyOmOO4lzXlWdyDvThjHhvWY8
	 C4eOdrutWJsMSoT+BiOf9gCJB3VOAQz+EEakstIwK5cBbYnGuAGHNDDp9n0/aRLf2e1yn
	 phH+wP+kXlR85trjD1hSft8SUXQTTNFn7b20TdssT99bRX3hYqva4hRbn/25pY0FY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH7f1rC3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E67606A32C;
	Thu,  5 Nov 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH7f1rC3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B28D1F000C1;
	Thu,  5 Nov 2026 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897235;
	bh=jNG1aps4R+HTumhwe6FbpJKRYYq9ElBPc4aOw7sMsq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gH7f1rC3nv+u5B47DXA6huc1TYmmshRhVSRnULRDdFNIdICi50wIeZGNiBadFBIp1
	 rDt/ybvyr2JUqdFShutl43qfSHcq8Fh/POeFRrNxVGhlo7inoEvjD/s4/P6hFOU47a
	 D1v0M4ux+vlP3iJr7xzed+JHTpg66CWdwEOMeMX1MZg9NQ9uAdab0S/aaRzw0MpQxB
	 cMv20dy5cLQVYksPqBCloqhlv6b/AKQIY2laFVbYFKrssDo8FecDHTnqWuI92IBSOl
	 1uPsi3nAqAFyNXR9YeFsz1+fvgNdPq9UvBsPvlxcz+ZEKiT6kIkoNdxwwG/6AlQNfv
	 /K6lbJP6vfqSw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103-statx-v2-1-8b09aa8118ab@kernel.org>
References: <20261103-statx-v2-1-8b09aa8118ab@kernel.org>
Subject: Re: [PATCH v2] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
Message-Id: <20261105-binnenmeer-gegessen-imponieren-c64f267ba409@brauner>
Date: Thu, 05 Nov 2026 17:47:12 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 03 Nov 2026 07:04:00 -0500, Jeff Layton wrote:
> STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
> from stx_attributes but copies attributes_mask verbatim, so it leaks to
> userland on filesystems that advertise it (nfs, ceph), e.g.
> stx_attributes_mask = 0x8000000000303000 on NFS.
> 
> Add a new mask constant and apply it to both fields.
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

[1/1] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in stx_attributes_mask
      https://git.kernel.org/vfs/vfs/c/3cfb4bcbdaa4

