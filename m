Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACD374A18
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183292; cv=none; b=edrukQE2mJztc4zE2BlQzduokjBIIueZs8hrQRs2UFzcUPPgkdoe2S1A7QCX7+g3U5jk2STV5y61Ru5kOhK6F+thkoGabuFTNAhhncEmfXMegKSquRbWe/iZtJIj1FQRsGJd/ITGS17TY2sOJ+POd/tfK/DHTrj3cUmGIMw2vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183292; c=relaxed/simple;
	bh=jSWP6PXLEjEYsMMu0X9cBXmITpU6xcE+hMnhBqj9zUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLVFvXu743h+aAJdFS5Az7xQYuUUWsFZuXKgha4hh62d5FCnPAVYXQebxuygLADh3W8ByFK3BMKZcklWm8aFyTnmwYWcCovfsCw08xerSdO+RAW2d6v6t1GiVNZTBZb/w8A2QTymKsZLSFK8QgcMjYUzExnwevuCRipvwOjvTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Pwn15L4v; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Pwn15L4v"
X-KPN-MessageId: 2e146249-77c7-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2e146249-77c7-11f1-861c-005056aba152;
	Sat, 04 Jul 2026 18:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gGZMZcKnxMJU/bFYMZhyKsdzdzN1KCVWyreiizlX7Ow=;
	b=Pwn15L4vMhbZ0Ny2wcnIyF2qeiww5MRZlM2uF36XkY172VXfhHUYEDpam92XzlbAX8UOBKonwn3Km
	 IjeFJ+EdPFYRB4qlAl+f4/22HRda6ZQr+FztmHz9DK1FkbhjtdCQXPp5rDNx4MsR+tqGxKDlyWe3Qi
	 0x7MdHxp5ffahZKShto4X7mjTk1AjraoNeo1cANEoZOdYX0S/WVYscKSYXR8RXt4M64EcuoSDbLCap
	 CW6OwJT5aW5JyQrocZF5NWo2Hgkd8jMbnwH1TG+RUjSemQXO86f9nLbnigv5cUaxvdDfrmC/cds570
	 Var/o+P5lJUKn9bn4O99VSMLYAXkMEA==
X-KPN-MID: 33|yxBlcxajSf8OzBO6tcFDpcDz36vbDjgdiZXJplFSJbL98XmCiT/nVBvP4BU6Ezn
 Ke/0abmonOqQgZwHLIqHtpQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gLx0ucXtRX3S2JV3a42LFYswR8hwoenBA3TK7fMBw936QVy64Ls+KW2Mi/AjCNd
 iyQ3mgw9T9s6DC0QKFhPoXw==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2dd36b59-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:17 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 07/14] vfs: move ->create check in lookup_open() to before try_break_deleg()
Date: Sat,  4 Jul 2026 18:41:41 +0200
Message-ID: <20260704164149.3480051-8-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i_op->create check in lookup_open() takes place after the
try_break_deleg() call. This does not match the order when doing a
regular file create via mknod(2). There the call order is:

	filename_mknodat()
	vfs_create()
	i_op->create check
	try_break_deleg()

Move the i_op->create check to before try_break_deleg() in
lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index daf31845e3bb..6601460d2772 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4548,15 +4548,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-	if (error)
-		goto out_dput;
-
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	if (error)
+		goto out_dput;
+
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 					mode, open_flag & O_EXCL);
 	if (error)
-- 
2.55.0

