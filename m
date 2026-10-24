Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877684;
	b=LUmvbJ49aZSF4ErJv1DdwWYUUX0SQtGhGlj0BJpEsaTxykYLU/M1K2Rr+S57zltxwpry
	 +dqnq11ltpSxaXZBj2mul/lOzQ0EETgBfnC/Ee/WBoMLkwj4Ot/b8Ps/cHSlfhKPKPA0F
	 1dWpBlrroeNy9nFnWHKmt/YJwDTj4HNdCBDj7O3Ge8IlA/6H2eZT/+sOSVhJehIvpNaEQ
	 hNLSK4Jzo42DhDYyraV7vUg2Zbe4ceoPlckYo6Z/+08sQ3aNN0iDXolFRmH6vBK1S+p0E
	 akx6pQ5+1eUDJbOf17yrxSIab/+dzN9vdTdskk+sDWEJfUowdmpLPtMmj7bOHLVqZhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877684;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ph0Eh9QzkzMCQ66Pk6A8/YQdg+1IERC0mMGYKPed2+4=;
	b=XJKc5ciy5HD0fj6h4ydnHQmZp+3IVtDA6ZRb0TwKz4BcjQqht8VaVQUL0zSvTAEItuv8
	 pv7YXK/OEATY3LeBDBIioVNCr/fF/oH6dZPHXUAgcnS+Xt+XX2TP/MvJsbq6XW56B+V6j
	 sG4mMUkD9h+9kRyf3Dx57H3z+e5lM0A5cJ8kjjOnugJj7T/bDrou1b+NuonJuAZyF444B
	 CGVFs5nQFclcOOv3F1fTLwaraIIIZoRGhmKL7LhasYtyR9XYNLqmtWsnzn0tnWcZ2lga2
	 uDNwy2aUG4tC9CXp1hFnRGgtidzkc/5xf3f1JoGqL7uRSf27UzWoaLhdjrBWuSE11RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=ZfvWZEuV;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DA606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F8DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=ZfvWZEuV
X-KPN-MessageId: b853eb64-cff2-11f1-87e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b853eb64-cff2-11f1-87e5-00505699b430;
	Sat, 24 Oct 2026 23:34:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ph0Eh9QzkzMCQ66Pk6A8/YQdg+1IERC0mMGYKPed2+4=;
	b=ZfvWZEuVTUWWsCTijjSYj5QNQ660xotkFXgbYCYpPDFsKhjnVv8CHSSFG7Km7VoeY7F9JYOKxSnyF
	 /4VtQi+/fao49aqt0lu8ze2SpDcPzLW5T4cL8+HJquEOtmQO/Z1H9LoE4USfjR2cHcR5S58HIJ9a9T
	 5rUa2VJXa7do7isfIWcYW3yimGlaxO7g4RNKu+JhfXEU0uMDEUaIYnZ/omR5OjwIhNU+dqjsrTovp1
	 QvL+3dK/4kz4mYMKPjCf2FfZXj3g5JIVE9KO4qxG04RD7rGiHkNXaXr3gispPSPw3Kz+XRjfniQC9y
	 llPHSGVXAJZjeyEZESeFfvjUtZwwAuA==
X-KPN-MID: 33|casElgXX+1D1ifhEdGcXFgDPh2YpaP0ytQOAbfxPfsWGyZqLdTcSO/swNeB0Z00
 JI78aJcNEHOEOF+iX18VZ4jxgSNpeRG4vCTwzpfNzFwE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gFm9x8PMAFAsHE1ZL4wlIsA7VzjvkGV6vNcCFJowKra5rus/271VH6PKLQheqe0
 aq0QUUtY7jaqJHu5H3wyx5Q==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b817fdc9-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:40 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 08/12] kernfs: hold kernfs_iattr_rwsem when initializing a new inode
Date: Sat, 24 Oct 2026 23:35:35 +0200
Message-ID: <20261024213539.1307600-9-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_refresh_inode() copies the uid, gid, timestamps and nlink of a
kernfs_node into its VFS inode. Since commit 9caf69614225 ("kernfs:
Introduce separate rwsem to protect inode attributes.") these are
protected by kernfs_iattr_rwsem. kernfs_init_inode() calls
kernfs_refresh_inode(), but was not converted. Its callers in turn hold
kernfs_rwsem but this does not exclude a concurrent
kernfs_setattr()/kernfs_iop_setattr().

Take kernfs_iattr_rwsem for reading around the refresh in
kernfs_init_inode(). This nests inside kernfs_rwsem, which matches
kernfs_link_sibling() and kernfs_unlink_sibling().

Fixes: 9caf69614225 ("kernfs: Introduce separate rwsem to protect inode attributes.")
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/kernfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 6630b29d7c07..3854ed5725e1 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -204,7 +204,8 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 	inode->i_generation = kernfs_gen(kn);
 
 	set_default_inode_attr(inode, kn->mode);
-	kernfs_refresh_inode(kn, inode);
+	scoped_guard(rwsem_read, &kernfs_root(kn)->kernfs_iattr_rwsem)
+		kernfs_refresh_inode(kn, inode);
 
 	/* initialize inode according to type */
 	switch (kernfs_type(kn)) {
-- 
2.56.0

