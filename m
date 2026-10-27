Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114206;
	b=V/Utq72hboyMDs1IBjYVZAL/Cg1j6ytDzHw+aAn/CntaJoTHe+JgOJnmZ+mXSG9Nh47S
	 5jW7ePYbZP42kNF1cOxkB1rvVk5RfmllsoFwrhc8Eo+28349S3viIXGcJR7CrpQn2YiOD
	 QFxQqdKrmW9DP4YUiXryLya/gGkamHH360sOTgDNSCVFEMlvxyDQLDoB/wI5TaqHbC1uZ
	 jMsyjhZUCpF5oqo/h/RVX7HAw6cz3cb+QSnP4QE8jlDTq9BMbU27joDPki77Ju4NN057B
	 RB+jEAs8XjFpGAKcIZLNNZcyGY2aq/8WsemytmslFjYpDui0fOObV4honUo2EV19FFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
	b=nrPyF9GvD0Oc+KsNBktgPT5zHFqjU/lm2vHf7YvWJvZ0qUPUyU8e002YnJutpRKZye1P
	 Y5R/EPnZbAExNYYbpFMehDXkBIGsqptlrjmUK4dQRrdQ95Y07BtFome+oh7odAQIOAwE/
	 +se4wkORlTuOv2i4I+lKgdxjFgMMu8CnrCxtBnyHgWyuaTeKzJF6l5iGXbML5Xc/tinYq
	 8Utt5h1f3YoIJ4N5ImSAJ5on0BIlWvmrbV8fEA0Q8wFTkMCojJz2PExa3YrgRFuXPS3/w
	 ZR95H+WUKhQeLBBvLZ7b7WT49WOEsBISBMkIkpsWVy6vcpYSi7fFHJqw+boAopTD+SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMwJSw+M;
	arc=none smtp.remote-ip=74.125.231.131
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B0606A31F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 421B0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMwJSw+M
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8459f7bc7c0so2215655a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114204; x=1793719004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
        b=EMwJSw+M91PgzAQaQPtBgZc95p/uQGS/T6PC3FZEOMTygnc1uk0gICdyas7ooMBwTQ
         fcIBKDuIB8fG3rqCWQVtuBedLeb3c0bcPs2vEMH4jxIKvS6Wb106lFSoj6Ujv9soiH2S
         4KGUMy1GNReA0DdFg5zRiViC77yBwkL9/YY7hS48bT+jU2A2WTC8bbblKYRiyaW05Qq7
         jYcAVYo8qkCDYd9WnDWK+p6WVOPz0o54JpvUpqJUgal3cFP+0b7TbGlQExyi883vtJws
         obRvHzujWHoWuAFf3jqpkjUjsgrEz9nmBGqNiPvav58KydrmsngXxi6/3nSte7+5B9zF
         LiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114204; x=1793719004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
        b=oicZyD+1Ihx+hSXZAITTmTFtaVnFyOVfEXN1Y3/TmbCqgWQfY5qD+aQZzP6u23t2hW
         OvLHESpm79WjkRRCaOUZOy+/CPccpLx0XRRgY3OEWej5UCTzVtQVJ4UL6X0YfW12bRPx
         byQwwonwczN5s0vqid9MCQtzlUnkVv7VpxviZUuQ6szrb3zw5uEUmN0Hs3ZIQRdHTt2h
         8IG79HTE3cBaRJS3uiG2ZeCdfdltxzz7Ti/xnsDjpMaiQS0IY76CCizQ1whN4nPFcSzB
         D3quzhjEgd5vQt9758UgAjI+947O+2grIij6LKd8Tl8/cpAfYroHHFqUOCuDbHOSQ+z3
         fohw==
