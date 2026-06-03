Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC620010A;
	Wed,  3 Jun 2026 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445744; cv=none; b=XauU7kJxvMPh3R+JgRO2oOMwSIrbApAblv0HqMlYoZMW5qP6V7C7h0u3+gkO4V5XFC+KmnJ5lDP1mD6IAUz9DUQnvOItLm6TfSikYeFy/4UTXyq2qHd3aCj1sMHnc5lC7isH+ka6gQY6bgHYsgV6rgUgZZuFLHkoGcDHbI69AJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445744; c=relaxed/simple;
	bh=gd8wDR9v6cnB8VzIFp0lzMRpBN0Z3IdiSBdLtFeeWek=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4u4++wLgJbWCu2kCXSN2N8GVFoe5U0HTLU9ZmRx6WTb+wA9u3cImoZnDnxZNdn3B58+3SbLZEmfMidmuWrm/2/hihj1+1Z2567tB+ajgAAWdpqrUvvdsn6oaC9oVEXkpI76smKKtDoy5o6+W7Ymp4GwQJwTcgegOwPmOiZC858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bosqbgA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bosqbgA+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D14C81F00893;
	Wed,  3 Jun 2026 00:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445742;
	bh=gSv9Pr8q/0JAfHzT/mySCm8uHyYxHXTJqvtNqeIRK+g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=bosqbgA+paZeYZkbP/5RT4Ev0NW1crZoK2kfrJqUkpGB2LosLP3mT6q7Me2oCZn07
	 HxBi2kR3eRkXKPu7NJ0KdMO1tiBTakKIOBSYsBdavBJuGDSHlbHhc7ZsMtGibDPe/A
	 Ll/iSqv0oayth0fgiTZXRzaJHNcvV+gKB+kTC1fPikWhqhKw2HLXKKHSLyh7p/Hpj9
	 rW7/h46jgsnVGL96ZO++pyPFaITCKB5MrCW/Cqsw6XC7OkCM4WDbBsf1QnM/B8Qn1j
	 Lly8vToxS525iWPBeo/2me4lsWdUzDxLTt79EDHsdNEKtbLZVDRFIdmnBc6Exjt2dB
	 IwhJs0ZJCR+NA==
Date: Tue, 02 Jun 2026 17:15:42 -0700
Subject: [PATCH 4/6] mountservice: improve checking of protocol version
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567896.1435997.1499306550078259526.stgit@frogsfrogsfrogs>
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
 

