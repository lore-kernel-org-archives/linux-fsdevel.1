Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2198582BA0
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971557; cv=none; b=FcxZ++FozLW7KZ0QI7sbU2l75iFrQf0HAQ4VS5igjTGVwnUaoVg+aucWdfUGtPXFQn3Vm96da8p6LRFo3N2rg6lT5bXdE1fhwEKg0DX3Qh6+krBzrB7vhRbDVwBISVP7DzJhxbNsINsctc9j/aI7xAWpUXMJ9DSeqe5t9ryipX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971557; c=relaxed/simple;
	bh=3yw28iVcq5k+J+M7mY7eeePgOPQVc3pxRbGi7Y6OLOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPurycvoaz0LoYnlh1KLAkWAOnWMgQBBPND7lIA4jX0l4IK4yLwgFOYnIeVqgSfBb9TB/IgddqjXiv3OrS6rIUeodis9k7H/dAU8TB+V8ZP1ekI27Otpto70H6iPzqTog5KJ+IrbrkSRw0+oihBhGyIN5wknhsruFczX/6Jf9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxF3lZxB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxF3lZxB"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4cc6797b7so3344987a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788971554; x=1789576354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVXEIU1yhRw/bbhmjo7A0XK8nTRQ4MeU4yLdlyk7vyY=;
        b=UxF3lZxBwpA+uU3/Yp2F4okGh9WpNLXSDTX+pPpVMw7M3kQfWGC25Y9jvCZPeuT7eA
         OPhXM9HYURsDY/PqillJSrqedE1RrNK7pSuT1wOVNFuTZT4mqHITkDP1AELXH07sOnGK
         rUDcQEx21hgs82Tz76FEDsnAulTi5H9G7THgUl9nKOJVn2XZ/NqcsovEg166Xit2SEPz
         UrF1K6YEParpqDmrV8KX7KUb+FG4DriB4mRZtFQMpe2TGdksterpL7BckOuHgLrSI+Gr
         qdqU/uJr0LscmSbjSHzZjMdKRIg9JLs7ZN/XrEw8AXEx/eK8Ti7aaPq12IBdQezhGSst
         ouIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788971554; x=1789576354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVXEIU1yhRw/bbhmjo7A0XK8nTRQ4MeU4yLdlyk7vyY=;
        b=gxRFDCP7LHN/ognqy1kTLYD5Ybm595hOv1xN/xed5RnLO2atL2Ay5djvNNQkW9rgx1
         B3tX1Ppaor/eT62D1C2SCQJeGaoNLwH5KRZjv+MjxrszfO4azCJoADaPvCvE5zeyVwGU
         DxkrTeHZLaWXSnZZuJcwqv4G/u38KmS2ycTpjf9Hxoy3nz5j3RIgPyWNnZw2EOkDCohz
         YrDcHyOn7uwUCQmMYaeeS688aEOWKC5rqnzBle4Aw+xQlJNZrTSFrAL7Q79CmxomB4/y
         /qUidNlNjM/DYoRTyQuILXo7Xny6Enm+uimAXWotdjgqI1obEQ9ciMcvhEr5RlduX6zA
         sK8A==
X-Forwarded-Encrypted: i=1; AKwUvBzekDg6SMQSB8x0FUlOOxQvlDdwXtz9Og2d6zpQr/plPvfNAxT2dEubTECQq1o2Cy6b5XklRWeU+1ow0rBg@vger.kernel.org
X-Gm-Message-State: AFuF++kCdYzIGDwVbS8dYNqThY9kK1zVE4hBwZ5GGy281dfH2WTDAOra
	JbXqJDRsBs0bU9+daFCLeGlHSydt/iKbZdoAUT8G67iKj9kCRiADKH+M5etGltOpJl0f8uRr
X-Gm-Gg: AYBFou2fJiojofb9jou/UHsEF0mIpm7kTuyMXTSX10ri3vsWqnjsK4LaJ9rMn1EGYkO
	it42f2CUljaFC+wiyXMrH3BOkR1XgG7Q6fqewMTUarTpe0vK57JpFFvozvCdqxloJdCkVEw+ewq
	ebCeZZFXyt8Ct3HyozhgI6TQ1EIX4QmT9C1ahEHAIy+n8vP1T02lBcyJrkWw9HLQbw6ZLli38d7
	twovov8w7cHDedwXMTjq6Bz0rQWeLZbNUVT7SapAdDHpBEElxkzRN2cjQuVWFCoO/AelNxxiK6t
	xVYcYntY1iSRRToapA8jH6hrvFFQMuzYVfWBU6p2l1zQ0Re95SR6cGo/eGTEAU6k9l85MEMYH4H
	1XfPriNLPhaolBX2S2E9exq0FBIh4bAGRtL0Foyp0OOtPkYSa4Uw9i/KGHlKxJuFgQxwAq8Jd0f
	MXLsa8qVWYSphO4P0bdMZPV3ORmshNFX5nEPHT6XUlOciHvfDsZl+Txwd06gqlvMAvGQKtDPwLg
	d7na4Y=
X-Received: by 2002:a05:6830:6686:b0:7f4:c88c:7b10 with SMTP id 46e09a7af769-7fa20de79b6mr22398088a34.12.1788971554406;
        Wed, 09 Sep 2026 09:32:34 -0700 (PDT)
Received: from fedora ([2a0d:5600:4f:22::11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6794e22sm17115595a34.7.2026.09.09.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:32:32 -0700 (PDT)
From: Safety 1 <git.userk@gmail.com>
X-Google-Original-From: Safety 1 <176830914+JokerPython3@users.noreply.github.com>
To: kees@kernel.org
Cc: joel.granados@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Safety 1 <176830914+JokerPython3@users.noreply.github.com>
Subject: [PATCH] fs/proc: avoid unused ctl_table entry in init_header
Date: Wed,  9 Sep 2026 19:32:14 +0300
Message-ID: <20260909163214.245399-1-176830914+JokerPython3@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entry variable in init_header() is only used by
list_for_each_table_entry() for iteration and is never read. With
-Werror=unused-but-set-variable, this causes the build to fail.

Use the table size directly for the loop since the entry value is
not needed here.

Tested with: make -j$(nproc)
Signed-off-by: Safety 1 <176830914+JokerPython3@users.noreply.github.com>
---
 fs/proc/proc_sysctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 04a382178..ddc510def 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -206,9 +206,7 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
-		const struct ctl_table *entry;
-
-		list_for_each_table_entry(entry, head) {
+		for (size_t i = 0; i < head->ctl_table_size; i++) {
 			node->header = head;
 			node++;
 		}

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.55.0

