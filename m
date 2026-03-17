Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B82C3254
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730799; cv=none; b=h6/TA0B4gtxLVg9IC/G9hBOSwxmnJA4TxR9uAn2mxf+mG5ulOeI78MimNct75fGjHowVq1eG2UTtkjKa5jadR+oAcnfALGFIIbupRmizNZX3q46GolCF8Vnma/CWfrGkpzK8+YXvEPj9y0TdqdCjDTYMVxW8Uta2AJ6ntxjVGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730799; c=relaxed/simple;
	bh=PE/xwOtz5UEtew4TT2ybzPmFU4GLZmECY3xYTXuJ8wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKUnuaSDDoohDG2dDznOil/818L/7ufI+1an+OP31qUkShOGeDHdADLbw1h3LwGrYVjlwX4hRjTLHEnJ+MuwXuQ0YQssJBY1qWn3KHumrPYqUpRtFqmq4RK/FzTE2xZGQJVfho+RSC/tzja79B9ockq46jlmDizKw0CvVwYnvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClQkfA8r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO1lEYt/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClQkfA8r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO1lEYt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773730797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ7ReJiYk1/9BPyCWPykLbLN3hvYPlD1LepuFJypFgU=;
	b=ClQkfA8rSNBpsBSE78WzC7ohmcPxLvxkscnQrW8a5awP8yC4rmdRqyQCEPvdhat7TZ6aX0
	T6alfaAk0pjTY815MTSdd8gKdfIgCLKlAE5uioku2uV8UmfoHuzsTvtkK1XoaH95kSZCgo
	7B3J7IQUPazyvmaxu9hKcOSpuE0+wX0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-BUf3pOgBMP-tByTMwHJLfQ-1; Tue, 17 Mar 2026 02:59:55 -0400
X-MC-Unique: BUf3pOgBMP-tByTMwHJLfQ-1
X-Mimecast-MFC-AGG-ID: BUf3pOgBMP-tByTMwHJLfQ_1773730795
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509177a915aso43717421cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773730795; x=1774335595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ7ReJiYk1/9BPyCWPykLbLN3hvYPlD1LepuFJypFgU=;
        b=MO1lEYt/SVmfXG8R0tue/X4q2tpse9hiltAyMKg0vT4wfUFXwcH0Q2rDJZXNB1hm9V
         89bjHwn9zqVAljIkdj4hcaFrUOyIZDRkEml1sDAwjJ/xmgPAIgOtFExCo0+ZBy0lSC8/
         ja5bcyeXnvYW/PxMSscEga2BwQhGqu2BUYX+r3XLR3gyCN92KinOv7bfC9StoRm680fx
         PgpZ4xgFuc8/hpaC73Sum+iryMjxh7FUUYo8IQI/Axt3b8fF5Y+rPq5DkA1HyDdTZ88U
         Jg9BK+FM5GKuynnxAtcpoOlA6rlU5N+MBP7JjeGWMvGXSBypfypJ/H9r2A8vu+2op3Aa
         F7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730795; x=1774335595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZ7ReJiYk1/9BPyCWPykLbLN3hvYPlD1LepuFJypFgU=;
        b=B1C2kfMdZDxAWuBxPn4FJ7au60Bq/YF6KkvNCeCCa1+Bov0RH1HochR0bMb2ObjaJU
         bISuvRCeRGJ8595bgSohTo2VwVa0B1GPKX4CX5CMJBm280SKNuJqne10wA3MMyOENnAL
         qz3yvkylk5+Yw84b2jQlMo615iBP5Q0AlcvmnRUy17DgSxdW0qNqcvoVB3VgpQXWIKBE
         jkaZqwJ1zx7v4iVfV9vvI3auobjDqBK6ktN5xZ1Z66qvw+KVoFhGvas1mdGIFExUu4vm
         vz5gaQ30Jd+81HIupJvoOdPkCtlo2+JduEd2CTcll7dnymawYTbB0SnI/I3LHRoGFiN6
         nSgA==
X-Forwarded-Encrypted: i=1; AJvYcCW2dAhsG6xVsagTh2cBuvnOqfmd+z4kV7nd/eNql5vPjiMbyBaRxr5wxnsNEeYZZ/lu0Uehe6eXJybgEz8E@vger.kernel.org
X-Gm-Message-State: AOJu0YyxESu5U9QO5Nwuzy+YN91e5qNHxMQ0bJZOo85uQPo8QSxEJWG8
	uBpVxBklyUoWr20pZKvdO2CU7CWogaBFs2uQhK9pcA0d4RUEhXyuG8e7wZIuAUSYsZ3a1EiSyWh
	WchMLMHYx1OOl5KhPnMgljv+zGiK2WSEuRA0lnkR9ZGDeBIZWGOATycdiV550g2wBrKg=
