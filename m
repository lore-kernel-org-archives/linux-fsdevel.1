Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7433C2772
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960442; cv=none; b=B2i1PEXWko3y9wsI0mBvEyQqGEUAuMhDosdc9fNGPLDY9I90HpfryxAeS54mVLisPAcZ1QxOY9blrmjyToShjsPKJQQexS6Mwpvl5vwIsQ+s9JKDJrjya/8lPrAvVMbtFtW2Qf08Gvmfdz84I9/Sz7PCffrXCePh7Nv8DvdagYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960442; c=relaxed/simple;
	bh=hcECBxJAM2ivQArXx1kNVQCJK73QMRhKZb/ys/F8bV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNbXe0aQIDPNuVlWzrgpzYcbS0wia11xOSifKA/bxUJyZDjQr8kwd9deXp21h5IviYAPz358k+w+nRjwbrXYQ+ZJQ76ZbGD+TCT67c43mLk8YrS+VtNVLIldwjKmoVZr6SJ8ndaBQ9bgGeIgQFqBvWzK5QeAS2qwu8ltxUcUcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pGA1C9kQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pGA1C9kQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=194X+II+NFpKDlrmdYW8Tmcsi/Qh+s7qaoW78kAjAfY=; b=pGA1C9kQARxty/DW27HQZVH/+J
	liYLx86+s0xMwmRNgeMTPbfLQfEmYoAMX8/474usqDk4IqApfJREaET075/dkhH3H8wOdQkzbBYin
	Hlnyhormz1iFL8kBHNgRYUbfrsnE4lvmcfReF9fM4L9bPH2Sxe0GsVw92q56YeFTPbfmR5hUDaPaW
	QEIQPWdzXSTcKll/2SBKXgifoKu64LNMsewuPscZiWcTfDZQKXE7vb5bv08DPEBX7kqqKWBFqX0iY
	TbtQF3qJ7pM/eJjm2gsE5lfWgPIePgtoH2iuEH4Vs4k91ADZsmiN8SjWsS0vDbkGekoktvsxFqwNC
	Jtbazw8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jX-00000005I5q-2ubm;
	Tue, 05 May 2026 05:54:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 08/25] d_prune_aliases(): make sure to skip NORCU aliases
Date: Tue,  5 May 2026 06:53:55 +0100
Message-ID: <20260505055412.1261144-9-viro@zeniv.linux.org.uk>
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

Either they are busy (in which case they won't be moved to shrink
list anyway) or they have a zero refcount, in which case we really
shouldn't mess with them - whoever had dropped the refcount to
zero is on the way to evicting and freeing them.

That way we are guaranteed that only the thread that has dropped
refcount of NORCU dentry to zero might call lock_for_kill() and
__dentry_kill() for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d8c23a42409..34d57ed9d791 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1200,7 +1200,8 @@ void d_prune_aliases(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	for_each_alias(dentry, inode) {
 		spin_lock(&dentry->d_lock);
-		__move_to_shrink_list(dentry, &dispose);
+		if (likely(!(dentry->d_flags & DCACHE_NORCU)))
+			__move_to_shrink_list(dentry, &dispose);
 		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&inode->i_lock);
-- 
2.47.3

