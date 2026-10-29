Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280692;
	b=ZWTsNoyFQO6J8No+77/lO63qanKdstc9k4bmDIvPIZqKguqzDIL1ZncSvnuPNA6xffNg
	 lKOoLGoWc1IQjPgrQYB96czY694MEm8AVKjUQRcCxR/zDrsOBIIaUJnMEfvw3k2AWxA/A
	 IdHOFLnE/CmYdr9CmP9cWuTIodNGv3w5i9TF0yeQiN31R8xXkinmNu0apU8vygggt3aUY
	 NNObs+y5qyBdLKc/A47gW2vphW+7KGzVm/IOj3EB5H4EPRepRItMUb3voJFgw0OLiqOgw
	 VuiXUli7++9jMjt/1Mth6ZpegZGb3pq4r3P2FvBqGHQ4aJa2HSBSOW1+mtO4SxuUfhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280692;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N9FnodYZ3kBJhwYghvxHoiPkxtwL/OpTE20Oa6bvLyI=;
	b=X3/LAJSL+V+LLfPM4qhxLTKXMq7ICsAiHb5EoQG+WGsoRtwmoaErgkSQJ5ABt2vknYB0
	 m1fn1tBd/XvHZYNdy4zpJCGFURi2c1x3hvxxrGwTy7pnyO+Tda+oyEnhejxmmH4aaNBxc
	 4Y9BGBSwB1vmqhcj+dQoBI5kEE0Q6e891AIvCM9Ux5/6IPYmTFjR/iMaxVoxB2cDr5Mia
	 tE09e83bp+9yJ5BbXmg+FUwYu/a8wWybnpIZu+ZjXmAhxHc6aG4u/Y1bummI7X5CwpVVg
	 kG8J4Ts5XiTwHd1+TMOIdcyp/xq/l0lFe1aq2RfiZ3J7BOg1B3muV4chiSgahe5UmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONahoAZC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B399606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONahoAZC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A591F01825;
	Thu, 29 Oct 2026 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793280691;
	bh=N9FnodYZ3kBJhwYghvxHoiPkxtwL/OpTE20Oa6bvLyI=;
	h=From:Date:Subject:To:Cc;
	b=ONahoAZCw2KJ4Ip3+oj3Vc82Z4vcxvJd7E5UWHxMmHv9YcY/XTkQOH2H1Be1hopK3
	 ZIOznH/netbMBoS/abeX/4nSmNGOEM95BurjlY4RDXEXJKZq3zNN9v7qXiuUZB+BJI
	 hZiG/9OAg/REp6IIZzU5TU+F0PjCHdz1E8gpG06IvM4xjLSQnEHB0SjgwMK9gdutpF
	 rhQ51BnU54FBo3P5Lbwd18qMF3TBzR751uFxu29FuJtreV+XTwf2TMzLoHGDMwq5+u
	 MMdXXTThHYdmtYWkIebO3Ic4X/prC3B9AKqipsKgULC4Hhq8BPt9Ou/XldNwanD3mx
	 BBzKsO7dIzTyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 14:31:24 +0100
Subject: [PATCH RFC] fs: defer reclaim of inodes with I_METADATA_WRITEBACK
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
Message-Id: <20261029-work-inode-metadata_writeback-deferred-v1-1-7e49f6c12b60@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNQQrCMBAF0KuUWZvQhlKpW8EDuBWRSTK1sZjKJ
 Fqh9O4mFVcu/2f+vBkCsaMAu2IGppcLbvQpVJsCTI/+SsLZlEGVqqlK1Ypp5EE4P1oSd4poMeJ
 lYhdJoxmEpY6YyYq27rZVY3WtWoT07MHUufcKneB42MP5W4anvpGJmchnGgMJzehNn6uMyRWT/
 5j8YTKvYFk+pzWGys0AAAA=
X-Change-ID: 20261029-work-inode-metadata_writeback-deferred-94f716db429a
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>, 
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l6UGRopzhmtN4DdQ66yhkoqkIV31utyxLuAkS4gfbXw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ99lrvoNhbZZ9ns3/vj8NbrxzZvfLEgRb+d0u+iGjac
 p+d959nXUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBExNQZ/pc4t35s7lj77dei
 nUpiHBNlFyis8lRa4afCIuMkk7go4gvD//TcLfe8Vub1ndLXEFnkJKndyhT+r65jec3Np5uTjV7
 3MQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

evict() writes out the metadata that I_METADATA_WRITEBACK tracks for an
inode that isn't being deleted. When the inode shrinker evicts such an
inode that I/O happens from kswapd or direct reclaim. Keeping I/O out of
reclaim is what deferred inode reclaim is for. So hand these inodes to
the deferred reclaim workers.

Don't make the filesystems mark them with I_DEFER_RECLAIM though. On
ext4 without a journal the bit is set by nearly every inode
modification, atime updates included, and the mark can't be cleared
again. So nearly every inode that was ever touched would end up being
deferred. Instead, decide when the inode is isolated. Once a data
integrity writeback has cleared I_METADATA_WRITEBACK the inode is
evicted directly again.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
This goes on top of Jan's deferred inode reclaim v3 (cf. [1]) and my
I_METADATA_WRITEBACK reclaim fixes (cf. [2]). It's an RFC because
neither of them has landed yet. Jan, feel free to just fold it into
your series if you like it.

[2] makes evict() write out what I_METADATA_WRITEBACK tracks. When the
inode shrinker evicts such an inode that write happens from kswapd or
from direct reclaim, which is what deferred inode reclaim is meant to
avoid.

I didn't use mark_inode_reclaim_deferred() for this. ext4 without a
journal sets the bit on nearly every inode modification, atime updates
included, and the mark is permanent. So nearly every inode that was
ever touched would end up being deferred. Looking at the bit when the
inode is isolated defers only the inodes that still need it. That's the
case Andreas asked about (cf. [3]).

Tested with the reproducer from [2] on top of v3: same numbers as with
[2] alone, no OOM in the memory cgroup run, no splats.

[1]: https://lore.kernel.org/r/20261009133253.20102-1-jack@suse.cz
[2]: https://patch.msgid.link/20261029-work-inode-metadata_writeback-v1-0-7d6c678a585d@kernel.org
[3]: https://lore.kernel.org/r/CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com
---
 fs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index c67ec6aa490b..9420afaaf7ce 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1086,7 +1086,12 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 				     inode_lru_isolate, &freeable);
 
 	list_for_each_entry_safe(inode, tmp, &freeable, i_lru) {
-		if (inode_state_read_once(inode) & I_DEFER_RECLAIM) {
+		/*
+		 * evict() writes out what I_METADATA_WRITEBACK tracks, don't
+		 * do that from reclaim.
+		 */
+		if (inode_state_read_once(inode) &
+		    (I_DEFER_RECLAIM | I_METADATA_WRITEBACK)) {
 			deferred++;
 			continue;
 		}

---
base-commit: 548be8616e3e38a9dfc02bd766582ec0acf06647
change-id: 20261029-work-inode-metadata_writeback-deferred-94f716db429a

