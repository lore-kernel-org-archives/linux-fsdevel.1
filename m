Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082CD363099
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960441; cv=none; b=kz6CBD1+O0gkib91oop2qqnwsWMWH7DO/Aa2jiTlfF89GfLCcALKE+HzDKiPGJkPuFJzRneY1ztFZjzN5o7jS/OBF3pQYkaNZECBTfERz0Ymp6ZNWNa503Z1XIZsTkoRlZsE/UmILuDg0s9kioTeBVD5a8i3jlVBbIDBp5kjAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960441; c=relaxed/simple;
	bh=psk7wSivwJHK+KZCT4tH0EGvELVpjagiCwqcv12xAiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2TfRVxBCHZLcfNJtYxpCvjrlIualDdzoWv1nAkg4JGKiMWTT/73lVODBwFj4lwCywN/rR4EtmxskK26Ed3oXxGVJcb9PlVn+P3IyqddwR9q03dHjd/jJHbH3nznQhRF6a3zzOkTYctlNIBJUKotmryspDQuI7M6zX100LtJ6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aa/qUJXC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aa/qUJXC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VZcywQeYPlniVdw7rbH0PXxaZQef+JviLVrqGznhvL4=; b=aa/qUJXCH+wUOqwnoBx1ZJqcQG
	1nQOsqvrYW38j07veOouFX+JVZbXe9d6TV8MG4oiezah9xWckHibVtpo2A+twmf3cxmwHh6ok4gMf
	HaAHFxRhujwZiDWIJO4ARDOnr7qPQMSc1gxI2P+bFj29IsYOYtHXDH++kKUKtBVaZQZpeF9A2YSYi
	UwsR1eYWXb0QGC18M+qq2UaaFk6IicJELO/yiOXut1t/YRcBmyBkmkUOWRyNqY/6y6UHMYSK8fZdL
	ufeVQBIq7Ts4VmYkvQ5xKfPekkpHVhbYhWy3pOC7ITI5WcKIhWIXAUG58XCFgIB/ThOhNW/adWOl/
	+p/TrtLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jW-00000005I5b-3j7M;
	Tue, 05 May 2026 05:54:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 04/25] find_acceptable_alias(): skip NORCU aliases with zero refcount
Date: Tue,  5 May 2026 06:53:51 +0100
Message-ID: <20260505055412.1261144-5-viro@zeniv.linux.org.uk>
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

similar to d_find_any_alias() situation

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exportfs/expfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index fbd45e7ae706..0295bd3386cf 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -53,10 +53,10 @@ find_acceptable_alias(struct dentry *result,
 	inode = result->d_inode;
 	spin_lock(&inode->i_lock);
 	for_each_alias(dentry, inode) {
-		dget(dentry);
+		if (!__dget_alias_careful(dentry))
+			continue;
 		spin_unlock(&inode->i_lock);
-		if (toput)
-			dput(toput);
+		dput(toput);
 		if (dentry != result && acceptable(context, dentry)) {
 			dput(result);
 			return dentry;
@@ -66,8 +66,7 @@ find_acceptable_alias(struct dentry *result,
 	}
 	spin_unlock(&inode->i_lock);
 
-	if (toput)
-		dput(toput);
+	dput(toput);
 	return NULL;
 }
 
-- 
2.47.3

