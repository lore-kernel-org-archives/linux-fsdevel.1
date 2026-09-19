Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BA393DC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856764; cv=none; b=ebc12FQku64o/2mgZ+6tC52VSHD2i/XAVyKYySeDnFUxtGPPoBJ57snX3XdLOptwGE3h7T94sKmOiLvS++V1hMwAvsGJcZXk9zOKin8uf0N+scWan6hjIgZoXSVS7XCzg0rziyIZQsICW27YlgRIyd+ipQ9u4vOy/28vFAGJ4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856764; c=relaxed/simple;
	bh=kmvLVl6fNpTzlloPojavr2VRqjhvKz6lutasv3yqTt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TL0yySDARGdqy8y9FhfFTT1bE0+BceCVr+cGiQ64KRcSSGnAqrzGARC2rBy/NSjqWyj0IgLCq6m0+uQNXJKkBtF9GGOwwipV6tPxrOtYqlHYFIOch8gQppVESQSW0g4n9pwLqPlRSpOc+DThRicm97VbcF+VK5Q+6pgY3mm6r3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekZZcoRJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekZZcoRJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91a931f66so11937635ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856761; x=1790461561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=57LGgaZ85OdGnj6rToiVIYTXeRS90SMHsMWqvOLknbg=;
        b=ekZZcoRJUBpVUrQ3xrPhfaa8+M6pnQKrZLFoa7DYGf3we+dtYgtJtlCJ6TI0XMCY82
         XwQ4t5c6A3pfOzsoU7X6c2353zsUQ6mXHImX5JvyVfyA+bZg/RrJlmkqx0Bf4J3sE409
         Qw55CTM0OYoZDF0mZCt7OoF4lFkmfO8sUmABfs+1YoCWY/LVUCJFA+s3su7nASq/i97X
         MSZK7d6GK1dK5Djd9FDs8hFx8P8ZEU2LK6YVdnQeYOcSfFSSm9jDuQut2eybQqgtBF7i
         sgs9tOwDQW5kgSTznbsjyYW94pHKqzkV0q6/Gbw4d8WsBJoxztT51n6tmUMOkg72hVOo
         NbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856761; x=1790461561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57LGgaZ85OdGnj6rToiVIYTXeRS90SMHsMWqvOLknbg=;
        b=IrVe74ZqINg0vGiZXztauE/UB5ZnClxV5TvjU+1Ynt6U6TW12hVK9Pr8NH/eFH85Lt
         8E2b9FJiuleXRAAHpVvhV9jgLfxFgiS8TDGwKWpBiKJXl5A6KV2sJga3PNzPSf6hbfVJ
         X8l4E1sD1Dr35TydejkWdNuhKozGW6N2EyvrXB/HcT2DS16xT8b1HLlqeTkf9zLS/V2V
         gZu48ZXa/WuzU6hJj27nDKhcdz2fKQ5P712vSfrwzfWv9RJCKEP9gOatAq3Q3CERoT2g
         Gim9aI2IlHlorz9divBqgCtsJK4ed9LEgy0zpuqOECZk6Sgt97k4NXGiSvsBOwDRLiNQ
         cdKg==
X-Gm-Message-State: AFuF++kUi8/xb7OXB+3ifLLqaaCR6nnYk2vYoTEsli3+lgYWh44cbo+9
	ASZL8sDmRodLrTERICY/CMv7UewFXAYAPmCsWJ9NjUT1H/MyhT2eZQ6pWFYqc9s8
X-Gm-Gg: AYBFou3rXTSxPUviwRr/wmIx4MiRDy811zK/Yqs284wecgfyOYvtPKyaAA87nsocZX/
	Yvq1No8ZLk7Sf0nofdQlgXutTbbecR3IN12riprTi3f/RKbk/0bCY26naSLsD5sqKwfrHnVlsPa
	9OvcnfyG0vJxaZUaooiXiOOhmv3nLFx3OO3y78lq/UBVk2ZHtcxawOBik4o9l0qjFPTqVwCpZpz
	Vm7EQZQUo8GHSTgTV/OMWkb+0tEfYZ9D0F6ZI4gno3J+QYGfhQbbRosBRDCe1qyE/1en/NaHXXh
	be3NytZ73swgdX/UnyIWcxJbKy3cnipFBM4IRsCBnZQrng/OC7RlCQdXpHs+pQ1qZrHw7ROtVTC
	sUH8rG3e50sbJOIXtnKyOPkZeyTHMLkxiT8d8/vfP3F8oTAj1gTm3zJb7hvmznbntJzT9bcyWiL
	vmAr0JAD8i5NxMKkOLfHrlPwrVd+VgkzUXJmt3ab7ULUnivF674R307YNTidudiTA3Ig2eWgoYe
	YRmOJK1iHUoHntVzgWoyTEoIlb/G3IuU1eIpYL/RN5QFjHR2DnpFMBI+IkPKqXSDmWioAlXm/pG
	+y1nIWZIvw4=
X-Received: by 2002:a17:903:19e5:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2ddb1ad9adamr114334675ad.7.1789856761227;
        Sat, 19 Sep 2026 15:26:01 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm13049925ad.81.2026.09.19.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:00 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jack@suse.com,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: validate vat20->lengthHeader and VAT inode size in udf_load_vat()
Date: Sat, 19 Sep 2026 22:26:00 +0000
Message-ID: <20260919222600.3793513-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In udf_load_vat() (fs/udf/super.c), validate that vat20->lengthHeader is
at least sizeof(struct virtualAllocationTable20) and does not exceed the
mapped buffer or VAT inode size so computing the VAT table pointer and
entry count cannot underflow or read out of bounds.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2ba5973ef4dd..2f0f087bcced 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1252,6 +1252,15 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 			(sbi->s_vat_inode->i_size - 36) >> 2;
 	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
 		vati = UDF_I(sbi->s_vat_inode);
+		if (sbi->s_vat_inode->i_size <
+			sizeof(struct virtualAllocationTable20) ||
+		    (vati->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
+		     vati->i_lenAlloc <
+			sizeof(struct virtualAllocationTable20))) {
+			udf_err(sb, "Too short VAT inode size %lld\n",
+				sbi->s_vat_inode->i_size);
+			return -EFSCORRUPTED;
+		}
 		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
 			int err = 0;
 
@@ -1269,8 +1278,15 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 
 		map->s_type_specific.s_virtual.s_start_offset =
 			le16_to_cpu(vat20->lengthHeader);
-		if (map->s_type_specific.s_virtual.s_start_offset
-		    > sbi->s_vat_inode->i_size) {
+		if (map->s_type_specific.s_virtual.s_start_offset <
+			sizeof(struct virtualAllocationTable20) ||
+		    map->s_type_specific.s_virtual.s_start_offset >
+			sb->s_blocksize ||
+		    map->s_type_specific.s_virtual.s_start_offset >
+			sbi->s_vat_inode->i_size ||
+		    (vati->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
+		     map->s_type_specific.s_virtual.s_start_offset >
+			vati->i_lenAlloc)) {
 			udf_err(sb, "Corrupted VAT header length %u (VAT inode size %lld)\n",
 				map->s_type_specific.s_virtual.s_start_offset,
 				sbi->s_vat_inode->i_size);
