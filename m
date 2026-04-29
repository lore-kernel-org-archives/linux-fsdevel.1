Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC426F28D;
	Wed, 29 Apr 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472919; cv=none; b=T4C2meNl4F6NNEm1wkJCBhIETtHgZAbDIo7Q0z+bxAFuSyVIA223tp2gCqjN9oV/c9pAscDVRCnPEJHrzpdvjFF7CMMTw2W5gcE9d6PgDryVGI8QJakOaiuqe/yqxNXeslOAmx+4n9HpqKko3m1UH+5iYzIWsWy/L3Ja0NoLV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472919; c=relaxed/simple;
	bh=J4CUD+6uFGwjoawy1DKHR8SIwZmcuozwdjPu54N7dH8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUu6+SJL4VGQxNIrfzikmqpnK7hckFTrJL76FTSsBkwkdPVvvq0cwX71YKF3ZK/IZQ2EOe7ttPyuw5TbOw4hiJNgVbgTjCyctOsjjsHDe4E/66Qp0oLwMYc+kcoS25wSi2z24Pj/fLHpcdc+Oj7rr8Et5BIKqHtCkksX+scclxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMBphlzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMBphlzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E560CC19425;
	Wed, 29 Apr 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472918;
	bh=J4CUD+6uFGwjoawy1DKHR8SIwZmcuozwdjPu54N7dH8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NMBphlzPFSh1SfzenmGwA5277M8uuYf+lXiUEqhc21KhOzFfbwawd1UGGPwBllLwh
	 S9uDKL5m1IeFyIBdVLBgPXqRURUxe3QT7bBT1R56dnkrmPT+Ju4w4Bw+xt+Zzw4gRq
	 U05Nc5RA/8WodlHy829KBakvHeyezfpwVl4bRU/mqzkNc8elx769qc/J1sk44k3Xhj
	 P7/x2uXd+L1bwyW0cRqXk+C+AC0tV8qWR7ysnbH3iqxAAY99t6wYb70cfllLts/bLI
	 9U/72vxPhvU3espqE074ZS7B3QPP+6l9vlwMKVQ+YcGIkYNJ/qpIKkmZJyTSpVaW2Y
	 mA/3YRvsXWWZg==
Date: Wed, 29 Apr 2026 07:28:38 -0700
Subject: [PATCH 19/33] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205558.4101881.9773866029326007150.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use large folios when we're using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_iomap.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3c40a1e58017b3..3519d5a9c836ba 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1430,12 +1430,18 @@ static const struct address_space_operations fuse_iomap_aops = {
 static inline void fuse_inode_set_iomap(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
 	INIT_LIST_HEAD(&fi->ioend_list);
 	spin_lock_init(&fi->ioend_lock);
+
+	if (inode->i_blkbits > PAGE_SHIFT)
+		min_order = inode->i_blkbits - PAGE_SHIFT;
+
+	mapping_set_folio_min_order(inode->i_mapping, min_order);
 	set_bit(FUSE_I_IOMAP, &fi->state);
 }
 

