Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578440;
	b=fShxVfA8ndd4vkwFs+2YQmU7j82+U2rwijGZmbfbqjKWgbyMycPsOhtWgWknlCrvhsYe
	 VxGiLD3cb5CX+geA+IuWfz5myX0DsXoFpb23iyLGVL0lGKP5VqF0AL93hoGkyg/rUonpb
	 X8AecaNVn3dzZpp959wrWUaNb/BvW7lar1T9iQgqItsEbSTF4t7vabsZFCmg6U9DlLmc1
	 IO58CR7nHwmaTbx1H/0GYTnzl0aJI7UQcqUzhV5ocLYvYNetmZeRKmvRGWjIN3t5fmiiE
	 9mZByOWuUYnFeqM5paFH/ZOwB2+WEugUPLtFBNq8ogUyu0RidT+FesaeANAMM4oNNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=dCHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=;
	b=bi2MM1JnUkQD9FxmX09+ZT5NL8OZOPC4PhwPYZRbc/4O5gYok5fODXCI5PMg1mkScUfb
	 /pYwycQaUVseTFMoA9Y8b2ILPpdVGhahVHv1ofJwI9jEr4zBPdTCH0iTqsIbg7kBH17Fp
	 jtNfNxjpTUnv9k0wFOU99pZFqQIpWppvVg7k7kbci4VMROS72i7Qb5Z4S855kDBdJ9/pp
	 vohL4/UnAY33+8SXWzf7NXmNI6sJe9SL5np3kKjVFqVuY8MU3/5nzaEKdlrvl4Qezz24O
	 TZZo+ABV3F/THWoXNCYtSpkJXVTHJE5IXe5JHCdQHxum0jiO5EPGmjXSVYWlOheU48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=va1d3aw8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FW5JIddi;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F553606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F553606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=va1d3aw8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FW5JIddi
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 97585EC0A10
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:47:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 22:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578439;
	 x=1795664839; bh=dCHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=; b=
	va1d3aw84KksXRSBIx4FJ2okx4+klG2QAdorkc5ywg1CK+o7Qu71/nyD343nA0Jc
	dhr/Gc90CmS3WDRIJN/+eJ2HjH8lpBtDy3BslQii0YxQQvx24BuOQY8eF/EK6DGc
	jDE1+VL+Qy169Ckh4wlxJ5XHGxY7aT1G7QqgHS9uQGNYEpiVlmszXuS3LgTAKY8T
	WNqTn/xVoLZhoIR2yL3uiJZA0zptePeCkXFR/Ty+Hwu0aClyvqGsJVXBhtUjBGGU
	WZ0peyBkgLxzMqtS0Mrypt8cS6/53Toj4vzEwYNgWV8vkPkm6r2NCq04xQ5NpQA1
	N6Y4LJ+8u2tyKeEito65IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578439; x=1795664839; bh=d
	CHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=; b=FW5JIddiieTGO+cqe
	hcQkgxBGwppM9POYHLDt6pG/23xq02TJyjltZpK+6g/2X9uWjYRCsbp4f3iqIVku
	XV9SpPLQl2GWRApWr1/DWppdhsWVm9uNnYTqA9on3sZnvfQ/W+jXsr+InIWbefUS
	8o3tnuU01nkB024NTzpwJODIdMGT9lMLwokFmu/XQiPTWRVeIuPiu6ehsTCEiwGW
	mNBXyw7aWiriP/TDPPS2DLtLz7SqTEWd2DkbOS17DrL2rv0F5iFLDf2hHnKL+udl
	FYipxENZCJAAjWmfndXsTtnziTard3IO/fuQCw/g6hI2OYH0vAZQCF0c7a3tVCzw
	JYGOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578439; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Eyf81GeWqq0tHMJmj3XTRy7Aqqz5TBvtFA8ktKReGeeh6N8
	Weebj8wTeEYx6m5oMFpz9jCK3eFP4/KOS2aI90jIE2GqGx4jcMwq4T1BqX6kNIjX
	luo0PEay3yV1x7gRUmJY4vN9DE2t4GxJupLZGHG3x0m5+YvLtytdx69ZqhrqTsLR
	m5n5ljdfU00bv8bomcceKYK9frlhNzQPh6YwkxjY3QWKalClqMnGHA5q+B1C92jg
	tEWWuclTYOCgQ+4RzWDrneh8QvJiDTYoLTCuCsEnh+qlAMnCZ3DG3L1rC0PpgTKH
	7Cq5zFGTpn+c/d6xL7WRzkYUxPKreaWVrt1fjAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:w7IvvJbIcnCTYqHB4sNx8kYi67Yq0w+ucVxZGu+sY4Y=:gMYcM06M86YJ9UdGbkaR2cCHQB6Y0einrDMBHpb3ffE=;
