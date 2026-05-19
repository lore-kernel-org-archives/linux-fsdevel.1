Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979A46AEE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184337; cv=none; b=EAJRM9LrkQBtiAq+lNTIKhC5DoqeFTaXxszUKnqB3aZ052/LkKj6YYlcsWcdLXXcF3TeTdkh5pYo/mC84qYnEN3lfZ7iFrpR8Zndtcg99pH4cESG2srbObTNEcAMrLiIUNl9NiR986qZjof6GQ2yBzI3x0F7+SAqvY4yu1t15BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184337; c=relaxed/simple;
	bh=oj+KFARW3atpzddg8zMv78o7rWNm5zu9UJAVmegL0XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCiNjc8T3MGVCgWkfRCmEqD2nXjNPnV4rDXvji9cEm2+1okqiMepxTOVvPPbYk92z2uoeqXBnK6wVOx8mDcmYwLX0qrVmuYl+anMLzdolfKhdL2/udCcL/peiRg47aHOGGbQFXOpxhlRPLLq2tIFYYAbNba9Gqj1C2UoEVOvGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHZleOm/; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHZleOm/"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ca12973e15so49123826d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184335; x=1779789135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRCR11qUHaj3Qg7MbFr/xCdePGzcx00slw0JQNYdwuQ=;
        b=CHZleOm/JM2oZlAx/Yz1dXBxriKZ7D+ctjN5+ZKaYuOP2oUDIEMcTHDoSCWNBZ8sT4
         aa73cDa/zOdoqDwUsBedfimfcjIL9Dwn3psFXZ9gdGmo2cHPYAvtUyAeAlf5oKjaAa+B
         kK9YcZ1LGGu8A6udFnFSzQCFzR9fycH54bv66r1z2VOto28z/sTyq61aspZQ4iDr9F7B
         8xfCjaENdgQbpTLK29gRcH6uV+6D6LrGbt7deQJK/LI1Jj+3aKXauUxwQrjdF2jI1O/J
         5fP16bxkvGGl12+JfY0FT18Jmib9Yv9Fn58bUih16YIOxGQB0Qu0iEgS0jpuHq/TNCAo
         998Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184335; x=1779789135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRCR11qUHaj3Qg7MbFr/xCdePGzcx00slw0JQNYdwuQ=;
        b=BGRtyiT4LI2VrzNP4sCOD9Eiz1y/AFDEpG4VWGTdTRbtDocfuLY6OtNwev6hNIRBmC
         pgsASWhVFGDE97sckcVpy52G2RGlnpG0fMF2/1vdj5vPfiA5Eouq6ru41cNeMwTPCvCl
         hY1C2cUjMYdX4oPpt9TKjw2NAiwENfoKMzatsdXaPtl/qOV6Ev+HJ3gFyQOlV6aWYCVG
         UCqSuqVFYRCWSpnLa2SLDvsrYmsTaGLSLP+4SwMJhD91IKa2/RTJTE8blimj5hsSZ2Dg
         bsVrCycEjODEmHIg4VdOJv23cAOSpysKng4tutQXtLk1Dpx411cymb8EX6lq6LflVfkw
         JL/w==
X-Forwarded-Encrypted: i=1; AFNElJ83lLQXeTg0iUXRE+9eQbJBWrbwbrNjkV3FkOr9/fIkLSdHSE+a3/vqakkjQxgzCTQd6EfII4qHGyxDuFcy@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEMwaf+U1wytysGEMxjf55uCjc8PVwx7tsagJr2WxdHsiB/GR
	jrZkgzeVpIqEA+40LQWaAxnYT1oCeIAV4m0o83gx5RAe8kXCv9PdhrX1
