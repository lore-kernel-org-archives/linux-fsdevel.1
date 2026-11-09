Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257550;
	b=ig/lbFGc09jHWPhiKib8z5NBOdS19MKhbCtbmwqTALckEOSj3IMb3B1inZeBz4QO43Tq
	 qzHab/MlcPIHjdztie003iiUAbFZK3xGZa7p/2bVhvxUI18oBXHyrrm219cokV+7s//cn
	 DnkyvNsG36fv0Kv8cFn0rS2tZxp4NiFHCCiGgIpOO0xT2t4Q3k1MKfQQLwCZkkzTZtt+9
	 rqnjZmXJN4VKf+eAYgTQ5AKXX8BxXONvp9U2pt+L51vIrHZBtzGZunbhaEZdk5Me0FWOS
	 pOm9XNhgZvyl3E1gl44BhP2aahqxm4WbZ75+mUdsL14WhnnDrBI6i/iwD2HMpVBVC0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257550;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=LE/8FPKGY7b6B+1hZylUvHjVMufKpCRz9FM3Kj8olxQ=;
	b=PFRX9AYeoR0wbXOtf5MNtpgxlNLZNI2vwzuHp3ed74yj8GH5rg73y4vJOW5W57gTyegh
	 ENy0oDBd+8AKNDvS14AQEy9CYNhwx//1DA5lr6FX196qYC10bqvzWz17NBvTw10SEWbnP
	 icmQ9jHiYe/slOHX07BU3VbDm3kdg+PjahYlzo1e1NipmrxvkDcgkdTEI3sNoNHIN5gwa
	 372giyLVzYaae5Kf0ype32+8e1BanFa1OZAp63NJhPoYcGk9PN2k9Dn95ZhCyddGfJiKv
	 b+m7wataD7THcAP+mjKXyESUol325UgC7YZxUU7X0uQiMIpGAMO5nAzpD1zkP27z8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=LAYVdPLQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I1LBirX2;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F290606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F290606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=LAYVdPLQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I1LBirX2
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 45E8AEC011A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:52:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 15:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794257549;
	 x=1794343949; bh=LE/8FPKGY7b6B+1hZylUvHjVMufKpCRz9FM3Kj8olxQ=; b=
	LAYVdPLQigUM75KuVxuBxI5rKGkcaW4k4ZIBhnVDSpFWWTFLhegiklGz+HK7Wl57
	p51gB4dDAuGO4npOuXafCd/6WTxqMeUZUXSXqgrIyHp3uOl39KXbJd4r6GrFuEIp
	amV0i2UbiksToxDnfHoVRn5bpdxWHoOIDCtbLlPGH4zeFWXaR4tSoDbgFXtetDLo
	yBlX4KA25Fwj8zUKGSD7EpmmkOonRUJxsHzau2IqebbrrqYrEwEotNZ/bul/0NwK
	6+BXge9hzLsO8FBg4NepMevWohBrMpX79AwPFazBuXwYZcbZIHWP7CDQYg2tE6l4
	c+P5culznHsYEWniUen3zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794257549; x=1794343949; bh=L
	E/8FPKGY7b6B+1hZylUvHjVMufKpCRz9FM3Kj8olxQ=; b=I1LBirX2jpS29If3u
	vLXlJIxNQhNatjBAa2nOAiaCxZrbURtGjaZEUjW8yUuFmTJsT5jBiKqLvz5SqZy0
	cd5JRGFILdeyUVz2Sg7+1zN1Tx3I06P2mBv5bSkA2ukaRcOMiR0wBgFeR5qPM34s
	9xMTTT4XL7jf/nAuuHxQgxs5GyIdOm9Eyi1Cml+G7w6by+8LIOH7PHItp+k37Y8c
	9LfMp0oLEyhJfkvwsbifaQSN99279cMvURn+xASUsO2gdag/OItifnp+n0H+zyBe
	csqaZkAkJyQB7yuvW8jczg7IvrXaMUlCxdaXM4CoxlcLX7v2al+EcyIL04l4JWRT
	Nmyyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257549; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:gj4XbK2qtkSXWM1wc4Nn+yr/VzrZ3VEOk9/3Esbw9sIhaLZ
	Y+sCDNs3Wzsg9CH77fG+zVl8a3rXI1yp4x6YM+4idQasEGG3ikgzEgzvbRo6G1fv
	MiwgK5p2tCxUEBNslPpQUUH+smL18bEyYvWVHLU8ZUrTiRnmp7iQB0vG17RKK64K
	ARDduOwbjIDw1t9skGOTRLOo4XAfitLim2t95KkfYjOzpkvTR2+hNVnVtWLtPVVi
	oTKK82dLRyxDFZOg0lMkcgAPgF4DQHfXbsm5uV/nrD3/GraBx4csW+NXhCiggvhF
	xsJDRt3Mah0TBduW51RIBgTcAj1pybS9WQ4tADA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:RqcUX8WWsmxtNvcjatp4mX/39+/rZM5omH3+zbspXe4=:330NM8hoV2DW1fEUdXKFwK1EkzIolxHoO6iOVXFMGx4=;
