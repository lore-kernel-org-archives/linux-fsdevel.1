Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877672;
	b=4J+lxFkjHhX6ebWe++nYfw7dfxhGtSZOnauAeH4EtFtvWLz9BA2SaV8uFrQuDcxKQ545
	 NUMk6KDyZfoDtaP9JuiltrXlZibNgNakFzduBOvX10HgHhsMV5Di9Wr4F5WX9QBxkZ70J
	 5jnAm7wjJOyOM4D5JygKFzXmeWdR5zB1fO1vbW6YHVJ0i9RTC73sRbL7wT2wBZUygJad5
	 EeViDqGexNJpTnNyI1sAYo44mK0LbknJYYBWeiGREFoOAxmsNfVFxHbl8p1ubgP9LbkSf
	 2SKCeHq6l3o+uz4E5y4sI+XCp9v67BtRjkw4kFvZeKAhu+CTVAbQ2GK5QI2Nm7vqzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877672;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vkd7dvUg3NJ/I8orzv1RLV4ZUytIZSmWw+Y08WDiE1c=;
	b=i9eJwVeifdDNUU9jtCxNG+wsUWo5rv4+MPsVYZatROGFFkido9JwHIPkrSUbjEq7srjG
	 zCAZYv+j+l7XC1avpzMa5OCFnq/IlDIya8t715JZeoxAUhI8MW6p5zofjj6Lx4cW61dZh
	 UMVD9ekxQeiISdYnTf1VaEvd4GU5vJCzPWUe5dOOXOxo8bmSVXXeNotofHij86UqwzlOj
	 P3dU6swu6L75IUk6ax2XP2a1sV6WvxmGYzmDa2tx0pkbTghp4bnyMqPeQcTYfG6RZFias
	 v0/kb1D2BeoMKquMUXw6jhoSNeLpo951eO9rUFvex0KFYVWfPvrlhe67wW1RlYk9QnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=aqWePpJG;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5D606A337
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0F5D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=aqWePpJG
X-KPN-MessageId: b08799d4-cff2-11f1-9136-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b08799d4-cff2-11f1-9136-005056999439;
	Sat, 24 Oct 2026 23:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vkd7dvUg3NJ/I8orzv1RLV4ZUytIZSmWw+Y08WDiE1c=;
	b=aqWePpJGdeoSIjRgHoJmClXUMDmabnNVsM6U10ZBYfjiV3k1DUHBHBn7hRlrBlCHmZBOQZjMhEHjJ
	 fplh0ob7sObjwYjTHO6Nd6QOVzBGtbK0CgCtD+FiAPcp7rVE6vrf7kfTvJWMe2GtglBDplVzfAQmkD
	 3bhJ7mW2+yTENjqFmR8SXDCGZxIQv6STvaW5j1aqKuPYC4olc6pjfs6R2Dal8yqF03gWzwuKKmNPpX
	 vvCOmqstn75kv1XttJdnwktLfAT5fg4rS35oEnGrcrGqvxhkuc1Qb0FUkcjvLBuJehkI/ovEOVmX0A
	 M91yhkEmTGijctwFu3sz1biX/2PH7sw==
X-KPN-MID: 33|kPUw9p2wMSdGHyIQL+A3Ct2AJZkzIe5lxmNnbBTwbk/hJ51IxLN07tS24DfnVwB
 4XoW4nxYpN8jmIMcp03GUYQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|A394orw+B5hjakbEV/DBIZDHJLie4W48fGawcma0HyM3I7PYDeRMFvzhL4F2mA+
 vUszAqcnxk3nGvtO85QivQg==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b0487a0e-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:27 +0200 (CEST)
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
Subject: [PATCH v8 04/12] vfs: move ->create check in lookup_open() to before try_break_deleg()
Date: Sat, 24 Oct 2026 23:35:31 +0200
Message-ID: <20261024213539.1307600-5-jkoolstra@xs4all.nl>
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

The i_op->create check in lookup_open() takes place after the
try_break_deleg() call. This does not match the order when doing a
regular file create via mknod(2). There the call order is:

	filename_mknodat()
	vfs_create()
	i_op->create check
	try_break_deleg()

Move the i_op->create check to before try_break_deleg() in
lookup_open().

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 94958b77b371..45c2de449927 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4578,15 +4578,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
-	if (error)
-		goto out_dput;
-
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
+	if (error)
+		goto out_dput;
+
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
-- 
2.56.0

