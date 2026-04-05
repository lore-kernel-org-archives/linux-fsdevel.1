Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080103101B2
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775355103; cv=none; b=IXrBuTCpaeInVsWPhpw9rClS2slSBpvCb6zY7QsSDxI+4R4XeHk2FnITKQM6EHkXDdLGDr9rbu8CCAEhx3CnkI5Q+/rmAlAHYLTY3ocx9MLtmTekURJAF+9zGW1VxzMxWtkoRbeKUFZpvCJEWP4QTjO+r5RUEBxiZQkThefwQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775355103; c=relaxed/simple;
	bh=ibthNlC76wrpl54fnY7tuKKKujl1ing3jCYAtOo3c8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sctMzYQ25OsML6aY2VvZO13n2nOKn20vme50jDTAsiTpn8f8nkzroHujyqw2kk1pKAmG8QFQflRMvo8k3ubogHmIvFgvlXhzf1qOWDHIPoqqmkSC/rcfpEUShi29Q3eKW5AGVIykuMFcd68Pey5LUXGiFHNVmbu7PrwLm3qcHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EWvDiQcn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EWvDiQcn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BsQETwp2AwlUZ0rAA+NLSbAPRuixOrdcziYvQwbbx5s=; b=EWvDiQcnN3qwUSS1XqCZOxWvHq
	YoLyIy1J8ko5XQR7lXjz8kmogPjYzHRjojc4yvPQynaBVGFFdwOJw2QFO3FdvKQsrrcBkGl3Q6Zls
	SdbF204Pn9nUg5kO1ozstIxgZdRsuvKXvi56wnDEjinMvhplLvz1VkRCSaoRJ/Lwk8Ajf+FqCtcay
	pVead5XAFrdSm7RWDfv62uKZi+oPGpd+Sqx1EdNmSarmoFJiD2dhSLe3JCib5ANCCHAgiN3eCXZqL
	L0h3DbluXMQvooq8Ds1myZzrTU/QbYYfcVD2SqrTtBQJragCnumGyKDykxySbyoNVfrJEL9ZfCXlS
	16cAuljg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9D1A-0000000C1gZ-0yAX;
	Sun, 05 Apr 2026 02:15:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 3/3] coda_flag_children(): fix a UAF
Date: Sun,  5 Apr 2026 03:15:15 +0100
Message-ID: <20260405021515.2866402-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

if de goes negative right under us, there's nothing to prevent inode
getting freed just as we call coda_flag_inode().  We are not holding
->d_lock, so it's not impossible.  Not going to be reproducible on
bare hardware unless it's a realtime config, but it could happen on KVM.

Trivial to fix - just hold rcu_read_lock() over that loop.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index 970f0022ec52..245131296300 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -93,12 +93,14 @@ static void coda_flag_children(struct dentry *parent, int flag)
 	struct dentry *de;
 
 	spin_lock(&parent->d_lock);
+	rcu_read_lock();
 	hlist_for_each_entry(de, &parent->d_children, d_sib) {
 		struct inode *inode = d_inode_rcu(de);
 		/* don't know what to do with negative dentries */
 		if (inode)
 			coda_flag_inode(inode, flag);
 	}
+	rcu_read_unlock();
 	spin_unlock(&parent->d_lock);
 }
 
-- 
2.47.3

