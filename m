Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52F1DA60D
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391690; cv=none; b=ak8hqKPYI7HKpdHW2R0b8v4hTzE+VWMwAkraNYEQMxGSdB1QXvdGWUkP/gcHVW92vlTaGlK+YmM84EjBzA06E8cXrqxW9AbhOQcZmBX4iRis2M62ZAmsc5EB7+ngOdyLM+ibfvwlt4agqEm202O8lHi81zvqEuwXyPPNNNo5aIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391690; c=relaxed/simple;
	bh=WR9lz8YOkg7neTra0Dv7h3KM4YHvzfKaeIixikFKPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPyzUgx6dQ/3VgcmP5d4Aj2byYDZy/9JaxffyWKVt5OnI2+VkXce+ZlMEmMAXx0zs78iIMXqt/0vQqD20LNka5igoF+aMcYCyfOS39JQSR/y1zUw3tN3b9kFe1ypgOlSjJIOCBW00vjX7KwIsq2r+OxcbXEAtZEG8s6a8/p/gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SvQ89cOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkqVBO2P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SvQ89cOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkqVBO2P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 607CD1D000E7;
	Fri, 25 Sep 2026 23:01:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 23:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790391688;
	 x=1790478088; bh=9Mlyi2A6aSMHAhjwjs/Q/Wl9lPPTlz5/DF8O2g17GMk=; b=
	SvQ89cOrwCKrOHrLhzye4ZkbvXUmAqUtZcaBeBp+43Z+ua+gE8BwgJE0ky7BzwaM
	l3B4iwByqHLvZgFa0/L6oXMDTOtn+RtKw8dsbiVKOb6CBBBka28umllAQBVqtZD4
	9a3FL8qfYM6p0752U0HDDrEI1+zAIjJlt/ERAawIkhs30j1s2oexg1pRKngJAsDi
	DV46gv3BHI4aKufpcgnLvsV32byKIpR7cBVy0NGiNU9AI+ITYEJw0HGZKEnCPR8Y
	fjWT2S+U0+wVQxAJ1YBPrlSUmKBlcARI+GjXiHlO+rzGAGyRq0lMMwggZnHO2agS
	5qInPcoOpCgu/69KuL4X2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790391688; x=1790478088; bh=9
	Mlyi2A6aSMHAhjwjs/Q/Wl9lPPTlz5/DF8O2g17GMk=; b=pkqVBO2P6iMJdoalg
	5328Gdu3KmAGY9hAfMHthfLwaSHmhbGKqp29Qk9at/YvU9loK4565eeT4IClF/QA
	ccYoyFOJ8HpHJ4CIZDJLPg3zw0cKmOnxKtibTGe9BkUnlWFlKunytT+RuU3qxjnD
	f+uRt6W6Acr26NPdLGsPhGqJYhwpthvoQR3riLXk4H4Annypimu39Fdsa6DS+xVY
	Vh2j0JqfxhuRAbrsIVucxQ2VMaycRJUzhqfdhbvBILsqdlfHGCgUyUVVjOiqXxQf
	G43UzbQVM8MwQeKfHfFMIqi4RQlgvGYZkt4cOpC8zcLpNWAqN3+nt3sXfGSMvFel
	ypOeQ==
X-ME-Sender: <xms:iDW3apGjn_zQE2cIW3J9MxVCdzeZIcyWMxwvg29nAv5ktLxISFE93g>
    <xme:iDW3ag7LTLcca_PspHAuTHsfRDzeZpEq_Q16rNI3X4c0llfoCTgNZepOwU-HZoBTA
    gTKYVL3rZ_R-x3n0uYF5Tlp7GxLXV3ahGxhanWPrdZgj2g4vN4>
X-ME-Received: <xmr:iDW3auzdJuYAh0MCfkeueznUEFUti0m2ZANGrOUMj5rmTO8zzzQirUFsQnKrSrUiZpCAvEbxPjYIVLssrFmX9-YX8FBJtW4>
X-ME-Proxy-Cause: dmFkZTGF7YpWubyzu579fb3slujvEFieLqPzpCtc5hxEQ6L4lVNSnbIULlGqjts7qW58y+
    fiT0LsxSLxPrEUq2phpCF3WfxXmMcNSrlRUtslDj9DY6InNnwyG5ElgIv0P1ksEjQOdF4f
    dY7iP287oVHqnyKstxicoV/3t1bbil4uJDXOkyrpw/L3I98BXHu3TNEDIOa5p4FE0sizkq
    a6AG2exOvowDXytBfSSY7xF/1KMITKSh3ACkC3VrNC1i2/q8qpt8TonMIY4NtHxPlpqVK6
    U2Aym4WtB79iItXHKNcF2C4TdawhSdOFqwrf15bpfAvErmeqoRRzZIEbgC0Miv6VTckMVV
    cCME4dpHroXIC0vF7UhbruWKNSoIz2alzLk7r6wM54Pb1JLLaAeI1c8ESsEFU9ERkBV2Ku
    MghpqUM8A3HtO0PMwDXOOkRCxO3grfDfZy6rsWOrNhDX+bxruvg3aBwG7XyRrePFC1Ya7J
    6wEnWza7sc1adMgNqiY/bbwp7p91rD2TAg5xfCBgkWfUYjNJZ1+7Q3i9xvbr4TXh+8HQcj
    5lcGGkvpwZ82ZpmOW97GhWssteQ7eu7Zxe4QcUwP6qBbTn+UYrpc7d5kX4buZSn2yADQtE
    fLuopAfWR+jqQxeCamEpkuxvZiEdCrTDboBQf15pIvBDBlS2qU3njIpRebpQ
X-ME-Proxy: <xmx:iDW3avM6CzWP0JN69Azbo4N4Golp8tMKOsJxoxVHX7EHLfLpI_W7AA>
    <xmx:iDW3akmbQkCbUnrLZFasIPZzJWXQToksC-lJIX2T6nGimdjDTA_Msw>
    <xmx:iDW3akRqzbq8ues3-jgpLnULiLmCTIZqU5ywSWlnHme3ioQ52JrwUQ>
    <xmx:iDW3ajVTps4bHveXsYQlOUa6sfM94NYFzeMvdEYcJRcQLRbStJ1ACQ>
    <xmx:iDW3ag5ky07I1xI5_he2zBBIQ1Lzev9ox-_6JVW48pncWrEDoK2zMuvE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:25 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 4/5] afs: lookup_atsys to drop and reclaim lock.
Date: Sat, 26 Sep 2026 12:57:23 +1000
Message-ID: <20260926030052.467448-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>
References: <20260926030052.467448-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
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
index 1edaa7323428..b8773adc4e3e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -911,7 +911,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       unsigned int flags)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
@@ -936,6 +937,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
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
@@ -945,7 +955,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		ret = lookup_noperm_unlocked(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -956,6 +966,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
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
@@ -1001,7 +1020,7 @@ struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry);
+		return afs_lookup_atsys(dir, dentry, flags);
 
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
-- 
2.50.0.107.gf914562f5916.dirty

