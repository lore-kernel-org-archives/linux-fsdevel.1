Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16913F20FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296521; cv=none; b=DtFczAUCkRICR6Zz34Ns5ECzFWI8Z7oor/eg1bwstSbBuPin3i0fdZG0nIQH0ZYeUIljjxS9hylLXnAVZiITZmBZvlyWo3IZymLDbfimKFvXLJQ/zx5cUtbvhGXkjXvBmqBXFZvxvz9ux8ECTH64csrI3/feq86zyGGDat3NIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296521; c=relaxed/simple;
	bh=/ueMGJeV3M+6NahfGnGox48rRXqZcRqd6BgSiC2a7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Q05Lu58Z/xI5Mjyj88044GKt9rNxroCri3qluIZzJbIfe6q5tL2toU0tX+8PYgv38FAuloMBhRB8uOv42OhzsYMT49aPiWnQmXIBnXr8lCtHAGZCU7HtM2Kzg5pw6ofh/Wxd8CrX+Ss2gbOmAWcVXd6VnxnrZ1BFrCEyOaLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtmaWfQZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtmaWfQZ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83f4991ac51so201252b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296519; x=1779901319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ22iTBZ4sCbgDlyf2sEL0oOtpVHxxbzLq25uqVdqz4=;
        b=DtmaWfQZaFEhYr840qTQN0WrHYRG6GizccDaku3qnglVi5lqFHN8v81D5dom2bITq6
         JPqG/gylF69XE2MqqOE1aqFtpQksUAHIkEsspugi8V4l6UzJU/J+C/j6Gey/0dlbcbGO
         CtRUSh9dnNgNRbuweM8+8oRVlRabprrRXNcX2DjzhUf5YfQAKKAC++VkfxPmPPUwGd2u
         OT3FbHTk4Nt3/FeK3Df3ieyCOtcFy3BFHiT3o010S+7bKwwCMkSaHKKgAj2zHDLVoWHv
         wCNgIPt5hZDnrXtQji7p8ov0H+d8WHz9eapasJBTOh07C8JyJxYznQpXrCRejlIyoD7q
         Woqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296519; x=1779901319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJ22iTBZ4sCbgDlyf2sEL0oOtpVHxxbzLq25uqVdqz4=;
        b=ikNS1YMkvkSks5QrCguk78HnhK475Q4HgMmdzp/DOJtN/fI9g75uaA88qfftu5sK/+
         5HB1oFT3V1Fwzz6AHbfVcJ9vuYyPLVnFYyaUy7rgqvUGlEgdmqsSetE8NhjwATHrDurS
         hnPc76N5384oGgYfo5IqICo8esEv9U/KfMSCEEacdX35EkIE5aAT1WKwJIvhn0fnxznf
         gUOPg/h8c/ZGw8TqDzEEiKaa5rkEM74Wx7cgQGVQ5SxliF9m0UpSzdYvPV31WVvS6E9H
         KmYSiODfNx8iPslUmQlnBgSK6SEMNzzMS8XvgWOESyfHPgTklGyD7AuZU+1Wsnk5/Yo/
         XMRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8oGFYElAPjAQFl1JMdiGpIxsOPQJSaBO/twm4Z39QhB6we2ZiCxbGDRT7LX/AhsT5cjyUTOmgZ8hNPjYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YxzYJnoKQ8ANJuNJeGY+Ds3p/D1phfIWc9He/69ZH/mwTB4m
	0/nVvnsExjr49nereDjBLKlNZtIW6nB25G1KaiXbVckA8jg+D6CeQXTc
X-Gm-Gg: Acq92OH2DV2a7JI0yjN6GuXWs3I0m/hb4lnxxwzQGSVG+xo/0R9zieRl1G1QQNh/41m
	mnSpwrKrl8ebfopjx7JwWY7ho52eJnTBxN6gj4wHmMemnXOVKpMpnJvkgtqNc+4223TBmYJO6H5
	qAdTlWujn9NsLIIo3ZmnsaFoci+6NAllEF/uoK+4mr30lo6I+xyhxzQ2QPYCN4egDd6YaChhMoo
	CRdUSA8nBANqu8J8UKrBYCCKWatsYVKhFMEttGOm3TjH2Gg/NlRGa2weKq/7TX4kvWcXDF8CkGO
	lAYWh3lZU1IplViDXdwuw430JFdhTxZppwgMQ8CjsYF43FRJKZxBYLI8S8tW1T7GgYfM8AU90hv
	aFZ5fyNrfizPt7fCRlcHxjSxjc6GDC8OnsHbGMBtZRcJUGgpkgVLD253EVGT3Wiq4wr8ahH0eha
	Dxe/Ydfetpl8evS9x0o0A74/vOZts=
X-Received: by 2002:a05:6a00:4c94:b0:834:e09b:de73 with SMTP id d2e1a72fcca58-83f33dda422mr13141557b3a.7.1779296518692;
        Wed, 20 May 2026 10:01:58 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm22125954b3a.0.2026.05.20.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:01:58 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/3] ntfs: free volume-wide resources on fill_super failure
Date: Thu, 21 May 2026 02:01:49 +0900
Message-ID: <20260520170151.4115308-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520170151.4115308-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_fill_super()'s err_out_now path frees only the volume struct via
kfree(vol), leaving several vol-owned allocations behind on mount
failure.

vol->nls_map is loaded by ntfs_init_fs_context() via load_nls_default()
or replaced by an explicit nls= option in ntfs_parse_param().
vol->volume_label is allocated by load_system_files() once the $Volume
name attribute has been parsed.  vol->lcn_empty_bits_per_page is
allocated before load_system_files() and was freed only from the upper
error label.

Move these per-volume frees to err_out_now so every failure path
releases them exactly once.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/super.c b/super.c
index f93f0f8bcc45..6cf09bbe017d 100644
--- a/super.c
+++ b/super.c
@@ -2638,8 +2638,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	/* Error exit code path. */
 unl_upcase_iput_tmp_ino_err_out_now:
-	if (vol->lcn_empty_bits_per_page)
-		kvfree(vol->lcn_empty_bits_per_page);
 	/*
 	 * Decrease the number of upcase users and destroy the global default
 	 * upcase table if necessary.
@@ -2659,6 +2657,9 @@ iput_tmp_ino_err_out_now:
 	/* Errors at this stage are irrelevant. */
 err_out_now:
 	sb->s_fs_info = NULL;
+	kvfree(vol->lcn_empty_bits_per_page);
+	kfree(vol->volume_label);
+	unload_nls(vol->nls_map);
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");
 	lockdep_on();
-- 
2.43.0

