Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0E1A3166;
	Thu, 11 Jun 2026 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140404; cv=none; b=PoN0zU667jDJgOfBcbZ2TEWDdcbr7BYKrcWhDGCDtSdSUjPPk1xUyVRS4FjIx8lxXHUHDSFhSvVakBR4+4H5Jo//qrcVlMnCsQA5F8S+vxwqcZhW/g2zVSQDgS3oV0T35G5NCq7W/qw6iKiPizVqgZBO6fv/noyrFm+BnZS//BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140404; c=relaxed/simple;
	bh=gd8wDR9v6cnB8VzIFp0lzMRpBN0Z3IdiSBdLtFeeWek=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM4gGMd4YYqjephqihBLO3WehWYaLPRrgizu++XM1tOpRjQhuWzZt86uZWl+3zu0vy4YGWJcU5B85/jMex7PXaLPAI06/u8qUoVHH2Qv/rxYigMfGqDYun8mO+dhSF0srRuaz5iN6luIsLEyn/z+t5XVaYgBRF03GZsORLyPqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFAKsSSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFAKsSSt"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9EF9F1F00893;
	Thu, 11 Jun 2026 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140403;
	bh=gSv9Pr8q/0JAfHzT/mySCm8uHyYxHXTJqvtNqeIRK+g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=MFAKsSStGi6zfN1EIOO6kASGDpe4Dzo4ffd+aHE/m6cssofdpZ4AFSUS4r4WTt+Cx
	 WvVEtfrj1X79k2mAXHTPB5e5Gizmf3O/pc4RrqfFQYyzHO44Ff6krkuN+dHl6SmD27
	 XCk7FzM2qXuDfudwQO+fA2S7LFnmyLd0W/FViTlXanclL/r8uD7KeiZEG/DS/EBLVc
	 +ChjDturGUNB/bEWFEqHZlNApb04gsRxrtuEInpIDB/YvlcJ+zlXv6E3bTgDCICSPG
	 0EXRFUUm5noixVwyJMCubAneSCrCEfDfE0jVAFSJ+ZrzguaZrHFBrlAy5Fzk7Rwd2F
	 ob5HBSStNB1fA==
Date: Wed, 10 Jun 2026 18:13:23 -0700
Subject: [PATCH 4/7] mountservice: improve checking of protocol version
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032644.139936.6490958742797698670.stgit@frogsfrogsfrogs>
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

Codex complains that the protocol checking here is too stringent.  For
example, if the mount helper advertises min=1,max=2 but libfuse inside
the container is older and only supports protocol version 1, the second
check results in service mount failure when we could just use v1.

Fix this by requiring that maxver >= minver, and then looking for a lack
of overlap between what libfuse supports and what the helper advertised.

Fixes: 5d8b9a39a1cb3e ("mount_service: add systemd socket service mounting helper")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_service.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)


diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 61d1cdf3f1eb86..7fd10211dbeab4 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -449,6 +449,7 @@ static int negotiate_hello(struct fuse_service *sf)
 		.p.magic = htonl(FUSE_SERVICE_HELLO_REPLY),
 		.version = htons(FUSE_SERVICE_PROTO),
 	};
+	uint16_t minver, maxver;
 	uint32_t flags;
 	ssize_t size;
 
@@ -471,15 +472,27 @@ static int negotiate_hello(struct fuse_service *sf)
 		return -EBADMSG;
 	}
 
-	if (ntohs(hello.min_version) < FUSE_SERVICE_MIN_PROTO) {
-		fuse_log(FUSE_LOG_ERR, "fuse: unsupported min service protocol version %u\n",
-			ntohs(hello.min_version));
+	minver = ntohs(hello.min_version);
+	maxver = ntohs(hello.max_version);
+
+	if (minver > maxver) {
+		fuse_log(FUSE_LOG_ERR,
+"fuse: min service protocol version %u must be less than max %u\n",
+			 minver, maxver);
+		return -EOPNOTSUPP;
+	}
+
+	if (maxver < FUSE_SERVICE_MIN_PROTO) {
+		fuse_log(FUSE_LOG_ERR,
+"fuse: max service protocol version %u too old to support version %u\n",
+			 maxver, FUSE_SERVICE_MIN_PROTO);
 		return -EOPNOTSUPP;
 	}
 
-	if (ntohs(hello.max_version) > FUSE_SERVICE_MAX_PROTO) {
-		fuse_log(FUSE_LOG_ERR, "fuse: unsupported max service protocol version %u\n",
-			ntohs(hello.min_version));
+	if (minver > FUSE_SERVICE_MAX_PROTO) {
+		fuse_log(FUSE_LOG_ERR,
+"fuse: min service protocol version %u too new to support version %u\n",
+			 minver, FUSE_SERVICE_MAX_PROTO);
 		return -EOPNOTSUPP;
 	}
 

