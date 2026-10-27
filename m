Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091104;
	b=MkgdzCtomgaG620K6yJ7heqd2XezWDa/A6KnoajZgNuBXFFZZfP2GbMXle8S5bDNLOQt
	 dkwCnbvMAKS4BtwZu8q/9KPrJrmAjNrOr50y2RM4AdcaEsQmxakYxew7JoaEePeYJQ2Dn
	 Z8zao/FT2GdGqtEzEls2qolRJ240RAlLfsuVm2RLlcgoyPoZQ5tTbOMt+iD0yQt0j702/
	 Hme2RlweBsz21nyWxSRXKEyhs6D2ERKOAlQs6kxsylJdQSJyaNB29RRbUZylSy238PJLk
	 SIYp9WdrJStR9fegRRL1oPs5G88FtH1VLvVDiNU7rbfiQEUwbF8aAg0Ry/ObntPR47w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QHhOVuc8SPWEac70B9W5j5+x2XV5aSw2etuC6aoVzBw=;
	b=TrZQwrgr08avu2aYKZG3mvV4n1Sz9a2AMMRhL/IrdYqzVpbBZlvjJxOhpEbfINDOplrO
	 PAlZIcHZoYJPFOw3KboB07DxegxqnR4AmexMgMfhf8V5eiP246Mds9dF5mdSg5/Hq9c1X
	 /hUY5jWGgrobrDQO0VFNL0/Q+/AxB/ORR4CQ5/KfWdEezm/wCMIFtesUvxtLzsFt+41E1
	 SIPvdBDJovUkoLb4fvbi7+WVSHMMosWkvAdVDpzsQGI7QBhVtSiS4dPsGmCwXLUDL73+m
	 lMcjc9yGwVLeiOwMWQzhren3fqVhH9hxI81kV09mcpmv23qWdGdPPEdyx7X6elVXNUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KtDHsPxr;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765B606A325
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1765B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KtDHsPxr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so24176165e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091102; x=1793695902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QHhOVuc8SPWEac70B9W5j5+x2XV5aSw2etuC6aoVzBw=;
        b=KtDHsPxrGgc+j7glKwphtDQsr/vlZOc1AIKx7Mws68HDZXv1sxqspkNym3VZ/sjtif
         SR9b5CX455vkNZouBan0CmiHmeYdy1juaNvZ+C/23Us/OV87ytFhXyiJGtp7jwbDk5xh
         lI71oiCvodB/gbR+XBIx8Dd7smbQ48zfp2tUiBSZWLQeeUj/ficey5kGyBbG6LOeR5qU
         bUm5R1pJ4j6S2PbSspGUNmIoylmR7P3YfQeeW5Kxzj//L3AMyi9dHFDxf3jBHY04buwm
         BSiZRblETwW+BmM7/+P34wTZ02fHbotwTiQcM00V+KMCewGwt0WN3mSnEjXHC6IprceL
         SXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091102; x=1793695902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHhOVuc8SPWEac70B9W5j5+x2XV5aSw2etuC6aoVzBw=;
        b=exdLOLnmWloGNLUIAkYSIz97Hq5pGn1DFHkxDQw9CFhu6QFpAT4To1Nva4JxOAHA2V
         uzNy2Rgp4Dm3r72E5VL+esUsi7VPqpNVPGcchzLM8g/c5ybG1MHAX6tFa498PAmiah15
         u1wDWjkjlAYGNle1atnY+39feWv4aQDPyJ5m0TfMliKl9K4r03N+r6HxHrQxDL4eHItP
         RgMeOedw0tCuCyeSg3ZpnmUloAql+Ut+wwuHBrJyTZS7eYXBLhXoB8q12FnMXu6Z+tWj
         55eitwhNjVzHtP4ejoEQON/PUjdh4jieBZ0OgWnY5R0zF/ghYeOJjd5d82i0qfDLnFyo
         E43A==
