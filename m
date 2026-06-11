Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEA1E8826;
	Thu, 11 Jun 2026 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140436; cv=none; b=fegKnt+cSHBihxdarXIGNHYJ6/J31W4OxndHP2/BpRJmKRYCaMcPW8Kq09//mwE7mhUZRnKmphpvcyYbG60PFVvRGpUCL8fRKD0+A6YxseqwtOKug4tj3lzGdXKiFC3egebtbUDGkU064b/yaG2RVbnZEWoCH7qrYMQdY+la8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140436; c=relaxed/simple;
	bh=tvXxzLHOEuoVCT9L6qDg4CwL8rgWyRtCfQnHG7pUAvM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgI/YlcBz7AawE7QdUVuOFnYQxzzL7bGTlnCcMKwIvohUEs3IXAQuDDrx2Pxu2wvnp37lb/nymzF7ohcu+yYHKVBalTHyWPFSCJvtH7hfYBfA9JuCiQps6fV+QYl6rE4GE2RZsNLk0uGfilNlVuOvO8g7AGAp5KJqzFf4FO6m8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUZv+sPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUZv+sPQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ADDC01F00893;
	Thu, 11 Jun 2026 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140434;
	bh=yAE8WmIXXqnC5QVR0nCudpe2O6RMMQz7NsMcH7lWAeg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=XUZv+sPQ03kEre4kpuwQ16rxfy5cDb0Oh87iAT3qi33dngosEAlXzX1dqjHbhMnJb
	 VbcXpLrEyqbqmS4nuhrMfX4JM5xcbckoJF7OHMHFMoy6/WtPPn0t+4JfMYV+oBFDNR
	 rx+Iwb3oSX6wbnNrgYzG3G4Dr3J1xC7d+UeCGhv4IyfTXnMBwifZljwHH8x0qto/fm
	 io08Hq4W+iWehhshKPQmp4pa6YBL6NNPeMgupCzGteuygGl7XK3sSECdYCLknHT1Us
	 Irx34zx0RDXwLYlx1+0QnehZMGz2uDVd6on5hn14o83FLNh/fFgaMp2p7yuaKEUP0c
	 2jsrwVoQendDQ==
Date: Wed, 10 Jun 2026 18:13:54 -0700
Subject: [PATCH 6/7] mountservice: advertise fuseblk support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032680.139936.4999896847995382064.stgit@frogsfrogsfrogs>
In-Reply-To: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
References: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
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
 lib/fuse_service_stub.c     |    5 +++++
 lib/fuse_versionscript      |    1 +
 util/mount_service.c        |    5 ++++-
 6 files changed, 31 insertions(+), 2 deletions(-)


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
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index 1e27f5ea0c6b57..44aef47e351388 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -59,6 +59,11 @@ bool fuse_service_can_allow_other(const struct fuse_service *sf)
 	return false;
 }
 
+bool fuse_service_can_fuseblk(const struct fuse_service *sf)
+{
+	return false;
+}
+
 int fuse_service_append_args(struct fuse_service *sf,
 			     struct fuse_args *existing_args)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 19caa1fc9cb2cb..ab79209008595a 100644
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