X-ME-Sender: <xms:jTLyains7grGptN91O6C5wLKQzTmJbjxvyuUVLkQjOKXSVBP5TDE8Q>
    <xme:jTLyaoHpK_b4LQ3exCuUYsc7zzIQcaq9cpvcP_DbyHjCujnNOI2sn1elqyQoNr5R5
    nb9dVFGVxPTAjEOpe_ueHxr4fuh_KZI7t9N3Hohgl7PRJFV-w>
X-ME-Received: <xmr:jTLyap-VtlwplS02I0NBB8hcV7zvo_iyRmJVUedU7dycwSkptexGtO3wP6ZjpJWMnA9YbhNJACVWAEWWuwFsLGzr02O1AFk>
X-ME-Proxy-Cause: dmFkZTEoCuCsn+7lfRQRDIW7ayWJjmjG3+FsIROcXIGbIb/Sj9aL2rR6d7yapGLsKjgkwH
    +t6vfhYvFC3KtKsa0mzCT0wqjH/bl4tEFvUa3GQlEsFs9zSV2NsKpFYqJCtl02Vgwt6Wv3
    REMHESkeqL26mVuzRpL/kZEslDjEJKQTYgqVrhXUCAzg3jn4YNf3P6PR95B+L7AoCBVRXr
    czpDj4G0hkrGAZDp/OcaFkA+PP5z/LsJv5MIxfxHprdFUr8AqbJyKq+mrAcuAlZXEbLDdV
    g5iZJ5Ocqubh2DtXlZRXBlTy+bVBiHQp2keZ/SqekOEH+prUOQ5gaS4KY2QRc/kukgmeB0
    KbFzYGH2QtUV049YNU32EocUn7ulAqEtCWYVy8qMXGV3cqB6onRQpNzfPRnBILan1KqJ0z
    GwSRExODJTu7V6znCnXn7/MHi6Lecdlf2tTVFigb3OGzdioObgKrh3PWOQp3RJ+5hByeOJ
    +IMm9+rbMIkkXX3LZkdzo9gsW9huiDNOR85z4qe6NXg7uNoMBaMq7DEbVSKFmVNagGEZwd
    Yp0wC9tg7aQNHtLFChSkMaUOp7VJWKxVRPhU45m0Nu4wtggbTTRTxt8RBAdr4b3leIQjJi
    BLpZMwQ+177ASTRjxDOfI3oh3ew9ZEs5KcIqWA4L8YrG0Q97rO8BcLS4qt+Q
X-ME-Proxy: <xmx:jTLyaplho0sjSLdgdKcKO_BHrRA6L2FJqgJesJ58qnN1t9WJdR1n9g>
    <xmx:jTLyakAfF3X2MZiT6IrezNUNvMFleCZbo687v6UDqLmMIT99RUHFCQ>
    <xmx:jTLyaiU5Ha2jNQGDXCdpn7zuZALZwCwXJTjM3sgHKkuG08Vs8uhY7A>
    <xmx:jTLyai_MNYPmMRwNnfTMGezeehc0sQ8yEOy7u4D6t9Gg_R2uF7d4uQ>
    <xmx:jTLyajC4c4_2eL0wjdwlwFzIiBnc23JDvNYuEVNm1xeRooeFmJE_dWcR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:52:26 -0500 (EST)
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
Subject: [PATCH v3 5/5] afs: use d_duplicate()
Date: Tue, 10 Nov 2026 07:48:27 +1100
Message-ID: <20261109205132.1561271-6-neilb@ownmail.net>
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

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to perform a
silly-rename.  This creates on in-lookup dentry which will contine to block
concurrent lookups after the original dentry is silly-renamed, and until
the final rename happens.

As the resulting dentry is in-lookup, we need to call d_lookup_done()
before d_put().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index dfe866efb43d..230a814c81e2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2079,7 +2079,10 @@ static void afs_rename_put(struct afs_operation *op)
 	store_release_wake_up(&op->dentry->d_flags,
 			      op->dentry->d_flags &~ DCACHE_BLOCKED);
 	spin_unlock(&op->dentry->d_lock);
-	dput(op->rename.tmp);
+	if (op->rename.tmp) {
+		d_lookup_done(op->rename.tmp);
+		dput(op->rename.tmp);
+	}
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2217,8 +2220,7 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty

