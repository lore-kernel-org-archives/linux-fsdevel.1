Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276515;
	b=xGV5GXv6C6l7PRQjxjzUF+uIev4W61pOPo1XyNmBL/+slGio8w/IEpqYEnruu9zsN5Tl
	 iL/I4f97LUg9C7brJ1jtWO0G/33s4fC7ocUDgsGKg9RhWLjsyE8xF+FxcIuJ+DXqSu4jm
	 kLi7fkqyFYRmzD3yobPt+uTDtAlHNFHGN6a3GnArg/XdsFu+ZOAqlPOcRxb9twPJFR/40
	 uPqJN42SoFKisAfcvFj5p8VzWvlQwwssONUJdne6cak8CSx5BJ8WTCZw+ZfCndN/NQRx8
	 MiZ2vQvqlFocju5r93ZrAuS4T4EQak8WlStz/eW0CAtwLEpu9Bv3wDKmPv06vQwXfqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276515;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+WySaPF5ekmsCugZKovMw6iIElIcUVyZW/MY9QMLJfo=;
	b=X6yN+Zq61FuF29aQ7u65b8JeYzN00WjQh1FkESdok2RY5OwV02YZn56yLiUdGtSuGwGH
	 yLr14ecWS7en0XIg7C8BTofpzeGYrO4PrSxkjxjhhYdNSCSeHXWkL1/yGbMDxBzDwLcll
	 Bp9sQMn4ShFPjVnfDBTrSmtFsPfjuyZcnUVfw7xTf6xI8Y620lYqnEDjrpLwJ7bomKSb2
	 Q/gfT/t0ROKl4DjzdeKue2P8wEXXvKcKyrbnA2MJxu8jK1rqYk6j6wSbWZfXakx/OvrCr
	 VSz7/zdTtzsEJpLbq+c+gbTuH5JQIfrUi5k/X4CV7gBAA49VSs8pSDA7kYCbCqfx7dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPIsfgGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C58606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPIsfgGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDFA1F01828;
	Thu, 29 Oct 2026 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276514;
	bh=+WySaPF5ekmsCugZKovMw6iIElIcUVyZW/MY9QMLJfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fPIsfgGwxOE1YTKowwSRNLbdjSXItCUJ8zHUQUDhnX7QNYg3ldaFiRf/1rAJHUuEr
	 +ftM1m3r6zexeO8Ut24mSTK0BvscEB04vIgsMLBs81c8fSCnptWLxvQlfroM0TobPs
	 ADFmf5PTGWCt7prvGgMhC+mCYuILCrQ5ANQW/L3GyPpWk5tmaiutV0LgER8q93MsPR
	 6QTBVQ6iUWr+O0/FhbtHNzJ4iKeDXXiD79IMCIe8Xdw+pU56AkMrvqjMJIRiTjTmUS
	 jAUlMma1QMgOAIbK80m94DnAio+113vyaJSB+cplS4Q8Dyeg94PFJ4XxrZMOiB+05S
	 pvWNwJkIkoi5A==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Dominik Maier <dmnk@google.com>
Cc: linux-fsdevel@vger.kernel.org, dmnk+artist@google.com
In-Reply-To: <20261022232119.2537209-1-dmnk@google.com>
References: <20261022232119.2537209-1-dmnk@google.com>
Subject: Re: [PATCH] xattr: always invoke cap_convert_nscap() for
 security.capability writes
Message-Id: <20261029-widmen-unkultiviert-suchen-45e8085628db@brauner>
Date: Thu, 29 Oct 2026 13:21:51 +0100
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

On Fri, 23 Oct 2026 01:21:19 +0200, Dominik Maier wrote:
> Commit 8db6c34f1dbc ("Introduce v3 namespaced file capabilities") changed
> cap_inode_setxattr() to return 0 unconditionally for XATTR_NAME_CAPS
> ("security.capability") and moved capability validation into
> cap_convert_nscap(), but placed the call inside the "if (size)" block in
> setxattr(). Commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> vfs_setxattr()") preserved that "size &&" condition in vfs_setxattr():
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

[1/1] xattr: always invoke cap_convert_nscap() for security.capability writes
      https://git.kernel.org/vfs/vfs/c/0f4a9e682f7f

