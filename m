Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729D42983A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515605; cv=none; b=ATv6uBPzy+TG1D7p8aThGe1BYnujuiEq83BVZQXh84K6lFulNKSyT486YRESbpPWG5l7Lou/7fa1kTOFCarEOZl8Wp1TXUNlomN+RDOboj+OqmsaK5BaiTk+vMZZOiOcsZZpMhggikXajWEIQiAD48T+xnszw8IkU2a0u67lbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515605; c=relaxed/simple;
	bh=+J6fOs6RknJ3UJj+/3CaRW5nRW9JX3hT5h97wmxwpv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHIBKEkM/dBCFhvoJTjYevZ51kcZ/xNYX4BMrK9q2pKioHLSUzv/g3QFGnNF9ZfJTFHw52VsqG3PFM8/FCA3VD+9Y7fOKpulI5IfBkV8pZGlEDAvGxCyPjAhMVQR3KgX3KQq9OEwTD5qAoKSyV61rbDgkkEMcy18ZoK5PL/WQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX3bgWnv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX3bgWnv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bcdc085c52so700465ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515603; x=1779120403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/puMZSjUUllHf9o6XXc/pt8PdxjFPmBhA/JoyPIRWU=;
        b=CX3bgWnvUcZzq2W2ljEhyilgbJUVFZMd5s57lIFJrq/7Ve2F0j5vxa/C9Cvzu/CFrj
         YpA5wVXG0lmKvmfBTFIOw+6XlLE1fX1jLeBdG57E2QKnnI23BSHLr7Dsjo+bpFuRWeYQ
         RiwFKK4e31OZ6oEA01ZX9ja3WkRsI9iWVWwUggXKrz49TrOz/Br5UBQEqx9o60xLLFs8
         vNUA1RYws7QP97wz42uOlMd1E8o6Rf1r3B9VporEskUVDVzqzptXr+Y1ubijOfCxOyyB
         G+NJweIc6TWq/F/5pTq5/K3EQLVGIxjs84vrM8dFLhdzR9JmO63CcQyRzRtlLKotQv2A
         h3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515603; x=1779120403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/puMZSjUUllHf9o6XXc/pt8PdxjFPmBhA/JoyPIRWU=;
        b=UhONLU1w0UFcv7RgX18mTFdKk6rC5Ow6KRMTskoWuvN2J+Jrj2SscbYHcamtJAUZUD
         SbFL11hsKBKn3JvfSdqBclK/efVifatQyFqzBqls2vhKpIQnijugGuxKWynevtyhZGQI
         E/zmeBjlm8LWzo+7M9Q/KZEM5fW/RheUteTcdE8sabkUj6yi/LJ0kYSBY4+LlGX/Yp/4
         jNZwJggtzQEuCBdhlOVlbgc6vrclWwQLX9kf1AaO6fg6SOUBFZ3G8VuDzJaXZym0nR4S
         EV8vkHSey2jMTm+xknwldZl1n0YEbR7zByxXmS+jwV5AA456bIenkGWdgxyZ2UZxGMxn
         J7EQ==
X-Gm-Message-State: AOJu0YyFTiH8LZm79ejGIYUT+z79DQv52NMofrhx7Tkq8u8X+pirz49L
	pL++myiNVbOFYoDWWp3AW2HCZuKptTJk0Q5lCaR2Vis2DtubKDdqsJNH
X-Gm-Gg: Acq92OGLI6mjp+h2IoNC3MerPn4ehOUJEAumnPL8BT1+aUVTEBJLTda/l+mUXhT6LOd
	nIHVoqYb6cA8kRuzjbfKwIrLcp1RPhTgXKaL1Sk2tKtECercDpHS00NkBRQivZAMRoONCM+m7WW
	qC7TdjxJktSppuMVfNRzlX+5cwmFx1O3yvsKTqR5KAHzxx/fxW6H52OD620OXcsS9VTNF8MHUS6
	dmjqwdBcoAH1Bg0wIvBcPDHP4wtGs71IiI5sFv4b829sSrezIGTu63utdxr/3HllZMoqSOiScvq
	+dt/k5QAKJtis0wbPUyfiKsYkhhWDmdlU5SCeFy0qbueh9f7F2C0hfrIfwvhFdmwecX/Ne7V+Tx
	vOEL/xy/ALTcK39OerLfJnxxjOvRg1x/YVShUE1CnPTVGdbtIVekrVqBoVvVUUZvReZkQpE0DTp
	gWgwP8BWCpiRIwebtU