X-Gm-Gg: ATEYQzxyUgFuHRI58+cbJyHMUI9WhLdOd8MuCh+GehVniTgHibbhlcscvpyFQZpAWPw
	fxeAwhOO+e5nhhbVL8E4SoXwXRMrILttv3y3Hm8r+rFPotfdk2bkIzcPBCdDDz+8lQq0FIjf1FM
	90Xvm4B/sghtch3fP3TPS8+QsNMgOJJx9PpcdfArp8YOFGJ/kAPbfH+wd1+TvNTxACbnrxgZhaY
	iJyvrE+KuZwV69PUQJexHfISOLs4ND+BzZ1+dJv75foYiyfOEfYO6C/4jhu0wBOB775FpImMhgL
	Ec3EcDGAlM+lYUGCXC2ky3nu/wicQmJ9OjD4oNsYagDX/ErWKZHE9lIIGIyfaLOwnfUX0pJKgDq
	Jwjqi/QMSZOHo+aNv
X-Received: by 2002:ac8:7fcf:0:b0:4f1:de87:ad90 with SMTP id d75a77b69052e-50997ff8dc4mr28822951cf.4.1773730795025;
        Mon, 16 Mar 2026 23:59:55 -0700 (PDT)
X-Received: by 2002:ac8:7fcf:0:b0:4f1:de87:ad90 with SMTP id d75a77b69052e-50997ff8dc4mr28822841cf.4.1773730794634;
        Mon, 16 Mar 2026 23:59:54 -0700 (PDT)
Received: from fedora.. ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c48689e14sm55785786d6.32.2026.03.16.23.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:59:54 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: adilger@dilger.ca,
	jack@suse.com,
	cem@kernel.org,
	ravising@redhat.com
Subject: [PATCH v2] xfs: return default quota limits for IDs without a dquot
Date: Tue, 17 Mar 2026 14:59:47 +0800
Message-ID: <20260317065947.306954-1-ravising@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260312090810.1145908-1-ravising@redhat.com>
References: <20260312090810.1145908-1-ravising@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ID has no dquot on disk, Q_XGETQUOTA returns -ENOENT even
though default quota limits are configured and enforced against that
ID.  This means unprivileged users who have never used any resources
cannot see the limits that apply to them.

When xfs_qm_dqget() returns -ENOENT for a non-zero ID, return a
zero-usage response with the default limits filled in from
m_quotainfo rather than propagating the error.  This is consistent
with the enforcement behavior in xfs_qm_adjust_dqlimits(), which
pushes the same default limits into a dquot when it is first
allocated.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 v2:
  - Moved fix from VFS (fs/quota/quota.c) to XFS
    (fs/xfs/xfs_qm_syscalls.c) per review feedback
  - Return default limits on ENOENT instead of granting
    unprivileged access to ID 0's dquot

 fs/xfs/xfs_qm_syscalls.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_qm_syscalls.c b/fs/xfs/xfs_qm_syscalls.c
index d50b7318c..2176dc617 100644
--- a/fs/xfs/xfs_qm_syscalls.c
+++ b/fs/xfs/xfs_qm_syscalls.c
@@ -391,6 +391,30 @@ xfs_qm_scall_setqlim(
 	return error;
 }
 
+/*
+ * Fill out the default quota limits for an ID that has no dquot on disk.
+ * The default limits are enforced against such IDs by
+ * xfs_qm_adjust_dqlimits() when a dquot is first allocated.
+ */
+static void
+xfs_qm_scall_getquota_fill_defaults(
+	struct xfs_mount	*mp,
+	xfs_dqtype_t		type,
+	struct qc_dqblk		*dst)
+{
+	struct xfs_def_quota	*defq;
+
+	defq = xfs_get_defquota(mp->m_quotainfo, type);
+
+	memset(dst, 0, sizeof(*dst));
+	dst->d_spc_softlimit = XFS_FSB_TO_B(mp, defq->blk.soft);
+	dst->d_spc_hardlimit = XFS_FSB_TO_B(mp, defq->blk.hard);
+	dst->d_ino_softlimit = defq->ino.soft;
+	dst->d_ino_hardlimit = defq->ino.hard;
+	dst->d_rt_spc_softlimit = XFS_FSB_TO_B(mp, defq->rtb.soft);
+	dst->d_rt_spc_hardlimit = XFS_FSB_TO_B(mp, defq->rtb.hard);
+}
+
 /* Fill out the quota context. */
 static void
 xfs_qm_scall_getquota_fill_qc(
@@ -451,8 +475,18 @@ xfs_qm_scall_getquota(
 	 * set doalloc. If it doesn't exist, we'll get ENOENT back.
 	 */
 	error = xfs_qm_dqget(mp, id, type, false, &dqp);
-	if (error)
+	if (error) {
+		/*
+		 * If there is no dquot for this ID and it is not ID 0,
+		 * return the default limits with zero usage so that
+		 * unprivileged users can see what limits apply to them.
+		 */
+		if (error == -ENOENT && id != 0) {
+			xfs_qm_scall_getquota_fill_defaults(mp, type, dst);
+			return 0;
+		}
 		return error;
+	}
 
 	/*
 	 * If everything's NULL, this dquot doesn't quite exist as far as
-- 
2.49.0

