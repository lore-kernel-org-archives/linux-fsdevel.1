Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0343FD132
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325426; cv=none; b=laZMDQOZYy1WYw4VqfgPIaz3dRah9E0B+I6C4o1pezRL78KYzeuvKrnl6HX5mWbpaNIlr3g7Es5SpGjqrmhBsA82ICdta1u/yCN0Ii1V/eE2R8hYG4q+qf1L/G/LgptTyJ55u4f+kuBeT1JRIn1xO6XUf52BzKTqpLeqSFtZhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325426; c=relaxed/simple;
	bh=IDCWIVvwPzVh483KqrhHhS1Jo9ADNrPQA6Q4j5SruiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXNql7ujDPvo7zKPo/uu3cuhyBFPfEd6/Opr22ryhUArxGqs/nODxsBQXJuVzZah6KcXsqNla2wanUjd7FPiudUP7HqHjiejvjUONsOqqnn1DyF8UrQ3cnNmFkk1SI98ERNKUhLpeJ2t7vz6hiv3hYSPYJHrRQuzrJsd9F9078I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LEkdT6Bd; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LEkdT6Bd"
X-KPN-MessageId: cfcddf74-afa3-11f1-a059-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cfcddf74-afa3-11f1-a059-005056abad63;
	Sun, 13 Sep 2026 20:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HzSnbSwHRiOGXhA5N5V5Bak1BWFtNPQDJwmZ8P6MHG4=;
	b=LEkdT6BdTO3eHUkCPKcYswWGxnPOn1NJrTwRf7X1dRkCmmBm5weS6T4GSl4TItqwpiqDgQE5p1PsR
	 jTi5+74Bu7HVmJiuO85cB12hlboTpNUrQ+aodhKo33KMzyEZZYCsO6w48M56gNauuVm5wNe6Ja3V8Q
	 OkEKaaZtsHKBiGD2Ntbxk2pmGB0E6SiAB24jRvmYlDxC6/PRykwuY1pvhMFAnCQGro3tOGtsVRiQ9B
	 mf+RSDzelBGfGZ5iENcgCEK3GcNr5eVjz1yGkSX6ER3scjO0a0Ui588qNShMql5OGHXoXbszg6o9ru
	 cqvkpDuVzX96pUCuiDou9qvQgDejrfA==
X-KPN-MID: 33|Im5LeJN53oxuzg0326CLs04iHcapfF+j5omCYZe0rRxsy5kEuNJBCnyRsFQzZl9
 iGC56e7kNtX76Laj/WeaMdK6ULVYnJA/Eyhc12RxQWMk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oqRSx64+PH58pDxUsqTkWkzMA9stfxcY16shhxbI/kMjcxiicYo/ZsWS7MZ2sEC
 Dna0QAwU2rbJXVkBpKEnV/A==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cf93a9db-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 03/12] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Sun, 13 Sep 2026 20:50:07 +0200
Message-ID: <20260913185016.523376-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
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

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index d8401aa3100d..f1cc3ce979ef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4580,7 +4580,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (error)
 		goto out_dput;
 
-	file->f_mode |= FMODE_CREATED;
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
@@ -4589,6 +4588,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
+
+	file->f_mode |= FMODE_CREATED;
 out:
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
-- 
2.55.0

