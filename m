Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0830F535
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728605; cv=none; b=JocssM7gCP0TuENcIJ6PoHKIPt1lTzFnF9DXcImNO5Nd9w8hY3b0d61b1Vnm9Lz922V1iKx4+dabPfuuWbcsZrZL0k57cUhfzQAWnqNfrE66GV8sbPIyXQ01KlzJmRH7FnHxg8UdIIl5mQkwFqecGaljiWw8CFqh56Xh9kkSk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728605; c=relaxed/simple;
	bh=Wi4Kx/kVNjMjYQ048MIsbVECDRrMkf6CQnYivCvpH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiGpRNba+9gymbkffn0Omi1+z+ggNxlUdwYUursSdUVhWnq/ZgLgEj0vV7+2wRM9/2+v/wHOM2R4tHhO9A7Ufg2xI4551N8WzpumOcG6ZwhUDNnW6nFBMG+haGjTh6Pugv1WlnCUITKMP5wVBz/+DhcOM40XVhMNgZhwM13V6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wwxDkaWJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wwxDkaWJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iEqqqhe57YEnmH3IFZBYj2tvXDrAa2mJndazdRWbtyY=; b=wwxDkaWJv3N3dOddUia+0bzTRQ
	LiC4TNcju96fNZZeQmqi6T+d5eCcNeyww/JKA6YFYLCbCwQDjvLEXNxpoB7mXOvOSDPlLO7l2g59C
	xulGzAK5DE7EEVIZU++VcZPxOWvpP323tZLLQYMQAz3YEhhk9xg22O2VlidoTxtq1DiGBETNTPXa/
	cslseS44c3IbrTueYw5vowAs6Ada7rzwCvqT9/6Yy8f38JL60EQXYxOU2DGC45EIZ5feEyUM/h1uX
	tQwvpoU2EjaHPKXAfv49sP64bb/Vw+zhsIb1S8yCaW35AG6jewYCJZ2Fof79/fMcAB+DKDX1poD2t
	2f5Svtkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkqz-0000000BQLu-1ihO;
	Sat, 06 Jun 2026 06:49:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/6] tracefs: use d_splice_alias() in ->lookup() instances
Date: Sat,  6 Jun 2026 07:49:51 +0100
Message-ID: <20260606064956.2722874-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

d_add() is not wrong there (inodes are freshly allocated), but
d_splice_alias() is more idiomatic.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 26b6453de30e..39c7a34531e8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -389,8 +389,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 };
 
 /**
@@ -420,8 +419,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	dentry->d_fsdata = get_ei(ei);
 
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)
-- 
2.47.3

