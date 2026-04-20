Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46A3ACA5A;
	Mon, 20 Apr 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691968; cv=none; b=H3lLUESr4V1sy5Q+mWU2tvvHfk5j2pEPjj5lEVbktAXLVJhJZDSrMeiOKcQOn4H+gJljQ/GTb5niVc8YV1PzU2gC33VCMR+TZJ1utVFpxdG8+kcHEe2qoOc8G4+1Ul2a2OsfNLMkhfDKx/ZyWaZG9dc5xbhrPeZ/mvgAAh0ySaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691968; c=relaxed/simple;
	bh=91T3siAjWjNZMFdndRhJZMMRG16pSjzssiPZfd5aOZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjCB1S7gha3d5kQGeQ08mGfsX/OB5Jf/1ih4Xff0fYJvNtb11wAzAs04K6yE2w+WUCsaCCaqfWA7pupbyBb9JA20rtkeirbd7sPLKD0/D/bYq7SRDiXVAVm/BdifDqi7vjKALtBX2h99B/ZOoksb//MM/xmDqAGj2/E3ZZeJkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNBCp72A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNBCp72A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD41C2BCB8;
	Mon, 20 Apr 2026 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691968;
	bh=91T3siAjWjNZMFdndRhJZMMRG16pSjzssiPZfd5aOZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TNBCp72AKsG8JDP2A+EaSBLdpZs/qQ15AIF4alZKMMxMjNLhPujjLZsbWrdxIZXVS
	 FYEWGKjUcWfCnqDnCW3nDLZZiGmUrVyPIvN3OSO5lvyYCW5mixahwSjeY9q0QSTVro
	 MTIOgmTcNb+oYUpqF5HHSphza4UcZ8VSt97uKoYQGv9fKVuHSWvgdymPgQoWpKYYQ6
	 k4gic/nnlBman7Lb9H/NzBdlElEWct365j416rhQOJOqnvHrRb+OlbzZqj4MQMAmsE
	 FjsUvIgz/cD4tmp4xN99xEiBDk27SQ4LyEPhFSvVKutn0vYOMM7HtrepdoTmCla4Jf
	 J4nwJ7eXJrPYw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Apr 2026 15:32:36 +0200
Subject: [PATCH 2/3] pidfs: return -ENODATA from pidfs_xattr_get() when no
 xattrs exist
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-work-pidfs-v1-2-4bd614e1cb33@kernel.org>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
In-Reply-To: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=91T3siAjWjNZMFdndRhJZMMRG16pSjzssiPZfd5aOZg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+0/rNekwkfe255pyEa8tE7beHy3nrdncxvlv9QSin4
 nJLT51sRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER6qhj+u5ofXKV15/xkvkjJ
 /e9Wv+5qez3/7vQvAUUzp8RMU3q1dhbDfy++cxs62Rj5fFYZtPw2MEo0ypxSv+wFy6f0x2rnLDa
 85gYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When no xattrs have ever been set on a pidfd (attr->xattrs is NULL),
pidfs_xattr_get() returns 0. The VFS interprets a return value of 0 as
"xattr exists with a zero-length value", causing getxattr() to report
success for non-existent xattrs.

Return -ENODATA instead which is consistent with what simple_xattr_get()
returns when an xattr is not found.

Fixes: 5c1e4b9db95c ("pidfs: support xattrs on pidfds")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 11eb53f3e50a..2ab8fd2646f0 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1023,7 +1023,7 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
 
 	xattrs = READ_ONCE(attr->xattrs);
 	if (!xattrs)
-		return 0;
+		return -ENODATA;
 
 	name = xattr_full_name(handler, suffix);
 	return simple_xattr_get(xattrs, name, value, size);

-- 
2.47.3

