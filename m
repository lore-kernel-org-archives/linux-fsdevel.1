Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544226;
	b=rnTJYSFTN+ba489a6Fdb+cCY+sIcq5VzeQO1SwLsfekGsaxbXsjAI8zUP1f5k1obzYKI
	 3H3jgoXNBnb0uibkaCvl18V7HGErWBo9QSye5C552cfeZteM41+hrEbcEYM7CEa2gR6DT
	 LnspLU2cEwHQFA3Ufs0374QUJg/waE32Raacl7tBx4HPfCM3To0p9OETvgGRgyTVxapOh
	 KRyCOCmAufq7+UJXR/Ny/MnfZ7Lwxz3ev0lCoosBzmdKcwDxDli+kRxdWpj4Zm+gs2isO
	 CwZ6iSbHM8jKeHcG1zzlsWGGyy/zdO8AgQwiQbDDzfVr0wDy/PFHTX2GIVnFDz/Gy2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XvdgI3fUAxy644OcYvPEMVJOC7V3Mgdv5TgcfGrHga4=;
	b=RQ86XDqjLrKq2z9vAsnfQ66pCV25FM2DvIDe+34KB+XIFA6yasAx700UklEZXm3q9B4r
	 8pOMqWRZgVFefT6Ac9n93oO5wfD7CyRUky/nj2yzCrJJ+oqB/DUmD+K7UiYInstpFhLys
	 FFw+dxKz7ZyA7jTn+SZatnBX+KdcReWimvBBeF1F/N3gpWhIA/kttjvBuGFCGdoy/GL0C
	 TZIm12B9gqONrl3CK1CBEqgyMuBg/x7YJOR+AcPGd8mgYy/nm6Ge/6TZmBssp+GbvoXow
	 c5bwkDyQwbcASpAbpEp5c/FRLRnvpGK9XRa20CVch05oPGFuCC4tX95acZ38r8UiZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WDpfLD5Q;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E21606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E21606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WDpfLD5Q
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f2049ea7aso11841385a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544225; x=1793149025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvdgI3fUAxy644OcYvPEMVJOC7V3Mgdv5TgcfGrHga4=;
        b=WDpfLD5QVTJcygAX45nKd2Dp6W1KL2wfrWZ2beietDVoMavuOi1Jes8TnW1HWOtxhU
         ubtrdSCSeIvLV3TDNVft4hAmetJYSY024rG0ngX1qcj+BWB23zu9WtfCrj7OGn8AWaLg
         seP6sC3Jg1q95XoLeVEq68BXDvLpHX9Yd4+0rMEdm7IujnkmvVqNGnzy40IqS+RHGRuK
         +OLCklX/3AeE3Mm3SwC6fqK6j1sAQKZnklsTib44vFK4q4x4dXMqO5NuHlrxxjsTyxxd
         iBvSLG5Dc7DnOEz/+g1INrqf6XAF8GH8AcMyhWkWrBQZViaTArgP0wuHVMUG0gZcHl7d
         jHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544225; x=1793149025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvdgI3fUAxy644OcYvPEMVJOC7V3Mgdv5TgcfGrHga4=;
        b=YdPY0vEQSA1DktoTqftUrEqfO10hYd9eeOuQFf8/4s/JhPdKgbbrthMrMtMqA6aVYa
         L//FtAg73qJmOtH8NNCA4+mViUWfIClrNz7SwLOAEPE+yT0k6L+unhqUIkdqRHxn9P2J
         Nf+OJi8FJNdOWDRZ0YiPfxhN0qL8WssjPE56cXuGNjLlGmuvXiVcH4eRCaRxr7ZM5Iqw
         D6QyASqRK04AFrJCKD2ErHZmnt6SaN4PQxPrMblo+H5AI4dRnT1gVwkmExC8XJnN3nUP
         m+Zlt+zUjYh3aLqfk/tb3qMfmbVRa67WZosiU5Qum4zQ+tOc1bZzVIlUKJA6B9okOGhv
         Wjsw==
X-Gm-Message-State: AFq9FYLpGOl+2hL3wM1zuRuogFGzI3Icw9WJScfpgkG3alvROdDkasyG
	eEJxqFKtIVFdHpKCcTXrXD+F4dM3vpe7U1LjxENBPUba+8DrNnIWLmha9KAF07kU2kw=
