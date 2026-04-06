Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A34A07;
	Mon,  6 Apr 2026 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453486; cv=pass; b=hcRfNPBZfmwAp6PVISpNLMqPUmKJ0megplazRSlgq4tV6a+bAz7dV9KXNYce/wzReIqSJLZ+Z1j12ZUmI88rChlUamjtRNmHfrH2vNUTzafaiHSya/UpI9q30UMIsqDTbQvB+i1QpY4YG7YiQWXjcvuUri1fwCxDl7pkSjvdsYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453486; c=relaxed/simple;
	bh=fIK1tBDkbAnOr3TY9DIiy4+9IsVgBTBTBTuK8mEDeyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqMq4tAhDD0nx299fBzLFJN8MCERzSMvvDqZ/XKwuuOws4O4e1FWiKCtHqjwIZdxKTJqzcRt6ZvN2t4fs19/7GR2O+/+MeIQNcFtJt6GwntfuDcC6kgZZKMxIxr5T47OPQ2MoIK/3T9Vj6VKptkG5fZj3ro4X04qlSsA9/yMsDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=U2zGYtkH; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="U2zGYtkH"
ARC-Seal: i=1; a=rsa-sha256; t=1775453462; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k8uyPH2AI4/jBTVlmAOnc2nv4m6EcatpFQQEMDhEJUn85fdsnffXqzcuca8J/H8XlMq67wDubc0g7S3tkcAJFVZRPHUZuieMdxRza/J2ERSSuU3/8BUisURK7yVevYns0jcETPfPzjDiDKketBj/nrrN/Cw+RaTxNLrMvKt6eTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775453462; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xATn25CuGcxv0/gHggbifzLDuhCgKz9KowplyikJSTE=; 
	b=SUu9t/cX08w7/Va4maqhntZmCWsDZjJnTnxkQJFrIEz+gFZyDtMZSu1u1jUTjIh2LKvnRMOS/7pzPZS9QbdcIsdMsB2UTEGH/VMTqlAvnCjvo9AoI2hv4TAuFOoxcL+f1NGND8S6WOFfDtbG8zfLGxkEEnDIs0rkwudU5fCI20E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775453462;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xATn25CuGcxv0/gHggbifzLDuhCgKz9KowplyikJSTE=;
	b=U2zGYtkH3W92l5kllwCuPr6t7vJkoou282U2k73A+Ynm6nstZ7/4mCvtXxJRkM9l
	w7C9rXgHmYxHXk5n0270lVOat1FINkQ17qRu8wF+c+mirKNvQtpySDKEyDGkrE6xNtx
	f94kJgo4TMDH6/1WilQM1WHezRr8k9tQypimp+Hw=
Received: by mx.zohomail.com with SMTPS id 1775453459732355.2841034822802;
	Sun, 5 Apr 2026 22:30:59 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH 0/1] hfsplus: optimize b-tree node allocation with next-fit strategy
Date: Mon,  6 Apr 2026 11:00:26 +0530
Message-ID: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

This is a follow-up to the b-tree allocator corruption fix series [1],
implementing the allocator optimization discussed during v4 review [2].

Currently, hfs_bmap_alloc() performs a first-fit linear scan starting
from bit 0 on every call, rescanning already-used regions at the front
of the bitmap. This patch converts it to a next-fit allocator by caching
the last successful allocation position in an in-core alloc_hint field.

Key changes:
- Allocation starts from alloc_hint and wraps around if needed.
- The seek to the target map node uses the hfs_bmap_get_map_page() API
  introduced in [1] for node-type validation and offset checking.
- Map chain extension (hfs_bmap_new_bmap) is checked before wrap-around,
  so nodes reserved by hfs_bmap_reserve() are always reachable.
- hfs_bmap_free() pulls alloc_hint back when a freed node is below the
  current hint.
- No on-disk format changes.

Based on the for-next branch of
https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git

Testing:
- Custom stress tests covering sequential allocation, interleaved
  alloc/free, ENOSPC on small images, and remount reset
- No HFS+ warnings or errors in kernel logs

[1] https://lore.kernel.org/all/20260318073834.462702-1-shardul.b@mpiricsoftware.com/
[2] https://lore.kernel.org/all/7194aa49efdb85c7cfc9578f1460aaa9a1c67095.camel@mpiricsoftware.com/

Kalpan Jani (1):
  hfsplus: switch hfs_bmap_alloc() to next-fit allocation using
    alloc_hint

 fs/hfsplus/btree.c      | 114 +++++++++++++++++++++++++++++++++++-----
 fs/hfsplus/hfsplus_fs.h |   1 +
 2 files changed, 101 insertions(+), 14 deletions(-)

--
2.34.1

