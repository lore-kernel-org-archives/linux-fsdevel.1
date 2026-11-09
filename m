Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257545;
	b=M2CQfhJnjJjL0XTQqGl9CSM07ot+wEvXwcR7dPJ3XNp3Dazcrirhu/yFrMuFzGQ4HRGX
	 36ysApnKjJ+4JdzYjMWgdHlYwFbBKIl169JFNLUcmAbZygpMhLtupCdAGKqYwk5xjwHDr
	 4nQpfGfPYroGkZiZLHx5vZ8sGDRbwl06ZzBqt8puDND+fUdrSj/sE9f0VO0ZIh/mWeN5v
	 48ZfmeB5S+RCXgLLzqUgUDqiV25o5bYgpnfVX/szAs1iiwjyQNozWrRdLvvsneH92lnjS
	 AOYf8auuNqhyRR6S+yMe2olWfrL9nirn+WGd2DUE8sfr680BAaMn1XFVL/z3yRJPndg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=CCVYE/nNp/2yHSHloBK89MVvkdms9LmsUqgE6uVtEbM=;
	b=BEg0EO8mEt6/X6s5QAfDi5vcLFO/SrNerPx3PqZJRNksqOhwVTpSGMnEySRahvo0wpGQ
	 EH6lVggOMvz5ZOGrxWQW3nsiDcdmpZOcymT36a4qgD3urJibeorI0/rX0WTs3Z6zdEv1R
	 AzJcR0qDbIQGftouU3A6oR1r8Lj2mviXv7odYJQwE17Pr7QA+jme+J9hjbyyk62BsS24u
	 povmZhnS+qtZUFxByGD/i3QzsZt8AFZJScwr3Xu3ZJQwjzSvBp7Wuvrbt12AnQAsF0LDp
	 nU7h3eO0F3NTHsRENkCt5BX+EWKsRUtNte54nriXBO7FIPJgEeAZj9/y6JjuYPANghw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=fDM7Rb88;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ut7gjPB;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6E606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F6E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=fDM7Rb88;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ut7gjPB
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA6231400159
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:52:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 15:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794257543;
	 x=1794343943; bh=CCVYE/nNp/2yHSHloBK89MVvkdms9LmsUqgE6uVtEbM=; b=
	fDM7Rb88jsi1gVTm6KbVtWVu072Yaqq6nlw4OAhfIhKJWsZB4NERLn+OqqUttmBu
	PmcCMaLwC8kueoLQHv9dDc1ZVSY523b9jvsYAAspVv/NFiU2E8orfIfgQ3CDJDC8
	Fjmc5C3cRPRlkz2/CDMEAIFXaOluNkgoUrfSNxwx0cneJntwUWmwRHDnX8VbdEWR
	OvyndKFN6QwUjl9o6m0WBTc7FdZMVc8BDVePg70DtHXjuZQXaVCnfw/YFnKADLmw
	6Gs+Ctlz1tJRlxISjkQ+sRxluALtMLSpaTuV/ttsSmLT02z3nAhJNg03MUX9YWdM
	bYISODc7VydCw7NwHPHg6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794257543; x=1794343943; bh=C
	CVYE/nNp/2yHSHloBK89MVvkdms9LmsUqgE6uVtEbM=; b=1ut7gjPBXrJ/rHVqv
	veeKds79rMBKuBFwz04am4jT+x3fB7y/fzv5eRzwqybLzO01wxPHAFh5y06iWeB7
	X12xceGPCWsIC8Aj2jhvrZ0HNBir3KxmfTagwO2ozFY/Yn0cnCcEfVHI7y9rxVS0
	w6Cs6gvyVYnpteg2HeRdwDN1M1N1jiHygbisA8H3WthjaC9Yc3XRAFwISV1sTyAK
	gIwYUotK3tFvkstZJG6CNwe9QGFbQjQ3+plFngOWz6uT+n6tEyKIX51qm1tZEFYz
	AwubOkkuhyy3CCgfM0YVaez8soyCbzTtgBPGQLjGJ7rD8tw81Dh14Hn71IU9MLi7
	oH5TA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257543; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:ug1IspQvnN4md3lZ0wjIyAtt1L+DpZVbe8iAx6rKCOzcp14
	XJgKb3HT9RaB27+U6KRX/lTai7zpcfozynXY6G8eG33x6CumE8qMpg/HbWzk8Mnc
	YW6DddCdHnLzUN9NsQaRqQQVpZd11v8A09u5VPcSrw34a8DdLM9oP2Eai4keX6m/
	YK2RELUP48qByl9G/jKmUXw/1XR5dgC/C31XV6UGJ0yB0EpD8hPqO3Bk4zn+Btw/
	DOrenUbZNZ7nc0sZQiU1UHmWrds38iotOwOSplRojiXsPS0yxTylIBxsCjzNF7rb
	Ojmyfu48UDQPkBR730qSssHA/JI3zSGdROa05+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:yRVu89KNlUmuSCXaEh4GRVnWw2MmZd+qtyW7d1zok90=:bJDwMuqSw0w1GF1wjV2pZMKnESFHUXfTd3fXA2xxLlQ=;