X-Gm-Gg: AYBFou1mIEnPbU/Df/xQ6kGhYREZsTcKEp474+e/Leoe1J4kYmhN10vpJBS7Zh8O51V
	1fTYENXncmNzqcyJbMQdPSB6MHGQRcGUeVABlRENh4qZnl7ZjoHJbEeKaDokortxxNXBq2tgQ/d
	tsbUEOYrOHjkZtxZ8BG8FRoCAI5ZNEgeIZriBRJV6UpzFyb/l+ZeMkf79obvYOMOIZb+LK/nUuO
	gauISdlHIiGL8m9IFYPlQKBav1jgJAwD5yOzfKN25xwb3Ye1ZtcQc8g6NshWYqgCJpa2/mefkBY
	7BpSKSg9Yu+xbYnsFIbzc2c6yJkthpHLyUQfeeWAchhigy8rMREw8v1R1gfieuLf7A6bBAC6grA
	tNhNsJ3SzGcOWifEq9G3FBT0ut3+m9eTArO0z6sGy9Ur0SGLpZsHvb/5T4okRphpoDXvoD3UCmE
	oifSdApZ09s85a3mbTUFlehJZt3+Fs1+Q/8LNF71ALhXMCMudYbPo+Fw5Fm7FWcrKg+DjDiLzRt
	vkwF99xHfX95Rw=
X-Received: by 2002:a05:620a:2585:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93f57f7933fmr155787285a.60.1792544224865;
        Tue, 20 Oct 2026 17:57:04 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c6f15asm119875185a.6.2026.10.20.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:57:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 00:56:39 +0000
Subject: [PATCH 5/5] fs: let a mount waiting for the old superblock to die
 be killed
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-super-lock-dying-v1-5-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544204; l=2506;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cSy1A5KxOO/zha70i/ke44UVxaSubA7uEV1r4Q5nwgY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE2qlIvPWAmGLfM72sm8l9frO2dtZ7qnexsMOQljMoDQhc6rNShfMJ9LTw0kLqdrws8sW1iS4Yz
 g7pDQB7JHYgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When sget_fc() finds a superblock for what is being mounted and that
superblock is being shut down, grab_super() waits for SB_DEAD and sget_fc()
then looks again.  This one does have to wait: the old superblock owns the
device until ->kill_sb() is done with it.

It doesn't have to be uninterruptible though.  If the unmount is stuck, so
is every attempt to mount that device again, and none of them can be
killed.  mount(2) and fsconfig(2) can fail at this point, nothing has been
set up yet apart from a spare superblock which sget_fc() frees on its
other ways out as well.

Make the wait killable.  grab_super() now has three outcomes, so have it
return 0, -EAGAIN for "look again", or the error from the wait.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 9f76b399f3fb..36fdf88ef88e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -673,12 +673,14 @@ EXPORT_SYMBOL(deactivate_super);
  * superblock to either become SB_BORN or for it to pass through
  * sb->kill() and be marked as SB_DEAD.
  *
- * Return: This returns true if an active reference could be acquired,
- *         false if not.
+ * Return: 0 if an active reference could be acquired, -EAGAIN if the
+ *         superblock is gone and the caller should look again,
+ *         -ERESTARTSYS if the task was killed while waiting for that.
  */
-static bool grab_super(struct super_block *sb)
+static int grab_super(struct super_block *sb)
 {
 	bool locked;
+	int ret;
 
 	refcount_inc(&sb->s_passive);
 	spin_unlock(&sb_lock);
@@ -686,13 +688,13 @@ static bool grab_super(struct super_block *sb)
 	if (locked) {
 		if (atomic_inc_not_zero(&sb->s_active)) {
 			put_super(sb);
-			return true;
+			return 0;
 		}
 		super_unlock_excl(sb);
 	}
-	wait_var_event(&sb->s_flags, super_flags(sb, SB_DEAD));
+	ret = wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DEAD));
 	put_super(sb);
-	return false;
+	return ret ? ret : -EAGAIN;
 }
 
 /*
@@ -960,9 +962,12 @@ struct super_block *sget_fc(struct fs_context *fc,
 			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
 		return ERR_PTR(-EBUSY);
 	}
-	if (!grab_super(old))
+	err = grab_super(old);
+	if (err == -EAGAIN)
 		goto retry;
 	destroy_unused_super(s);
+	if (err)
+		return ERR_PTR(err);
 	return old;
 }
 EXPORT_SYMBOL(sget_fc);

-- 
2.55.0

