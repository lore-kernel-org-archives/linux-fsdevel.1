Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476340E8FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816887; cv=none; b=qOsSJtk961vowjw8fHaqTxF7TSy2jErQiAB82aleEntcolpqFemGQCs6Zmw9x5xn1zCXV2p7xeFC6wKP/3JkBSAJLkroXYclIMqqNbk/ba0hN+b43w4aKKMNvPVGJ6efztdvFB9Cb/BUniahFiOP559uY1PXDNXHDcX9nE31DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816887; c=relaxed/simple;
	bh=djhNgpRs4WTJsSSBUD0+2V+eOBpNj/bLKvjrYYL0qww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gftMv7dA7DkhY/0uYxKsBmheOleT9YkFrKForC3ecKhUC/dAYYaqIlPt9tEbmDHBONDzQQYIRC+zb6sbYzl6w+znoWqk7jF1EbK07hJkfP7Atf/ZUxiELIAM025dgWo6js6UW1jMDhhCS/hGDr5ZDISx74qAfJReBc+QKkvJKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZDHLtil2; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZDHLtil2"
X-KPN-MessageId: 1a5eb17e-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1a5eb17e-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4/limCEz2m830HyHpK9WsB8sPPzPH7fWsjeSdMGRQrE=;
	b=ZDHLtil2KRPpwI/jmJntcUdwAX9rQvAqkJcdu8TEhldVOlGQ+FdDPp5069n5CjB0xnEv+xtwMJvUc
	 n93nTVxbdVIXRbAcyBaidxijmN93mwWdELyEqO6xR5074pL0OyYRNwi1/vKRkKINFFbLztsEH5z3nM
	 rO0EPOAuadcU9N/2nF1LJqwM7BJuCZyFoixoQXMfN3qQrLUttc4qGowX/4Na5lGnp4XsECyw48AEHZ
	 RTAVvlzpz8RDRxthWihczyIa4DPj/oIgyB66rlWkV8Ln8P60ST1JECyJX+tH1RaVah4OIH8Tw08oGX
	 W0x6zZxUylhJJubP1NwZgi7DmbvziqA==
X-KPN-MID: 33|P8eSLkJIEjv/aHGnlNIcWx1/IaXoMJosD0WloU5E4JC54DuIP3B8fZB1I0Hk9qO
 JQXU8ReO4bbwH97Z/Lc1DPNBHATKWe24v/TYccJYRA+Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|27UdK/eBUV0TAcjqWbIJnpKgA9rEbB2r6iyKrqQ+BDTn0TXRyZnTTdogKsrW54a
 KUaCuN7/V4QWg1/8ilJELsw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1a1e9c3c-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 24/31] orangefs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:53 +0200
Message-ID: <20260630105400.68459-25-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in orangefs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/orangefs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 75e65e72c2d6..22b4107b8dc0 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -333,7 +333,7 @@ static struct dentry *orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	ref = new_op->downcall.resp.mkdir.refn;
 
-	inode = orangefs_new_inode(dir->i_sb, dir, S_IFDIR | mode, 0, &ref);
+	inode = orangefs_new_inode(dir->i_sb, dir, mode, 0, &ref);
 	if (IS_ERR(inode)) {
 		gossip_err("*** Failed to allocate orangefs dir inode\n");
 		ret = PTR_ERR(inode);
-- 
2.54.0

