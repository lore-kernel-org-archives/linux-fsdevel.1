Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750029B77E
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809452; cv=none; b=tZqrntoPMChBmLabppo1d4UMPE/F+QhRchcTfQXF+8rdrev6MEe7+2CK3tvWYiRIJZm5yhN6H9FCc60T4CDhrhC5OlHeEmxIb/f6Yyjanm1wRZTMCVqU53J4gS9NUZdguGbauyJT6y20lrViZXju19ThvkUQB5VVVIVG+EmhTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809452; c=relaxed/simple;
	bh=j+xZy8gt8DDV+QgucaCN87y/EmcwMb0teW0b/sea2b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNqWMXNmQyxta9xWDgvu9wD3eduSwRFtjCQHCKLbzyaZrn0d4M9peR4NfxO4zTT6OG45xqV3aFvzAqcKo9XPd1q3sFrw1T4Es+NoNvs6ew4ra27+VE76MwN7YyN0UhsGSwYJBf4LWOrg5Zu2jXyub9kVQbZrFwnGRGaKOV1I8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg9c7Ck0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg9c7Ck0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c35980c6so6696625ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780809451; x=1781414251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/xh4ji4ljzs7Ld2VhqWZs4IQIsCD/V0jgUFhhnWvko=;
        b=Bg9c7Ck0L7xjNgIWEDnGguzpc867L2BAS5vr7QEM/Qg7br8Z6+LAlr4mn4jmpOQLQi
         3GXNspQcrg4yOyfH/b5R3tDshIsvkszEqsHL+iQkjb+fH07OzMkp7TvBkbS3KmDSDkao
         JVCqDmDkgQZ0Lbgj98abD3ncD8zeRQ8cTfC3gX4mrrceZ0/vmbTRJ5cjTuSHqx10EGg+
         lB5V/bv/dgdf++achcWip4zupIRr9xnMA3nUzQWEaSOyZfPqaKVmqb3TZHWqVOoKj4Ib
         pOfiOagv4cuLVC4Bdu4AtHN+f8zlGZYBuoSCChleIk4LLVdKiCQSi4ixc+uNC+vp94Yb
         qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809451; x=1781414251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/xh4ji4ljzs7Ld2VhqWZs4IQIsCD/V0jgUFhhnWvko=;
        b=L0UmOjWjvri3khAkZvjG3Hqa5QjUHYNsbzzzLgsNdphYeXvA16sWmj84fSNEV5Rpt+
         eznmygjzGlDoNLjEhoIE8KS5w3vRCRTV4fKRw2agJGjnSnBWJ7C5FeptY1styPemD2WC
         awQSZrOvu47nNDwXH3kY4MoR90t8C8cZF2B26S912fOLGXLedEcv5mNYTEsj2lQX7eh0
         CszphOkEWSL5neGZA3p2KaD1mi350+2bY8r2tTqNKLDaOFmUyvYFSq4uzRFgklmXfdpW
         E6KvN0T3+6sLwKwY8WGvHyJdHQ3GdtFBQKLHwssl6s0YT8ZKyDIJ6Bh0slORk+t1GKi4
         pRqw==
X-Gm-Message-State: AOJu0YylBMnuxyR4rO3sUBImc50Tnq2a8pldaI1h4XoebqSOZw2i2+t8
	s8fhynIuFGSkNHqDrbjX6GhER4NFR1kvffwwAN2V/ZQutUw5Fj2YB6vp
X-Gm-Gg: Acq92OGyem3zmSdZKzXuWWej5X37wtuS7YxB41Am+dHe1K8TzCQ3xgF/KkavwN1numP
	/aBsLZ6nC72J1PjBbMXnltUb52K89RnLjR4vdPJGrKKkIoZE4jnxwn4uBEXULZK8qacLnrcUn4W
	gHd9UgxxaL3+IZIkhFui3G3gsxXCwni0/KS+vatpuMHVI84HakdJTVm0lUmU6BV8XBw+g9A9Cbv
	HZuASJVhEBTPwbz+WvPqopq5AAsxoVwPPQ3cmbS0uvFYVwTxm1NOdQ/OzUCAw04wLc+DYwpcdQZ
	wxdWS5RKUUocFIKUdZFd73hS3Mb16wMvoRsBh3rydIAiBuztQCXGKfnZ6sKuNzpEoPHT7NTTmw+
	otl0yvwlng1tOSnfT0g2ksaInf6RICOwbi50h7AvxGJKoUEgt6H3E59NI6LdkZIXNK2vFAdWO47
	YF2mvCci2i/6TT3A2KEWbWYj6sOC4=
X-Received: by 2002:a17:90b:2708:b0:368:f0a:1c49 with SMTP id 98e67ed59e1d1-370ebdfd031mr5330721a91.0.1780809450653;
        Sat, 06 Jun 2026 22:17:30 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm14494648b3a.50.2026.06.06.22.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:17:30 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v5 1/4] ntfs: reject non-resident records for resident-only attributes
Date: Sun,  7 Jun 2026 14:17:20 +0900
Message-ID: <20260607051723.1499833-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607051723.1499833-1-charsyam@gmail.com>
References: <20260607051723.1499833-1-charsyam@gmail.com>
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
index 7e293b85ad19..0fb2b6acf8b2 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -595,6 +595,22 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	}
 }
 
+static bool ntfs_attr_type_must_be_resident(const __le32 type)
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
@@ -665,7 +681,7 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 	u32 min_len;
 
 	if (a->non_resident) {
-		if (a->type == AT_FILE_NAME || a->type == AT_VOLUME_NAME)
+		if (ntfs_attr_type_must_be_resident(a->type))
 			goto corrupt;
 		if (!ntfs_non_resident_attr_value_is_valid(a))
 			goto corrupt;
-- 
2.43.0
