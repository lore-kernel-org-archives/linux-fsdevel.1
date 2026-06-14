Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3A3CAA5F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455434; cv=none; b=Ly+b3lqrWQNNiEYsw5PbztMh8WSJO8qNh2sbjytnOh7+NlVdFUeKXLrmIqJmdsQdTGxZz5xEc8Bv2vzbBsSE9/W9u0dAHM6gSvI+59S7Z8jkXkKE9KGAKjmTiwB0IuTZGnqRAh9Yg9Z0KkpJ0ixVY97aPTFjm6Gei1lNXnmW0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455434; c=relaxed/simple;
	bh=vo7rjDIEyHsk7g2mBlD4eMsivaLrS3Y5ct95VGbMyvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxoIt3skKge4x1YoekQDjIc+d8Y+ubTmjTBtS0YMFd1Ir+0CUEzlDlWjorhJhPKCHx3YJa50y/gxE2WtAtIzsBVLecln4gNevUYn7VbWAiyilB2gwbFY8tQhEsFlRerHKvwm2+fxNF3HHoCKXofqOwSRiirlq/2ti9I+GVPB39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=EusoSoAs; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="EusoSoAs"
X-KPN-MessageId: 38b2929e-6810-11f1-92b5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38b2929e-6810-11f1-92b5-005056aba152;
	Sun, 14 Jun 2026 18:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=u0VpG5Ql1nMdy/6hHBpNIaQEWY7pDWqi2izElw+7Smc=;
	b=EusoSoAsGbw1AOQzhZ8bnxnXrpFKsaKOcyPaEF1lp+iXMeosEKNen5nmSNqbTqWD9qi9sByzynKK/
	 5dbtDcJE0Ro3KWJKV06NzTYUfQgTOtI6LMxDN5/ARnMrbA5K2OfLmJymPEfBMcHUmvCekbSO2YkpXr
	 JNXwMXYWjO8dKO+fV8Uy8VgE0G/i8p1s8rJvbdfKg7rn+zxrmW85LMJr3qqde7BJZ3C3wPH/jIfurn
	 BBEYOUd5tumWbidMluCTS3kclbk1hEbOru+JO5iC4EYfp6XGrdqvg3AOeEEMTv0n3Io/7Zt7RYl+Ed
	 rOXO7f2zUtkHAtQK+3r34rP/zNl6y7g==
X-KPN-MID: 33|SOYc5j2qteyvMoNmAs3H8WT2b8kbzqyzFmTM6uX9c47vWGOPp3HfJ3i1MPWB0hZ
 CRvBv2sPV0T1O59noC/n5wh2eZkK75QCRX3HElCeaDcg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|y5MQgpvJ70qDwDh84WVorfoRee5uglMSnW1SqE2w5/78QNMP6BdkwyZrwQdMLgq
 Um16yN7cQ8w8Ly0t5GvUIqA==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 387f2690-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 11/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sun, 14 Jun 2026 18:44:37 +0200
Message-ID: <20260614164438.2980769-12-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting write access on a directory can never succeed. Rather
than performing a path-walk to determine whether the target is
actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
to -ENOTDIR.

Currently O_WRONLY for directories is only blocked in may_open(),
which happens after we have the inode for the target, so after any
create via O_CREAT|O_DIRECTORY.

The advantage of short-circuiting is that we don't have to add even
more logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also,
for filesystems that define atomic_open(), handling this cannot even be
done at the VFS level, as we can't know ahead of calling
->atomic_open() what the result of the lookup is.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 5cf8ada58483..be980a737c82 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1268,9 +1268,16 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
+	/*
+	 * Requesting write access on a directory can never succeed. Rather
+	 * than performing a path-walk to determine whether the target is
+	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
+	 * to -ENOTDIR.
+	 */
+	if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
+		return -ENOTDIR;
+
 	if (flags & O_CREAT) {
-		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
-			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
-- 
2.54.0

