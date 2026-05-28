Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C127F017
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934557; cv=none; b=K3iCZyWNx7q+AwjKcWGKOhwHWv13e8dWDMcH2tuRcMBYv9TKyQE/YsBLfva5DNy5KoAFxJhGBfU6n7wk8Nsfzow2DX9NWnKr617on8fIEuPc0V9Va4g2jkyQckGMzbdTLXtk3qU72vbtej9ntw9ehpxa4gnS3S2f81VIDHJWPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934557; c=relaxed/simple;
	bh=cTDRdOQPPIBJHJS8UtAzmhpnUyPrrU4bxmh03cAS/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nb+3Nhag2l7LMkzDH8xzOUZYfU5J1Vjrfo3Ogr4Wz4v/ORitN9SPuUEAshf5fxfkhxHp5Vn9xJSwdjdbmoxME7EU+oxEM0bL8lJBoedPtnQMd9FucfthgoH6Nw0Kohe8wRs1Dnzw8kAb+FP+ojOySR/DPUwKmZWATUX4B0COFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESiqEVwh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESiqEVwh"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so16666a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779934556; x=1780539356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qKTx4wwwn/KnQj5P1c8u+QpqNSgMGAUsRjMkSqVvk4=;
        b=ESiqEVwhcJKbNTU8d0lhrsqjOwTZFxsNF+0tg4WgClraPnwAXw+QorWPLlNs5YnsBJ
         uGXc/nauYt7EThMjKtXCAsD6+kbUGjYWzW30LT+agq14PNpJadQGC9n/pgoFYNoYQUTG
         lqJEeLrSa48FXg0gQ5zzkohVsVrdvebKXlpIHsazjBCIowXpWT7eQtF+uGJTVAWxTOzl
         QTxQ7+tUdXJAjC/loHeCvc3EDh+3723wMVA7FhUcys1HfBNGRG4mW6o1k0B7f4nrHG96
         dfJMazN2uGx8mXltYyR8seOezkzrNjx45yh51IRmhDR4iyaU1LGB5E9LRxqV7V8JH0Fs
         TeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779934556; x=1780539356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qKTx4wwwn/KnQj5P1c8u+QpqNSgMGAUsRjMkSqVvk4=;
        b=f2SompI5Q8zFblKSEZFkJ3WvW5OinuoepIS3uIGodnUhY2orzqzgDrpWSY3rTonYym
         qMHWLrl/xrGTRhha1sAdMEnjajvbFvAYtbeKe1n3D6owyaQmmvpiiTJEKFFksGc8JHHs
         xpRNc1tsTcp+cNzdMN71Q+3Qn8tAh6UoC43WmbmhHc1vizwCnH6A0J2dQjmRKyW/lweY
         i68jxX0dFjRyrw+mZoTaxfbUh6Ie2kOchf6BwrJfuO7oidex0bpIuyRQytIYp1ZS7bsL
         QYHVCbAZ4l6N5xhBOXgmNLb+jSojuWAIzdb7nDn32Uq3TL/PHoVPOALqS55XeqRp8o1e
         EF5g==
X-Forwarded-Encrypted: i=1; AFNElJ8qU3wC2saieNY9AsMT3OFgOw6j1LOvOT6OEJ+PxjG+2imDcEl4jTSOAoiE7z/XRVd+XQoHhhm1Tu8wlLxO@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSa8M4TH6+FxEqZ5b2GuFDaXLbDA6YfOQJYFJXQ/qHthNZvX0
	w96BCwX3xMgWE1w6TIk16gdOiXgJCXwwKFqjSbu54IK3tQnC5DDA93TvBJhsCg==
X-Gm-Gg: Acq92OF4DEJ1Nb8VYuV2qwGSy1lVCFe3eKQLm+ajZ8+BuS6IphoeBX8KBVcBF1MzbyT
	KORblqhR/fgNJL/Z35tnMZJ3UwmoQVINMiyIkxtTYRgcFBbJ+qhoYmpNidJM6KJX4feMxpTh48r
	5LtYsnUOQ0G2oWSsq5P1J/WfGKBfh6ZaIkSOhM+Ff7ZZpwOuJTOXrPziGVTcVWtaDRmWYgI9ZuK
	37eRL0vpVJDSu/9Qo+doJUHDL03rca4+7EWcMBce5gtsvufjTyvXllwTL1lSaa5xOhuZCLfceCH
	Z1PUlNKrPkkLeQ0TS2Zn8FI726RXezVmTUYdLETanFRXf91WrOgxwU4IgtpSJQwgM8lQpqRoLe7
	Ya6o5NfDqvFV+zWKLGsWL2wnrlAv1WgrbXtTo177OznNd55dgz17gGcPS/+Q78vJtxyuJSiZAo3
	cFHzBMq8ag3YRvTC3pUl0UtieFGFl8bHrNO87B9mrlF7i+T+Pb8B4=
