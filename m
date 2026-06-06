Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B53AB48C
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752229; cv=none; b=qV8xaYJYg0f3UKSUZCJHF5hZtOgbDVDwXtd3nXVa7eHKo8Ac5sKw1BleSkFCUnyw7+KlwvLL3YUcyXhentt74ft6jqtDDAcYMZzVCc/wO4z1ntBAGaBZcAEdBY98l2IpvLvrYjDAghzpYgtL9O+de2Ib96z8Jh+LICnC542/0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752229; c=relaxed/simple;
	bh=KqAzpPi8hGtLJfuBcg1Ih682mVy8O5OwKv5Hr6CSYyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFeH3Yefee1JbjyBd7f+seIoKqtGLakZaT2iIxGSdYF8/qC/qal6Nr3NmZ781AEykm2m2dXtn2jl4MSrWl7hZhrLQ2xGCnrG/WNZjlW8G5Gv5tbGcHhCjBbD5QRwE5QRPEf3wvjZ4pH5m3G26l5a1fPylT8QcZeh5CWXpl028ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6zHZ+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6zHZ+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4CD1F00893;
	Sat,  6 Jun 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752228;
	bh=CK3N4reuqkgIU3xCajC0NliBbQ59y+R5TmUR3YDwDpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YV6zHZ+VJT5tTiv49gnzzRvpZYRC2o9wvK7ViYqsYGzezOzLDbSlgPrVrFRb6NKoH
	 C9L02BYBbb2NB3TwAQQ6V9zj/pxposDjLo2qvLYSnssT3S80zinwW/Zz4G+8oWnADv
	 NsWUXqmDqNCiZEfEdTMC13eJg1KjdPrryTj2qWHAa8yvHl+yRL9elbVz16WApDipgm
	 hfDNLQ3q2qkWZsztk+2wu8orxBCZUdEp2VpHs0rsYNx3GtErrpQuAqVs6eJauAPR8X
	 m2uHZB/9cT4ZB0NNuwSt8Lu+8kU/rVcJp3mPAsVz2UCXsR7M7Ah+gM9Qe9UAgMfwTF
	 bNCfwhMqrHTAA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/4] simple xattr improvements
Date: Sat,  6 Jun 2026 15:23:22 +0200
Message-ID: <20260606-gebeugt-mitkommen-eurer-06f3266d54a7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605135322.2632068-1-mszeredi@redhat.com>
References: <20260605135322.2632068-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=brauner@kernel.org; h=from:subject:message-id; bh=KqAzpPi8hGtLJfuBcg1Ih682mVy8O5OwKv5Hr6CSYyE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSpyCeYai+oWStUXcQToX1avf/lEueSQ09Ko73rf87d5 zV1Crd6RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETE1jH8U44z82ZNWHPvn7ec T+KhyIsZB+s+r2KSdBX5rnDgB/tDR4b/kbFZKvPlztZlxmgW8991fzlJ9vbHTz/mlekuKJvRfK6 MEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 05 Jun 2026 15:53:15 +0200, Miklos Szeredi wrote:
> v4:
>  - yet another accounting fix for shmem_initxattrs
> 
> v3:
>  - need per kernfs_node locking for simple_xattr_set
>  - another accounting fix for shmem_initxattrs
> 
> [...]

Applied to the vfs-7.2.xattr branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.xattr

[1/4] kernfs: fix xattr race condition with multiple superblocks
      https://git.kernel.org/vfs/vfs/c/6a07814ff643
[2/4] tmpfs: simplify constructing "security.foo" xattr names
      https://git.kernel.org/vfs/vfs/c/832f4de4c8ba
[3/4] simple_xattr: change interface to pass struct simple_xattrs **
      https://git.kernel.org/vfs/vfs/c/076e5cef28e2
[4/4] simpe_xattr: use per-sb cache
      https://git.kernel.org/vfs/vfs/c/1e7cd8a53b72
