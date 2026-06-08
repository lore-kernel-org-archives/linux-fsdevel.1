Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDC33ADBF
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933780; cv=none; b=NOAMOmNY55QfFoLy8vHfnQX/ZK5mU93GOjue0B6j+K7q0ArQ6PcARZMSwJoooCmjImTZnZUTdGKgEHMMSppq8DYtim4CxpFWVaeIhpVVSJeHoqGW8Py9UjRy51IFHmwCTTjzviKhTCiUuUOjdHRpoOGlKG4Ls2Jo56lXZVQ1oX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933780; c=relaxed/simple;
	bh=y8Ah02eZGE5R94LKgKZ0j7p5NoLSTMUMNDU/5kpVwyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx8WMT4qDG+Sud/YEBCdv5QMFbBg82SonkbQt27e8hFASjOHMs0RY9ap+njJ+oWeomwi4Q32cl757ryKBWUjT/iKgZXXqkL9ddptPlhEXHI25+yW7xqj5+vBdLvBJdKVdyzhJrpAj/9/jJyPmWMDCLxl0eBpffaewz7jdQtwLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojiuQhcc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojiuQhcc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f241792so137245b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933777; x=1781538577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMxc0vnL60+nkUbc3gwGXspn/XIsFvlD4dNklu47BYU=;
        b=ojiuQhccp4Nj1JLDBp2Hk11B8DizrRaogcqqLvH5tTbiqcykTNZniSf0RELD5iSxQF
         mlCnE1iSv69cmxs1zrcrT8yFvmyXNyFpWS4KthaHQF9RnixPuBcufVaMcKtkwIi7nAmT
         d5T1snMLQ1EMlBWQ5GnCRjUYwwOvDtDZPXyl/+d8qi08wv50w2FFg9qNFBgE0gh03A4I
         22gsZs4o9sCc/Q8s4l8tFNm+mT/McqaHH34Lr8sCFJN6+mGLm7oeJPXPktccJFsSHRvQ
         EfI1wNP+c0RQF1Ojj9kXsrq5VgLDEdc8EqPprWPaR92VlKiS26sRIV3RV8qhF+z0lw+r
         hENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933777; x=1781538577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMxc0vnL60+nkUbc3gwGXspn/XIsFvlD4dNklu47BYU=;
        b=XKw5e8/YQynJmGM9EldQ3G8UpqZxOny/NrIvLdresDqGk3oO2j7GblC80Z0/ifbH9I
         nvIjc6MNo76zBknLTwK1xn+dh9Mr2tjq43AD5QoUVRbm4MEJlXTQfvHCAaAfuDNLNO+8
         QrMyV37wq+DAZVw15aY4MCrohVChIYHBDN++yL8SoRUZ2LjhOlBpeWTyBHWkCv7yuRHP
         5s28PQJ94ywEGDfPbzOSqVO2BPdTRkpiRoZ4V9Ef3zdz6H3LLeFTS4xwcitbLWaJysOm
         Jk2bRkCaD6TF7OvEiFyzabSuzPJSQimuhf/ODuNSY9hZZPVMXfg4G2GKiuzGfZfWdAi5
         FV8g==
X-Forwarded-Encrypted: i=1; AFNElJ9JovsTYCYNmKSPLJMJvQbQf05pLeag7ce2y82Xepmp26lQN9mlE2gwCKgptf9z7Qp2KRZ/+FIjymbmYpy2@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbIOgLwR3n9Mm4vUf68kJDRITRN78TRoetZJ6H1qc0CEPUYqj
	H+hNOBxeYA4BF/oQHFTsQ+QBancwyABmntFJa3tLY2ke/TtP6hQ6YWiN
X-Gm-Gg: Acq92OFUjMo+89w7oPoI5rJPzzU/ra8cl4/jLOXTIPPjA1aH9dHo2G/0LD6U1t0uyqM
	IjjXzqu8tQjfKVnXz/QSEl51bC8E85r/kDIdBi7cGPwNJkHlwXXto1lY+9yrVJYrpwrP7YRAmu1
	oGDV4xpb+TNwph/MGVEb3iI3jcx8vD2id5euvbhy8iJGdbhLa4pmuKAngpT80cehnHs+O7HTDkY
	JshX8yuNhpXclTIk4qcKuyc6EovNfMvqDB0CahIfwQPJa12jXGJY86+PY2LRxcRtTIpIN3r2Blz
	WrXzsuVVx43k+UcFM3KniOUCPJvec4u9GRYy8tHWYOd2OjmZExNPHX068DCWxEXhMHDDi5stX1h
	GP3zEAjSif/CAs9+DpPapIzNafz+TuoALf/fU1eIaJhgCLPwpHzVp9piDDxjWNzgPwQ49Ob14Nh
	kRK6eX9zLik6iyzPAnaTX3gFT+8r8HGPlRoSviiA==
X-Received: by 2002:a05:6a21:48a:b0:3a3:18d4:2590 with SMTP id adf61e73a8af0-3b4ccf8e757mr9053112637.3.1780933776942;
        Mon, 08 Jun 2026 08:49:36 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm15937526a12.18.2026.06.08.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:36 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v6 3/4] ntfs: update index root allocated size before shrink
Date: Tue,  9 Jun 2026 00:49:16 +0900
Message-ID: <20260608154917.2703739-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608154917.2703739-1-charsyam@gmail.com>
References: <20260608154917.2703739-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_ir_truncate() currently shrinks the resident $INDEX_ROOT value first
and only updates index.allocated_size after re-looking up the attribute.
During that relookup, the resident value_length can already be smaller
while index.allocated_size still contains the old larger size.

That leaves a transiently inconsistent $INDEX_ROOT layout and prevents
lookup-time $INDEX_ROOT validation from being enabled: validation can
correctly reject allocated_size extending past the newly shrunk resident
value.

When shrinking, lower index.allocated_size before shrinking value_length.
If the truncate fails, restore the old allocated_size. Keep the existing
grow ordering because the old allocated_size remains within the enlarged
resident value until it is updated after the relookup. The shrink path is
safe because the new value_length still covers struct index_root, so the
index.allocated_size field remains present while it is updated first.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 052d80fddbbc..c5f2cf75b750 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1365,9 +1365,16 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 {
 	int ret;
+	u32 old_allocated_size;
+	bool shrink;
 
 	ntfs_debug("Entering\n");
 
+	old_allocated_size = le32_to_cpu(icx->ir->index.allocated_size);
+	shrink = data_size < old_allocated_size;
+	if (shrink)
+		icx->ir->index.allocated_size = cpu_to_le32(data_size);
+
 	/*
 	 *  INDEX_ROOT must be resident and its entries can be moved to
 	 *  struct index_block, so ENOSPC isn't a real error.
@@ -1379,9 +1386,14 @@ static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 		if (!icx->ir)
 			return -ENOENT;
 
-		icx->ir->index.allocated_size = cpu_to_le32(data_size);
-	} else if (ret != -ENOSPC)
-		ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+		if (!shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(data_size);
+	} else {
+		if (shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(old_allocated_size);
+		if (ret != -ENOSPC)
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+	}
 
 	return ret;
 }
-- 
2.43.0

