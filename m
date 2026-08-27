Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412E3D75D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870161; cv=pass; b=Mw2ZbvvnOhGfV29FK4qjR/u1A1/YImKHrFG4/5lbTRYsWbM8h+k6D78q2BscYs1NqTYRM30qqXPMRyEzlyOSHNurmKAxjRkzz6ZxAd0cTlpcLj/+Z+JZqU0UEYg9VN7fqKnSuSHKJHVg4J2E67+/ps2XmkyQfmJDQ5qf7p81ids=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870161; c=relaxed/simple;
	bh=u1ODhvNFMmxXNrG0OJn2dGP7Qu4N4k2hoIPT3wVtaLA=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q/csWQpGqZR+YDmmEa6S57NAd4SXKiiXkUwKWPm1dkqDfNCKMBikUHR1nX/wWs7zHPwm9Dzj86RI9vzCIP+pDGJoT24NP+RGhEIaXq75FrxnUp3eK+rUHqlmbVGPW/3AsOAsmNrGdas/xhgUXFWDCsSkMvq9K3UCkJqfYoBM/MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=S710XyWS; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="S710XyWS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6f55a7089so1900225ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 15:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787870155; cv=none;
        d=google.com; s=arc-20260327;
        b=exPsKc4CNKDtFQTE5KVN2DWuj+3vlD/7eGqszfc3tPqaux1VaKOoQ/bW/H69oC3VVp
         LeaaFckXT3vwRb2X4xaFast0duXEbf3LUXwkIJxbqxnOlvnPNPMkknpbHRo8Nuh4sSnC
         C6sHwF98EDx38TsBAiFLAdNuozR6+3uruN66SYzKvqQx+n2A8s75Bt9KRC+Azf3Tc/Zf
         cDut2pd/F5+AhXvdOlUtIqkFKcCEbhxBTcGLOJ5oUDRcL/Ct/Wko3tYG9/kTI/aDhtNm
         xif4mO7kERB1qe7G76iUnoOD3uDjIrx9QmUDcXKLZy9ccanq9T1EOEx2XZFggY8ZKX1y
         Eqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=MoeD6WLey2iPImsUR6TLXDfulyi5sEhqEwHnTLrN3cQ=;
        fh=E7bM3Mthgl2LckVly3YkRKAPONJkHIZY4CcTYEilSMI=;
        b=SQUhrNm9eTRJA5SaSu2neIQGz7QLgAD3fv9MlKYnI6/9XEkAo6e5OjrFYIafECvGQ+
         2wBH0o17Cmsv3uEOq3TgGcQ78JsbmjZ69f16xQ/F+ijpgd44gUOCGLHb1tp2WAYOWcfh
         VFdaQk/BRvrttyuicmOcLcAH2KF7z7+lg3w0n+tE5eWJTscQIlmtMdNYW2PS1csGO8Xm
         ozBK0GCsyYlInsYJuPgEMF/x1qjFCHU57ey7jf2jyiAR4FkKQYFadXj3+PCd54wViPG8
         J6zX7E+xdNm3+LIp7wonf5v0FA1mWzCc1yaa4R2wxLuVE9qxD8zMxcUdadpks7i4JD+Z
         sL/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787870155; x=1788474955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MoeD6WLey2iPImsUR6TLXDfulyi5sEhqEwHnTLrN3cQ=;
        b=S710XyWSFsf93KeUf0eS+4dhyi1LtREvf35xlXw/ASmP4Et/duyb9vpyrtyoyjnZ26
         buVXFoKH2mxX0O+1166c+CrxsVG0X8X2lTb6T4PAn8c/fHFJk5Re0qQ497BsOqhGzBYA
         /POClQSAF8brokxIDHcUbrincV5wklsTtwPeOJAFNpn8PvIUPQa9j9UKpIZJxDfwrrQU
         0X5IWt+Znnzih4TBNdbYCqMPx8bhWOzGgtQ9yFXwMCEWjLe0+b33IsUnF6vgekEL+h/1
         ckYMtvAGKYOA9oYhg1hVpOo/m35mR70I6Xh9wpR0n81Kw+ylfnB9tobtbaQOsIxagGzm
         /kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870155; x=1788474955;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MoeD6WLey2iPImsUR6TLXDfulyi5sEhqEwHnTLrN3cQ=;
        b=dtSsXa7my307/e3P42Vaog1D1rynSNd8zhXd2gDXRBpVaEq6xYx4G5GZgX8e8KPxJC
         gxvRN5QJBxfm67u14DS9+C3W2oYtwrDc66CGjlhsID8vHt+n+F7n8ndjJIx2s8SHQIPc
         xX79jN63lkh9MI5d7jS0gQM9QNJ6AkIQVM4rovJXVSz/P3d2v5WvqucZYc+qMsEx4flV
         frKz5LSbMZzwMPLbaOIVbMWYl/Od/kUBBAKboy2kzjIrnoHWfnCqOwOjbxrYm3kdxkhY
         OVSR2Rz0vqGFbqCto3IuS8i7j9dQRSYXhF4YPDv3mWt+3Kd5QBPRWsATba9v19s1Uyso
         nHuw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo1Yqk5u5UYdQ5z/c3R+yyHbod/2BlU0bx3T6HOR9xz/iaURU64KmQRzrCtZ9Tz2G3qVJ0Qg0BW4L5LRDG@vger.kernel.org
