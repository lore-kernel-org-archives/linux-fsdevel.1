Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB7346E70
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501179; cv=none; b=IBDoF0Sz6biewtKLNSUtN8N5MemiBCWlmHAjSiZ3VnL3zEWbcONm8IlHfHe6XWs0R4sCWgEfJThAqgAYvYuQXR8prHjXRNSlJnNfpturd9Y+lyq1FzNV9CgMs5ApSrqlt20sIhX4zLxNvwOCTNQAi8puD8Y0Y3eH+ODVBNp7n/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501179; c=relaxed/simple;
	bh=J36fVG2Gop1jTPTE0Lzk+Nipg8LtgBVKtOm80+fB8JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry6FKwvNDuSMhZPvyXpdOSIodrHqH0ACDwUISODC8L3LCq3C3CPayc3TPhSiFc9fTMoR8Y7KBo2fzupsm2SQzjV0E8QxoAkzQiEwjhLh1AjEGAB/wSAEk/koTcfpealSc9CWqLESwJe25oUKSWKANWpAJcO4QFJnJVebaw6GLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lfU1gwUT; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lfU1gwUT"
X-KPN-MessageId: 90512e8b-9f0c-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 90512e8b-9f0c-11f1-bfbb-00505699b430;
	Sun, 23 Aug 2026 18:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=I0mBoC0NDW7esUAmw5xGbkSmt0K3Ofsyt4PIap3Vlt8=;
	b=lfU1gwUTUQ/J1Z8ama4Jcmb3NVruyF261VaIs7JHmKeTPPT50SLFz9AvGI/HpjLOlaBhJ3m5W6CYr
	 xSNq6ym0n/Z1FnXgSSoLfbPRELS3Kd+GWwLUoi9m8Zp8wcfP3GLayHSLvA8riVtI93lvigWUQqpYWQ
	 NSxK9Rm2XX5n1YGyUJFxfCihPe9vkMVnpgVqvhWG4Ll6Anh1StSAPu2lWjua3XV/i2VCvZCVzqY1UQ
	 9R2bOaqlq02tT90Mtm7VpEwD7DztfQNEZ4q4WaYA9bq/JBPNyPCgIY7LK9ZvrttTgGacXwb5QVp+MU
	 x8DqJh7I40URAcwreaPqOEBUzw/sf2A==
X-KPN-MID: 33|MLSMDmiIUqpjUJLjXUU23b1NIkip/N7AFqmQVW3wqjUX+AIMTyWFhH1/0/9t5CL
 OZoT1X13j2SRAxRQnXpfHXRkA+Qbm30U2ABXi9uI9vfs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|trvADC78DfaEI+9dDVQRk4aMhhsvoJauKDLsNKnPGNwlRu57NGiyvwuJ1Z9EXnn
 nYLnp7ynTLqSKYLmz9crBpw==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9015fc0c-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:13 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v5 09/10] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sun, 23 Aug 2026 18:07:05 +0200
Message-ID: <20260823160706.358293-10-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting write access on a directory can never succeed. Rather
than performing a path-walk to determine whether the target is
actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
(-ENOENT), etc., we short-circuit to -ENOTDIR.

Currently O_WRONLY for directories is only blocked in may_open(),
which happens after we have the inode for the target, so after any
create via O_CREAT|O_DIRECTORY.

The advantage of short-circuiting is that we don't have to add even
more logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also,
for filesystems that define atomic_open(), handling this cannot even be
done at the VFS level, as we can't know ahead of calling
->atomic_open() what the result of the lookup is.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 189af02a2425..6cb5e2ad781f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1319,9 +1319,16 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
+	/*
+	 * Requesting write access on a directory can never succeed. Rather
+	 * than performing a path-walk to determine whether the target is
+	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
+	 * to -ENOTDIR.
+	 */
+	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WRITE))
+		return -ENOTDIR;
+
 	if (flags & O_CREAT) {
-		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
-			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
-- 
2.55.0

