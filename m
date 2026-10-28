Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160653;
	b=BAe+CN7EPCi6UvCAlN7Gr1aCWRYeSLoumaE3Rw9bdDdtQp2bIV3BKGA8D9GVE/N+TVvX
	 v/lCzVePCMoqpbGm8ZHH93hWDjBiJFo7xthZ5ztKZ0zf7c6NtJm0KexbF1mQ5iJQcHuFM
	 HOoob41n4SfrdxIIfFM/z3IW2tMU85BqshVQT79xExzw9S/9/ZjvhoTnO+/i3pt9Rz1r4
	 Z0c3/jG8U+cHb55iB7MocK93K+35pagpWzWC2JGfOXhvT98fJ20CVOdN4bl9uQoOrcXTR
	 RTB4lQ/ZvyBa64M5GxxHXlHQhO8lueDtuN9hnV33lEV4HdPJ3W83Pv4ILOGLKkijGvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160653;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=hQZh8NhkxOMWWoDu9n1I0xZHgx2A7inY4Slk51nZ6WA=;
	b=2IFFSLiK5j3UZUvGGQ7jxnM1wGVma78ziS2+CGmWMI3w3rDWufB2JQ1TnMxZq+EFNaCP
	 2G4yoeIVc4JoU4ZbCir/hA1FL0AZKeRej4KwWWYK3YvjfXpfZmT0y+k1+ENhLscbZPkkN
	 zFWD5d280jRsM8+T+Ci/tutLsOuX61XUPllxqCVdyDx4np5pi6DS6o20+yywzDc3Iaclr
	 xdR2W4BAhacnt1m1Lj90sbDvMPpvHTor4flqY/g3WL56YF4w+m+cqKER/m8MTiPD7277X
	 Rtxi24GS5B/SyQiAg+f7lYu0w1YdC2B4hbKhhWgm5ofs57h9gsYV5tyM9pL6T9G4BBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=HAiSv9n+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EVztEjjM;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D0606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 04:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497D0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=HAiSv9n+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EVztEjjM
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id CD8601D001C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 00:10:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 28 Oct 2026 00:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1793160652;
	 x=1793247052; bh=hQZh8NhkxOMWWoDu9n1I0xZHgx2A7inY4Slk51nZ6WA=; b=
	HAiSv9n+EeYtYbCTI9V9R0VW+hR5Q7Dv2xl5OEKJpnB2iWm94xhsrqOrWcuiY7EX
	sTaktqtLJkU8foAIDzK2sGlDGTSn0VwplD3hz7XLjvgch+aBGWmnyEfwZoT29Hmy
	BuXYa1amq4waJz06tnCx0HkMA4ozPTY9qhaI5W2Pr9TzVX7eJEy8hXVPlm+yolKY
	Y9hcv2edEqJ7+Q/fgybv8h7vmPo5xB19yc8/lpojCo4smy1IKA2OpY4txC4WI9G1
	2btRomtTFAatoN9pAIWSLOtesa/UUXxkGO4QXpFyMzPNQUu6ZApskBp5c/jXnRmq
	xizL+D9h1NcHzzCwWzOn8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793160652; x=1793247052; bh=h
	QZh8NhkxOMWWoDu9n1I0xZHgx2A7inY4Slk51nZ6WA=; b=EVztEjjM/Yc4sl2+O
	srmjDl9TvWOyLICQI8Supg1bx+FBCcO1ZjZgYSTwV1xKTuNJ7VfXbpsh87PRYhyD
	i4+UpCJkPGRSOkLH9FFxg2It5CZzOLZqj67ucgLtDFE7JOzosl3SxeQhK4q6PaM0
	jnf4w2oFa045XChpbsWkAXqPog6KHxswnAVnRqmHidO08Oy53jzId7HnarlTrws5
	L6s/U9wfVQ3XRarPuprc3UIoqOMlzm9RO5X+b4oeb8R2yXfCEBF9HhDdVTVdPeGR
	et2Bh3i86cwO0JZ7H9MAZwlX9NTpABhB5hmdRZOB879lgp/HXwFl/B4rTkWBytRd
	NtRKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793160652; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:Y2jyA25aZA5AJC2Ter8hSYxO2Xm8oVZ9CZ+fjGHq82FcWXm
	kFRUtk9IHkmXAWM9xPpL0Ygj1U572d43CfHHtcvB24BYg4PHX8rAmKg8Bj49YsxK
	eqkxZ9gFct/ypQNW8Eq/68gvQUleX09B8C+j640fvoctglC7JLxaaj1kUt5KPrY1
	3wjEcJEqudWgtq0jaqBDbn458B0d7KE+OJfskClRTBdh7eKUOZNSIDEkb/FP7Ptj
	GP11IUbfj39FNnjIb8rP+3AtX0hB5N0MpGDu+CtWt25gT5MxaGm5b6PqVFsNmtnr
	SvVYMyfxO1Jjqn8QTK+wx4H6558eZ9Z5tZPwOqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:CLFz3lbEDFthX2ksPfadozk0m6+FyDl+t3bbInZB6Fw=:XeUvSGmrsuRVKscYb0EA0v5s84mC7gqlJKX0NEX6XvM=;
