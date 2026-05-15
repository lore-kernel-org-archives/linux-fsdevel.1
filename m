Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3573B19DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862842; cv=none; b=WjBBz6nP5gqRSsVO9rEBuwqFtWFozy66bJK6Ecuu7/Qc97Ha18KutMRQ2eaqNpSD2RqVluFIyiX+mt2zHQwRm/e+Y+BU03GdtOBNRkATTXrumHgMd3NDhDIZEGCDOW0Ee4meQDfjr7RSVcOZcO8cSWiIzZtImxYc0iFusva4SfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862842; c=relaxed/simple;
	bh=3FlUiIkq8nNfO4gEt6qM3i6l+lwaCE8lbOgVEylPzeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIuAQxhX0XPUzziYPkZ51LSdtf2doQ5VttngPMp7dubsF2KMjH31lgJEVUXqK9XO8SyfpeAhAw+xcQRduXqk/8dvg9rqs4IInCXKbTbxODNTtx4dwuEqU12gGZd/rICJZbEDgThKNGg2oDpN2nvjXrgVfsNgLVFslpB5NoxOdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMoZjGjZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMoZjGjZ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so92353536d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862839; x=1779467639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3vUVjM/dzC2z0GaCVAFpFXQRqsDU20UVZqnjmL8hhQ=;
        b=hMoZjGjZIKR+vAnV60/kNb2odjlLcx062PUD6vqMepsFqnP0s0Svzr1fvtEN5iCcNA
         KhtLf4rFs6OU4ElzNRW9aPnJUbUG+rC6BoJ0eLRVLRlqclOVWho05UxsM5ACXUK01OTi
         QT42ZrT1PsXbQx6+m1SiRZIIJVf4VZbGmNBoUGm4c+ySKWOuwKK85jWAOQIXscjImkva
         H49smTmcBLJU/P/HpZ4WKpOfFpnr3atlyxUdsPAx+0Z8IC4/loo66jst1xxFd8nESAUN
         ukjk5KEFJLHhX4DHQCuu86SK7gQOZbsr8bA61Jh/Oc/JBbfOpP3bL2WA2b5fji0gEeeQ
         Jhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862839; x=1779467639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3vUVjM/dzC2z0GaCVAFpFXQRqsDU20UVZqnjmL8hhQ=;
        b=caRY8usvgZrWULgvsISuBE7n66r5UCWH7nXL7KnTjGmx1xfsltYnSOtUHIevji+bJf
         8RW/RRMEUGDDx9SdnXxtAqRq0Pbh5MhIh5AhuN9yQRwRUm+GUl5lnNk4qqHsIh2Vk8p1
         Vdu93cO/8D4iGX9lPklOraMjhIiZZjKyfdX3A3La+7jBQj8PGoaiSPLD+NyVkXnTAELv
         7AoNs68qRl8iQUOG90Ta8edr4ehddNlq8f+4aowFma+TdrppCiNro/FwT7FHk7P8nf1E
         uxn2/oFVKvwjSzW1KZ+8BhRQ3XAUFAbOrN5ELcQlxfpdrgCeSr+8PI7lt97wVmggxL+B
         I2vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pX7YFIqLfrB095Gyk0F+u6wXTNqZ4NCD3sW0tkzIvNe0G0N6exEH6jyaEiiVHm4xpGA3j8N332ejAi44Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwExldUAjomMkahfEUp2B37pCpjcQuCFNZjC2+jHoddBdcNmvDf
	qYayFFR8TFv24nvzs7fAePdj8sVbwkYAJGQctwQLhqOPPDQQ6Ugc46ycKtWHiJ4x
X-Gm-Gg: Acq92OHGNk+/Z0uXUFStQ0hQP75og8w6yJ7AOtogisc0N+Bcxvb7k7VQ/MYx6k1Y6kQ
	VeSSwoezQn//Fkk+OhSKBVFbWY8urU/fwB7Mt15cilKdwrRM+XD8D/piLNbuMfOLxfEWWsSQ/Pb
	MhFkeFdb0opdUILc8wYfkM8v5bRjwHZYQHtc/o6PlF5TcEbxO4ASrzOGqgX1a8E9vN18C35YSxr
	n/YxcYA8sIUCOtJKdvUNAPLs/j2V3ZCfdC5CdRW6rjL1Tn6wAaKY7A8b0A6B6vhmeEdX+4pmsIK
	mofXL3RyJQIWCz93AOynKkbizaAkZzUhuhbYG5Dn/Vl5OA+9kopOW3azX6YO8Ng2K6a7VT6LwKo
	Txfw/Wp6704lFtEFUkxEPeShiAHXFzYzc11hNcut7LUkw6QFb2+/y+flLVP7AbrCAYL07fDI4HB
	pfvNBB8d4Oedj/5XQGUPWnlCrn1TLKivHjshcWqc239r03uA/zhSych0SNs6GVKq/pln0vJAWiK
	CK075k4LUZbNhadMycT/QdfMIwSoMx8/Hko2z4s9AAAZSHZiOOH9w==
X-Received: by 2002:a0c:f08f:0:b0:8ac:a6bd:503b with SMTP id 6a1803df08f44-8ca0f5f704fmr67820876d6.15.1778862838975;
        Fri, 15 May 2026 09:33:58 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c37bc64sm54721256d6.48.2026.05.15.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:33:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fs/ntfs3: bound attr_off in UpdateResidentValue against data_off
Date: Fri, 15 May 2026 12:33:54 -0400
Message-ID: <20260515163355.1574086-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In do_action()'s UpdateResidentValue case (fslog.c:3307),
lrh->attr_off and lrh->redo_len come from the on-disk LRH.
When they satisfy aoff + dlen < attr->res.data_off, the
assignment

	attr->res.data_size = cpu_to_le32(aoff + dlen - data_off);

underflows to ~4 GiB (e.g. 0xFFFFFFF9 when aoff=0x10, dlen=1,
data_off=0x18).  Subsequent code that reads attr->res.data_size
to walk the resident attribute payload would then read up to
4 GiB past the 1024-byte MFT record allocation.

The existing mi_enum_attr() defense in fs/ntfs3/record.c:287
catches the corrupted data_size on the next attribute walk
and fails the mount, but only on the path that walks all
attributes.  A read site that picks an attribute by name and
reads its data_size without re-validating is not covered.
Validate aoff against data_off and asize at the source.

Reproduced under UML+KASAN on mainline 8d90b09e6741 via
pr_warn-only probe: with aoff=0x10 and data_off=0x18, the
post-assignment data_size is 0xfffffff9 (mount then fails
at -22 from mi_enum_attr).

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ntfs3/fslog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401e..4977ac1f62027 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3325,6 +3325,17 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		nsize = ALIGN(nsize, 8);
 		data_off = le16_to_cpu(attr->res.data_off);
 
+		/*
+		 * aoff comes from the on-disk lrh->attr_off.  Forbid
+		 * writes that begin below the resident attribute's
+		 * data_off (which would overwrite the resident header),
+		 * and forbid aoff + dlen < data_off, which would make
+		 * the data_size assignment below underflow to ~4 GiB.
+		 */
+		if (aoff < data_off || aoff + dlen < data_off ||
+		    aoff + dlen > asize)
+			goto dirty_vol;
+
 		if (nsize < asize) {
 			memmove(Add2Ptr(attr, aoff), data, dlen);
 			data = NULL; // To skip below memmove().
-- 
2.53.0