X-ME-Sender: <xms:R1oGa2GWIhPFFgR0emympFg5thHmpkZ04X7oHV2p0PHgddxncdllHw>
    <xme:R1oGa-SKJA3XOQaXzRv4vqCxAgtgUW7YanUpSleGoHkRAJgEuLAQ8toJiwSWeGvvo
    -QzyT8S_bGR3cxKikVjUjrW9pwNgmp3PMP7JmLK5w_T70BV0AU>
X-ME-Received: <xmr:R1oGa1NNd-EoKNVfdkDi4ggicxB4RUQLj4nz0vzEr7yKghWoRMPaj8ciZKkaGVnWJn-l3nMDpP29AbK5pwrUpM8Um2v8n-Q>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7E+
    NhwDTVyxSr56UGePiE1r6hEUm4rr62pt0ea1crZBNCZZ3iI5npQNpdqKexwLE2ey5zPQVT
    kDhkVCmNPqxKgalPyvC2iQjnNVaXgdGBhj7v8CWR4NKmycHqHQEput8fYFsOTUivOijkd/
    C7WmEDTTEDydJUKJW7nxu2LiMovm6yLdR5YhhMqM/S4XNtznI8gHyXT2wyiXDgmPbfr/hb
    I2RDigEYftuQLDbApMxygEBRb/yjHao/gw/eOEnlNiIU9+mBBu2A7WIxyoMNXYtPZkjjt1
    QxiRJEhoblSgSdCJokLOY/H9/3MPCto/MK3arCn6QkBj6Fyz8ygF2suOcrVg
X-ME-Proxy: <xmx:R1oGa3O2fpbpCsTARlOuVg0NnavpbZEL2-aFG55og_QXkWbY8JEoYg>
    <xmx:R1oGa3H1QfK6v0Dbn27qqEhWQ1CmUScikM3Zr2XG4Q8cHIH-55BV1Q>
    <xmx:R1oGa5Pelic14_ayqIwY0DjQCUd_Ggg1CXUR28uIxq4C1P7Lnek_Mg>
    <xmx:R1oGaxsfBUQHWNeYcwSDv3DRdYfBrAsciAzU4jESmw7oXOgY-Cs_8w>
    <xmx:R1oGa7wqWlJ5rmNRv9gfnvyM_oJXD96fN3FJTTsN-1oGR9hSUDlVUkDS>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:14 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 11/11] afs: lookup_atsys to drop and reclaim lock.
Date: Wed, 25 Nov 2026 14:16:49 +1100
Message-ID: <20261125034543.4084039-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
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

If afs is asked to lookup a name ending with @sys, it needs to look up
a different name for which it might need to allocate a dentry with
d_alloc_parallel().
This is done while the parent lock is held which will be a problem in
a future patch where the ordering of the parent lock and
d_alloc_parallel() locking is reversed.

There is no actual need to hold the lock during this nested lookup, so
with this patch we drop the lock and reclaim it, and use
lookup_noperm_unlocked().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index bc90b30d8b57..7ed5ff63c90e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -938,6 +938,12 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/*
+	 * We need the directory to be unlocked so we can perform other lookups.
+	 * We don't really need the lock any more. The in-lookup status of
+	 * dentry gives us sufficient exclusion.
+	 */
+	inode_unlock_shared(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -947,7 +953,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		ret = lookup_noperm_unlocked(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -958,6 +964,12 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	/*
+	 * Cannot take parent lock while we hold an in-lookup dentry so
+	 * must make sure that lookup is done.
+	 */
+	d_lookup_done(dentry);
+	inode_lock_shared(dir);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
-- 
2.50.0.107.gf914562f5916.dirty

