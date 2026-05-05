Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51483CEBB1
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960449; cv=none; b=uRzwN3kbLlev4vqBHxZdD+CiohDLwnySOPN4sbR/JtNltj1b9ZF081RItk45vLOnebCOiik8q0+q5jRZUhJkU+/4HaclHc9oqDT+P/zKxaJro16ZvQU5qEiaFL0l4eXqHgvjgljuAIne0BRVhR2h9Xhb9goDHqbxLft79Nh7Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960449; c=relaxed/simple;
	bh=jtpDP1ou5MngxwvMnJl5eB8rHtfHXrR0a42mW0UkaIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYnt379nwfZ16gZAFDtcoqMD7epUKWGsTnOaiGxEBSrMQqu3UaIxoqFHLrksMxGzVsxd9c0FFCX9PMq3hcBd6pi7D04NiarXalivmCuJFAEqEnxM/+7MkTSPFS0wVODZWkwhSi3OOGDLL+DoH+ULoFgqoDL6TqojfnDl2c9pixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eGj66j/T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eGj66j/T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mBqL1MElLJnBLOe8I8dWPJzOyWDAQaKjYlA7IhD4Z00=; b=eGj66j/T6b3bF7KxL1IOTZIVgC
	38f+8nbNUpwjQmRx2VsLCPemRKyR99J8coWEXAyXv1B6YrydfzjzzRfwC2bu0xnWEucoFYXFiKxdZ
	sUayk8Hve7EviJNe7mcmt5Yz4GYTDiPXDbBH+gl+BT2JbU3P8DQ9l8HryI8Q3t4Fbn6ECBRg6mNpF
	nrIKuemjBXg28Sl05Z462E30plMwbribYx+/R+p6IVRMzSvWAiRubwJsoUxxq5uU3ANv3pRyuNZu6
	R3gBSIqfSyRu7yYevD6WhqI9qzoTPVW5u8dqCFdtDncXtAsj4EEgGnzNMbrLi6cUlWGGeOIEUXfaE
	hkE26L+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jg-00000005I9W-1kui;
	Tue, 05 May 2026 05:54:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Date: Tue,  5 May 2026 06:54:07 +0100
Message-ID: <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we only need it to bridge over from ->d_lock scope of child to ->d_lock
scope of parent; dropping ->d_lock at rename_retry doesn't need to be
in rcu_read_lock() scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f283818095c0..2a342d618303 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1477,14 +1477,15 @@ static void d_walk(struct dentry *parent, void *data,
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */
-	rcu_read_lock();
 ascend:
 	if (this_parent != parent) {
 		dentry = this_parent;
 		this_parent = dentry->d_parent;
 
+		rcu_read_lock();
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&this_parent->d_lock);
+		rcu_read_unlock();
 
 		/* might go back up the wrong parent if we have had a rename. */
 		if (need_seqretry(&rename_lock, seq))
@@ -1492,7 +1493,6 @@ static void d_walk(struct dentry *parent, void *data,
 		/* go into the first sibling still alive */
 		hlist_for_each_entry_continue(dentry, d_sib) {
 			if (likely(!(dentry->d_flags & DCACHE_DENTRY_KILLED))) {
-				rcu_read_unlock();
 				goto resume;
 			}
 		}
@@ -1500,7 +1500,6 @@ static void d_walk(struct dentry *parent, void *data,
 	}
 	if (need_seqretry(&rename_lock, seq))
 		goto rename_retry;
-	rcu_read_unlock();
 
 out_unlock:
 	spin_unlock(&this_parent->d_lock);
@@ -1509,7 +1508,6 @@ static void d_walk(struct dentry *parent, void *data,
 
 rename_retry:
 	spin_unlock(&this_parent->d_lock);
-	rcu_read_unlock();
 	BUG_ON(seq & 1);
 	if (!retry)
 		return;
-- 
2.47.3

