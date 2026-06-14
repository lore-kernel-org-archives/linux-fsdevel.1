Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E73CBE7C
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455496; cv=none; b=Jsa9VPtr7Xh8LZbW2dqf3xUBY3D5vR+XQiYajqXnNwwvRkekuwrsknh7JEvDU4p4h37RIJB9O2+/F0rDZ8nXLy907eEQ3Zfc/azj0pzGHe48IqXvnpSZ9Ppo8FbM6+CVY7xxMImLR851GGzftrYLmLnUP4aDUa32jvRRJ++xSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455496; c=relaxed/simple;
	bh=eZ61OR2g+GT4eomaa9iCVtkHStwdOKKq00v7YLVmYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5GnkMDzWx0H/UlAViqCySQS5a6gJ/2EOMOJh3BBchtgMWPDmOrB7VPJ0BrrS6BdDGQbaeHOIjqTIJMiKx/KnYPALjn37/32eB8fDdUNed/hJ913Mh8YhlYN4LlP3TfBca9yRjsekbFxRRGKNzLL0V43n75/XPzDl7yX41KL3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oo1AyITm; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oo1AyITm"
X-KPN-MessageId: 35f86b14-6810-11f1-b18c-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 35f86b14-6810-11f1-b18c-005056abad63;
	Sun, 14 Jun 2026 18:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gY/4JcSmmeWSEgHAUGig0gcz9WOmvHfoIDjTtVTLo84=;
	b=oo1AyITmdC5xqXx379pxIqd4y4t47L3yee4HGb2cQGZ51+N3qCQOhfSXNEQHDlox5uaj4ZQnjiBk2
	 NZhLLabvubpN63XT51H+W93vCZ8PK7GHJdFHD/FHN/DBFF7jnkaCLo9mUGQbXEWl5HsRhnFyAseLde
	 Akl2y7CuzQ+GI96o9T53lgseV6AFQWQnptgmaaBPfYTaipjIB016cJiENvk8ZsDpuPLwKwK/3Nt1H0
	 lZJ9yREgx1RwGMS/mo7uF71yHKn8Al7lW/69zRqsl8OUVzmBXG5D/GhQblIp7B0km4cl2ex8sXSEQZ
	 vCSFhbzMQeCE6j5c7TQ7YJIBwxa/ahA==
X-KPN-MID: 33|YCzi5wJf/PxXrR82nHCGIoLBSCiN8i2g+rL832H0lc4zoKzraKnYp43mn3CW4ph
 St6AKdDktfi8+377lmni8hzOVoVENlubdGrEcj38uIw8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jqa916x8GAWGOz0OBVUn4DWvXRJbCglN2STFnQ49l38qQSUqxZauLObcA23EQHL
 2N3UgHKehneD7gObgNdRo/g==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 35c4e310-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 05/12] vfs: lookup_open(): move setting FMODE_CREATED up when calling create()
Date: Sun, 14 Jun 2026 18:44:31 +0200
Message-ID: <20260614164438.2980769-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index a4a8cdbb48e2..e21f23502e8d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4533,7 +4533,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
 			goto out_dput;
@@ -4545,6 +4544,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 
 		fsnotify_create(dir_inode, dentry);
+		file->f_mode |= FMODE_CREATED;
 	}
 
 	return dentry;
-- 
2.54.0

