Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800233937F
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734199; cv=none; b=tN0yW5QHq0Ey4jdjEf+BZ4xy+gIjbQPZVBi5IIl0WbY9kWUVHSHNTH/CWhTUncTeZ7kaU9QKBedFlVcmWAMbIQR/BIXay3ALM1520RbWuvKtdOP39gwCKuve+wqZSQL1Q4RripF0k0yLBo+RcUMa1kU/08T5BBY5QFArF6OaXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734199; c=relaxed/simple;
	bh=gvo6MOK6lqJ1FkyebzyJk2PycICkreurExdyysJIvWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKx0GelFVJqLC4aey/PYPS4tJDcD0ZuD6ZsCJnCDz+tsmxODFznohfK4bEZcWhs1+NuoefZywLMqBrSFKKKSHi4VA00J7Hcsctbb/2Y4U7GY7T2it+g42lrcIVvgCLDJbW/vDVYsZkNtOQzPSw7RrlekXEGkpP/QsokKDh36VTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMRvPp+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMRvPp+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA52A1F0089B;
	Sun, 11 Oct 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734198;
	bh=SrucIlZ1WHLSfxQc2Yyuezp0ciTQ7w94qOl8Gr5aRC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DMRvPp+gnrwoQDxEkX2ozar02Uq2mxHBG4vGR+oFiIpRn5UDdiDRkRmvkG4HAWlpK
	 RZV9vwRwc1fUEwyak3miU4/jN4i/ODCCoGy7T68NcE3QhWgvcSW/lhYj+CzQeWt7aK
	 SWIfZGOz7fgJuq3ax6HPhUJSvucoWkDrc6vs3zJzjGcTpcgzgzvdh8eWN5yd54HR5Y
	 SbHTfpCazur8uyANH0Mz419mF++5ONhMDA5vPaeOL5qIdpOxZlQHMjPDsfjzo5MX3/
	 g7Vj9M+hKUi5+m4yeYPiKqMhBH453jqSPYEcshoj9WheeY3Up2PxmdEOu9rQeotkM8
	 Z/Uozig7shFxw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:13 +0200
Subject: [PATCH 13/15] super: remove SUPER_ITER_EXCL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-13-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gvo6MOK6lqJ1FkyebzyJk2PycICkreurExdyysJIvWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjnbrrXTDHLN9/E1/YxJS4yao/fOfl9dJFtp9nGp
 BslcuH7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSsIiRoVv2Qc9dd2ObN+Xr
 jac9Dvji/WGFi3zssaM1tx+5lJVzhzH8s1p/+sWJAJHvdiXdDNtZFqmHyfwP0wjvkLNfuVBoUdF
 qdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that do_emergency_remount() takes s_umount itself in its callback
nothing iterates with SUPER_ITER_EXCL anymore. Remove it and take
s_umount shared in __iterate_supers().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index edd5648d1720..657958a1d135 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -935,9 +935,8 @@ void drop_super_exclusive(struct super_block *sb)
 }
 
 enum super_iter_flags_t {
-	SUPER_ITER_EXCL		= (1U << 0),
-	SUPER_ITER_UNLOCKED	= (1U << 1),
-	SUPER_ITER_REVERSE	= (1U << 2),
+	SUPER_ITER_UNLOCKED	= (1U << 0),
+	SUPER_ITER_REVERSE	= (1U << 1),
 };
 
 static inline struct super_block *first_super(enum super_iter_flags_t flags)
@@ -959,7 +958,6 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 			     enum super_iter_flags_t flags)
 {
 	struct super_block *sb, *p = NULL;
-	bool excl = flags & SUPER_ITER_EXCL;
 
 	spin_lock(&sb_lock);
 
@@ -976,9 +974,9 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 
 		if (flags & SUPER_ITER_UNLOCKED) {
 			f(sb, arg);
-		} else if (super_lock(sb, excl)) {
+		} else if (super_lock_shared(sb)) {
 			f(sb, arg);
-			super_unlock(sb, excl);
+			super_unlock_shared(sb);
 		}
 
 		if (p)

-- 
2.53.0

