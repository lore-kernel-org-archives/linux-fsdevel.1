Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0D3A1CE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358690; cv=none; b=W0ktcGbl+pAHezelZ6esVbsBauTWqGgE9KiFpAAjUSS2g2YAvNCzrDfGiBdPCXhFbllxJYErou1LImxULpAcqXqFOJs1Il2YpwMMIVviN3YYVydfEt7E5FOgwidg1ToLa2IRXC42N3w8SqrongoysXu4Vccnrf0IGi0vweIT6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358690; c=relaxed/simple;
	bh=vwsQZ2R3eKTkCSRO/SpyoNW9ls59kUMMez9Nn4L1k78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtbUqALbqDUPGsJK0lJrVpPabG6bDECvtcdwVvqJgXaPNuNiZKK5ZhoNGoADuqyWW9B0I53uS84UNBYxlZNKxwn+EFF1azXvdBQ7I6vSyIMGSXqqaWyVUJOAA65NLemp+t6BDhpjz9CUrdOhxYoTg7XwMl4rtPGZGhun2TlWBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsUX/LBz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsUX/LBz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-365e579731fso883528a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358688; x=1779963488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FhPZ6mwbYBBt75MdFT5zKA1xzkMlLRUIuzLsq8lvBg=;
        b=VsUX/LBzf33hxA1eD+3CfsxDMlLPBta2y2MpVfH0AOBMGCe5DZV6SV+N73JmY9/WHL
         gl+ZJaLC4wYG3cl2UnyuMed2L5uuNS3/Ork/G/pEKKYN6nzodSbWKtSdx2j4Y08jMgiW
         HuirzGp0SLHbvRCCx3ePO0KHy6wEQhPPIHHW7ZdsVqYqclMleKAz15H6i8soW65zjaFL
         A2ChrJ4E7UJmd/CA9BRbTRjarjlmYV80GePYmOqOk6gZ7pprHaArQTmyaIlsG5ImdvZs
         M2n/mLb16+nCIavCSDe7BWSMs1yrkmXpV/IFf/KCH8Px1w3wUCBC4iRxk+1I8kyap5nF
         56Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358688; x=1779963488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7FhPZ6mwbYBBt75MdFT5zKA1xzkMlLRUIuzLsq8lvBg=;
        b=gV96XkdKJycEwJ6jjziOGOAoSWeaEtnIj0Wzai5QDMfY5yjnCDfj3XB9efXxSTT9gb
         Md8l6frT8uYL5Fh48peSC83PSvgsvSlWp96uPpT3hiyj/qKHXG2yBhu/DXp2Bj1x2wvZ
         hIPs2TQ0efw/yFfC6LdWOC0bvjFkIg0yHL+hBwyZ2JdU/hLpY8y17T7CAyC7Hzwgqaaj
         LyIVeAP3CL8zHkvM4qFZUd1+N026cBIXrEvk6/7CilxRGVQdU1AbQWq68HtH6emzIdpH
         dIK5WNO6W2l0xgLksxF4YsIkXQP/WAOkE3rzZEm7pmdt7dfN3wDl7ovEDshE37xtZDIW
         1N5w==
X-Gm-Message-State: AOJu0YzCSL92pQoIO/BHtHgSd0GYFEoNZoWPqlEvvprsKg2XBhDJBZbM
	lgWx5/i7NbBvc83qgtt6+tS3lAjbceZKuuAazNxcvDpEqS/p5esUUxfA
X-Gm-Gg: Acq92OGSSZeT22Y8EhhKJVDo6MtEdJg88nKtoz5Uj1W/dTTq0syX2AKnsE4b7va7oMj
	eFUzKI7L0rkOWMoeu7U7J/aIC4y5DwMOyWEoxx70hKBAMYFh8+XqnxCR7NbukTmteGTEHRqmpFr
	v+99wCLMjYSybLdZPZ1RyqSxyc6wQNRkRle9EuDaBC6kHW23rnfeaA6r5G0/uAfZMlS6kGRbI54
	EYi9qhF4ZsvYMci1AMWfFNogomBYDFbbXA+UipHckDT6b+6kgdJZD/1RweP0BgdcFuSD0GNLBU5
	BJzA+CYuxnbDynhziyFEAYYLlQpMizNJnYNN2XwyK890Q3snLT3q8xJb8ib+TqwSARfbXhSUj2t
	NYN09T2k4w8xAHP0aoy4mUtnO3ULrLo0CNDmSk0YKNmBKOgOF3ma6tSAqYswPuMhEAcb7mbfqTh
	sLmtWiisJ/8JzD6KBo
X-Received: by 2002:a05:6a20:9f08:b0:39c:68ed:9a39 with SMTP id adf61e73a8af0-3b308791329mr1429889637.6.1779358688285;
        Thu, 21 May 2026 03:18:08 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e1fc86sm1197799b3a.44.2026.05.21.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:18:07 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 3/3] ntfs: only alias volume $UpCase to default on exact match
Date: Thu, 21 May 2026 19:17:51 +0900
Message-ID: <20260521101751.591345-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521101751.591345-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521101751.591345-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

load_and_init_upcase() currently aliases vol->upcase to the global
default upcase whenever the shared prefix matches, and then truncates
vol->upcase_len to that shorter prefix.  The result is correct only by
accident: upcase[] accesses in name collation are gated by upcase_len,
so the prefix-equality alias produces the same fold output as keeping
the volume's own shorter table.

Still, prefix equality is not equality: the volume table is logically
distinct from the default and should not be replaced by it unless they
are byte-for-byte identical.  Use memcmp() to compare the complete table
in one expression and drop the now-redundant upcase_len rewrite.

No user-visible change is expected for compliant volumes whose $UpCase
has exactly default_upcase_len entries; shorter volume tables are no
longer aliased to the default.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 14fd244f29fe..971c2822f5e3 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1323,7 +1323,6 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 	u8 *addr;
 	pgoff_t index, max_index;
 	unsigned int size;
-	int i, max;
 
 	ntfs_debug("Entering.");
 	/* Read upcase table and setup vol->upcase and vol->upcase_len. */
@@ -1374,16 +1373,11 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 		mutex_unlock(&ntfs_lock);
 		return true;
 	}
-	max = default_upcase_len;
-	if (max > vol->upcase_len)
-		max = vol->upcase_len;
-	for (i = 0; i < max; i++)
-		if (vol->upcase[i] != default_upcase[i])
-			break;
-	if (i == max) {
+	if (default_upcase_len == vol->upcase_len &&
+	    !memcmp(vol->upcase, default_upcase,
+		    default_upcase_len * sizeof(*default_upcase))) {
 		kvfree(vol->upcase);
 		vol->upcase = default_upcase;
-		vol->upcase_len = max;
 		ntfs_nr_upcase_users++;
 		mutex_unlock(&ntfs_lock);
 		ntfs_debug("Volume specified $UpCase matches default. Using default.");
-- 
2.43.0

