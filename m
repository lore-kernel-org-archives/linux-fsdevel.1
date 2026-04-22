Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31273B27EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851266; cv=none; b=aKD+qyie4Vz2HjbBuXMsNTL8+1ESyPvuq0143kAhJAKrbZwUeR0p0P5rmse8/H1BJ0RC5FSrFLhD6jVqYCtMbDss48wuvBeJBbezBNkc4Mg/sD/wtE48SrCZQAnBdphiBsFhSr/A9apA/+rGvT4k/zhUjRxuLdjaxxcI7Drx1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851266; c=relaxed/simple;
	bh=or+9GmJFvEjUIs8ezh8O5LdPLBI+95FYLJskutQ1wRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoCzYh3uEFYNsq6Y+qVeXLFLQkVy0MRxSSoFfRjOzMzzWT2MaBN2U/RBe1mL4+LmrssamwON9kNzK6kPQp3p/EjuSV4LBfJftlv34QEsCYTJ/Bxj7acoQNoKXZW6rigEJBOLYs7Qlx8wfzN/A9SSJ8morlxW20RNcM3Qbqh9KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/TEDMqK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/TEDMqK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296dabef74so4498164b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776851264; x=1777456064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1aICTJnChD2VnWBKaFQv7Zohky9zRn/IDcQ6gWOlYg=;
        b=a/TEDMqK/rSw6oHLLQBaOFAvgn1JblzYweraczx2UmY9dy0hQ+q+us1xexUjpcj4aU
         pBL1PTqMruPW7WEiEHljxkEMFntWSmEYDGK7ZNgBLD6C+0fQpAkmwhSWR/7FmYWlJJ2g
         Al7lRry1JU/lzui6q/R5Dy1er9tBvuNoVd+3pgSWEK6w8NrIEbHGbuZDfcRmF3DkYx+y
         el/O05ceCBwETRMj4hCZc70oaYsTGzAJF8gOBvgiVsdCiaICRqnJgViVKqwvo+RXtEUk
         jz+WAM7PwzFOAO/3i7v8o+FUoqsSbPTZAD4PslC3SlUubQ1aPoUXFGn5cb8aSbPSYePF
         Kf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851264; x=1777456064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1aICTJnChD2VnWBKaFQv7Zohky9zRn/IDcQ6gWOlYg=;
        b=OTww6o+l+7BkoTZuF9QI07A4VRLSFCVXlINNeGIOs+6SoJsIlDNMVFVfu1YX8juMHf
         mL2zD7il2+5JpwKUJP1i0Tzi666Of/KQl7n2kl6iLVPlxeswLcTG5XC2PmCuXKBN2EEa
         uaFOWhfogmmvK2iVK0JSZJMJuesV0GboTKP2sG2A/1tPsor7fO0N5N6KJBIXAKo0A9g+
         8TGjBx0+/g11PoEZW3gHEfdisymXDEa0aw0Afz3kcb+DDswpOXWQmgszSSUq7v0Y9zBW
         83Encb5b60iZdq9KBPP5JujlkvQ3FtkH9BgiMNJ7a/QqJBtpRU9DgNLom1VZMqQ8mlax
         6Teg==
X-Gm-Message-State: AOJu0Yz9i8I5X6OQfW43Q0dXda4qlvL7SfkwqFT570uS/4EfTMh185lI
	Arf5hfBRfMWQIn8EqJRfUSULp19jbP8svRa1bBpSWDpbdO3+YUHs83G48SJ0yQ==
X-Gm-Gg: AeBDieu2reIxnAmK9rZnfukY7pUXwVea0TdIKCW18qOVBrR+lMmEZgk30Y2xSRp/63U
	xtkOvkuG6bzrsYUg7bNiTzDb2f6A/AE13bVsk+yKkunUYA+ArdZ7lcLreKqp1IGeeB43Yh7CkUd
	WUL9fKP4Ktxg7pmkeHPCrimlOvaCTE+t9BEwZMKnIVQcSC412zh+Xx4Gg2o/C1Nc1OTrNUC3aRT
	WGt7O36Obj1fXV/o29I6DQKz3y15Q/xWnzKqPARR+nUXa7Q/7vLfX7nmzhZVHifyNP8IKp69BBW
	g6TH8kKfyob+siUfGrm9IzUhPZzRM4V5Z0UY/+42SJYr6k0SFlGBw6NfDKHPmHXcADNBlu+vjGZ
	G+WN5BDfhYFzaWYE8s1xdJkoo69SohKycYsizGQYtMcRiHZHdGAE0KGnczf2sdBdRt3ZDy4HgQ4
	F3x1ljtzQ7cFpna4Vr/zB2yjs7+khKBvNcpsUEPjljeeM3cmU0xRkGId04QXJ9yjS5oQpl
X-Received: by 2002:a05:6a00:2308:b0:82d:162c:581f with SMTP id d2e1a72fcca58-82f8c97c71emr22298338b3a.48.1776851264230;
        Wed, 22 Apr 2026 02:47:44 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932dac13sm16136446b3a.35.2026.04.22.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:47:43 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] ntfs: fix VCN overflow in ntfs_mapping_pairs_decompress()
Date: Wed, 22 Apr 2026 17:47:37 +0800
Message-ID: <20260422094737.194069-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANFS6bY5KfZ34dAw8StDnXkrr59r883ETB2enZr++Ny++B6H=g@mail.gmail.com>
References: <CANFS6bY5KfZ34dAw8StDnXkrr59r883ETB2enZr++Ny++B6H=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ntfs_mapping_pairs_decompress(), lowest_vcn is read from
on-disk metadata and used as the initial vcn without validation.
A malformed value can introduce an invalid (e.g. negative) vcn,
corrupting the runlist from the start.

Additionally, the accumulation
    vcn += deltaxcn

does not check for s64 overflow. A crafted mapping pairs array
can wrap vcn to a negative value, breaking the monotonically-
increasing invariant relied upon by ntfs_rl_vcn_to_lcn() and
related helpers.

Fix this by validating lowest_vcn and using check_add_overflow()
for vcn accumulation.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - Validate lowest_vcn from on-disk metadata
 - Use check_add_overflow() for vcn accumulation
---
 fs/ntfs/runlist.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index b213b4976d2b..ee68258ebffb 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -749,6 +749,12 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 #endif
 	/* Start at vcn = lowest_vcn and lcn 0. */
 	vcn = le64_to_cpu(attr->data.non_resident.lowest_vcn);
+	/* Validate lowest_vcn from on-disk metadata to ensure it is sane. */
+	if (unlikely(vcn < 0)) {
+		ntfs_error(vol->sb, "Invalid lowest_vcn in mapping pairs.");
+		goto err_out;
+	}
+
 	lcn = 0;
 	/* Get start of the mapping pairs array. */
 	buf = (u8 *)attr +
@@ -823,8 +829,17 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 		 * element.
 		 */
 		rl[rlpos].length = deltaxcn;
-		/* Increment the current vcn by the current run length. */
-		vcn += deltaxcn;
+		/*
+		 * Increment the current vcn by the current run length.
+		 * Guard against s64 overflow from a crafted mapping
+		 * pairs array to preserve the monotonically-increasing
+		 * vcn invariant.
+		 */
+		if (unlikely(check_add_overflow(vcn, deltaxcn, &vcn))) {
+			ntfs_error(vol->sb, "VCN overflow in mapping pairs array.");
+			goto err_out;
+		}
+
 		/*
 		 * There might be no lcn change at all, as is the case for
 		 * sparse clusters on NTFS 3.0+, in which case we set the lcn
-- 
2.43.0