X-ME-Sender: <xms:zHXhatJ53Lw69PnrWG5rLyJZrrHSJ_9ifi7f1Hz0P-_K0ldlUDVU_A>
    <xme:zHXhanYQY0s2o1UOJZY3p0xDNSNqKL8QBLwcLqAwwkSYHY7DpKJEvv5uoee4qwV38
    GA_gHecNt4wqmFPhLeCpRAHw9FiQnWCEDgaML6cc2ZmJqBEVUQ>
X-ME-Received: <xmr:zHXhavBJDpKUZDNbNX6s-7LrY8MugPk571FqWVMjqTw8tYpEODL6Fr05KHbM0hviLg>
X-ME-Proxy-Cause: dmFkZTEtaaJo3zhk6q8YHjcrAGFhzjZGx7kav9mjn36dhiCDz1sQNUcnPXqPMC3VqBUdUM
    QC/BqNrn6VDtoNvGfXsPC6PtPC8Yf5vcT7dSqr4OQVWjbDjoqPju2ao8WKvEVWn6qwQJpD
    4CN6jGUHDBUbMwADgY1eHpCxVa8gj9W+FVkilH/Bf9wmvEra1caZDRUZmQcG/Ro3xW8rsx
    nbEpGLXA1HN5mBuF45EijzjRcn/0zOhqfoHROonBfk2oQm2kGy7PxZcAZk+GCvIPn4bVTg
    3udSvT9vlUjceFzrt+IHSgKFct3qykKWsSJoK8kyGUhtj7khaHZlaj5tXb3YwgPRJ+b+mY
    z73jxXjVEEj+d8hVQY/pU4b2x5pQncNcyFqpsb4/Wo4hEu5nDSAsgaLQyL/JcO5f4qLLQv
    q6ggWO5k8tsz8+vGFW+xTdbv7irePtTq1xbgnkhSdqkMjipWfSfHuCXqbjiaq8MnonBfiM
    b6Nitv9oC3UaqOlkwhLa0t3qz20qFFxVoJUKp7X7RWOQ1WxlQPY07K3zTFjt+mPR2Zvn+c
    +FertsR1sVeACiaj6125oXE08TsMahOqkQyegDcss/w0BIwelmVBRpQSchuyVZSiLGQ/wo
    leRRB3JFxnTSLLR4FX7ssTFL/FdGSlCtDNhqMROtBC4lwZHDYF6SqcDIUpDQ
X-ME-Proxy: <xmx:zHXhahbup0aGqldVZCeH2Mwe6Q8G2ci1N9JXiJN9WjhI7k24GOL1_w>
    <xmx:zHXhank-e1WEwZTPSDAtXIejniYlzs6p1q8GkzIsk3KvARG6GWEPmA>
    <xmx:zHXhamq6V2Iyt3tXVzrCInPQT9ceXMDpUtOW1AtGi_eIlVw225x93g>
    <xmx:zHXhapDU3j4cISb3H6WXkqgGdgtl-_15ag3PWSq0BtEzxVopUxIcbQ>
    <xmx:zHXhamqSa1-R_R5n2vYD_oaIUTdhjs4MAXarIsM02mkiFoE5--37FIEU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 00:10:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] nfs: fix nfs_call_unlink()
Date: Wed, 28 Oct 2026 15:06:30 +1100
Message-ID: <20261028041023.3738553-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261028041023.3738553-1-neilb@ownmail.net>
References: <20261028041023.3738553-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
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

From: NeilBrown <neil@brown.name>

nfs_call_unlink() calls d_alloc_parallel() on a dentry which has not had
the d_hash calculated.  d_alloc_parallel() assumes this is calculated and
doesn't calculate it itself.
So this will never find an existing dentry and so will not detect
the races it aims to detect.

(This dentry ("alias") is never hashed so there is no lasting
inconsistency in the dcache.)

Fix this by calling full_name_hash()

Acked-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Fixes: 565277f63c61 ("NFS: Fix a race in sillyrename")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/unlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index c8d712204e64..11a46a993e11 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -125,6 +125,9 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct dentry *alias;
 
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
+	data->args.name.hash = full_name_hash(dentry->d_parent,
+					      data->args.name.name,
+					      data->args.name.len);
 	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
-- 
2.50.0.107.gf914562f5916.dirty

