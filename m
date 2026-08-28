Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60933C3F41
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895980; cv=pass; b=YW6qYmjZR9/0FU4ULbu9NSBU4O2OYXLopjwRq2LVG3iXu4oLSYMgIT5hBfUjWzSGZCVnxJIFpOiJ7DOqbYH4fo5CZL6EGwP5uAGdqNygD4K+4v08D+o5JxoSd1p5UQU+Ks57ui/5kAMIwtnB0g6HKVH2nQ9EsgP8JMe4w6ywx94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895980; c=relaxed/simple;
	bh=3mzePdxBZU/3WYB/4lvrTeALz11TsrQx6TVNX0NuogU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=GZURxZdvgyjlOvm5uFAGGmzOW6YVchlj7CafLx8j1+bsEGYYk86XKpop3WZmC2wsRUUeZ+u/4sIaN/p2Byz5AjAuvXXd0OFuVE3huEuIpfMox0yegWGtpd71/aYfooFthf3uiFS1aw4jFK/CtFeQHK6iGFIFOwLgvn8N1iZUg+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ZVk3NXk7; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ZVk3NXk7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6e954afbdso4654335ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895978; cv=none;
        d=google.com; s=arc-20260327;
        b=Beuii26pmY+dCJ5T7A5HU76/j+ecexT/Z0RXOOkqKh+P2N+dsw5MZDjtGhLBoPyUGD
         lmycNEwEkYZoCZ1w+dQnkL/9uxZ1zfiFo/jlzywJ2fO/9nwNBMrULp8eckdaELKnmo/h
         givW/AODHI6Y45HHLUd3Bd7U2WSjlJGlczCNQFP3/BCDMiPDfkKoIIkh7X1CfoRk7AOd
         EeOjltRCwJ9UhEjhx+cyaobX/x8gL76npuq4/ys1I76h4PYq5MHLBOlQ6Ime8muYvnES
         yEnkFCnlkfaTAaSR33FLWKxNvGzYvKmLvGyer0NljevKlgI2FNQi9WIV72oVE1OwfxjX
         l1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        fh=hhFjzdAhgkfk4DHBwpd1QNrjSn0dDFQt1K3zps76f3o=;
        b=T80CWRCsyA6r0A3e0QsWkofknmSIAL5LM4EJ1bOdrxyxbkNr/VdmBnEYwm1JWFw1Xi
         56InE4kPYIN099IYKBz6RWd+A3JO33HBHQqxsGn1/OaKkXi0MJmgLEdKLS23uIo3e+2a
         XQSsjtBGBkNATX/SP0ExhC7eZU6kym/nt9o4CP5N8fJDRk3MzVQuoE+Uf1hIeVR6YG5X
         lEW/7bip8fiLru/AdxxX/BmVK2zeJL17oRf1RUqBA0zQkIE7ALY333I0I6llF/TF+QZm
         EA9SkAvPwaFFcOnE3gATvCqL+w5n/i5q+feIdUtnIBmQkiCDILwbjVry47Eo3UIFTJVA
         WV9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895978; x=1788500778; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        b=ZVk3NXk7GQ6ecYx9QcxJBPyd4MO00O0pY7OP2vYI1geEUvXF8gSq11xx7quvCOGsuy
         AvDNuyAjyS4XvVai6iquWFkI45tLTDNbILKXlQPsWVWrC+T9c9AfXWp3yumLO6c0k3AL
         RTl9TtZYRlkUUSH9ntAEP80gjx3li7wpvsnHoCvM5pqqHy2Ye5UBX/CDbOIMT7yC7N2m
         uRerS5bgwEfbF3ccZb95tzfWYB7eVadL/hb2gXtRQVH2t7lypbQ1zUCzWI1Qv0qf4WC2
         Fj1Q3n3fwlbbsR1i6R2mzvQpu1dUf7LfaarsAlJJBmfNFJIKJSt55Ij8SOzTn74QSEzX
         VW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895978; x=1788500778;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0GUepPC6eQwQ4aTuikrhpmMNCO3bQ+7a/vXwuKLRNKU=;
        b=b/eVGfEdoH54/NJlYqx8mzCKXbA8pLbTfPlDRIQrJpRgSPmVSPXRb1+9/ZWWl2VPg2
         hNFNtMYr3G29Ae0HyFzMxMQkGqgB+RP8FcYifwy3F86bLvUPeLWpCCf8397ZM0+KJ4Xb
         5VHqgnXjwNfDC8vD+dTBLGbAxc3zmhC7jSg4sEDAwyYZDHsfs16JMAI2drRAAvQ8D6ju
         VEgJG2HJx+Qc6bN+kKTTFQBj9W0yJMrzmP0A5WlzMwwD0rz9Gl1A5i8ol/Obq05iWTkZ
         bfO4DS/U9yRPq8/zJ3xPjHvzumC02Jq9DUJkB7krXtJ/UXGX+E/WvmjZFZTN7DRO6/gx
         X2Lg==
