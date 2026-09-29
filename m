Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEA42902E;
	Tue, 29 Sep 2026 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652596; cv=none; b=H67W1aaaj7FvslRu/4CgMomxUuVeVIe5ZOKbSh3htJ1zv5l6lY1CKMWechjQ0fwvys7OAKrBIPqZPhoasyJk+sBWg0pQ7p8jhOeN0w1CguL9N9sawlINjQNN0hw0kf0U8hUsXDTkQPeFQ4r7XewGmomktKBODnjanHjMpSndxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652596; c=relaxed/simple;
	bh=KazC0z9sRv8ot919XSBOnftP6BCkeNAqunLSO7P9N2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ4OR9t6NRMcwDv3TC1zWmd8wap42MR1uoesTze7/zLYX+6KMPkKKOAa18W0QKBihMRfdQynHSDmlUaj47nKoBR7WGSe0LqMwYGw+QtNZ6E/TKE9SEot/aS7DQP7kUY4ESixX5vKrMXIr+H6FxsEujlkSpigVh70+Q8apDHfedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ihSqBXVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qtmn4vBm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ihSqBXVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qtmn4vBm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47EDB7A00BE;
	Mon, 28 Sep 2026 23:29:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 28 Sep 2026 23:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790652594;
	 x=1790738994; bh=FaJitx4zhnVpxwiBKdtTxtI0jOi4xPtETCBT5uCt080=; b=
	ihSqBXVRPJ/jFaciWNkaUDb6TgkNV+NAXAzxY9yaunmVzYpIAovtsQVMSERMHQ3X
	bIJp9fUw35mqLVCKRi2IeL91Nn45fWFrcDtluW6jERyQL5cBJJhW7IXQcQ1qA/vT
	uF6jFQjxfnrCQ9icBb+os7vGpKQu51OE3w3PCnezeBV3bRDhMMzgqaBUsriWE4gU
	78gx9fEsNs4qGzAv78I34BB1DxrxvKmXrvgAePaHd55CUMo+kVzeGOXtY/0kvIat
	53dru4s/9p0tpnodyOxpbsGSJb3EDE4wZyfA736LfTxuQZ+J/5ffTZYSs0T6+IKT
	zfsi6CA7xzjId1y6o7JZtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790652594; x=1790738994; bh=F
	aJitx4zhnVpxwiBKdtTxtI0jOi4xPtETCBT5uCt080=; b=Qtmn4vBm0ljHk9lQW
	+i6a9BYfL0lfByFK31jLD/rfUqhADT+w7piWjSkb8GMAdekoFwOmeBEbF2bb1rPD
	DevxSQ4gxNRwUNCxpENC/LU0wK4KT00/pFT/kwsevHSPFODDzGWqzfP4cLIjqKo7
	pX+yYc6EW7nyxhcCaRTVE0Ldo1PHMtPNCvGNffATpjpaTcxy6hJtoEg9XIpdEcKG
	n8khVqqPB/sleGlsGpP5SZzooWM0XJJQJhVEF0htdG5OZPFD5bleJHxNlyvHy0nM
	lXkLm0hLCW9Ru1hLpu7WKDY3YNn0pBPV9Kmd6SBixCPax5jKu5H7b20pfIJRCI/h
	/tf9Q==
X-ME-Sender: <xms:sTC7asEd_Msz6sCXsAdYjAm518GwcOe4qe4X2QhNiMX-xohy3evCyA>
    <xme:sTC7aqTGjDZAmfHtiiwtt6SSAvMKixuwApf0-CTf3z6ECq24n1vYiKLNLslP1U1Lb
    k4gNjXNzja7JqSVSwH8XEa0Jk0hsBTZzrHC-RyYH9fdDVBeFcU>