X-Received: by 2002:a17:90b:3887:b0:369:223a:cb60 with SMTP id 98e67ed59e1d1-36a674558fcmr23292850a91.8.1779934555746;
        Wed, 27 May 2026 19:15:55 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b9090b6b7sm223234a91.7.2026.05.27.19.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:15:55 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: not change 0-byte $DATA attribute to non-resident
Date: Thu, 28 May 2026 11:15:35 +0900
Message-ID: <20260528-f-0-byte-data-v1-1-9f36f5ce39b1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=cTDRdOQPPIBJHJS8UtAzmhpnUyPrrU4bxmh03cAS/Qk=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqF6UFr7Q2QW/zcUfkpuUJK/6R99k2b5X+QQRO0
 Oh/cFQrXreJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCahelBQAKCRA08jD6945I
 00cxEACWQZm6mmEBizp8h3eOL6Md6bxlVMGPCAQd7EdEQHLz2MvHfE0Tcnb0bAvna0HoAyOMztD
 UuZEwsLj32xcFIzquMdDuqPGBr4e5XunmP4o7H10vOsIPKspVShiVpYhf/AfhDbR6VppCXYlinB
 fShlyTEEE9n2N8BiLVAiLNt0J3f+SsteWAFwr2z7ej4DO7GoRS+f0FaR/EYsPIkWQ+S1duej5mP
 xzkyeCNawgyCputWr9G5TEJe+Su8K6b5QB10StRlbseT4VZmEcU+bfy1PstcT+mTPdG63xIKhyA
 8NvG2qRRdEP9zembDoO3goLrVlQa82CTBfbbgVoV25v3C9GDcKg0DhBLZkMB+H6c7WfbrXX5o47
 l97XpyDF+zP0WUN7k1dIs6nKknBoPpC3YY+pduMaPrOZUSjBidTY7tESIUm9974YymkNKeU4gKU
 uThv4X0Ygf9T4N2JGGf2DQD3FLygDMc0Wl3yxnw5oRCaX5OtXo2IO/rC5NSAS2h/HLsRQydGQ2r
 RqI/6MfBOFS/Nx7eePi5DewoG4+IYhHB/kUpoUissEXPvIVQvdOEPrDRR+oLMQxdSgK5MecirA9
 /vXmZeFXuyC46lpXcnXa4d/YnkcfA7KhJ/1p0CpZcYntcvlTRyeaHNHxbGXNLlGyXSs6Z3gUXa1 /CTT8TifUey1Gvg==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

When ntfs_resident_attr_resize() cannot grow a resident attribute in
place, it retries after converting other resident attributes to
non-resident to free space in the MFT recrord.

Do not select zero-length resident $DATA attributes for this conversion.
fsck treats 0-byte non-resident $DATA attribute as corruptions.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 9d676375f25c..2872b4ce1835 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4537,10 +4537,12 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
 		struct inode *tvi;
 		struct attr_record *a;
+		u32 value_len;
 
 		a = ctx->attr;
 		if (a->non_resident || a->type == AT_ATTRIBUTE_LIST)
 			continue;
+		value_len = le32_to_cpu(a->data.resident.value_length);
 
 		if (ntfs_attr_can_be_non_resident(vol, a->type))
 			continue;
@@ -4552,6 +4554,8 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (le32_to_cpu(a->length) <= (sizeof(struct attr_record) - sizeof(s64)) +
 				((a->name_length * sizeof(__le16) + 7) & ~7) + 8)
 			continue;
+		if (a->type == AT_DATA && !value_len)
+			continue;
 
 		if (a->type == AT_DATA)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
@@ -4564,8 +4568,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 			continue;
 		}
 
-		if (ntfs_attr_make_non_resident(NTFS_I(tvi),
-		    le32_to_cpu(ctx->attr->data.resident.value_length))) {
+		if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) {
 			iput(tvi);
 			continue;
 		}

---
base-commit: 47a20013412ac44a71be899c206a2dc71c7a5dd9
change-id: 20260528-f-0-byte-data-ff696b1bacf6

Best regards,
-- 
Thanks,
Hyunchul

