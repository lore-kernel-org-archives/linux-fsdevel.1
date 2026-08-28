Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759938AC6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887319; cv=pass; b=lxGjL98XM6ReyQosGUdaAhORRXv2Z2NUOodpuJVE2THz8l/EWuaPklAFGGOkilMPe1NYb2GG22M9NaV4X9luxCjD+tNtBJW7pvy/y+SYNQIhxWHMEnMQwCu95dAEmO/Mo51+761apqAoMzAg1RwcRlqJTSc7APei6M02JZl/x0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887319; c=relaxed/simple;
	bh=PV74xrzDSBRTke/cHvAJ9HlN5yJIVvwoG/IxBDWTvkc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=CblIvnNFWNMC6nQZhsCnKvr3Ffbtuo0BFB7aV2Kvk2wa75eLO30XnYbLJit19zEDrHMCnp6P/2Qr5dcfQyJB0dV0lf3x/puQBd6nX7RQjIkNClTACKQjQi88cTYg/IO0lF5h0/BUdiAD7QjN7NoQk3njx5I7C5uHFqFN4M+UpYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ffZq1M0a; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ffZq1M0a"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so5414305ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 20:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787887315; cv=none;
        d=google.com; s=arc-20260327;
        b=qN0phctbcQdLaGbqNOKMz7BV4lIeSfaLwgy31iMZggnhz2mpkAH80DrHaqMaongsBJ
         XgywhS1BxuYihdotN86UowDGbZkGObdXcdZF44dJbiJ3g/nEtykW7cpzjKEE/c/WhZB6
         lffQzfv1JdBoDJdEpDJ/latce7652WdfW5Bmajx9YkrcdiKjdNhuryqeWu1ItbyTIv1y
         Y9s2U5slcFn69B5uK+YxmF/oaUNC63hCG6NdhZ8+7u5FqWZc2IclMkGwCa6xqIM0Baw4
         I4KD+imJTy0bt1V+D4NkwrEH8fQBnbGGfx2XdhI+ikNd8J/oiNfP/engvkGvPUOWtEzH
         1tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=Uee4CaKhfoQ1WGVh8aDxMhw0p8MYNhqtIxucP0xeS34=;
        fh=Hc3U1fIpggGPkozZryX9ivuKMsIR9G4dPQY/jrgug24=;
        b=jH18msFTpy87MPrc/PUxRnrO2NacjMr2UGNqSM6iG0qspDBRMQKtyb9Q9S4m1DuE3w
         gmv5VjsdPqSTHJJ7jvPmMsFUA0lVpbnVJPZ9S7S47Os+gHryOw8Q0+O6wkVxkELpJtmZ
         qev1JNereAF82sEODeX39U/Rg5THDYjKuOAh6ITbutxKUoM2XASZgnTE6jb6D69/tQlq
         oAEk3M6TWpC5uD5mM+oMs9fQVoXNauhQMeGMGoAsCnRsLcXRfOUZmAaqkJVywnpX0fTd
         gyNjKPFeiK/Ugcz2aDuIEXgXQVfh4Fch5PaTgpLzG9no5Ya4z+Wf4jLlvl3ld1KWP+x9
         TUhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787887315; x=1788492115; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uee4CaKhfoQ1WGVh8aDxMhw0p8MYNhqtIxucP0xeS34=;
        b=ffZq1M0aHNvGSLq2qKqHYliIRl0lTJBc9XouJxJAqzd07LgbUPnlUXmJX77rs/W1v9
         7DiiFpghKGY1xaN+8i0zPlF38H4W/yh4X0I6IWj0JkNMopp2vDOWdCBWQgMNrQ3yzGyJ
         f4A4a/bBxxAcl3xB8mRMw2oU4WHgi5pRpA6Z1YK0gPljoZn+lbG6rvBeibYR+6jIV3Ps
         edrozim8XPl+vmNQ2R3SIvwfcklKku9by1C4erBurrTHCibuDiuwcLtYGsF4H5bqWYlo
         qRle7iuuBLhFie5VC/QgL6P750B1olWrNmvGdWzmFEGTTpBH8GZQIwusImgey10WK4s+
         cxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887315; x=1788492115;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uee4CaKhfoQ1WGVh8aDxMhw0p8MYNhqtIxucP0xeS34=;
        b=n2Guq5tfml7O0/ORJIyM553h07U7iNurxOp2t0SphVRuLBoBIkxCwM37CuCaUQQm8z
         +nqz+fcrZlvwPToh6lQ1WmM2uzddp5t3KQZF3jX9f7GtuyDnCuevM3RkAYOx6yHnIpcj
         jBJlixZo1vI5TogK4d5HEEvGQQkBjGaUwK6xF8+LVWvkICjtfEOEj1owRjsbvER9mSpy
         PjZEjUiHDfDxHZA4oEDRKWnkOVAY9kRowwxjtb01FlPYUGBLnhAKiIsYC/4YCVCuR8WU
         k8FFSdirY/a7vgdCEoOaJctC9maAU/cOHI+aa0LDmhUZE6vIeNnTUYTxhW27BBgjG19U
         iigA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+GxwP30YHBYYlrI+nk14N6A16QC3LTi4uyTtMT4/4gMMsSPEs3QypgW9TLiNHifIXz1sUSd8hYTg5lSVF@vger.kernel.org
