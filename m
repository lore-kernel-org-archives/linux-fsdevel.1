Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424736C9C2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295720; cv=none; b=gmX4mh9uBgnqFYX7V47AXCt/d3C68M3RrYO9vvlQccxpuBH6S56XOSk14lp2NqkhVldwPAr9xuJ9+isZx7MNgqB4N0+sxLNqTLK2voVUDwhfcGDwx0T8GA21T13ou4BQL7ONHilePObVrM8p9POncFc6rPx15nzn8VFh5OCKLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295720; c=relaxed/simple;
	bh=D88r0MR8Wcii2C2ZFogoCk3+mHTmyXNTIIC1YA+CIrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btOyJ7dKUzeJGshZz12sN37vJFtAYZ52ARgfVfW3LZB+auPrReSo27BTlRIu0ZTX1jHqKJOw0hvCa2MD1TvnjkGO/vllwk7mRx4Vpl8Pkthng1SlmJbX3pY/4Do1xixzBVKhnpitN0TU8k2hxdXLF5CDjTfBgd+fdiZWMxQiKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IMIAVro+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqEhTynu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IMIAVro+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqEhTynu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47A4E140009B;
	Sun,  5 Jul 2026 19:55:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 19:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783295718;
	 x=1783382118; bh=kpzG7ZFFXNexgJ9DhNkn+uKepPQt+j0TERMystPmEuA=; b=
	IMIAVro+BhLpHHcE/29sCfcIx/AU6ZmZyKE445XPDxN/GC/FH2rkbjfXAftM4n3i
	C0WzzHWwYHW2o1wPGTz194Yz6oG7xZ6WZatPYguLxJu5QlH00c+p58awanW/NbNY
	FeRX2FKPny6rctsRE5oZSWtw67ywtTR+/P1RuZaD7Aphm+plBdPj1GiiQVa5tSdS
	dz5INCj9YYx3RA4GGYrUI2eSHY55pKY3DY0SYY9I40oT9y5g02NUDpy7ZHlGrWzz
	1yguakq08NV+bQ7kvPuach15mtFQDCQ18jq1z6m+MWK58Dfdkmo1s0ZU4Kpv7W1d
	QJfuU1PhSLqV4tjbkp1uDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783295718; x=1783382118; bh=k
	pzG7ZFFXNexgJ9DhNkn+uKepPQt+j0TERMystPmEuA=; b=LqEhTynuk8ww4lb+1
	ly4cLMPaTkqO9FHnb4jWswGdwFwNCONCbiBac6mwFQjSZxb2TE8oNCdGM7ExPJ/+
	zI4HBDKt9/lsMeT09HjudoESUODUh2kE8Y1RCuBGAP6XjDASneSRrAo9H2hH4oQU
	QHeZoV4JsdyttRFtPj96YVzKxoFCpY1NMJvZPGcpsBH/u1fYCvPQ1jbABnRDkFBA
	0FXf9WfLU2z7mR1U1rN6W8mwV5iI8PzcXA8RSOAQ/ZMcmSkCsj7nxbQcBHASBLo7
	j4M9SQ0ci4dT5Ti/rBNO80g+PILkwhI2ESLffW2JNZOJT+LyPha1rjXQR73aqBKs
	dEvQw==
X-ME-Sender: <xms:5u5KamTPVqP9Rm9ArD4tK66Qda4olWNLwV9FtGDRhO2FZAnmq31ghQ>
    <xme:5u5Kaptts8gqgeJgw_iXF2PuU_Jmra-4crVd7gy_gEbwBf5nzqd7oJ-lRh3ZBJcgO
    2L7DoMjGNaDJJRLJED8hOSWWkCgb0kh5RCbMQsP4mIZ-wTgaVw>
X-ME-Received: <xmr:5u5KamIuNBX80X2_E0GgoDUdYrh5tzghOD02oQvBeHN4Rky2nNxfziAhxSkc2j_nzoPFhh4qE6qi51pPQoAnZYIIbafzs94>
X-ME-Proxy-Cause: dmFkZTGEz0C1opa+98GkNZEjox8piiGk5mAWDC1jIHr84UbTtmOxDhoDFQqtq6YrqgcqRf
    WHLMK/yh2QzQfa3hYEiQ/PpG4oUnOQ5tSuhtvnaZbHTiP+U3kNdqk92ppsdI3xZp5P9FjC
    seMdmOE24nlxYjRPmad713S5jWCXCMLgjewRh5/3HCuorosHDS6ZUCSy09bZQlq/zYTtlP
    H+j6f3YTCv4rnq3MeenQyR/wi3mH1Kc0f1Q+iJ+fXXSFDL/4YhOdBgtMATQGoPcBGfoPWt
    HY5qAjzpOmgmsnpbIlKH1zxerTDshhOYyymczM0+xLFu1thRVU5JOqqhy7Oan5BhDJkiLA
    AjE48IFYYfEPAOY1WlTxFgiIbRXWF40kUQNnE47erRWhjWVqK3NLZDJEIu/fILvjhc2AXH
    +HLT4q6bdr6blrbc6wdgJqn/DjahlgVkY0bcWigdFtJIH9UdwOI3L6lCARxOLvQktz2Q1i
    eBoLXllBv1AZPxKebW81g/SOnAo+BBde5br4UP0/RTZ6i+AEvWeuggMtDsqQ7knTBH4nN+
    K0hghcVyd89i70MAmY79HyJmVSzUV6QvXGM2TOoMvk7oTbT0DgpkER841Gtkb3Cd2CyIYF
    eOyPDr7/wJ3y7DFGRyRdRXvENT93F4b11JE+RhmI8MZHhMD9xgIi21Eqb7lQ