X-Forwarded-Encrypted: i=1; AHgh+RrJkedP0KiqHBONj5o/57Gke/auto5/oU0eVQzHoKasp1iar747L7ywkxrcapm7ZYpk+SCgTYgpaNIK7hyA@vger.kernel.org
X-Gm-Message-State: AFuF++kcoFEAqo2IUv51lh3+vseqHDcqWI8pvfPLqp+k8tS4aQkwankE
	TCEzHv07lgyczRQR1JJyx7ImKPWpaf3jdRXYx07tkspQnZwdhG26D73i0fw6KMOCzyOj2kgynHR
	J54SKH2i87rbD0txf7NzC0O3dabF2rLexrs6Ksdm4
X-Gm-Gg: AR+sD11lSjyWc+JzfpwiMv304ZYgZLrpYs2Mq4kFAg1jDo72jUW5fEfRZqqN1PjQIy2
	Ew+XES46jvPemPl5HLk/Rg0+zfd0DB5ZVQGTFWIXOlQigymSG/43UfPd9o2AHKp9UI+HjrcNuZf
	3ob7mWTL4R00UfI+rwhOBQI0ZsRIPivH7NJb/y5fLaY9KFlTwTVHtzZVzjKOjNd7U5susEzhr7Y
	JEryRO9YDl5nKRUeac9O7lAMaSA1epENTZ1dJ1IyO7hPv7Ox1pdmn+bVEIk/MC4KD/jTSBDjpB+
	jP+XVNkOxNFfcevcY2zuu3XThsUZkTOlilgY31F2gN2uu2qUrh6h38ORiiNjYO8JSDgvrDP+5YM
	S/qiZmLa6dJOD7nWiDS1bkuSj03bdyXkC
X-Received: by 2002:a17:903:15cf:b0:2d7:1aeb:739 with SMTP id
 d9443c01a7336-2d74e1295c2mr86465035ad.13.1787895977223; Thu, 27 Aug 2026
 22:46:17 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:46:16 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:46:16 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:46:16 -0700
X-Gm-Features: AcwNN1X4mXiwbv-zD7khlznKWnAht63BaDjhnKiIcjF9IZjcchKCLalWAp7F7Lo
Message-ID: <CA+0ovCj14CqeH2qH-fxDdvdK3Tp=rgZM7opqOp0PkYS52RmOmQ@mail.gmail.com>
Subject: [BUG] KASAN: use-after-free Read in gfs2_rgrp_go_instantiate
To: Andreas Gruenbacher <agruenba@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/177-kasan-use-after-free-read-in-gfs2-rgrp-go-instantiate/

  BUG: KASAN: use-after-free in gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
  BUG: KASAN: use-after-free in gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
  BUG: KASAN: use-after-free in count_unlinked fs/gfs2/rgrp.c:1159 [inline]
  BUG: KASAN: use-after-free in gfs2_rgrp_go_instantiate+0xb0d/0x1340
fs/gfs2/rgrp.c:1238
  Read of size 8 at addr ffff888011445000 by task syz-executor/17182
  Call Trace:
   gfs2_rgrp_go_instantiate+0xb0d/0x1340 fs/gfs2/rgrp.c:1238
   gfs2_instantiate+0x151/0x210 fs/gfs2/glock.c:442
   gfs2_glock_holder_ready fs/gfs2/glock.c:1250 [inline]
   gfs2_glock_wait+0x1b2/0x280 fs/gfs2/glock.c:1270
   gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
   gfs2_inplace_reserve+0xc43/0x3420 fs/gfs2/rgrp.c:2093
   do_sync+0x64b/0xca0 fs/gfs2/quota.c:948

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
