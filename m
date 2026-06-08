Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADD31E82A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933771; cv=none; b=eWh9SskP/HBOdfjGxBkgKfo9Ts7xPde86sZkSVEThtSXY+AsNHPMW546MHlFXP/5FErWu3CoRu9MC5LAccLM+D91cv12MJBMitO8fF/grDacd4/u+2PtkSfHFaWfPOkaOvEDqfe5pbZnkew1BGz6wPtbr6aFEHboEBNKssbE/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933771; c=relaxed/simple;
	bh=UPloW7wCBJ8A+fJCKHYFghT/wlBntz1WJRmB53j9Ttc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6kpYRFcZVKGbbM/+iNv48QMjnOixhaLL5xN7wXOb96BLuVnHejuGuGhud9+vAL+gOQrX3fIroYM5zoVaESBpFlHZUqAjcKjCW0L+BgQmuVyW2U9qg1z501+IXYlO+a43kYeykuBUFpLyVoqJQofaEqQYMELLrOl3/IzB9JDHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNEr/74n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNEr/74n"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36c0fd8e2e6so389114a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933770; x=1781538570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AEyICkcxZy1T6IWxG4M+aIj2et6ppgQhv+Dv6SSs9s=;
        b=MNEr/74n5hjLlgB3wo40ywGOduUmRpxx55GuY9PyBdn7spBCtBNuTYQatwy0wc/QHn
         3bbCUM385YcXAmVAh8beXjaCcy1DyjaMcSh01LLQsc38Cas16ChDrWOXggoycTELLVFc
         B0WK3JAQ1Ak5D5MNjKif28vnjY6M2KYEM6tQzx/2qkw0ZSxI5O9IPQiSJjs42IklY8u1
         YtAKjZQpQbDl2e9CVX3ZFexhqwAQBAj+1qa2hSysgfGAVpgoZRptBu4VeR+epndDcMkj
         IQst2Z4/pgm/llcqEGZ4ooreQLaUFtQ/1aPP85IP+HMSa5d6jOH8XDeY0lOxhbUh+m+J
         ofOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933770; x=1781538570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AEyICkcxZy1T6IWxG4M+aIj2et6ppgQhv+Dv6SSs9s=;
        b=hN1hDy0eayOzRv8wnAgRfmwnf6ykoD/8bMUD7YJ8DF516e0pd3GbDuCL0xQGM8fWfX
         6/+vzc/I82vWEzzM73IH8BykQ6KOI6+ep4OgyZ2hQQUo4duDQg6KIGUqXqSFuYJnSQPb
         LtpQNlc4PYxLFmxOtGPtarRp/4PjBhL30WIkoKeJdFDI5gKMnpcbqwWeX/jgB4qmRIwr
         pb11jE1/mR4mk1GvS4hrqMOZPfgi6voACgB+GHrSJq9SVIjU3w+LGtJZwIWutXOoOsXS
         e9AMJj/nax8RHtkayCIG2+IACMfHb7Del/x6NfdyaFy9IipB4yaUKY3E7dpetWv94qlP
         Ewfw==
X-Forwarded-Encrypted: i=1; AFNElJ9mcaYZhy288m37E+dRsEu7JLUudC5XeVjCL3z2CZs3p67xigAo3EMXGxJiL+N3CLo4jtZGfSKDtyL6LKGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC0BVpoeiFxF4o7tcxd118xH/eV9llv2KtqgpiXETf6KaqoSW
	2xUpSKMA9G7/33MROP/hI7kriQnoS3tOlLjcWgTNG/NJR9My6vNRJm0S
X-Gm-Gg: Acq92OHRyR4dT8QWr80Tfs1/DKtLRAuffBnD1fujiMxe8cNxZdEJcecgiy9iiuiA21E
	bh1/J6vIuHoL2u4w7kA2xol2cNnJoHQbmDebZwUUkcRzSFRSnHXh8GBHAwpTkk0M7UQ4SaKfJBm
	Xl9SCvKP8a33ohYQpX3Nniz1kZEfBkR0knRvsp3aWbtN3UM/IREVdNLh3mnJskMiKyJ+NTlig5Z
	iVRwqXtUjCN1L5e1yBqLA21nuAkkQdLzrTSFR/0AswdslqtHDqdeuEXT7qQUK5BclTbMiilNT5K
	X39GBeQQU72lh1MUBUaQzKVoNW62sz3hWQeg0h+dBXXlsGXyTD5PHNTAgNRm0Sdzay9eZoYeUe1
	2U2qeDmmyVkRU4ye2iS3NH6FI+79CTEhhKbJVAH2chGMaKJgEbBMSRJT3nG+QlZxvhm85Mryrw3
	ojhGwlUZjLOpp4dp9W4i0S8EraTgE=
X-Received: by 2002:a17:90b:5190:b0:36b:900a:d298 with SMTP id 98e67ed59e1d1-370ee340826mr7752785a91.1.1780933769563;
        Mon, 08 Jun 2026 08:49:29 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm15937526a12.18.2026.06.08.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:29 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v6 1/4] ntfs: reject non-resident records for resident-only attributes
Date: Tue,  9 Jun 2026 00:49:14 +0900
Message-ID: <20260608154917.2703739-2-charsyam@gmail.com>
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

The shared lookup-time attribute validator rejects non-resident
$FILE_NAME and $VOLUME_NAME records because their formats require
resident values and callers handle returned records as resident
attributes. Other resident-only attribute types still pass through the
generic non-resident mapping-pairs checks.

That leaves real resident/non-resident union confusion paths. Inode load
looks up $STANDARD_INFORMATION and then reads data.resident.value_offset
without checking a->non_resident. ntfs_inode_sync_standard_information()
does the same when updating the standard information value.
ntfs_write_volume_flags() also looks up $VOLUME_INFORMATION and reads
data.resident.value_offset directly. $INDEX_ROOT callers in dir.c and
index.c depend on the same lookup contract before consuming the resident
index root value.

Reject non-resident records for all resident-only attribute types in the
shared validator. Keep the existing $FILE_NAME and $VOLUME_NAME behavior,
but factor it through a helper and extend it to
$STANDARD_INFORMATION, $OBJECT_ID, $VOLUME_INFORMATION, $INDEX_ROOT, and
$EA_INFORMATION. For $OBJECT_ID and $EA_INFORMATION this is contract
hardening for resident-only formats; this patch only rejects the
non-resident form and does not add new resident value validation for
those types.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 5e1ad1cd0118..1254fbe7666e 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -596,6 +596,22 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	}
 }
 
+static bool ntfs_attr_type_is_resident_only(const __le32 type)
+{
+	switch (type) {
+	case AT_STANDARD_INFORMATION:
+	case AT_FILE_NAME:
+	case AT_OBJECT_ID:
+	case AT_VOLUME_NAME:
+	case AT_VOLUME_INFORMATION:
+	case AT_INDEX_ROOT:
+	case AT_EA_INFORMATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u32 value_length)
 {
 	const struct file_name_attr *fn;
@@ -666,7 +682,7 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 	u32 min_len;
 
 	if (a->non_resident) {
-		if (a->type == AT_FILE_NAME || a->type == AT_VOLUME_NAME)
+		if (ntfs_attr_type_is_resident_only(a->type))
 			goto corrupt;
 		if (!ntfs_non_resident_attr_value_is_valid(a))
 			goto corrupt;
-- 
2.43.0

