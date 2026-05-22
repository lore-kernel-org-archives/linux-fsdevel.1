Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70D3A3821
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453856; cv=none; b=RexmwpjQfjYdFNecoAQCtDbMFo8LqHEFU+VwZZMoy8Jbku5QRIJz+XO6nttvxFHQTxtJZ0L8WsDQ0FbGP3vAHchO9S4rmqzy3OFk/txHm8+BO8b9DHk91UY6t8JEiWpa/0cHycY0y+LyO1xmZjcc30P6Zvm5MtWhw05Vma6vm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453856; c=relaxed/simple;
	bh=OkWiNpV0PrDScl0wgw6JJtVvWGS2GjuALDAAMIEVDlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dm6NAW2AeHtKkDFzslBbPUB53jEDMKFwi77rTucP45sfAuaXo0stLAaWE6sLAaiMN0cBtsFM/oynJIX6JvNE8pJJcvFootPuroNuB3tqJwrpMQAkVSe7UqnDNKj89NqyE8MucIvZ2LJH+lAC6S+WmGHJIEwskdv8vCqYQzZaHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVvolVah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVvolVah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AE01F00A3E;
	Fri, 22 May 2026 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453850;
	bh=W0Qd4kCzcdahkGKiDbTYgBLTZeAVdJQBjmYLYQ/bOBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HVvolVahl0LCA3BgpBk9uL4ztcewbhvBM8P4AIz/tjfB5p/1lNdN7Gyg8es077TAo
	 Jio0B/oSOEJybGoQJZcwgfBwzbDX1oOM+2vSWAolBWcTdhI6dI686hWzQQQOeiF1st
	 5lH650AqIpbXkXdZL/zPnM6yY71AB/NJ4XbzRkBGaGbSF6rUUNYsxsHcu/eLmnaRNp
	 6cMu3fh4w7gq68AFfHM+TKLrcaJpI+Ii6VXUdoaWjdCvA1gpKwCB3UbX8nv7jCSbxy
	 qFE2xp5bMkm20AEKu6LyXFbhoXFp1FMrHrgTQZLej/Pa0N7EG135PUnjocVvvmlAsj
	 NGS2yLmZQF3uA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-mm@kvack.org
In-Reply-To: <20260519081324.979769-1-mszeredi@redhat.com>
References: <20260519081324.979769-1-mszeredi@redhat.com>
Subject: Re: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr
 names
Message-Id: <177945382308.2991556.1256192774754909984.b4-ty@b4>
Date: Fri, 22 May 2026 14:43:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OkWiNpV0PrDScl0wgw6JJtVvWGS2GjuALDAAMIEVDlA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJ+M8o3CQW0dEc+EEkRZStP5f5sfV6i0ivh6aa9+3dm
 3+xSoR3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATOT4Job/Tn3rJrBG7193but2
 WZ9Pj4Scf39TE2IWO/ufSe6ThZn8ekaGw56aWvzZwV0CVs7/XQP2XrAvNGH0k9jKkR6wMWx3VDQ
 zAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 19 May 2026 10:13:21 +0200, Miklos Szeredi wrote:
> tmpfs: simplify constructing "security.foo" xattr names

Thanks, this looks great!

---

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

[1/3] tmpfs: simplify constructing "security.foo" xattr names
      https://git.kernel.org/vfs/vfs/c/aba5853b137b
[2/3] simple_xattr: change interface to pass struct simple_xattrs **
      https://git.kernel.org/vfs/vfs/c/1cd9d2387c05
[3/3] simpe_xattr: use per-sb cache
      https://git.kernel.org/vfs/vfs/c/12e9e3cd03b5

