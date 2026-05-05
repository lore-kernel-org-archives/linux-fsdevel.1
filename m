Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C13AD538;
	Tue,  5 May 2026 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958663; cv=none; b=GtHYNzO/M1xJSueMtS98WhHrWy7TGmwwTw60rymjAd/6MtXBjj8993jgwRWHxNDJ7LmfO7Kmg+43nm1VPN+owx0y5cc3jSwIK/PVpbUpe4ZZPyrokcq5jX1onfIR2g+pM7JQhkariQq4mrlqTtWc7ubt3vhMbKzsuqbPHiPdeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958663; c=relaxed/simple;
	bh=OUBMm4IAJ42UB4hA8qUKoXXNZ8hoOPbKUUq+yJZQFQY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obIogxPiulQjx3hQvuiRQikkd/cjahilsUsD52ic61Ed+pj3JsObgBVotgtdCyjtjzGMN/zQKzfWCEpG+a3OSLPCHpwCRVdN6i1NojFibI+/8FipVcJZG5Yx4Mz4TqkxP8EyyRAu4Nj2wYXGI6pcH8IUvnECbR99vn7s0IMmqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcmLfmo9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcmLfmo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D66C2BCB4;
	Tue,  5 May 2026 05:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958662;
	bh=OUBMm4IAJ42UB4hA8qUKoXXNZ8hoOPbKUUq+yJZQFQY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VcmLfmo9EgxFClNGgUhuEpoMU2u95Uieri3XRTJjxQlRwXi5JjPAQcCo8jNjD9ff8
	 nTXYZ98V6gPR/woKOb+/94sqegTLIIhVJB+Q5xDgxwigkSTzo9cGdIt30HX4axrH/W
	 +GLs59MUmTOCewsSmJ+BsDV9WHYs6oI7NOQ7wXf8MH7M2W7vWBShn7QhQdhkrsqo6x
	 Qonk6Pi0N3KhEWzqTiR2cf0MKVxFP6adgyNrpJ8lVyEd2EObA3Y8Pc2Zvij0nooJzb
	 d7rIKfAutuJnn7MT+lDLq6ydRzgyzNEkGhDLjWpaP3VXCeR7CAMUbfLg+PNMdQAWnd
	 pBpHhjxsrvZlA==
Date: Mon, 04 May 2026 22:24:22 -0700
Subject: [PATCH 02/10] fuse_service: handle weird behavior during SCM_RIGHTS
 fd transfers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853722.1133612.17708182364255366948.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix a few problems in the code that tries to receive an fd from the
mount service helper: MSG_CTRUNC must be handled if an LSM denies us the
fd transfer; and protect ourselves against the kernel never actually
writing to the fd array.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_service.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)


diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index e9a8ddc0912362..240b1107296849 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -64,17 +64,28 @@ static int __recv_fd(struct fuse_service *sf,
 	union {
 		struct cmsghdr cmsghdr;
 		char control[CMSG_SPACE(sizeof(int))];
-	} cmsgu;
+	} cmsgu = { };
 	struct msghdr msg = {
 		.msg_iov = &iov,
 		.msg_iovlen = 1,
 		.msg_control = cmsgu.control,
-		.msg_controllen = sizeof(cmsgu.control),
+
+		/*
+		 * Do not include padding at the end of the control buffer,
+		 * because we don't want to receive fds that we weren't
+		 * expecting.
+		 */
+		.msg_controllen = CMSG_LEN(sizeof(int)),
 	};
 	struct cmsghdr *cmsg;
 	ssize_t size;
 
-	memset(&cmsgu, 0, sizeof(cmsgu));
+	/*
+	 * Set the initial fd value to -1 to signal an invalid fd in case the
+	 * kernel doesn't write to the cmsg buffer and doesn't return an error.
+	 * It shouldn't do that, but we absolutely don't want a zero here.
+	 */
+	memset(cmsgu.control, -1, sizeof(cmsgu.control));
 
 	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC | MSG_CMSG_CLOEXEC);
 	if (size < 0) {
@@ -91,6 +102,13 @@ static int __recv_fd(struct fuse_service *sf,
 		return -EBADMSG;
 	}
 
+	if (msg.msg_flags & MSG_CTRUNC) {
+		/* SMACK does this */
+		fuse_log(FUSE_LOG_ERR,
+"fuse: service file reply control data truncated; did an LSM deny SCM_RIGHTS?\n");
+		return -EBADMSG;
+	}
+
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if (!cmsg) {
 		/* no control message means mount.service sent us an error */
@@ -147,7 +165,7 @@ int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 {
 	struct fuse_service_requested_file *req;
 	const size_t req_sz = sizeof_fuse_service_requested_file(strlen(path));
-	int fd = -ENOENT;
+	int fd = -1;
 	int ret;
 
 	*fdp = -ENOENT;
@@ -182,9 +200,12 @@ int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 		goto out_close;
 	}
 
-	if (fd == -ENOENT)
-		fuse_log(FUSE_LOG_ERR, "fuse: did not receive `%s' but no error?\n",
+	if (fd < 0) {
+		fuse_log(FUSE_LOG_ERR,
+			 "fuse: did not receive valid fd for `%s' but no error?\n",
 			 path);
+		goto out_req;
+	}
 
 	*fdp = fd;
 	goto out_req;

