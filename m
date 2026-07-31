Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4A3DAAC7;
	Fri, 31 Jul 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486985; cv=none; b=Q3LeSiKxpyrXHxpMQ+bCnuCVwqVP4td4CHZqRx8cKC+JHuHwoASDUgziFjb9neVfHA0mLkwTDaZ7AY8sEBFVW9m97+Ns1UZ2ZcDY4g1N0IK46jyvr3RU8vmyCmnoTU6kmECgNTbI02SBAXVDAqori9BnIEHL8PVM4SO7pgY4Nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486985; c=relaxed/simple;
	bh=Do/KO/aLC0PUSCgWC9+dwBuZfQyu5wVMvbvXRUz6MrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbzwhulG/O4xOXxqyTYYHQoUfhSUS4H4oa5JBlW7u7meX9ij1mQVGoj7TELx03ZeYRKIGHVQKlgn9cVo1GyFo7KucMCR1m4Xhc/6gja3YA/WHx5Nq6T6hq7/tMefBg1vm9/BJbDphfZXVqf+ZyuOpmBoDszsODH9OdAv8EjG09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEPxmMgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEPxmMgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890191F00A3A;
	Fri, 31 Jul 2026 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486984;
	bh=iXDa6cBXMmVhGweESIk+725ufaH2YJ65RsdC8aXYicA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FEPxmMgzT3M3wmDY5A+6lBgoaCmQMDDoj0O2SOI4o8KPKgKjtS9e6ELXwbjeWQb0g
	 a/iYwOAf74RwgfjmzrK7B87Tn2+JizHKfgYq5Cn3uLOyNUcWIrsVYIjw3eIKCWDAjp
	 uWrjM0UYcTLgeDCkKndj9ePcUEVZCx1/BXxcDGSDgdNS2gvjffuK7VrzxKffoG1SLV
	 JqEXhbkxJIjRaGX3yiizX+RrPWafk9hQDq4lRedtcfqMfUuCo4WpSuzyEc8MEB7TKp
	 UrwzcRYaG/gnsMHkNSVGNw34jher9G0QL19Y5leK7t8P6lvoohlFoyohn2GU8tSX/X
	 7DjO3nEFF7Zdw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Jul 2026 10:36:07 +0200
Subject: [PATCH 3/3] fs/namei.c: fix coding style in atomic_open() and
 lookup_open()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-work-lookup-fixes-v1-3-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
In-Reply-To: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Do/KO/aLC0PUSCgWC9+dwBuZfQyu5wVMvbvXRUz6MrI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlxDXMazmi7HmPiV+82MqrNbnMcfZu73kHveyeWjIm3
 dG7X6vYUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGvWxn+WaodmvKnq+FPumy0
 r3jysopn26IvPT00n/GHlv6e/QH3tzD8s9ORyIs/JC5vup7lpZ3D+ab5JdNMmFqat+bq3XPkcn7
 OCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on
failure") indented a continuation line with spaces, left three
declarations without a following blank line and used a trailing */ on the
last line of a block comment.  Clean all of that up, no functional change.

Fixes: 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on failure")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e31905dfeb20..c0da9b5dd47a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4377,6 +4377,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		if (file->f_mode & FMODE_OPENED) {
 			/* finish_open() called */
 			struct dentry *opened = file->f_path.dentry;
+
 			if (unlikely(opened != dentry)) {
 				dput(dentry);
 				dentry = dget(opened);
@@ -4384,6 +4385,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		} else if (likely(file->f_path.dentry != DENTRY_NOT_SET)) {
 			/* finish_no_open() called */
 			struct dentry *replaced = file->f_path.dentry;
+
 			if (replaced) {
 				dput(dentry);
 				dentry = replaced;
@@ -4392,8 +4394,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 				error = -ENOENT;
 		} else {
 			const char *fsname = dentry->d_sb->s_type->name;
+
 			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n",
-			        fsname);
+			     fsname);
 			error = -EIO;
 		}
 	}
@@ -4540,8 +4543,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
-		/* No need to create a file. If lookup returned a positive
-		 * dentry, the file will be opened in do_open(). */
+		/*
+		 * No need to create a file.  If lookup returned a positive
+		 * dentry, the file will be opened in do_open().
+		 */
 		goto out;
 	}
 

-- 
2.53.0

