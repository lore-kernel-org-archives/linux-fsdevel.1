Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9832AACE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163120; cv=none; b=Aa6O2wqXBOd6fm1HyLj2c/fh1J2jrjlFAJic3qbWxyzwEiz3U7ZrSYjgq3AN/swRvh7CyLnJMDUxY1dZ0dJ0MLYdBSbYg+zbwgVaJr0moW7VHabVZB2QOmxivOTLHazSzmawUYIDc3t1elpRpy66cuH3ZLIWwSj7cUFso5Yd/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163120; c=relaxed/simple;
	bh=ISKquQhqIJSHIc+WSYsjQmPNfXOAlUpNqmx6gz3TOjY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fYKimnZjR/IyhOUPQjR5nuCoOlkFnMJjpEaQuZ8IX9lGMaGN1bvR+5rIbE7to2wkNlaTL9yuZdCdHKVsT4+cshGUR5rpoOEw6N9E0c+jgBebuZt0qounxunw2lI0NnIuBs2YmQhYv4kk8dOKL3QNS15aiLp9GuIxn+3lkCYeAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upLOXXJB; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upLOXXJB"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772163116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr4zyboFdAPQ3Cak33Bpk6ampsu5iWEcatVRj6UGzbk=;
	b=upLOXXJB5UXrgeCQzrsGUxZEF1D3mrKy6Rj9kcUrj+82JPeXSw/miuAomPgutSLnzOce9l
	d6n97fFDvsQpw27NUesDKBVP/e1Ra/v49rzBWLeDFaXtLPcDDe4KU0zKEfwkcXMdgvib2R
	vl+2mbopA9te9KyKQuYniQDS8ShLqpE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260227025548.2252380-1-yebin@huaweicloud.com>
Date: Fri, 27 Feb 2026 11:31:14 +0800
Cc: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 jack@suse.cz,
 linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 yebin10@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
To: Ye Bin <yebin@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>=20
> From: Ye Bin <yebin10@huawei.com>
>=20
> In order to better analyze the issue of file system uninstallation =
caused
> by kernel module opening files, it is necessary to perform dentry =
recycling
> on a single file system. But now, apart from global dentry recycling, =
it is
> not supported to do dentry recycling on a single file system =
separately.

Would shrinker-debugfs satisfy your needs (See =
Documentation/admin-guide/mm/shrinker_debugfs.rst)?

Thanks,
Muchun

> This feature has usage scenarios in problem localization scenarios.At =
the
> same time, it also provides users with a slightly fine-grained
> pagecache/entry recycling mechanism.
> This patchset supports the recycling of pagecache/entry for individual =
file
> systems.
>=20
> Diff v3 vs v2
> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim =
dentry/inode.
> 2. Fixing compilation issues in specific architectures and =
configurations.
>=20
> Diff v2 vs v1:
> 1. Fix possible live lock for shrink_icache_sb().
> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
> 3. Fix potential deadlocks as follows:
> =
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.=
com/
> After some consideration, it was decided that this feature would =
primarily
> be used for debugging purposes. Instead of adding a new IOCTL command, =
the
> task_work mechanism was employed to address potential deadlock issues.
>=20
> Ye Bin (3):
>  mm/vmscan: introduce drop_sb_dentry_inode() helper
>  sysctl: add support for drop_caches for individual filesystem
>  Documentation: add instructions for using 'drop_fs_caches sysctl'
>    sysctl
>=20
> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
> fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
> include/linux/mm.h                      |   1 +
> mm/internal.h                           |   3 +
> mm/shrinker.c                           |   4 +-
> mm/vmscan.c                             |  50 ++++++++++
> 6 files changed, 225 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.34.1
>=20