X-ME-Received: <xmr:sTC7aqYbGI1Cvwc_cOFssw9_wX9V9Kky1wOnFcecErBZG9YABbDSe2yBoDSQ4uG_Bb8N-PfyB01zThrjmxtnyi70Ft0Tb_Y>
X-ME-Proxy-Cause: dmFkZTFj85xp6bLK+q7zY5LvEf0n2NtUow0VP2D+b+pxbXXAHePfaRLwkQCmGIoHNnnUU7
    XFZF/r1REEi95X1KcsQLYtxMFZmwq/KPz7uBc3KWLa6uoFYyPUDlje/SOhfoa6ewH1w8eT
    ziheSO585jMLS4z9M66AAVSHCLK2fdf1UcidnBLU1fyUN+VYr/DQbrVJ3YNYarCTeGR9nk
    Xdl/eTqCqBUCKAATrp+xGoHUD1XQLuMDbxWchpf3h6PqkS/2Z3ESZHYvfVv+yfzfZDDOcA
    poLwBeSX5N2ha2W2chvibHb/wQiSQ/Ol0pyNoXUB/4iunx0x6/alrS7Bjm1C1X3PKlP4WL
    flMweixntpT3PtwIBhFEWOrNsVzmixeqRsWjxQbIrGdg+lR8SJjxOpROnmE+b6woAGpTku
    0tLavVIgCMcgeKYadR1MB6UlQ+HBo/ykGLHFSnp6t8RSGyF8w33/Uv7pjvQuGTd/RyLpdX
    YaLvXH4dK88iGoDkUtK2ueTdYL20rTXy37+WBSoCwTptl3OiI8agBANtYAr0bJP3cQT/lu
    o2qmhCWUJ/e7cY9VhNb8X/dTjomvZ0s0YPDAVB63IZJXlHrJ/G2VgyGGsRRbKEwbSQJhAg
    xvic9BRcOGG4F5Qncto8e6IWYq/94vC1PWlZCXI0yoeXLxes3/Nq1x++iJpA
X-ME-Proxy: <xmx:sTC7at2fxD7g5kUjrdBLSH3gzYS9z1s2zpxvnf5WnKaw7CNtDgqKSg>
    <xmx:sTC7alqbGzAkDb9SAFnL2tLIrsGz7P25aAxRyW-0vlj553sm_isP5A>
    <xmx:sTC7akPoFwSi0CmpXwneecaicLSDaMcciDjGoLRry4UWuhjk6vb9ng>
    <xmx:sTC7ampPROQiu0jPn7fovCen90WTWEhC2ujDkBWDMGGsbvFwOGqEUQ>
    <xmx:sjC7alt1t8j6jLh_OcGyS5ADobnu6-jbemwJhOVreQf1w8vQGUVtsXty>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:29:51 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fuse: Use d_alloc_trylock() in fuse_direntplus_link()
Date: Tue, 29 Sep 2026 13:26:16 +1000
Message-ID: <20260929032927.1451259-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929032927.1451259-1-neilb@ownmail.net>
References: <20260929032927.1451259-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

fuse uses the results of readdir to prime the dcache.  Using
d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
in that case is pointless as the lookup will add info to the dcache and
there is no value in the readdir waiting to see if it should add the
info too.

Also this call to d_alloc_parallel() is made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So change to use d_alloc_trylock(), which doesn't require full_name_hash
and d_lookup to be called first.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/readdir.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 5ca87151d70d..709630e7b79c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
+#include <linux/namei.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -195,14 +196,15 @@ static int fuse_direntplus_link(struct file *file,
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
 
-	name.hash = full_name_hash(parent, name.name, name.len);
-	dentry = d_lookup(parent, &name);
-	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+	dentry = d_alloc_trylock(parent, &name);
+	if (IS_ERR(dentry)) {
+		if (PTR_ERR(dentry) == -EWOULDBLOCK)
+			/* harmless */
+			return 0;
+		return PTR_ERR(dentry);
 	}
+
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
-- 
2.50.0.107.gf914562f5916.dirty

