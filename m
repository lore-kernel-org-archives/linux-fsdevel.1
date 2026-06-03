Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECD23AE9B;
	Wed,  3 Jun 2026 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445759; cv=none; b=unnybG2fQrGbsVsIqPRpfuxJSX2SMdadT1pJ8gaZfPWXsjiOPP9+lQ+gEufu/kYf2E7Uwm5GFpzZ6ucpvae8Yi7C3ux/P9IQbHS1FkQfXy3ehe7neTHXj1Ot7IvynBRNj9X8uzzckT3xtg88CMhwaA14Ku8/fygEg+0uj7LIY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445759; c=relaxed/simple;
	bh=UU4Qp544VeSuC/zSquIF4n6WR+BZ0Ct8yRKZmL3R908=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCIUghLjm1A4+z97z3WPv46KnLgioduzhtAuUBZJ6FZ5nwtACSXchSyQi5yOT9F9bvsMbApdTD/Ss4Q7DzT9nGsaMTOqwI2vD+2xNxQKxOccRF11pm4xASzsD0GJ5MIfJNJsdTp1VaXF/Wjmib2KsTu3XGOpivfflMNRPx9Ovkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkmqLxhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkmqLxhV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5FA551F00893;
	Wed,  3 Jun 2026 00:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445758;
	bh=drkUbm1U0ym+1zo/ltBdp8+dZj405maylbCWXbyUBOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=MkmqLxhVJYEBGe+ZP2jiEL7eEp+NCVZ1Los+47eRsiixHrOxqfoIackvPJ1zVQamh
	 AIEa6lhkPS4y83rvCyM76qLkP6NYXTUmG05GHFSBWBtCxDIgqxQEvqFucC7A0VGIZv
	 kHrI8wxVbfm0SP3R+3YPksDEOC83BEDkIeERTAok4vfPNHGFxfWQv14tSueRLT6HuN
	 0VJ0O7ejcgJl3TDZs6G0qJUuDhBlex8it740c9o8nf8rsmJBueEjuqlP3HVX4fYPqt
	 NMEKFF+atDb/WviEdbXOzas6XObIs/3/CKZXTXE708MYPtG4d1U2M3AhwY0MVB+Rdu
	 ANPMMcDIGFt1Q==
Date: Tue, 02 Jun 2026 17:15:58 -0700
Subject: [PATCH 5/6] mountservice: don't print bdev preparation error when
 quiet mode is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567912.1435997.10187588344693413638.stgit@frogsfrogsfrogs>
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

