Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B31E4BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142995; cv=none; b=lprooagxAo4mganlSvjxjGhAqKzFjN+2ARFQFE7qoWHIZGCtf+nUfKjXsSqHoyx+RuT3lTERiVuIXSGXpS3X8/FBw/22HXpBYBYfpF6FlDiu6thg0PYR2fxlqldJqh7RjpjAMBi+zyAI0ExEx10uLTwljaqU/vRwTAmU0uiZlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142995; c=relaxed/simple;
	bh=LsSKa4OOxFDIrQsustTFnu8P1ZHeiaMTkXDVOiY1Jv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U8J4P873YdbVZZVYT0zMJeAI+IXwjMHhSPedfzJKtT1cbavm9QsYWgHLXq13a6v/0ikIlZ8dT2csz6/ePO00FpeOMqhYYjNm/m3zyFujdIgtataDKUXzDHUrVhhRSSwKF6aoPLypzoWYf6t+gH60qbTO+mhVi+776CaZPYUdnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlugeshm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlugeshm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2FF1F000E9;
	Mon, 27 Jul 2026 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785142993;
	bh=rz61UIzp3gNhXeqXJ6lCUi5KFjxzOwVDkdatD/1kxkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Tlugeshm67E45cQfZHVwA+mYLAjgmQW3i1a5ZTKK4FnRGQjCWOJ9hCuVoZP5tnn8b
	 7lb6jJ5t8MKi0o7afXJtA5zY66BFSvWBbcmOnMK1FlfLBUQ+vJZyzhDM5Xz373utrM
	 iUdxJssBHlGgwD8jYdGmlezLECIVeQE//aNFhJOhMe3fR0YuZ8uv4vwtkcp832yF6y
	 p7jnRHvdhtdI455nbuxNll+hnEtGq1wejgm5P6Nba+pGTiuL1mOOSMamDiY3Wnfqpf
	 nImL9PnoWCJqS0XRglsJW5PZ21sxJr1HDZSQHGMFD2Pf7FeuPUIfb/6NTw+oaRM22s
	 Uk4gO9Z6VJCzQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, NeilBrown <neilb@ownmail.net>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <20260714230534.776886-1-neilb@ownmail.net>
References: <20260714230534.776886-1-neilb@ownmail.net>
Subject: Re: [PATCH v4 0/3] VFS: refactor lookup_open and add vfs_lookup()
Message-Id: <20260727-zugkraft-zylinder-klonen-0dcdf1ff6e35@brauner>
Date: Mon, 27 Jul 2026 11:03:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LsSKa4OOxFDIrQsustTFnu8P1ZHeiaMTkXDVOiY1Jv4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSly10w9Xi8ukJp5lPJ73qn38+5vU3JUqHoVfPjEpX4u
 ao9f9sSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSwsPwP+LRscR0r1uuR/c8
 TOeOiWq4ekW9Su3VU/nGS56X3iXf+crIcOOGu4TIeb+aHbz+E882PF3SmLb74/uTnwunTl5o9Zp
 Jlh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 15 Jul 2026 09:04:11 +1000, NeilBrown wrote:
> VFS: refactor lookup_open and add vfs_lookup()
> 
> This v4 add a WARNING for unsupported O_ flags, and fixes some
> documentation typos.
> 
> Thanks,
> NeilBrown
> 
> [...]

Applied to the vfs-7.3.lookup branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.lookup branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.lookup

[1/3] VFS: move mnt_want_write() and locking into lookup_open()
      https://git.kernel.org/vfs/vfs/c/ddb6e6c72a0a
[2/3] VFS: move delegated_inode retry loop into lookup_open()
      https://git.kernel.org/vfs/vfs/c/a5438415be54
[3/3] VFS: add vfs_lookup_open() for nfsd
      https://git.kernel.org/vfs/vfs/c/536227b814bd

