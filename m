Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877681;
	b=xDSnLUXadTS5ne0bgmFNkYZsAHSKBL0bji9YQcDJ1JUVoMUuLlwNlIdN1ttWBZhJnZNF
	 WRaCCQGK0Rqv/93ZLUPRhvPw7+U+v+fn5XU1IPvvB6ZbS2y66ELYQ0BiNKP7FVpfg8Lqf
	 KSlB0MD6Ru+cMS9804MG4BWdBRjuBTVPdGU8FA7r01mhryUu4ROEQz4xNGUyQag1czhAk
	 77lQtclqmeGY2hwhIq1hpXE7QPLIpA83RR5iIpg9f4a1hdnvrIqt36158LViWjawqFdnt
	 Sdkqv4cqzGTw3DX/dBZ7urKeJipB6v9FyEIWmo1R7/AyfcE1IWaG8H0oMGX2FobawRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877681;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3LnkUBXAkz5ES5BKS7v7PmDSAem9yDZDiG5JW1YUjkw=;
	b=xryLnfoaOBJTTjr/FEB9ScPMmHsTpeudgO6QSkygRpx53SFALFXRaItDsZ7frUBf2ndK
	 LOMQZV9JA4xQq71a70IiBCA2Rf1cxKr9CI16vit+7aPXEoxj1cU3Dgfu2pWlag2kf4YAk
	 dQioH6ayTYrDbvW0YArb493SP4NI9GqyS+AmE5vnsMfjcWnLQHEyX8bU6RBPzD13xQCV6
	 yMQY4yziJRljUO4WR9EjxMtA9cf1kYC/UnxUSx6mLjD/V1DF9IEuD/qC3MoUjqvYLSCIT
	 czW572ddsK9wRSD1dJaJwThbbEn5Ay7Y8kOziIoAGKtb25dAWH1WYoT/c3Tpby7BiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=g+FgX7OM;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E82606A324
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E82606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=g+FgX7OM
X-KPN-MessageId: b6454713-cff2-11f1-87e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b6454713-cff2-11f1-87e5-00505699b430;
	Sat, 24 Oct 2026 23:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=3LnkUBXAkz5ES5BKS7v7PmDSAem9yDZDiG5JW1YUjkw=;
	b=g+FgX7OMUz6mG2JRZFQ7FCrqLfL4nDz/AvvkcVwoBzu0XQ9wu/S4mQTWlPVItxne+fEzrSshNEVt5
	 bl2wgQT28GWTVFgQcN307rLu6cZN5JQ2zohbWfrXxvs9xPD2sQsLXO8pMTaZ6jNlJUB66ypFc+xViw
	 6MSBr0Bggo5+ku9zurx4ygS91NnU2VIqyNNUnIhPi9+40zkAdhUv6bt59BAMULjhZCFhFcOPqmoIkM
	 7qjM4MHQJyjEqGPgWMa78O9pcEy/Vg6KcxkEBmgcYcp3kIF/F6DiG9MLdT2DRGJsmCHVxUQghaQT2A
	 uaIPQd2XVE9iugOi3M7JL8rHbFPGBew==
X-KPN-MID: 33|N0Hwi6qXKs9011soAHiujX85wQLvJ/u+/Gmohp2EtNrlOrp0s4Ov9CDzxSmPguF
 i8OPi22FmY4mHiP8ZuWvcuZHJfm8gTBh28vNAka50I40=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2CgEOpxva7iMN26Te2JrlATfUZs7L1+csMr07Z29DVDZ+0HGWr2Moq547/FsjKd
 OiI3LMrDhgELxY5QVo1NAFA==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b60d8aac-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 07/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sat, 24 Oct 2026 23:35:34 +0200
Message-ID: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting write access on a directory can never succeed. Rather
than performing a path-walk to determine whether the target is
actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
(-ENOENT), etc., we short-circuit to -ENOTDIR.

Currently O_WRONLY for directories is only blocked in may_open(),
which happens after we have the inode for the target, so after any
create via O_CREAT|O_DIRECTORY.

The advantage of short-circuiting is that we don't have to add even more
logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
filesystems that define ->atomic_open, handling this cannot even be done
at the VFS level, as we can't know ahead what the result of the lookup
will be.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index e43f02ff64ac..4334f30bb7ff 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1343,6 +1343,15 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
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
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
-- 
2.56.0

