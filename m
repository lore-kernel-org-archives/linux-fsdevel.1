Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9831E85B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870376; cv=pass; b=f13ZtQvlDvnIFBSohn8jkqhsDQ1ZMGsPO8JfAW1xl7mawOkM8BhvBwhrw1HvnZDl2s5fQNz5nujvHltYW5bJN6h77WX87Ghu9juGZXCGpHiAPBPrwZ77t3HxpIlybtJgWPYYY83bVSyYNDtpDq/aeK4hlj3Iy2yNm8Em5wrUVQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870376; c=relaxed/simple;
	bh=f3WK1sLR86o61DIAy56snUiA6RhSELzDEenaTgBQ5UU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xo2fIUlGbVPdL//SOaCc9w+36gZiB2v8+TpnIAGeJ24z0qQHmFSKVfxqTt3enfzCa4Mm8L9hFhX1ZSfFza4iOigTiGLTeNm+YojTP65VXnSwXuWGagGzAl5FIxGnwBW4MRAVtXUIzuK/QBQ4S0oVEG4DY8p7eLV26PZpcv0Tr/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=teAVrN/G; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="teAVrN/G"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc147d86bebso421579a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 15:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787870371; cv=none;
        d=google.com; s=arc-20260327;
        b=m2oPaQqNj2ARnfe2T9v4b24n7+0u0fU/QrGZkGQMkVw0xoRiK+4b0SM1DAf6OoNBvJ
         mBAh5u7beSb5/SS/9snYEZlHyEG4CkxbAkl0udOjgTZ29n2yBWWYvYG3kmBDv1mhdPrR
         hcOzrZVhy0fv7gGu0yZc8XkGxDfNeiun3t1CALsvoguk6D8kENUzEEH7xzToPfMhEgLx
         4yBVYsjBDkBEz3cTjk18MIVP640kV3d69JOJM0v3sxlm+Ocu9FIAVJX2Lk7W3HCUpUEF
         XfjZ6vNauP/XObDlTI6b7lXCBLntPOZrKd26iz3ine+4ahC2Cx0IGaKSHQv9dbx2gYQH
         py+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=aUgC6U0Ri042MH9ckfeZORUhqjWsZjHuRBdl9sus2/8=;
        fh=e8yx3AYJNhCD1u4CGG/NK7WlHJ4zey1OA3kSirVEUQ0=;
        b=iEQnarzeU2qJiEFjA9Ygydi9OEZklIDNat3XDghpYJElx3XyOYp0irEMV9fF2E3Qw4
         kv6gwmVsQfgOGYbqZ+hrT1LNLGyKKfuhCErMCh39x1U5DYC5n8vlxXVS/7sP+nlI+EkK
         8r0KbLsSI6zbelYb0QJhx2yUh13AbD9xZLySVfN4s8wsnhE68N6KpCwJbvxCO3Rk+CLw
         flgtsx6420c0DmxHc2w0Tl6UHcKS5803/2YlR3O362lHaMIrX8KLB0L1YMOXgoi1tyPb
         5GaoQzJVbyvOMzmiqgPa9I9s0+RoD/jiEBv5avyBXhIMvNMkJSbn4ce90BAv8YEC8jOo
         3XYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787870371; x=1788475171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUgC6U0Ri042MH9ckfeZORUhqjWsZjHuRBdl9sus2/8=;
        b=teAVrN/GX9q8UkraHwaRS89Qmos+LF4L+bmiYChswagKfJAyKQ/VcuiGzEtiYIOYVw
         s5+QAkWfpRBXi3PBQDC5whW0d0/+Uv2W4cf81paMttfhKNFjK/bVuLmu4FnUsWw1XSBM
         1/XtkhgDJFYoKaG9UT809T/zpumbAnVUuPcA5HtM/bKrzqz0ZizOHXoSPhoEBm10EUcq
         8TiCMyIPpZl8U4/8EYTX72nzzm3JHaThUtVMiSHrl3LOny035XprsvLOmgKgFDQP//WB
         ZO/BNF9pX/BKfzh/WxeiyNGjcz4i440xiG8EQsyPE18pGtBCeFSGKnlCCrSpqYD/jrjx
         LXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870371; x=1788475171;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aUgC6U0Ri042MH9ckfeZORUhqjWsZjHuRBdl9sus2/8=;
        b=LgM6jeG6oUwxKlKH+3wv1glksC7nJE/BLL+SNnP1RH4FP21yMa/D/88JQ7DjhgKInf
         wz1vb+k2V4Ub4duZlqhf6DaLQsPL/xvkbFax1HKofUDKw6bidRqgVE8AbFCZo1JxbRtJ
         cr6YYLfpXUfbNcJxIlzZAU3ibZbpJvcjD2YTLyW41K3RdjNHOrSZRuNUqIbnZ+P/ijTn
         ZbnV3KjTvwEUaw+BSI6HSbY26IPEN3wp4XZ+KCVHcxNrLjv6PO6M3M2hTo/wg3ynKhP1
         LLSPfPRIFxUMS9CNrrOy5w8B2wJuq2OKm78m9uRQZTiYBINoJ3QWcjs+R5TrlFt6L0hF
         0yGA==