X-ME-Proxy: <xmx:5u5Kamkm_-8M0HrPOiRzHRw0nGZD4azELvCPCAAS30yR_rpBHMDbUQ>
    <xmx:5u5KanIg38YkRlorqG7cyNegqIpNZELVe6RvcrVh6zXs1D8-DCgN7Q>
    <xmx:5u5Kar4LtU_QtQQSeoZLc_MZro6UGOukCGpk7rEAgLDntQZKUOOIPQ>
    <xmx:5u5Kar3S-r5kCwQUFUJZFgj48AFH5DmCMjyQwhw8TdbE9K_8Ksg_QQ>
    <xmx:5u5Kaon3OkKRyqn2ayjGQUPQYfSgcGLIEmInGWQYgzzzUPf_rT-R5H87>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 19:55:16 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
Date: Mon,  6 Jul 2026 09:46:02 +1000
Message-ID: <20260705235447.1322365-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705235447.1322365-1-neilb@ownmail.net>
References: <20260705235447.1322365-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

vfs_lookup_open() is a limited version of lookup_open() which is
exported for nfsd to use - to replace dentry_create().

It is limited in that no filename is given (thus no auditing) and no
LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
the open flags.

If a non-regular file is found, an O_PATH file is returned.  This allows
the caller to see what was found and to return an appropriate error
code.  However if ->atomic_open was used, it may return an error rather
then provide a dentry.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 70 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 ++
 2 files changed, 73 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cb33a01d16eb..60dddf7b97aa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4562,6 +4562,76 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	goto out;
 }
 
+/**
+ * vfs_lookup_open - open and possibly create a regular file
+ * @parent: directory to contain file
+ * @last: final component of file name
+ * @open_flag: O_flags
+ * @mode: initial permissions for file
+ *
+ * Open a file after lookup and/or create.  This provides similar
+ * functionality open_last_lookups() for in-kernel users, particularly
+ * nfsd.
+ * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
+ *
+ * Returns: the opened struct file, or an error.
+ *     Caller should check that the file opened is regular,
+ *     if something else was found, an O_PATH file is provided.
+ *     Caller should validate FMODE_CREATED if O_EXCL was requested.
+ */
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode)
+{
+	struct file *file __free(fput) = NULL;
+	struct nameidata nd = {};
+	struct open_flags op = {};
+	struct dentry *dentry;
+	int error = 0;
+
+	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");
+	error = lookup_noperm_common(last, parent->dentry);
+	if (error)
+		return ERR_PTR(error);
+
+	file = alloc_empty_file(open_flag, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	nd.path = *parent;
+	nd.last = *last;
+	nd.flags = LOOKUP_OPEN;
+	if (open_flag & O_CREAT) {
+		nd.flags |= LOOKUP_CREATE;
+		if (open_flag & O_EXCL)
+			nd.flags |= LOOKUP_EXCL;
+	}
+	op.open_flag = open_flag;
+	op.mode = S_IFREG | mode;
+	dentry = lookup_open(&nd, file, &op);
+
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	if (d_really_is_negative(dentry)) {
+		error = -ENOENT;
+	} else if (!(file->f_mode & FMODE_OPENED)) {
+		nd.path.dentry = dentry;
+		if (!d_is_reg(dentry))
+			/*
+			 * allow caller to see dentry and choose
+			 * correct error code
+			 */
+			file->f_flags |= O_PATH;
+		error = vfs_open(&nd.path, file);
+	}
+	dput(dentry);
+
+	if (error)
+		return ERR_PTR(error);
+	return no_free_ptr(file);
+}
+EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
+
 static inline bool trailing_slashes(struct nameidata *nd)
 {
 	return (bool)nd->last.name[nd->last.len];
diff --git a/include/linux/namei.h b/include/linux/namei.h
index ebe6e29f7e93..86d657b24fc6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode);
+
 /* end_creating - finish action started with start_creating
  * @child: dentry returned by start_creating() or vfs_mkdir()
  *
-- 
2.50.0.107.gf914562f5916.dirty