X-Gm-Message-State: AFuF++ks7i+kxVrm6LkZ3d0eX5VPbBasU5rjfySgnemxgr4ULnC+HyCL
	k9tBiPfSVQzMR40eoA+pUQbvYlcLfCR6i0ltKVp3vi9gvpr3SsD9lfFGxyMi6q7d5Yzb4za2bwS
	GC1A7a4LqsNMt5GcQ+2UT1UOGsrZif/XTNT9g4b/4
X-Gm-Gg: AR+sD10No2PnPi+B4yAWumIBfCOngUrv3io4p486CAuwyNPVJEiUhY8V0F/SRXKiQWO
	cz+etg0krmDFAZ0ww7XZ4o80VVlPH8BFAqaAtRC6gjJyOCp+ryyBgJKHEXpzdzVzoyN7Gfa2YBU
	SdD3Q9N4kl3bHUSi2V1qwrP2FbxZMHQjg/h4GWQ/QIuBXKeHzRW3kiIZvWyTxAXz/Z5eR7Bwn8p
	0F07VL/m2EOA3Y70RhbQ4DwYfoqvGI/a5elgF54y2onhRxriN5ytaIBrQp/0N5cBfKi0oerlpUe
	VPEQHojP3cHQkBtG9Fc6xMmau/x3emg/jCpQlQhMpmXGB1NohxZtGy79HEeONNSbnJGbT8ZLBsk
	1mnL382gkjT4TsuZlACtUhck/2Sak1uqD
X-Received: by 2002:a17:903:286:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d74dcbe867mr43946985ad.7.1787870153630; Thu, 27 Aug 2026
 15:35:53 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:35:52 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:35:52 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 15:35:52 -0700
X-Gm-Features: AcwNN1WN9_5wnj8R0zXdgU7mM5B_PNMO1_m9fHEFXOCMJ-e7juPFtPd7hxiDQzI
Message-ID: <CA+0ovChCRKkAga2sWaNCZms8Hv=2+5gSpQfkaN0eePs7eWPXrg@mail.gmail.com>
Subject: [BUG] quota: NULL function pointer call in dquot_acquire() with QFMT_SHMEM
To: Jan Kara <jack@suse.com>
Cc: falemi@asu.edu, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jan,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/103-quota-null-func-ptr-dquot_acquire/

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x0
  dquot_acquire+0x175/0x610 fs/quota/dquot.c:489
  dqget+0x795/0xed0 fs/quota/dquot.c:1002
  __dquot_initialize+0x3ba/0xc60 fs/quota/dquot.c:1530
  add_dquot_ref+0x2ca/0x3a0 fs/quota/dquot.c:1073
  dquot_load_quota_sb+0x873/0xb40 fs/quota/dquot.c:2496
  jfs_quota_on+0x2a/0x110 fs/jfs/super.c:803

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
