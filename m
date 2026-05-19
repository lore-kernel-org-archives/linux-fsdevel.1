Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD303BA23A;
	Tue, 19 May 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229562; cv=none; b=ewjDq06itYE1P4uz0VPnZwwujHLAg52IicMMeSmnC0FxqrevU73XeTmGLbBviVrf99bmKH+laRyHTIQ9OJ4S/EBoW7sIT0AQVnouBNeTHwyPF+cO0Y4RwhFD0GNlxvcAHOO7BfusBg4lZoeNRwL/rORK9peuE11TgjKDbCOWjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229562; c=relaxed/simple;
	bh=4d48WiFO/68xBRgtQ4yIuZJ9c3PmV6Y8BIoxR3/rmJE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqoTFGw4MAOswuWr8RsBqBc++G0UFfUzc06pmj19XjUFNmzsxM1EYUeVbGEoK/WW2HDRqz2cK3B8JyMpnx/cx7EFz1mcttTTQkwMrMiN+c9hHlnA0EG8NnbgLy//E8Aih6VhKZN1LS1jH8hkljBp3mfcdEn6BHnurQrHhzjxR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAY8elYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAY8elYG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D91431F00893;
	Tue, 19 May 2026 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229560;
	bh=847A4MLmbmPEjTLDuEE5e0oWJNL+lnRy0UvDPYNUCMo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=cAY8elYGh3KWsXFedasgt1m13oqrtrXwfOxxV5ZT73nUuvWzbhUheGaCs4EHI9Ue3
	 /ZH184rmY9f6eGrSNYTfsiWLILSijEPtLZbnkxTRBwkfORctUjEDILgyI4VXfI/dRV
	 ZE2EriMh2bNAkDdcJlrNHA1I/uG4CQpyMZnE4NIZQmVHv9Q7+00WrIbWrOQ0oN7OGr
	 OfiY8jnLe2bfhNh2nNWSjV/XDcUj/LUkf722T9XTewixNm3BWZMyrUKwEmuu1o+WcL
	 rFBbVX8Axitu8z1fbcebmTCryy9xLq1HhZRYGhRoPC0i1ROamCQEC6K9KIh2NetcCy
	 n4pq9FYkWmGgQ==
Date: Tue, 19 May 2026 15:26:00 -0700
Subject: [PATCH 2/4] fuse: store backing id in fuse_backing objects
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922944866.2436629.1081840703046716342.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make fuse_backing objects know their own id, it'll make tracing and
recovery of backing ids easier later on.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h  |    2 ++
 fs/fuse/backing.c |   12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f9939df81e3f9..b0a11a31bb5955 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -122,6 +122,8 @@ struct fuse_backing {
 	struct cred *cred;
 	const struct fuse_backing_ops *ops;
 
+	int id;
+
 	/** refcount */
 	refcount_t count;
 	struct rcu_head rcu;
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4f86f3ca13fd40..217facf3f408a4 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -40,15 +40,22 @@ void fuse_backing_files_init(struct fuse_conn *fc)
 
 static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 {
+	const unsigned long max =
+		fb->ops->id_end > 0 ? fb->ops->id_end - 1 : INT_MAX;
 	int id;
 
 	WARN_ON_ONCE(fb->ops->id_start < 1);
+	fb->id = fb->ops->id_start;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, fb->ops->id_start,
-			      fb->ops->id_end, GFP_ATOMIC);
+	id = idr_alloc_u32(&fc->backing_files_map, fb, &fb->id, max,
+			   GFP_ATOMIC);
+	if (id < 0)
+		fb->id = -1;
+	else
+		id = fb->id;
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -147,6 +154,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	fb->file = file;
 	fb->cred = prepare_creds();
 	fb->ops = ops;
+	fb->id = -1;
 	refcount_set(&fb->count, 1);
 
 	res = fuse_backing_id_alloc(fc, fb);