X-Gm-Message-State: AFuF++lH/TLJC4fBaiYPQkwmZRxXNro8zixbGtc0LdS7tyYAQN+hDZ+C
	Y1NRmleWTBQ8AUa91kJKnn0s0QqMCN6kBZX105yTFbmQpLC3rqzOzCl/aNcc9E7DdR75Wx1muyP
	d3a3iI2XWO7uFVgxEPnG72sIWUVbRYTkE0Mi+nUjUY0F4yMvPX2azEw==
X-Gm-Gg: AR+sD10Csn+A9C7lWTvoSuV+PRN4QuLjQz3wev91X6VJVYzezaOSqcvj+t77K+HJGMS
	SdLztHCamu9jLd0Kj6Lrhi2FaewgcM9TqCJzwyeM+5NjmozX5ZGdH0D2BelTyH1aGFv+2ttgQxo
	PYctjIxXc9qDm6VxY+mu1mmse8gLQz84bcn8nRpcZqiK7naneWMd0y8CPOMsW4VT2BrChMbGG7z
	/73866R9l2mIbH/FFrqJFDfGfUAe0gwCvfxh29gWZ1bR0kr+M/v0h5Fw1S8YGp/rNfcat/kqWzp
	M3UiTe+p3en5IHn3vgjnArFhjB6fC8shW1Te20ZSwCugIlHgXS3LZLxR1YhRA8UIHAP0whX+FK0
	+eLO+iFoBcoXGeCVCjCUE6BqYfHtH0p6U
X-Received: by 2002:a17:903:2f8b:b0:2d3:160b:c01f with SMTP id
 d9443c01a7336-2d74ddd684cmr64429595ad.6.1787887313715; Thu, 27 Aug 2026
 20:21:53 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:21:52 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:21:52 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 20:21:52 -0700
X-Gm-Features: AcwNN1UXSzbvMguu57VTO6I3Vg6s4xk8FB-MSfUF9MZz6nJ3LiZ8NA7RHl_Tt34
Message-ID: <CA+0ovCi3Ng3vsi3ZWWMxKNA7Wk91iGUu6j+x9Lof5EGsm8W6zA@mail.gmail.com>
Subject: [BUG] afs_done_fs_inline_bulk_status -- KASAN null-ptr-deref on
 call->server when a fileserver aborts FS.InlineBulkStatus
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/134-afs-null-call-server-inline-bulk-status/

  BUG: KASAN: null-ptr-deref in afs_done_fs_inline_bulk_status+0xb4/0x180
  Write of size 8 at addr 00000000000001a8 by task repro/9497
  Call Trace:
   afs_done_fs_inline_bulk_status+0xb4/0x180
   afs_deliver_to_call+0xbf6/0xfc0
   afs_wait_for_call_to_complete+0x2de/0xb00
   afs_wait_for_operation+0x244/0x8d0
   afs_lookup+0x1245/0x1700
   __lookup_slow+0x1fb/0x2f0
   lookup_slow+0x53/0x70
   path_lookupat+0x3f5/0x8c0
   filename_lookup+0x256/0x5d0
   vfs_statx+0xfc/0x200
   vfs_fstatat+0x11b/0x170
   __x64_sys_newfstatat+0x151/0x200
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
