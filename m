Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824629;
	b=l5iAgHz344GZLcKdlJ7Hl3SkC1qDr8GweUND0tSGlqHpldUXZi9rhcHnmFZz6mXpBNev
	 3NTiEFJC1GZJxTPN0ILHiKzY6KdSsnck9LI8cx7UKj70l75p54VZj3hp434zQb1sEt9Cj
	 dlBeVEU3QEIedhuKtu3N75yfSAFl4mZ5msKMt+XS8YHkTav7jgMsOtqrqBerZ70M24gdJ
	 QUld7gWx5hP0FmlGz98VMZnSl+BexPkYpP86hw4t9EacbEZZovm8HW7rf/o/hha1oNBUV
	 +R8WUR3+T63B7yAMEQmgYqa/P/F1ExhEnCeUPPcVRYCLSVj07rQnZch5v4A2BUknrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
	b=fV0Bo0MYaOibI4wlpFx3VVeahkEU/aU1ZIGGBhB+D4DeFwxpaDLU81NzLeDB+KlYdqFU
	 mGVvzcMnDRPSI6AhMWg9o8gd0iiIXkNuN6bf0dtEP8UeEYk0LS7/9KSlfMYuONUpSz+XC
	 g//t7CIXb8sHQhHuKyK3OcoVWk5KLn7PYQQfLuH4PmAiF7iHfrXUqKxJ6VztkGHWTZc98
	 OwazDXCsn74OwhSfFVi0vcBG164SpjfPgmhzmzojLmoKD+rS4ur2I3m0FrUrtdvimQqXd
	 dZjeQkdCPsLqvVRNMkew21LYFVwe4qy8QRAhov2CfIydqyapTgNKebjLOsqrxEN/N0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlwp1ta5;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552F606A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9552F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlwp1ta5
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a210470b49so26204465e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824623; x=1795429423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
        b=nlwp1ta5SDEnakttiqWxdmNJS38raYe5iE7G79agIpBYLhpLANEdpEp8DcRTIZeMpN
         bogWAayszJMdKU+SePBWmx4W7Tnq4dL2QSzWiWxe8dpAmxr30RWcECUKJLlRxt8sAJa/
         UxLI4DvIYigUXepwY+2uiEgOm5qNI+oCd9imaotrC8l3HIShcGnk7nvECW7V+8ITcWC2
         SqKu4siD3nUV85hlP3i6bvYohTFXXq7NT9gWUsDGVgrgO0+d8gsDj/camLCiUAhpAf+J
         zWFG9ycTDvA9iLwAgrU3LldqLMCRf00pO4bMzSjTthvzT1bNxIEXda3oWAJHaRYo0tv6
         1MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824623; x=1795429423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
        b=NXZS28g4XbXbcbY3wEilVZ0Kk+UiVKhvWpkzf0THodkPytn34/SNQ/lWR3RNz3PodC
         d5ECh9uEoOrQ6ogBP9O+izYizqe78vxb9TLlQ5jPH6VAXD2pbAv2+R7G0OGhMi40RDmp
         zxWUEqw1W3VEaNeFajR/eMCoB3cuYKPXzxbyi9qCOtoVWfEQoiL0OHcdL2kg719tbQG2
         a/539Zd9iUVZos3lnndtU7tvx1unLuDua0JbpNT4/4PeA4SfwSO2DD0g0GAMX6I0bw/4
         hunau41IXnq6F2Ez/rOTvBGj98A8gNXAjTqDXv1i4jXuJoEsyTUUN4+Plb9ymz3D16B9
         gA9w==
X-Forwarded-Encrypted: i=1; AL+hErHP6v5WdU1+bKIkOlyBanMTe5HaVH5o50pqJaWK2b5L2J1QkhRH6+pCbPd+RMOFGC5PBJNKWczYp+Kxa+Yy@vger.kernel.org
X-Gm-Message-State: APuU4Z/IPyNoctpbJjxURaaqsf4cgYsacKsvl62cyg+M+AF4vVzRM13X
	1AiBY6fDN5wb3+cOTAQfCi2APR0Tgj523ftaALW25Gpl3/ik/lkePi+H
X-Gm-Gg: AYBFou0JqTrQw5fiSt2KObYRk1jOIxLWr6/zHrrMJQ5ftZhOfUGlOTw5uTarBW/TfEL
	qhcFGQ6WZlxwBgP4qn+i8qrk9/hROyw1SVa0swcgHX9jwq530wXDP/K/LjCbLVTMzLDxpJ1/M09
	29HhbllwCK114n9pJeXl/93jK1Fs/y3697dmRlrvY4tnXkmTM9Yamv2/mLGPe9GcvJH1ynIQMQJ
	EuEOLCrp4qtKSeUL2BXw6gnfDI5HzsaB+BgUnYB/qhct490xyplD38ffsTU8lHxS/5NF1pCIdeF
	2YtMLeKnRTfoqli1UaelRgLBxNqaQKwHIGZVP1n4A+WZR2CJRdSDhxRrj/wZNivFk8sqVR3M+ig
	up+3Tr+q3LXxImhnt2nyAG9clk3yNu9Fm4olMlhrfytwUi9O9bUcIzIn5p/6oU12dtMz4vTCf2d
	WWJytn76SxeVSVK1JonnvbEVJypRLPLWccBvxWLqGwqrTtPAOblRXhe+9apZ+SIIYjlo6XVQl/A
	9fuPchO5u/F6NVXIcfLaVcUbmDkfw2hew82rOlRfQ2tvIpZTpoj6UT+c5gapdRLD4CjArLGXnhW
	51BbAVz5paprwV4b05k5
X-Received: by 2002:a05:600c:5395:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb55a95d09mr204699015e9.15.1794824622940;
        Mon, 16 Nov 2026 02:23:42 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f6a40sm108149375e9.2.2026.11.16.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:23:42 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:23:23 +0700
Message-ID: <20261116102324.81107-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 246d138ec066..43c4a60b773f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -223,11 +223,14 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