X-Forwarded-Encrypted: i=1; AKwUvBwbiF1kveLWqV3VF9qfAWsFRcK5SAF9thBDXDhC+auHlCCd+dbK0h+90FJlgT+VG3+jTh+QkSPIGQn4TWKt@vger.kernel.org
X-Gm-Message-State: AFq9FYLzZeUKqRN6KthTlUX+ZkHNsRmiNUhUC4GviDXMOoY/E4jHdKGq
	0KpgkgU/xrDjqkkZaEmvzhEvTNg9y6qKELN8wvOFDjO9chtgjhs85mpd
X-Gm-Gg: AYBFou3CcVKwpsRi1P+AC9BdmZMxM8KSYzNWfMkNQw/mY+COWVRbXIWnzyfAiMc1YPV
	4/I4ZLfooxQZy9Z6mXUcWV8qSreVxXqDJ8DRbFg4LjuyZUS3WHJpd6rXZeH3LuZAJ/qmXgC3aWQ
	SbjhQf8Xogm3xmCUszz1ey0XhLAds1crDm9kYGYW9tamrA2dUvtXa7nqyRP8mvqEYL+4GiyzTSC
	tEx8Gkjs00bZwL4NAfF0FZdQ8rewxnCc+PIisaai6v36Syc6sO/P30128iIECwKrjqXK1+49LF5
	n7cFgPbBODmmmD0QR0svVJ91MjEnDVCBSGQxWGrEzdblsl7mG1i2T9fmqf+s4N/nHcseRWEYuzV
	h2mj3jp9LLPNPaXfCyNJbdRGEdYup7grYUnUbaRQXZeaNlaP33OyhNiC/4baTWgMfNCTqFDdudy
	SZ0JKoUEG1m+NeudwZk/n/G2pogTpOUtmTHWPlNiSYt45bCln5oXcVFgsg4z6JD5xoX5hU99DR+
	hWB7c8crKNpQrK8KZFhDWh61ZEY4ElNnojEIePvQ0fbelkJVKfiNF5ABW6sreY+i5vksmuzaA==
X-Received: by 2002:a05:600c:c0c9:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4a587b3e000mr90772595e9.13.1793091102146;
        Tue, 27 Oct 2026 01:51:42 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:5658:786c:2fea:4768])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bae01sm310495765e9.7.2026.10.27.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:51:41 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	David Disseldorp <ddiss@suse.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] initramfs_test: exercise the oversized CPIO namesize guard
Date: Tue, 27 Oct 2026 10:51:39 +0200
Message-ID: <20261027085138.4107590-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

initramfs_test_fname_path_max() uses a directory with a nonzero body.
Such entries are skipped even without the namesize > PATH_MAX check,
so the test does not detect removal of that check.

Use a regular file and terminate the archived pathname early after
fill_cpio() has encoded the oversized namesize. This allows the test
to detect a missing parser check without relying on VFS pathname
length limits.

Fixes: aaf76839616a ("initramfs_test: kunit test for cpio.filesize > PATH_MAX")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 init/initramfs_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 1154547721ea..32d4d3e4e6c7 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -474,7 +474,7 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	struct initramfs_test_cpio c[] = { {
 		.magic = "070701",
 		.ino = 1,
-		.mode = S_IFDIR | 0777,
+		.mode = S_IFREG | 0777,
 		.nlink = 1,
 		.namesize = sizeof(tbufs->fname_oversize),
 		.fname = tbufs->fname_oversize,
@@ -495,6 +495,8 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	       sizeof("fname_oversize") - 1);
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
 	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
+	/* keep namesize oversized, but give VFS a short pathname */
+	tbufs->cpio_src[CPIO_HDRLEN + sizeof("fname_oversize") - 1] = '\0';
 
 	/* unpack skips over fname_oversize instead of returning an error */
 	err = unpack_to_rootfs(tbufs->cpio_src, len);

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

