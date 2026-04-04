Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4E2848A8
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289859; cv=none; b=o5S1mRE/4n+J0gWh8WZASo5mwAR9qPCJTBvWkiv6F3XekoP+HjjyYMFm4BDyibDMUiB2oRnkQqSH3X+IatOi+nIAd4eaxlmU5IUqM5w5E3QDdmB4fme3/SOKnjQ76GYm0nrfwnYXllFPEiZYaCW6Fccee5zDQYZGGkonty705N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289859; c=relaxed/simple;
	bh=VwqR/jltwzijDJKcjM9O+CT1/GoGWCthHi9svTsQrq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0Ypt+kkDM57syMixOFpn1i6F5IqlgG/YcxHy6qVFLyav5X9KpAece0VaWBk2/2nz6gUT4fn0DffTPMcYBza/NywlLw7ToL0goacSmV1V6TRgEKXjmsyAi8FWMg6U/VOggSbPxACPjVLzecRZ+BQG4HZ/omilLw29oBFIhLNotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YlW9IRPh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YlW9IRPh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=q4ui0Jxfe+wEszxYSQzhi6R/7rXxgxRSqLVewLY4krI=; b=YlW9IRPhRJfwaFNPgmyAGTSa2m
	IWC1O5FXPY+8sy3uCl/5J0DtF+t9cOYG7FSRKtvUC69EwviCdLVCCksQ2Vb4TEOv7qPB1dTwhXU/8
	WLxxtb5iSia5RmHtd2gKDY3g31mUfK8TwOpuOMAxOvYimP9sUBrJhKckknccOgp1uyjocesz/Has+
	LsdLxNnCEkPMFHme9XBliFUTLCiK8MEsU5qTrzU83HUk6GwO2lAEDKJTuJj676jcJwswnQI0wIJSG
	rmDDFS5xWZUYeAHqSl4X6rcjYsXyXivgpL+CE/HzHLx7XJfRHoHgNd9WuMMwrrC5MOsbPBKP+vxfy
	uzq7n2hQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8w2q-0000000AbOB-0XQp;
	Sat, 04 Apr 2026 08:07:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v3 3/4] dcache.c: more idiomatic "positives are not allowed" sanity checks
Date: Sat,  4 Apr 2026 09:07:50 +0100
Message-ID: <20260404080751.2526990-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Several functions have BUG_ON/WARN_ON sanity checks that want to verify
that dentry is not positive and instead of looking at ->d_inode (as we
do in all other places that check that) they look at ->d_alias.
Just use the normal helpers instead - that way we no longer even look
at ->d_alias for negative dentries

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4378eb8a00bb..616a445ec720 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -428,7 +428,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 
 static void dentry_free(struct dentry *dentry)
 {
-	WARN_ON(!hlist_unhashed(&dentry->d_alias));
+	WARN_ON(d_really_is_positive(dentry));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->count))) {
@@ -2004,7 +2004,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
-	BUG_ON(!hlist_unhashed(&entry->d_alias));
+	BUG_ON(d_really_is_positive(entry));
 	if (inode) {
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
@@ -2024,7 +2024,7 @@ EXPORT_SYMBOL(d_instantiate);
  */
 void d_instantiate_new(struct dentry *entry, struct inode *inode)
 {
-	BUG_ON(!hlist_unhashed(&entry->d_alias));
+	BUG_ON(d_really_is_positive(entry));
 	BUG_ON(!inode);
 	lockdep_annotate_inode_mutex_key(inode);
 	security_d_instantiate(entry, inode);
@@ -2795,7 +2795,7 @@ EXPORT_SYMBOL(d_add);
 
 struct dentry *d_make_persistent(struct dentry *dentry, struct inode *inode)
 {
-	WARN_ON(!hlist_unhashed(&dentry->d_alias));
+	WARN_ON(d_really_is_positive(dentry));
 	WARN_ON(!inode);
 	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
@@ -3185,7 +3185,7 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
 	struct dentry *dentry = file->f_path.dentry;
 
 	BUG_ON(dname_external(dentry) ||
-		!hlist_unhashed(&dentry->d_alias) ||
+		d_really_is_positive(dentry) ||
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-- 
2.47.3

