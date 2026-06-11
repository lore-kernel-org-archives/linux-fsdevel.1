Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F31A3166;
	Thu, 11 Jun 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140420; cv=none; b=lrp8oArzbzzB3XF3bLxIdUHPLS7sj5LWWKOxiv+exjZj7NeIqlXBxi0nXx+l/f9Ja7O9waVeMPxxc8xE+5tWWozIdHxlXV17dlf/3KDZUo1tZrRjo1Juv4X/1Y5MBSnypTv9T1TL/X/UtOYFM/cjWWQWYyfaHyfWH0u/eQeuc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140420; c=relaxed/simple;
	bh=UU4Qp544VeSuC/zSquIF4n6WR+BZ0Ct8yRKZmL3R908=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcIPOCBkMSK3YKhg/N0Qo7OyD16mpj8c2EMgfJFFKUbHoGPgIPbM/V2X3epQ0OWLXxfjn3C6dbLqNSIS/d3eAdatoVvNwOwCbdQm+BYrF5dVvt2vZFyqux1MGWp/YODWZtsgV0v1NsU+G0swt0GOSjzKksuEC6bsNGF8y7aMpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTOrr2DX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTOrr2DX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C48A1F00898;
	Thu, 11 Jun 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140419;
	bh=drkUbm1U0ym+1zo/ltBdp8+dZj405maylbCWXbyUBOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=oTOrr2DXOG3nRANMSH0m72dmbaapCTx60buJxVQOTkBm8RBL4Kq/LCqv8On9LP23J
	 bLKlZa8FO1PVa9pZn78Wy+pT0U4NKKFLJKgtVPozkapm+iiWtzSmwZ8cg1DERPkDCj
	 h+c15Rcw/l5FeRf6zMmLNHrkefUJeuj6KfP1TX06NI/fFF1XfElvcSeSJdj+xtkLBr
	 4U+J04t0qgqjZML0Ud1lbQozQ/PkKcMwYKCift9jJOorCSw+nBwVSuQzrIINoa1bd0
	 pOMgTyuXj7Jd/OhpMH6PAn1BMGu1am7kXaKZFwMlzs5MS6yr5/abFt9JY1crXIK6I/
	 cI/G83bBgMiQQ==
Date: Wed, 10 Jun 2026 18:13:38 -0700
Subject: [PATCH 5/7] mountservice: don't print bdev preparation error when
 quiet mode is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032662.139936.11186876380152887113.stgit@frogsfrogsfrogs>
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

If the fuse server tries to open a file with
FUSE_SERVICE_REQUEST_FILE_QUIET, that means they don't want the mount
helper to emit any error messages about the file open() failing.  We did
this for the main open() call, but not for any of the code in prep_bdev.
Oops.

Fixes: 5d8b9a39a1cb3e ("mount_service: add systemd socket service mounting helper")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 9890d6cbf028cf..df22c1182541b7 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -710,23 +710,27 @@ static int mount_service_send_reply(const struct mount_service *mo, int error)
 }
 
 static int prepare_bdev(const struct mount_service *mo,
-			const struct fuse_service_open_command *oc, int fd)
+			const struct fuse_service_open_command *oc, int fd,
+			unsigned int request_flags)
 {
 	struct stat stbuf;
+	const bool quiet = (request_flags & FUSE_SERVICE_OPEN_QUIET);
 	int ret;
 
 	ret = fstat(fd, &stbuf);
 	if (ret) {
 		int error = errno;
 
-		fprintf(stderr, "%s: %s: %s\n",
-			mo->msgtag, oc->path, strerror(error));
+		if (!quiet)
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, oc->path, strerror(error));
 		return -error;
 	}
 
 	if (!S_ISBLK(stbuf.st_mode)) {
-		fprintf(stderr, "%s: %s: %s\n",
-			mo->msgtag, oc->path, strerror(ENOTBLK));
+		if (!quiet)
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, oc->path, strerror(ENOTBLK));
 		return -ENOTBLK;
 	}
 
@@ -739,8 +743,9 @@ static int prepare_bdev(const struct mount_service *mo,
 			int error = errno;
 
 			restore_privs();
-			fprintf(stderr, "%s: %s: %s\n",
-				mo->msgtag, oc->path, strerror(error));
+			if (!quiet)
+				fprintf(stderr, "%s: %s: %s\n",
+					mo->msgtag, oc->path, strerror(error));
 			return -error;
 		}
 		restore_privs();
@@ -798,7 +803,7 @@ static int mount_service_open_path(const struct mount_service *mo,
 	restore_privs();
 
 	if (S_ISBLK(expected_fmt)) {
-		ret = prepare_bdev(mo, oc, fd);
+		ret = prepare_bdev(mo, oc, fd, request_flags);
 		if (ret < 0) {
 			close(fd);
 			return mount_service_send_file_error(mo, -ret,