X-ME-Sender: <xms:hzLyaluKmGNa8_oiMmcbjXlO-cjDHiy7R4Nfzx_inXsAYReEV2UXkQ>
    <xme:hzLyasswnUxlQKSg5c_ltEe3XlhJYXOadZmXG5UJqP5NWdT6LvLqHjyB9UjJRUjGM
    NKp-8weP0g0n4oowPcZRbabQbK_iKGuknuB-i7v4yNrjp2hGxY>
X-ME-Received: <xmr:hzLyaiFsNtVmSae0jR23iq9CILgDOBuQtmTOx4Dla0bPEF93sFgfSZAcaZEFG2ZWvk_xZwbxIp_b4Pocwy52ZmQ_E6mphQY>
X-ME-Proxy-Cause: dmFkZTEoCuCsn+7lfRQRDIW7ayWJjmjG3+FsIROcXIGbIb/Sj9aL2rR6d7yapGLsKjgkwH
    +t6vfhYvFC3KtKsa0mzCT0wqjH/bl4tEFvUa3GQlEsFs9zSV2NsKpFYqJCtl02Vgwt6Wv3
    REMHESkeqL26mVuzRpL/kZEslDjEJKQTYgqVrhXUCAzg3jn4YNf3P6PR95B+L7AoCBVRXr
    czpDj4G0hkrGAZDp/OcaFkA+PP5z/LsJv5MIxfxHprdFUr8AqbJyKq+mrAcuAlZXEbLDdV
    g5iZJ5Ocqubh2DtXlZRXBlTy+bVBiHQp2keZ/SqekOEH+prUOQ5gaS4KY2QRc/kukgmeOd
    gaISvbjdxu/7pF/PQUEUvzQnsEvzVN4IRNzs0Qxol0NzCZ2Huz+46VFBXH5uZSojvXpKPe
    PEP37B8fhwQtkv066HqQ7Y5f2Ffi4RX2p8H2uTty6G+eGCuyFc7+rvP0yXPLMxXHeJXdYw
    IdmCCe7V8aAAcScXAbu5X67wENJUEE1kcZPjbib83ykVP9RKe2JhYtD4UbVxE0KevlrD38
    H0jXCevw9T/4U3USRdsdXnI6T31pJRjYbDF2RmYsypqIiHBR8GLpe3yBqiKjIHxy8ZSOYm
    9u9MX+uRf6RUEJvmLenCMfNtpdBDnY6aiMJxlxUyn4ufT8YtZYM1X4wkMpMg
X-ME-Proxy: <xmx:hzLyavOCovCAXrEEGK1TyZe08G-GfCyTiD0CCmyaP0YQczOxJaCTpA>
    <xmx:hzLyapIup7hC9HfougSDoj-HO2HzAsYzsZ1Vf-_rQb0f8-zAHL3YwQ>
    <xmx:hzLyag9rzxoRrTI5KZFrDpxw4Uu3Lm0a0I0Pde1fQRS7QkeKmv9c1A>
    <xmx:hzLyatFIpUD38A47tVU50dvlWFVJSPVhjvmbuTYHhQMIslwR-OROpA>
    <xmx:hzLyajKu8rPqK28TzSd1AuFCEjh-KM5n3KStB7c4sd0qflTOtDogVzAb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:52:20 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org,
	"Jonathan Flynn" <jonathan.flynn@hammerspace.com>
Subject: [PATCH v3 4/5] afs: lookup_atsys to drop and reclaim lock.
Date: Tue, 10 Nov 2026 07:48:26 +1100
Message-ID: <20261109205132.1561271-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261109205132.1561271-1-neilb@ownmail.net>
References: <20261109205132.1561271-1-neilb@ownmail.net>
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
 fs/afs/dir.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 580fe51fd08f..dfe866efb43d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -913,7 +913,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       unsigned int flags)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
@@ -938,6 +939,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/*
+	 * We need the directory to be unlocked so we can perform other lookups.
+	 * We don't really need the lock any more. The in-lookup status of
+	 * dentry gives us sufficient exclusion.
+	 */
+	if (flags & LOOKUP_SHARED)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -947,7 +957,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		ret = lookup_noperm_unlocked(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -958,6 +968,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	/*
+	 * Cannot take parent lock while we hold an in-lookup dentry so
+	 * must make sure that lookup is done.
+	 */
+	d_lookup_done(dentry);
+	if (flags & LOOKUP_SHARED)
+		inode_lock_shared(dir);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
@@ -1003,7 +1022,7 @@ struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry);
+		return afs_lookup_atsys(dir, dentry, flags);
 
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
-- 
2.50.0.107.gf914562f5916.dirty