X-Forwarded-Encrypted: i=1; AKwUvBzZinjBSZTQo1OVm89WdK/4E3EhrD6p0R+TyQIbxtMD/CNSmWV7v74U7JHEVE/QcGkxsmXa+51DIqDmb34V@vger.kernel.org
X-Gm-Message-State: AFq9FYL1aarayMJ359m2wqQjXJjclI34RWwjXFsnbQtp1Gtqe+zpAgon
	BzCXLoY1dww6w6IZdwLU3+sOaCOwiv7Mu7DIdxYg+r1jBHm52ifzAqI8
X-Gm-Gg: AYBFou1M22Rga3MXbJrQIzCJ4UpnPqvZCNlBEXaeJuiMJClDB7/m2Kvz9FgUf06IuzN
	XEl88AhEsyZfU61g7dctmYKsmIYFjhCxFX0EXNLfbVDR1jr0/SciYiQOTCS0L+JlX+OPXqbpZqe
	eNeZDDWBeLpCBTnZ2I7zaGcR4igEbm0ZalQocW6b7FDIkE/DfIdm2WjtqUd6yClqL8p0t3/6ZMh
	g1Ljn/UUIJkN5ZWP82AA+evZ+W2VK+Gceyhq6dA0vyqARLfu2A+k3MrOKs0jWEm/DsysqS198yt
	WkyYpaS9qwXcFI1EHkMfNFT6sV+KL1JmOUzWoO4uTylmFLhoFKebU9EFxp43IaxurLnyKYUFg/0
	iUjySyw85of1x2TkRyqVTYsdSdXayLsMwz0PlR5mD9UiPE0f2UlXAAjDxsIrfXAmwVwTMfD9lra
	el5Msx9D3rwo4W9MuE4aziKX9Autd2goOchNAnE8tzd2E3nALIdXsI7Z/a8Z5ARvlLnCS2ILP5l
	/etxKOBy0oypiKmfRAfLfKv9eHlOSD7bd1NXqNIDCc4yWervw3kayB65ZNk7WODyyNT3RR5Wuxz
	/H8wpi6huXIev6yahkVtZ6QXXRrvZ2JqqpbVlwR5Uw==
X-Received: by 2002:a05:6830:2b10:b0:821:c75e:5309 with SMTP id 46e09a7af769-850fdb42781mr8911434a34.7.1793114204118;
        Tue, 27 Oct 2026 08:16:44 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d7fsm10768970a34.2.2026.10.27.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:16:43 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix NULL deref in ni_std5() on stream inodes
Date: Tue, 27 Oct 2026 23:16:15 +0800
Message-ID: <20261027151615.971171-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
References: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
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

ni_std5() looks up the standard information attribute in the inode's
own MFT record:

    attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);

without redirecting to the base inode.  For an ADS stream inode,
ni->mi.mrec is never initialized (ntfs_init_ads_node() in
fs/ntfs3/inode.c leaves mi.mrec NULL), so mi_find_attr() ->
mi_enum_attr() dereferences rec == NULL:

    BUG: unable to handle kernel NULL pointer dereference
    RIP: mi_enum_attr+0x18/0x180

The SYSTEM_NTFS_SECURITY xattr path calls ni_std5() without a guard
for stream inodes (fs/ntfs3/xattr.c): ntfs_set_acl()/ntfs_xattr_set()
reach it via ntfs_insert_security -> ni_lock(ni) -> ni_std5(ni) on the
stream inode, and the stream inode inherits the base's i_mode/uid/gid,
so the may_write_xattr() ownership check passes for the file owner.
The default stream-name parsing (colons) is enabled, so an
unprivileged local user can open("file:stream"), set the security
descriptor xattr on it and panic the kernel.

Redirect stream inodes to their base record in ni_std5().

This issue was discovered by Tencent CodeBuddy Security.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/ntfs3/frecord.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bead01a953f3f..dce6400195aee 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -89,6 +89,13 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
+	/* Stream inodes have no MFT record of their own (mi.mrec is
+	 * NULL); the standard information attribute lives in the base
+	 * record.
+	 */
+	if (ni->base && ni->base != ni)
+		ni = ni->base;
+
 	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
-- 
2.43.7
