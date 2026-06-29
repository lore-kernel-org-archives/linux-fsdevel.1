Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEC3E5EF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747356; cv=none; b=E4sZ64RTr7pS0+MkG1n3tsVY1lc7gHczBxX/ctRVGQxIyiTHDRG3NL7letzGJ3FNI4K9SdCbmsoasCmPzqy5Xjr79Joy3PikPkjJjX0LbRG1hVKji54UsARya8rKdvDaYuWwI3KnitTS5SIPFJzx3jAZZnGsVybvt8YGriOm28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747356; c=relaxed/simple;
	bh=4dfljeAr+sTy+O4saiHZMfvnyUNYTEGkkDvA3NCb0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC7kCqOxIddcyH2hwGNErs5/LbceXiP/v7qdXtp6KYj43QpvXJuRyo+6fDQTQFXaI8mPXjb4AuGUJ8C0oAIni02tPOB+c+ZnA4sVz8ukOni5szw5qqxL/toJcN8StSjZWJWKEiJs49rtRtyWotWZCxEbiadtNcsVvrw/iy+Wdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IqRtYXIO; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IqRtYXIO"
X-KPN-MessageId: 32f87966-73d0-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 32f87966-73d0-11f1-8f53-005056992ed3;
	Mon, 29 Jun 2026 17:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QKuNKqAQ93lKXMUcNEfKJzUJ8pSc51bdXyjr3BFhL6M=;
	b=IqRtYXIORC0LNsRanJHigjp8UJ423Q5NyAhG/wHkgHb2elbwVGX/qBx/qQurjyaejlhEFkSRfIxE0
	 Fsoa/92/wlcW0PsZo449GvfERWl/8vo2mViAry7z05Xsjxqu/IjQR0CtJHVftJlPDcPRNJhuz5s4Ks
	 bCqqn8eSqbpqjsmJ+iZ+/TzIj4uOLR7y0phiNrwVzPZJp/5h3dGuhVQgfz7AaNzuspNKHxtqdfqNVA
	 YjufsXDooI/+ZtGVYdeOyzJWNwILKPkFdDWr7r+BbFOuzAUvbIjMcb/jET5EvX4Tu+bVInokfsyCf6
	 uLOv+NYkNBs6mjouuFaTHtQZCa5ASNQ==
X-KPN-MID: 33|rk1RCRZ3Jd1gWtYP4ZkrVqF7GLEDjxg2mv/9+eTJ1qkpRB1rLRBtVlYcWNPYDQY
 R+Ct0yScacSBwZbciEdev4FUhH/lexzxjYImuCng1BtU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xoeK2DMbbCgBo6oP6ntaiksoBLq/0zJksr114P3MBTcTSWw5hcy+vsduRGucSQG
 GuCVzSryU/lKum3c/AGsWOg==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 32c3d3c9-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 06/14] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Mon, 29 Jun 2026 17:36:22 +0200
Message-ID: <20260629153630.2158649-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
Reviewed-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 85ce44b068c1..a7e179366703 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4550,7 +4550,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (error)
 		goto out_dput;
 
-	file->f_mode |= FMODE_CREATED;
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
@@ -4562,6 +4561,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 
 	fsnotify_create(dir_inode, dentry);
+	file->f_mode |= FMODE_CREATED;
 
 	return dentry;
 
-- 
2.54.0