X-Forwarded-Encrypted: i=1; AHgh+RrIitSK4fYKbnsII/4U+VZ/ZXiZp8vaIn+HLmxlkAmUBa3kkXT9U7mbBIZQHeqRVpH/VqT+HJzIuxasYme1@vger.kernel.org
X-Gm-Message-State: AFuF++mSA3ab8ESoW/iIV8ZOkOcDTYHNzOCtzSW8TvU7pr6MMXmueRUJ
	6C8u2mDIgsgMzkwGFtvSTcx1JxwwidLNh4b3MgpjXBOJXIP6iBzyskSJX95iP+gh3gGC4XWpVO3
	3OwaUplxyj0c0p38I/QwKn0Siop053vqxU4t+h7CZ
X-Gm-Gg: AR+sD10A1oJ1tnan9TF5jJSb2eSYQBoUkL6OpYy7FUDpAqTy1e1UZ4LA3d9peoGjh39
	Oa2866OFwVTjbs3K065gYnHcZ2cs5VzS1RPYmS30yRlSZAsSiR1xuCMug9qp/BoUvhH5r1G9CLy
	MIZlze0fY9KM12UzHTEgOSd+0UbnzAv2yS3xIELM7HoPxwvcoJejIxU4fo7n4BQ/236UaWIlwCw
	JmpBAeem2Q0zl/q8uja7Bf21naMvCvato+q+ZVARaUKixDv+Ac81KOWH/bt20rd7UFf6ILSdlJS
	eHjAWfJNKWtq9cPX7QYcrig1JycXbcqHEMUf6pI1KMNnbhRPkeyRAgqHkwCKPWYzYpjrWcZKGDY
	v0fgMRTGJK/uwKOnJzB2y5SfTKec9w6L4cg==
X-Received: by 2002:a17:90b:4d11:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-396d0f6486amr2117646a91.9.1787870370120; Thu, 27 Aug 2026
 15:39:30 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:39:29 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:39:29 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 15:39:29 -0700
X-Gm-Features: AcwNN1WPmhEDwxbrpltfK-UsN5SmqLvSNmNta_ia13t7ApSIc0SOkNKwBfo9p1I
Message-ID: <CA+0ovCh-bPqXn8L5AY8=c4B2L0n3ixXKHFExwGtMOouBYGuXDQ@mail.gmail.com>
Subject: [BUG] jffs2: BUG_ON in jffs2_get_parent() on a crafted image
To: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, linux-mtd@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello David Woodhouse, Richard Weinberger,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/110-jffs2-bug_on-jffs2_get_parent/

  jffs2: notice: (20910) jffs2_build_xattr_subsystem: complete
building xattr subsystem, 2 of xdatum (0 unchecked, 2 orphan) and 2 of
xref (0 dead, 2 orphan) found.
  jffs2: notice: (20910) jffs2_build_xattr_subsystem: complete
building xattr subsystem, 2 of xdatum (0 unchecked, 2 orphan) and 2 of
xref (0 dead, 2 orphan) found.
  ------------[ cut here ]------------
  kernel BUG at fs/jffs2/super.c:141!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 20910 Comm: syz.6.1218 Not tainted 7.1.0-rc5 #1
PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:jffs2_get_parent+0x1bd/0x1c0 fs/jffs2/super.c:141
  Code: ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 46 ff ff ff 4c 89
ff 89 f5 e8 40 e7 01 ff 89 ee e9 35 ff ff ff e8 64 7d 9a fe 90 <0f> 0b
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