X-Received: by 2002:a17:903:191:b0:2b2:67ca:5ffa with SMTP id d9443c01a7336-2ba7a599c68mr133831005ad.0.1778515603407;
        Mon, 11 May 2026 09:06:43 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm112447045ad.43.2026.05.11.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:06:43 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
Date: Tue, 12 May 2026 01:06:25 +0900
Message-ID: <20260511160626.1268612-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511160626.1268612-1-charsyam@gmail.com>
References: <20260511160626.1268612-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remount read-write path marks quotas out of date after emptying the
logfile, but initial read-write mount only loads $Quota and never calls
ntfs_mark_quotas_out_of_date().

That leaves quota tracking metadata looking up to date even though the
driver can modify the volume.  Call the same helper after $Quota is loaded
during initial read-write mount.  If marking quotas out of date fails and
the mount policy is on_errors=remount-ro, convert the mount to read-only
and set the volume error state, matching the nearby $Quota load failure
handling.

This intentionally follows the initial mount error policy rather than the
remount-rw path, where a quota marking failure rejects the remount with
-EROFS.

Move the load/mark/policy handling into a small helper,
ntfs_init_quota_for_mount(), which captures each call result in a local,
derives the failure reason, and gates the read-only downgrade on policy
in one place.  This avoids calling helpers inside compound if conditions
and keeps ntfs_load_system_files() flat.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 46 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc786..8fa298f 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1221,6 +1221,39 @@ static bool load_and_init_quota(struct ntfs_volume *vol)
 	return true;
 }

+/*
+ * ntfs_init_quota_for_mount - finish quota setup at mount time
+ * @sb:		super block of the volume being mounted
+ * @vol:	ntfs volume to set up
+ *
+ * Load $Quota and, on a read-write mount, mark quotas out of date so that
+ * Windows rescans them on next boot.  On failure, downgrade the mount to
+ * read-only when on_errors=remount-ro, matching the volume error policy.
+ */
+static void ntfs_init_quota_for_mount(struct super_block *sb,
+				      struct ntfs_volume *vol)
+{
+	bool quota_loaded, quota_marked = true;
+	const char *reason = NULL;
+
+	quota_loaded = load_and_init_quota(vol);
+	if (quota_loaded && !sb_rdonly(sb))
+		quota_marked = ntfs_mark_quotas_out_of_date(vol);
+
+	if (!quota_loaded)
+		reason = "Failed to load $Quota";
+	else if (!quota_marked)
+		reason = "Failed to mark quotas out of date";
+
+	if (!reason || vol->on_errors != ON_ERRORS_REMOUNT_RO)
+		return;
+
+	sb->s_flags |= SB_RDONLY;
+	ntfs_error(sb, "%s.  Mounting read-only.  Run chkdsk.", reason);
+	/* This will prevent a read-write remount. */
+	NVolSetErrors(vol);
+}
+
 /*
  * load_and_init_attrdef - load the attribute definitions table for a volume
  * @vol:	ntfs super block describing device whose attrdef to load
@@ -1638,16 +1671,7 @@ get_ctx_vol_failed:
 		ntfs_error(sb, "Failed to load $Extend.");
 		goto iput_sec_err_out;
 	}
-	/* Find the quota file, load it if present, and set it up. */
-	if (!load_and_init_quota(vol) &&
-	    vol->on_errors == ON_ERRORS_REMOUNT_RO) {
-		static const char *es1 = "Failed to load $Quota";
-		static const char *es2 = ".  Run chkdsk.";
-
-		sb->s_flags |= SB_RDONLY;
-		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		/* This will prevent a read-write remount. */
-		NVolSetErrors(vol);
-	}
+	/* Find the quota file, load it if present, and set it up. */
+	ntfs_init_quota_for_mount(sb, vol);

 	return true;
--
2.43.0

