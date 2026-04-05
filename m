Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F22BE053
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775415637; cv=none; b=pMFffMkNr5vQBVEZWKIJIhCEjO/qSvpq5fajld1nJ+7Kkd38T9zAuJ/5PJYzuiXFDY//CfS5QT1HG60R+sDMNY/VPnyqfJsa+CExeXTOrupICfuSNccFOTOTdLXtMDhS4XlPvoXvltZ74foK+X5xqG2dFN0ZgnCqAxinbrRSM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775415637; c=relaxed/simple;
	bh=RetsZ6Y3fnx9he4D5XAcwGsFpkFcaC9x1DUXcd/riGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AvToWc8jSGIfB2j44uP1hFvjzMbbPYpiKGPAMpqOADjs0G24kQU+FOGKqlt96st84OX5trnTZnAfJ7+pk8a94clyw8tubK0pj9gqKfz+uB3CYmbHsqMikTgiBiunl2F8UAZB2KG4sIt4kCeJx9IxAGN8e+k8jbQNDc6xzbVdnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uYYToms7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uYYToms7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jSGU40NRpIQurzw5hMa/BM+lZwfos+MQT4JlXZsPTuk=; b=uYYToms7xF2KwuJ19U6zvlh989
	lLkm0BgiP/uDkIgM/B1ZON+K6/1O0C361yp6wn/CYZHZ63CPozzcgJqHO8L30oLBe1hzSQpWrapzd
	VTn/W5SKMyhi4Ep4coikbqbhhIDnETEUqHzt6IGCyVB3qXvjvHKpDH9/x1bGjamkoW3kHafwleO+Y
	vImhRKlXxf2GNF9BRCEC1V7oT2BFBC7sQyT+MUAJIN0AfiK3NuJYbZ9AR37ToCHXLB6zjQlV8gzPo
	YQFG54c1eJ7vNSRM4MiI5QP3OODrQTxZ6xfQFWehJuC/x3NxXbuCz2XXb+k47VY47qRARFwpIO6zK
	siUiIZGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9SlO-0000000DW34-2m76;
	Sun, 05 Apr 2026 19:04:02 +0000
Date: Sun, 5 Apr 2026 20:04:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: NeilBrown <neilb@suse.com>
Subject: fs/dcache.c: bogus comment re LIST_POISON2 around __d_drop()
Message-ID: <20260405190402.GV3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[Caught while documenting ->d_hash uses]

The second line in
 * ___d_drop doesn't mark dentry as "unhashed"
 * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
is incorrect; what ___d_drop() does is
	__hlist_bl_del()
which never included poisoning - that's only done by hlist_bl_del()
and we hadn't been using that since 2011, six years prior to
___d_drop() introduction.

	I've missed that on review back then; the first line _is_
true, so functionality is all right; it's just that LIST_POISON2
reference there is confusing (and incorrect).

	For now I'm dropping the following into a local branch;
might or might not get combined with other changes in the area...

diff --git a/fs/dcache.c b/fs/dcache.c
index 0c8faeee02e2..c9995545d8d7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -604,7 +604,7 @@ EXPORT_SYMBOL(__d_drop);
  * __d_drop requires dentry->d_lock
  *
  * ___d_drop doesn't mark dentry as "unhashed"
- * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
+ * (dentry->d_hash.pprev will not be set to NULL).
  */
 void d_drop(struct dentry *dentry)
 {
