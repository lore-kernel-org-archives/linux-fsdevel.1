Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A93FF1D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862872; cv=none; b=QMiMCg4NYwWI/2J3zrlWHjzIP3OQCnKdzfy+Q56D4ENmiiURpd0wBtZDlInBZK5k2hl+KuFTYGhojRViO6lQn2pPBndcTXBbXP77Go2UOxAGLr74Dsh60pnfMOgpGBWJ+Qiy0a7fLhw+kqoxgh/5P3rcZdrzZ+fzYYdqSS4Uch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862872; c=relaxed/simple;
	bh=xlcAFzQ5anxdBg4vLnjX9Kl2UmzhDPu4qRy1NeSloO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSQTb/LJ52idvNFOyu65atakggqFsjM/X4sLA13Jek7WUoDDHIHco+zqbpNlhBICLfk5tQZg3VF92LtM+nr0+7MHi82NyrsYjrFS3lwFryHUdgBaM9IUvXgkvTSeKhZMYgotdiql14kMC/KVC81B6l7yJybMeosIefMKmZMTKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrzDM2/H; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrzDM2/H"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90ea08cc5ceso6032185a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862869; x=1779467669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8oJHB857643S9JSuhJvdTYsAdyjAOzUqURlAvQ8IEs=;
        b=OrzDM2/HIryf39tzUSyyw3A7J6u8yW/KezdNYqomxFdS3flS0lEEI6HuFEz5UemvnB
         +++RKMEcoKhCh9B9KCT7BpXWb1/Vx2b4fctMyRBhQM6IYl1qDCa+VU6UHO+l1gmpWRRJ
         ngUvXBD7e9jMC30m0jio1iO3QrRNU8jiETrRcVt5gbJNi1YJ94GNPmDXY36IAP9ZV3sT
         vDhL6A2xhWzY2lsymd1gzykBcXm9Y46Tx5LQeUDzHyncau/JV2E/SkuMRDAoaYapS1j/
         h8hKe4ANMyDkX3It4alrj0NantEqtCAuqgUVShHcCqa5KrHnHusl5HuoHyD+flpa2pAp
         fuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862869; x=1779467669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8oJHB857643S9JSuhJvdTYsAdyjAOzUqURlAvQ8IEs=;
        b=gUSVmf370vuT3pYoO24iU4txINuoHHE0Y6O8A2mMFhaz8LovdN4qPRJ6OYHtTz0NzQ
         5XMUCd3AtNald1j8/yFmU1fHAgUId7BHonIlJGStxyiGACgYjgD40ra04/eWq4rbW3jq
         WUmS0iouss1htisiYuJHz04Cd07pPTW6jh8SyimH7yvXPybhykqQNE51SMKexgMN5n9D
         vPR+TH1jn8vkMRVRCzpLvJA+iaSjb4Qf308UaIoPm1b2DMfWG2ijbznfQgrgvDKiUAGM
         bU+lj+5WYz6b5kc1E//2/iimFBFiS/5ProGEeL7rIt/5FBuZDe3xlSHaN3z/4U+a+aYP
         gFHg==
X-Forwarded-Encrypted: i=1; AFNElJ/Er+ScktDSdhqOf52JAWtYtZXUh15p1G8ho0JZrouVxMqHdT/9DcHUfbEJDAu1Ph6NdMX3qOz5USXnx2VG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0TV2HZDqL/vckrSNljv+FnvuKcUnIztxevUDKdYGtxJyhbye
	HHBc3um1LO43zZdHI5i1y6SBhXFLzmIjBZSkq2CjxfH8Xq4r+zdPl+4Y/hzRFGrI
X-Gm-Gg: Acq92OEBxA4OGawD4dXtBPpgkqxdVyTAPkGg2JMOH7Edt5Xa/g5tTf3kEb4kHrfzLBr
	B0VsWvPjNH3zOus7qRUT6YsE0YHDNKRyvAkRN4PB5W5OTC/sOD6M/3Me+OnUguzwqvCzmJgztLD
	/aSvhr6Z13gpdqoiDSGJhrJ9QDlmOQ8VE3bLKvEp7k5CMeNurFc5tNKAphlIzlVn46LoP55kSMt
	9+pIajXxnJJNX/XVlTubNkJQTIJPXMKYKSO1pOoIdyO6Ryf+UZUTSok4Xo6HJhu8yVDcHM0/EvX
	eRPzh+mTCekrjRbJu45EucBjUjK52HlzUCLK+LIg1RoNKzBkNFkatUwwUPJZnbx9Z2JNWa2WBl7
	UF86tCNbiwy/1JFqdWuSneHZcaH+yVnhzfBgSMPtUR508j4vaZk/sRLyCxGcLF/nEUhR1dxZu+P
	69kKgP9sYsQ/Xo4bBbVqTLAI1mIcjJ50AbR/torXNVVaKvRnJSUK/xkCyJwdkaQ4ZSq7jDg4IEq
	Sc4jT3kTzYPARk/qKjTHoNtW4nvNOisRrsImPUmqnM=
X-Received: by 2002:a05:620a:6307:20b0:912:1:b413 with SMTP id af79cd13be357-9120001b670mr481513885a.15.1778862869007;
        Fri, 15 May 2026 09:34:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba1825dcsm585339185a.2.2026.05.15.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:34:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
Date: Fri, 15 May 2026 12:34:24 -0400
Message-ID: <20260515163424.1575298-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In do_action()'s UpdateRecordDataRoot (fslog.c:3489) and
UpdateRecordDataAllocation (fslog.c:3697) cases, the memmove
destination is `Add2Ptr(e, le16_to_cpu(e->view.data_off))`,
where e->view.data_off comes from an on-disk NTFS_DE inside
an INDEX_ROOT or INDEX_BUFFER.  Neither case validates
view.data_off + dlen against e->size; the existing
check_if_index_root / check_if_alloc_index helpers walk the
entry chain and validate the entry's offset, but not its
internal view fields.

The neighbouring read sites (e.g., fs/ntfs3/index.c when
iterating view entries) check view.data_off + view.data_size
<= e->size.  Apply the same bound at the two memmove sites.

Reproduced under UML+KASAN on mainline 8d90b09e6741 via
pr_warn-only probe instrumentation: with view.data_off forced
to 0xFFFC, the memmove writes 32 bytes past the end of the
NTFS_DE.

This is similar in shape to Pavitra Jha's 2026-05-02 patch
"fs/ntfs3: prevent oob in case UpdateRecordDataRoot"
(<20260502105008.21827-1-jhapavitra98@gmail.com>) which
proposes calling ntfs3_bad_de_range(); that helper does not
exist in mainline.  This patch uses inline checks.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ntfs3/fslog.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401e..127860fd2ab50 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3497,6 +3497,18 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
 
+		/*
+		 * e->view.data_off and dlen come from the on-disk
+		 * INDEX_ROOT entry / LRH.  The neighbouring read sites
+		 * (e.g. fs/ntfs3/index.c) check that
+		 * view.data_off + view.data_size <= e->size; mirror that
+		 * bound here so the memmove cannot reach past the entry.
+		 */
+		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
+		    le16_to_cpu(e->view.data_off) + dlen >
+			    le16_to_cpu(e->size))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		mi->dirty = true;
@@ -3689,6 +3701,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			goto dirty_vol;
 		}
 
+		/* See UpdateRecordDataRoot for the rationale. */
+		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
+		    le16_to_cpu(e->view.data_off) + dlen >
+			    le16_to_cpu(e->size))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		a_dirty = true;
-- 
2.53.0