X-Gm-Gg: Acq92OHGWq49wYfOcZ6a7LIKLYPgeK69CJS9fBHYeRxN3U3Aq/k05JAfJgvRWeBG5uQ
	BLRaNe787ofkPaREP7I6E/2Rr0ylZVoEuB8WOjZBADIlw7tx5UU+sG90YONX2J6KqCjz/V9g+wE
	r4UIcKhfRn3x/d0PLqX8JhYD4fSs+nwGBBOcOpUBmCjxa0hFdY7AUCxmQcpE2imjWHQFg9EryIy
	lmQQEO8Qu4eJcrDHDtWmkdfb3cjvFOw42zYfT7/BGAU/PY4Qrj9pl9h0Biux4OQMFlKwVL145sF
	paP07m+u2qtpg/9XVpaHn/IHQVrG/SCn+1WC77+AWEcbkej10KEczWqHu0YXCFJQIeEPNk6KoWx
	FWwqpvtuXo0V0RBgGQeQmzUlt6zs2PocxAdTZiH9s3SX9sROaLynz9WOUNNqI76prgCZMzWb2td
	cHkqpsKo76H7wMRO2bT7R23IcqNgQrr13YdXV75FMAdvlVrUwJDS6AFq0SsfiUYU0MDj29tIUft
	bzZZj6OlTdPdnPBGoeX
X-Received: by 2002:a05:6214:4e06:b0:8ca:1dd8:10c with SMTP id 6a1803df08f44-8ca1dd803bemr234592946d6.30.1779184334701;
        Tue, 19 May 2026 02:52:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619c7d9sm84697036d6.36.2026.05.19.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:52:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
Date: Tue, 19 May 2026 05:51:35 -0400
Message-ID: <20260519095135.1609973-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515163424.1575298-1-michael.bommarito@gmail.com>
References: <20260515163424.1575298-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In do_action()'s UpdateRecordDataRoot (fslog.c:3489) and
UpdateRecordDataAllocation (fslog.c:3697) cases, the memmove
destination is `Add2Ptr(e, le16_to_cpu(e->view.data_off))`,
where e->view.data_off comes from an on-disk NTFS_DE inside
an INDEX_ROOT or INDEX_BUFFER.  Neither case validates
view.data_off + dlen against e->size; the existing
check_if_index_root / check_if_alloc_index helpers walk the
entry chain and validate the entry's offset, but not its
internal view fields.

The neighbouring read sites (e.g., fs/ntfs3/index.c when
iterating view entries) check view.data_off + view.data_size
<= e->size.  Apply the same bound at the two memmove sites.

Reproduced under UML+KASAN on mainline 8d90b09e6741 via
pr_warn-only probe instrumentation: with view.data_off forced
to 0xFFFC, the memmove writes 32 bytes past the end of the
NTFS_DE.

This is similar in shape to Pavitra Jha's 2026-05-02 patch
"fs/ntfs3: prevent oob in case UpdateRecordDataRoot"
(<20260502105008.21827-1-jhapavitra98@gmail.com>) which
proposes calling ntfs3_bad_de_range(); that helper does not
exist in mainline.  This patch uses inline checks.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
Closes: https://lore.kernel.org/ntfs3/20260502105008.21827-1-jhapavitra98@gmail.com/
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
  - Add Pavitra Jha's Reported-by trailer and a Closes tag for
    the original public report, as requested in review.

 fs/ntfs3/fslog.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401e..127860fd2ab50 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3497,6 +3497,18 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
 
+		/*
+		 * e->view.data_off and dlen come from the on-disk
+		 * INDEX_ROOT entry / LRH.  The neighbouring read sites
+		 * (e.g. fs/ntfs3/index.c) check that
+		 * view.data_off + view.data_size <= e->size; mirror that
+		 * bound here so the memmove cannot reach past the entry.
+		 */
+		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
+		    le16_to_cpu(e->view.data_off) + dlen >
+			    le16_to_cpu(e->size))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		mi->dirty = true;
@@ -3689,6 +3701,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			goto dirty_vol;
 		}
 
+		/* See UpdateRecordDataRoot for the rationale. */
+		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
+		    le16_to_cpu(e->view.data_off) + dlen >
+			    le16_to_cpu(e->size))
+			goto dirty_vol;
+
 		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
 
 		a_dirty = true;
-- 
2.53.0
