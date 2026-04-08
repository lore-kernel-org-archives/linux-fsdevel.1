Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E43D8917
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671919; cv=none; b=foDXq8i3AWR7Vi52o/1n+iLOX4I7gYMMqKtLBmBA6+rynJ6yI8hL/E5C+6bxRVn03qrsVn+sawNgWCpMmvqsT+DJswrOQZS3BCXosR5tBiSLOg0elasE602ZtDXND4FewHl9OwP7qg0oq0iN/i/puvUh5BKFW2nUTPBHCry+Wps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671919; c=relaxed/simple;
	bh=Zv0tNE5niA8DJZx9zdKIp+Usa6lQwTQeIL24T6SKXUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmFwWSamtZyll5f/x/fj1NC5Rea8dDQ2FHCecEg2hmEOjAp693R++hySOOe+2GhegXnvfgfqlUklGZDANW+FlZpO9Hxa8vyQhC2gu5cMoU9tVTvm3+klEXeHHjXl3dLAQTUghr98QK3FxDMPuDjQqwxYzH9c4zzfJxTbbaAijCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Lm0fBuaU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Lm0fBuaU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7991db3dc98so399317b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775671917; x=1776276717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5akrb9d7BApoz1cA1NMQjcGhi2drcsvjolQqKfTVzo=;
        b=Lm0fBuaUO1aiMPyKjB1FsSlLYrG6wRBShbU8eLG60BIOt7q3jFnTnMImnYS0a4Fh8l
         fC0HqXDvGHLgpdFKh2M+/IEV3JaVXAACIDJP10srncYy10D/qTdDrSGsACFrhUmX1vyA
         +ZiZcwS0iT9CsrgUnfviyZfv3d7PBAfvwyNrN9v+1wi0prfF5flAVfph4hLpqCDu2Eqm
         I+bUd+bacLw5xeW7MS/nzT6ZNK+FwV0hvThFp8hvaxi3dpEQJByUpCFJG+S4VujkXTYm
         Po2uPcBosnK+NnM33z8IWDU+ocrzCrmgX6z1/IfjkeN4ZXrtUKgJtI5DNxp+VdqrBxiz
         RNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775671917; x=1776276717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5akrb9d7BApoz1cA1NMQjcGhi2drcsvjolQqKfTVzo=;
        b=dOm5veBaWaCluSB2is1guJoshi/AChu7ntXJAMSSR/5sP+rYPlTzOkJaKfarfb8S1R
         Il00Qo9BcZjm51Tnd5HVV9Mw8hJVHGaOeF7uTIjy8pwZWobkaf8GWuAKpY+6592tbGq9
         m2m0+r/+qdJydQbFOubRLWwvACCoFWytqjq+7Iocn+0zmWSqpQFOfHQpLyP94+CHqB9x
         po3npL3ohPAQGI1XB0rnUw7aFlRTqMoe/K1ib15jFiNpBv2I8hO9htajavmQWR2VRyyq
         MPod0S/yuYZwWG14azTdM1Pl2IGo7DYAPL5xVM6OTaHzATznYWQuljg0NXl0cPyqX0CY
         MuJw==
X-Forwarded-Encrypted: i=1; AJvYcCWqr0mIVSCDDP2sQqhCFiIFdOxEQE4rqbHLD90ubm+6MCDMKf8qvjAyEfTT6YCtsJghV8Fnl8tGR+ZEKg6G@vger.kernel.org
X-Gm-Message-State: AOJu0YyhikO/fyoJ0Aqp2SHkgu7R6Rsh3PTGd04QTOpCIQ0Fv8+8cLe8
	lq0y1/sVTlSobpkyThCn5pLg3YUzdbCierZDj/FBjN0oJOVAgLek3g04v6YixqChITk=
X-Gm-Gg: AeBDietz8Z/V/j37vwN8bIVuxXv766ZpIZvkTBo0ZQODUHRT+JdSksgG58aFhmtRmNz
	4zpuob+FRbMZ8HvNE5Ty0CltNHmrVVqdKswvb5zD6GATU0VtXaljiwc+ji5zs1p8ShDRpBV6aXz
	maA7hj+vahPKbRgr0qxDBgmKz1FeaTAL70Jlm1vGE3Mh0EIiao+Y92rLVnWQe0mun9e13gtthWu
	LTrijSAYn0Vmr7LMl3JUR0jEw6y0k69/r77A+GDUm9j61FX9UltjUk0/IOY9eQtHXYFv/90Kag/
	8JSFOtRMveaCseYeCJdoEuEwNSbzPHa1PIDETouu4TgtOqNwXU2BIPXCngpaadrPw7juHs1YWxG
	uqbPYSfySHAVMEzPMyCEg5DblsMzteojvougxZnOsis6TVrxrjlCuP8zx9QO732eg4rSVxGp2Ns
	mePKpejinQNJlM+zxA45CTY5D2TBFLmunW6+7NvdlQRXSSJIIKl60wJx9BWCjWZu1Io9eB2MVx3
	Grtr0DfzeY+XROjydKtcZQaw+XK5hM=
X-Received: by 2002:a05:690c:c50e:b0:79d:9d85:3622 with SMTP id 00721157ae682-7a4d2ff2044mr200468557b3.9.1775671917239;
        Wed, 08 Apr 2026 11:11:57 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:de59:1272:6c6c:a235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef4af8sm91417037b3.41.2026.04.08.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:11:56 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
Date: Wed,  8 Apr 2026 11:11:24 -0700
Message-ID: <20260408181123.310291-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

When MDS rejects a session, remove_session_caps() ->
__ceph_remove_cap() -> ceph_change_snap_realm() clears
i_snap_realm for every inode that loses its last cap.
The realm is restored once caps are re-granted after
reconnect. It is not a real error and thsi patch changes
pr_err_ratelimited_client() on doutc().

Every quota methods ceph_quota_is_max_files_exceeded(),
ceph_quota_is_max_bytes_exceeded(),
ceph_quota_is_max_bytes_approaching() calls
ceph_has_realms_with_quotas() check. This patch adds
the missing ceph_has_realms_with_quotas() call into
ceph_quota_update_statfs().

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/quota.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 4dc9426643e8..0fa0e7c4b52f 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -231,9 +231,14 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection.  This is a transient state;
+		 * the realm will be restored once caps are re-granted.  Treat
+		 * it as "no quota realm found" and return gracefully.
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -343,9 +348,14 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection.  This is a transient state;
+		 * the realm will be restored once caps are re-granted.  Treat
+		 * it as "quota not exceeded" and return gracefully.
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -496,6 +506,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	u64 total = 0, used, free;
 	bool is_updated = false;
 
+	if (!ceph_has_realms_with_quotas(d_inode(fsc->sb->s_root)))
+		return false;
+
 	down_read(&mdsc->snap_rwsem);
 	get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYTES,
 			&realm, true);
-- 
2.53.0

