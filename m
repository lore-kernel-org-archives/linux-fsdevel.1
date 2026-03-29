Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26038759A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848545; cv=none; b=cXt6cnZ4bvA25H7JLs8RkQQziu1p+XIduSqgobPavGJHgM5FiCGE/HYVlQXK6Bs4EYC1rJjVFHSKQrMCMXChBSOCXW+lhfr96g/WgXf2JsMhfeFsau7OHFcZTNQL0nnDz4eBOeFTYgo2YZN2Run2RqTcUVEy90ksf2fyxcOVGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848545; c=relaxed/simple;
	bh=niTSGz295UJp+q4HxxkUsFYKIU+oaGVIm9m2hpCyEz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOa9LQU8oawgjv+2rX169DfsZVfPzfok3haO2MUmFaqlcQ5BcSLw8CfhJDaAhnadPvpdg/IBqAXi7SDJqxDOcnXMbmdJXeApiBo2JZcB5AHHW9kkaL3mhkr4vcAaEr4B12dJDOBxrpkRc6S0RwxpeGldMq1kfGRujT3yIPjs/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=es+1AC8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0NDH/qZl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="es+1AC8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0NDH/qZl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 014A97A02C9;
	Mon, 30 Mar 2026 01:29:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 01:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1774848542;
	 x=1774934942; bh=w3vfU/9ij9bxIxDju3QEfjirYEMJDpjfBG+yyG9WNM0=; b=
	es+1AC8+6EcGNktCrL7ImggSN3un3WwmN4JzTaGO1j3s8fZWVYpG8qRKaxXXStkZ
	BuIMW1MvIY6buzHdlPmH/P57kTJkz6rlPP/MSa0RTx98yaiITTZLoTJelpApPom3
	uXr7FR7ubyDZrjXQevhvW/jPIlppl3F8+f/OHbmuHQblN/nd5k3xzvlQ2WpPSxR6
	IXShcOWRKr0TiMjU7nZ79Cde54Kvy9dFfLFf52r7sYfItSBAmyVPSQMBeMA8FtMM
	a296jSkRDzyo9LRY4Jvhhxa2/vv5afNvmFWEIlqvxTIprgs8xZeg3JfjBLIBLqNO
	YpVS/RcMej4TiXyWTuSeYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774848542; x=1774934942; bh=w
	3vfU/9ij9bxIxDju3QEfjirYEMJDpjfBG+yyG9WNM0=; b=0NDH/qZl2IvalGCf+
	sDzCghC80lE6Dv7yANuk/GUx14D/zpwR9jNMMQ/QomCUhqBbdoZ4xnBQcZ9PSraE
	GEx7Cqkw6SmYU279sZvgU6/mW6G5w+h1Ye0sdwVj/CQwJN2dQmnBCWPbwvmDgpI/
	F0OXFz0LIaeSugSLiIP1T07Il5JI+jsPjV6KbZxl83zVvFgipNgG8l/qT9t+HSk0
	AmmBPj11/ES6Qh7BmoMxWCj07ormlA4q+yLlsHc+PuBr055vA4RyZFfkAasUdUR7
	O8n6BYpD095M1K9xEtfCZs64yK+p9KeYv2BaL0kvYve1pZ9LrHrUK98RhxWyQqW3
	DKg+w==
X-ME-Sender: <xms:HgrKaU2L2b4BzABG8LYj6bP0ApmPLg1AmE8cZtq3W1Q4Q7-6qky_Dg>
    <xme:HgrKaajLWTX_xtYOraj2JZ_FGjSHLbGYwAbXUcwydFBMPw07BtT8EqoIVNACxIRED
    B7UnJnVSY8UN-c1wkAgi1KqW_D33rroSynXO8FFzU7Orm5tTw>
X-ME-Received: <xmr:HgrKaQa6_1rT7edQGCNXNJgJE522CyS9qSIEf7uJU3ffnlwZu7_aemk2DSQKKHbjQ2Soug0l4jadi08sOQIypTznWzUqxxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HgrKaSR_uEwm27D4Fkl0jqi-GA2DsRNYQpJyPFsy81EmQTOMeRZ4qw>
    <xmx:HgrKaTQNC31eWLx4Qim53M9iDkkJOPde8MBKGaFVmuSrszxZ-0CTGQ>
    <xmx:HgrKaWSBIvVtABX-WuVC4Cck3D4umKB1MQChMul7CIGxDAiYnk3SBw>
    <xmx:HgrKaY6sNpUnzmiQF_I-vUr3Xea6SNRuBMvSF0e86W6cH8Y37kJcqA>
    <xmx:HgrKaXnjp-IBPlS9oRJCl4cE_cABivKy-LQhLTtVSQTwRmVuvWJ-f3J6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 01:29:01 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] VFS: allow d_alloc_name() to be used with ->d_hash
Date: Mon, 30 Mar 2026 09:46:38 +1100
Message-ID: <20260329225603.2177730-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260329225603.2177730-1-neilb@ownmail.net>
References: <20260329225603.2177730-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

efivarfs() is similar to other filesystems which use d_alloc_name(), but
it cannot use d_alloc_name() as it has a ->d_hash function.

The only problem with using ->d_hash if available is that it can return
an error, but d_alloc_name() cannot.  If we document that d_alloc_name()
cannot be used when ->d_hash returns an error, then any filesystem which
has a safe ->d_hash can safely use d_alloc_name().

So enhance d_alloc_name() to check for a ->d_hash function
and document that this is not permitted if the ->d_hash function can
fail( which efivarfs_d_hash() cannot).

Also document locking requirements for use.

This is a step towards eventually deprecating d_alloc().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2a100c616576..3bd4e15320af 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1878,12 +1878,31 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 	return dentry;
 }
 
+/**
+ * d_alloc_name: allocate a dentry for use in a dcache-based filesystem.
+ * @parent: dentry of the parent for the dentry
+ * @name: name of the dentry
+ *
+ * d_alloc_name() allocates a dentry without any protection against
+ * races.  It should only be used in directories that do not support
+ * create/rename/link inode operations and so is particularly suited for
+ * use with simple_dir_inode_operations.  The result is typically passed
+ * to d_make_persistent().
+ *
+ * This must NOT be used by filesystems which provide a d_hash() function
+ * that can return an error.
+ */
 struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 {
 	struct qstr q;
 
 	q.name = name;
 	q.hash_len = hashlen_string(parent, name);
+	if (parent->d_flags & DCACHE_OP_HASH) {
+		int err = parent->d_op->d_hash(parent, &q);
+		if (WARN_ON_ONCE(err))
+			return NULL;
+	}
 	return d_alloc(parent, &q);
 }
 EXPORT_SYMBOL(d_alloc_name);
-- 
2.50.0.107.gf914562f5916.dirty

