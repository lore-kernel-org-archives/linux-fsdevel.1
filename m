Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F02566D3
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151734; cv=none; b=Ep+x7RSk1w+jG26iKeAbGBkmcFKoya7Tbe36HhUh/8CtjkDVzNiwvMzdf9z+72OQCzHQ2hiyjKHLgNkXAUXjxpGiYYKfMGijRDCoQEpJ12OPIYv077L3+vLLQ0geFyhCuwLb1pByn67gAheCLvpe5WCLjKR5w5gw5EczchFId/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151734; c=relaxed/simple;
	bh=ijOuRHPAqJHZAughCM9VYDQ6TyLb0FcaeFQA6fy4rEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCfI25TgGgfCvQXpZfkUQeu9TbgsfEhSVykghjCpwWrklvKYIL0hqWkGuTJ421jn8VQTDBh4m4upolJILX4f5Qc86HRlP0WIeIyABmHuNafn1Fm0EXswmkHHGIMkIPtXa30XFBrtEe4QjlVioXWUXE/NYd7OiiWZcgo3/7rq1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgFF979y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgFF979y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b4d634bddso407072a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151733; x=1780756533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDfvTLy1+sJMtcgOCTiZxQEYHCAfpO8m5RiCueB0hpU=;
        b=BgFF979yQqBJ2IfV0n0QAe7fhjE9Hrw5cv2O1+1m+WbH9dBl0iOPjfIX3bfb3EGtjI
         Jdmdl9txzNo+H+vDgIQW0RRgXX0rrCeTZ2IQ/7/EVyKnF6XT1rGxtfBBg4S89hfpcBq6
         RLjH8oy/Lx7mciOvIzMYCpqUjb+T0lk4IAn8FJ1K+n+KOIJ6oOONbv/WdKCpAS78gL08
         sIJPFA/gtjFL81ToJlGL6kXp1Hy7A5Qu6E8OSEuetgZaJynhU0YBaX+1Sg43u7spbdGF
         fR0l3FQQakdU1853IopmL2ErQ3g5UwPLyCAvRm53nftwZ1jkhCh1vIcopRS4G6UgvuP7
         dq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151733; x=1780756533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDfvTLy1+sJMtcgOCTiZxQEYHCAfpO8m5RiCueB0hpU=;
        b=k8jddHCsMum0bPePg676z9LrQqYSzwMI6W3DAPn/DBzbkTSHWQI/PV5BKZ5I7sI8Dx
         QtU0R1qp5Lz1L+RLOt2ZWec9r+tXnszXaKzVB3ZHTOE/EC5L2XvKnAYYbpiFxF05DvP6
         PqVqU8wMGQg8+eZY5rhx/ijLjaf9qzqbEwkYMlkyRGr6ikjCddU754/jH6a17gyBkCaG
         FpRnbwjWUbXtc5n1DmsBU1LZkUVCTZl16uZZNPYfh4CNhiRisz8uIy9NrdkTZ5n8aka/
         UclBlikcaViy6uO/ES2TZPeEDky6H/OtaCqTgjsAY9uYKEnIf4ycZ1D7zu87Cy/j+iCa
         yy7g==
X-Gm-Message-State: AOJu0YzokxoVqJhEdQmzTaRRqRmOSU01raEkKhj9q5rllXVp1plg2Hhm
	R9MnHPayY+2YYS88AhhowBIkWeBV4/Q9LziTnGO6sZb1zw6f+SUFs+dr
X-Gm-Gg: Acq92OFyDTdbcobTwP6ufEiipNzpWWzutUG/qUwIhIW2Mj0P2mvsxt+QnGHA6xbfZYU
	kApI36fsn3CgFOV5lkhcIaDbx4A4fXI2bz5R+tt+a+GKzWQRuFO9kkJWgx5Jzq6A4yRPq9F//3g
	uL6pys6mV2tTWUa/x3+Eefgl65UzLsEeLMEs3AUPNZxdarpx+/rRBCqhF9V2rdszhbTZJR1jdB1
	sQ/nCBwC08Pv9BjNJ7LC18HT/pddiy4K2aea9uMxRpBkQVxgDXxhdejsCuF8QgEe6KjsVRFpSGB
	eD75aYr1LCmBXgo0qMrCC6/OCW4+QNRihZdReaNvdmyWNrknfI0X8JYiKoK8zZjIKu7hfZiE2ZE
	F34sq6HP/Xy0wYlnLsqKWLOBRMVDNpjGq6IWzVeeE4kOzH7lagjyaeZIb2FDycvtUy7jBEGNHKw
	2KiAKv3gNMBKBTQEg6ag+Jfa3d4H0=
X-Received: by 2002:a05:6a21:9189:b0:39f:a451:4a6a with SMTP id adf61e73a8af0-3b427e9c7c1mr2162463637.5.1780151732474;
        Sat, 30 May 2026 07:35:32 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:32 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 4/6] ntfs: validate resident volume name values on lookup
Date: Sat, 30 May 2026 23:35:12 +0900
Message-ID: <20260530143514.3083601-5-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
References: <20260530143514.3083601-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shared lookup-time attribute validator now has a safe caller path for
$VOLUME_NAME corruption: ntfs_write_volume_label() no longer treats
lookup errors as an absent label, and the mount path reinitializes its
search context before continuing to $VOLUME_INFORMATION.

Add $VOLUME_NAME-specific resident value validation. A volume name is
stored as a UTF-16LE string, so reject odd byte lengths, and reject
values longer than the NTFS volume label limit. Empty labels remain
valid.

Also reject non-resident $VOLUME_NAME records. $VOLUME_NAME is required
to be resident, like $FILE_NAME; a crafted non-resident record would
otherwise pass lookup and ntfs_write_volume_label() would remove it as if
it were a normal resident attribute.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 98e0b8ea2edd..7e293b85ad19 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -607,6 +607,14 @@ static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u32 value_
 			value_length - offsetof(struct file_name_attr, file_name);
 }
 
+static bool ntfs_volume_name_attr_value_is_valid(const u32 value_length)
+{
+	if (value_length & 1)
+		return false;
+
+	return value_length <= NTFS_MAX_LABEL_LEN * sizeof(__le16);
+}
+
 struct ntfs_resident_attr_value {
 	const u8 *data;
 	u32 len;
@@ -657,7 +665,7 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 	u32 min_len;
 
 	if (a->non_resident) {
-		if (a->type == AT_FILE_NAME)
+		if (a->type == AT_FILE_NAME || a->type == AT_VOLUME_NAME)
 			goto corrupt;
 		if (!ntfs_non_resident_attr_value_is_valid(a))
 			goto corrupt;
@@ -676,6 +684,10 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 		if (!ntfs_file_name_attr_value_is_valid(value.data, value.len))
 			goto corrupt;
 		break;
+	case AT_VOLUME_NAME:
+		if (!ntfs_volume_name_attr_value_is_valid(value.len))
+			goto corrupt;
+		break;
 	}
 	return true;
 
-- 
2.43.0

