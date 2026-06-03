Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD12356D9;
	Wed,  3 Jun 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445775; cv=none; b=nqs7MQivF6GV45/vRgpKNXokvxB4m1/cFHF2BCMNvwRg002HlI+IaPgOZjfEEQ/Bt/LMbNnIZDd6X5Dc4Nxi/IRvizfj3Wqi8bpMoK0uAce15IpJgnMW2qIQJIBtYYqpjYU5Hxo2gVexL7tFUeRqygQj6l8FKimxhjMfFA/gqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445775; c=relaxed/simple;
	bh=+Opx/rEbuIuVBEx2AAGHVH1n1ErHPWGZoI6iWOWbyCE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1GEx3aN5JGLbxJKmPDMKFqYYKcdaSMg+P5WP7LJuE3HEyETDRPmUhSm2UWarmKgR5FYYjztbsMJ7hhvpRwPU28xY3DI5pdxDX5eeWT65QFzXXKOfkzNd5QUkhFd16376Tis4UnVVeG1Jv1ei24XnSeHwqFocijWxUXnCOQGguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltN6W2wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltN6W2wi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E0CD31F00893;
	Wed,  3 Jun 2026 00:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445774;
	bh=Af5kij+mnr97p4syNz1jVQjX+rlp+l/COu+y7kl5K+k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=ltN6W2wi1JyIfpzDMbIY0AQAUpUaVWCDPHBaQjkBPM3wLzQsg7hCvIuKkq38Argzd
	 V0vziykDmV4WgYflailkTCExlFDhUCYZdK6B2i0RWk5nrGDY443A6L9jDylrlLjt4a
	 md541k/JYOwYwJnkAC6OYCN2FgUm8nt2sPg+Vd0DsWxBWJKMMMSrjscazU4E3nVTEl
	 GQEVmk64Vkt7kXUeM5hTyMx2aaKH7za+YZamsdIMziJnlwIyeeaB4S3u/Peg25F2BN
	 wzBqzFYgNYtKazV4Gf1PHwEgPp2RseMGORvC3n0VPh4wGRzVndgVmxx0E60Vi2g38h
	 R3A+74gFwieFA==
Date: Tue, 02 Jun 2026 17:16:13 -0700
Subject: [PATCH 6/6] mountservice: advertise fuseblk support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567930.1435997.15363968498209622419.stgit@frogsfrogsfrogs>
In-Reply-To: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Amazingly, permission for the use of the "blkdev" mount option (aka
mounting with fuseblk.SUBTYPE instead of fuse.SUBTYPE) rests solely on a
getuid()==0 check in userspace.  That /might/ be an indication that the
kernel also won't allow this, but as that's the criteria, let's
advertise fuseblk explicitly so that a fuse server can discover the
capability before calling fuse_service_session_mount().

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h      |    8 ++++++++
 include/fuse_service_priv.h |    4 +++-
 lib/fuse_service.c          |   10 ++++++++++
 lib/fuse_versionscript      |    1 +
 util/mount_service.c        |    5 ++++-
 5 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index bd89189cfe5d5b..0536312dc7120c 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -61,6 +61,14 @@ static inline bool fuse_service_accepted(const struct fuse_service *sf)
  */
 bool fuse_service_can_allow_other(const struct fuse_service *sf);
 
+/**
+ * Will the mount service helper accept a fuseblk mount?
+ *
+ * @param sf service context
+ * @return true if it will, false if not
+ */
+bool fuse_service_can_fuseblk(const struct fuse_service *sf);
+
 /**
  * Release all resources associated with the service context.
  *
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index 8560b1ac610143..cfbc444bf5dcbd 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -54,8 +54,10 @@ struct fuse_service_packet {
 #define FUSE_SERVICE_MAX_PROTO	(1)
 
 #define FUSE_SERVICE_FLAG_ALLOW_OTHER	(1U << 0)
+#define FUSE_SERVICE_FLAG_FUSEBLK	(1U << 1)
 
-#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER)
+#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER | \
+					 FUSE_SERVICE_FLAG_FUSEBLK)
 
 struct fuse_service_hello {
 	struct fuse_service_packet p;
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 7fd10211dbeab4..2d7232c3484aea 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -51,6 +51,9 @@ struct fuse_service {
 
 	/* can we use allow_other? */
 	bool allow_other;
+
+	/* can we use fuseblk? */
+	bool can_fuseblk;
 };
 
 static int __recv_fd(const struct fuse_service *sf,
@@ -505,6 +508,8 @@ static int negotiate_hello(struct fuse_service *sf)
 
 	if (flags & FUSE_SERVICE_FLAG_ALLOW_OTHER)
 		sf->allow_other = true;
+	if (flags & FUSE_SERVICE_FLAG_FUSEBLK)
+		sf->can_fuseblk = true;
 
 	size = __send_packet(sf, &reply, sizeof(reply));
 	if (size < 0) {
@@ -612,6 +617,11 @@ bool fuse_service_can_allow_other(const struct fuse_service *sf)
 	return sf->allow_other;
 }
 
+bool fuse_service_can_fuseblk(const struct fuse_service *sf)
+{
+	return sf->can_fuseblk;
+}
+
 int fuse_service_append_args(struct fuse_service *sf,
 			     struct fuse_args *existing_args)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index e09f53bbf3f7dc..b89a7f1f3df3d9 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -236,6 +236,7 @@ FUSE_3.19 {
 		fuse_service_accept;
 		fuse_service_append_args;
 		fuse_service_can_allow_other;
+		fuse_service_can_fuseblk;
 		fuse_service_cmdline;
 		fuse_service_destroy;
 		fuse_service_exit;
diff --git a/util/mount_service.c b/util/mount_service.c
index df22c1182541b7..6a6a8b608b7c6e 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -367,7 +367,10 @@ static int mount_service_send_hello(const struct mount_service *mo)
 	struct fuse_service_hello_reply reply = { };
 	ssize_t size;
 
-	if (getuid() == 0 || user_allow_other)
+	if (getuid() == 0)
+		hello.flags |= htonl(FUSE_SERVICE_FLAG_FUSEBLK |
+				     FUSE_SERVICE_FLAG_ALLOW_OTHER);
+	else if (user_allow_other)
 		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
 
 	size = __send_packet(mo, &hello, sizeof(hello));

