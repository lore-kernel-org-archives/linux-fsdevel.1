Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35943C818D
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896204; cv=pass; b=pAIb6Id3RSSxHv2ga4yD8BUxG8vfYY4eCWDZpOdVJqgHh375CEHFzTPD6MGwSarnXbP+vWMLQc1x+uJZ9Ts70FJpaACwLGKGoRdDXP8Ncdntmz+j9XVETh1beaI1XgX06CnXj3tx57DqTO7egYwlnOiecyyKEnBi6ndWfRC+lZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896204; c=relaxed/simple;
	bh=Jio7sO4pCEGq3rVPHZZ84dICs7hxJu4+ln/FH4TXjhI=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ahpvt8K/L5XYVN3JFVacHL3TYJgKMCvx5Ld8kWV2x3w1Yh3WhSrMcTwqeR1OfzlQWTE0YJrX01URPn6yQ9Yx7kJNS18+9adotdE24hikdVcle51LKY0C0VZ9bUXtSzfG5LcDyomSSABi3s2fZL+ZyKFjvEh4bxviYdueUmKjCb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ISwtKVCf; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ISwtKVCf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f620399a0so742594a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896202; cv=none;
        d=google.com; s=arc-20260327;
        b=V2PHlXBnDAyLIouhj05r+yWLH/ztwMiD6MRqhns6WffLA5H3qzeErZUUOp+ueiRZVv
         Pjgfxq3WjyZBMa9i/0+byWnN9AyaPrBc73Z7KpmBOt+psdmo/PsixTFD50AaiD1zlRdm
         Cced7oRFKAUpGl+HYe6r6Wk898RHX2aabGDo1mK9HKaf14Z4WqTwiECkDczDQF0yoF0s
         JDY01rvGnEYmHACqfwWSmiMQgfZoSsmY5wAjGtYaXWkMRTOPLX+pa+4nAyaOd+HFZQzB
         UrbYk5RdVcqAXqsXD29v4/gdQwkrVFVcUKzuIuDdeTvZUWn9xH/sCPSZJTU91kVzjnKG
         1WTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=vAOGoOHxM3mKR4qJD3BaTZbqRLt/kDWX0QIIW8aFtCo=;
        fh=KUiu0FcvL19NOyciDYVh2BpFofWyJvrSFoFgd/t7LLU=;
        b=srpHxaJRdiJ71KolyZUIrlaIVvLb3QXpjZyaJJCD9HU7k0krd00DLZNxClyrlqMkvf
         7veffymB1p8NjwtqNGzw8FLgbYW+66ycTtCG8RDwWXpGyq/QCG6jRiXkaCoTK6LRGJud
         nLSAEvL4iwXNfcr663271Az5ZUObuvg8bFjqQ/aZLfq/M9urOCPj6306/m8reZWUOK2G
         wSy2Oz2dc48QVfyPVlFu80Np6dpYo/sXnuIUkUPFS7I7bheVs4gBlzKbADbJGTwsEYey
         GmRIMljHXpo0QGAuOhL1WomnssLPHfyEV9cL17i8re2LXxR2vDA+aaYS86lAH6KjKC/6
         8l9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896202; x=1788501002; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vAOGoOHxM3mKR4qJD3BaTZbqRLt/kDWX0QIIW8aFtCo=;
        b=ISwtKVCf93Am4tpo4/v6ixMpAT2rHZfdTnV6KL2rH1Tzyqo1mtmd1Ii+VaAqcXsHyK
         I2DxuN4L+s8UvHS/4q8py7ntvLz9Q6YsEQDKHq/opeKVyfJ4uPBKgsYrme2KLbKYSYfE
         youstZ79VUV5WXldc7fcmvp5StzHIZunjpjqvDo5aAkmsSmtQMXl1yUCQ6nld2hjnw4v
         tozGG4w4/eUGP0JVjF+m1+QM6JpY/GYxQ+zag+8iJ56Jaum1vqYwXFUCwICw0OBK3gIT
         qldXTi92l+O0PvBcs66lSK8KgHKR7foVvrsY1Z1ejmtkHHjjv1pDjDo5TYaRXhje92Py
         LlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896202; x=1788501002;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAOGoOHxM3mKR4qJD3BaTZbqRLt/kDWX0QIIW8aFtCo=;
        b=rw4EXRmkr4rkvp1+66vPmlgmMQQq1t4pTw9Lcd/Zr1UXhnsdbqciOqm11BdsNBJ+Gu
         yY3Ptb6pYjVvzT+r2bV/5uTevxCg7jpwVIyPzaKmXvGCS7fUuyeC2HZiCWHWhPq9ntmU
         6I9aWFgVShHQycnxTHduEqy/tV97gUtPmNd/4S8Xl+VSKAr8Cbq5Z8lqKUKUN5uIb6xL
         PDyTrhTtg1dL5AM1tGvUTQqdCA/nBpwUfNXl0OdAuRCcoa3XFcaoBE4FfuGjIWQ3WqJ8
         YImRrW5HlMczgTZ9ynXPdOTfyq8nx00YqhvJ9uBqQ5WvJKcMkGnUwSgfnWrBPk5P+HIA
         MEtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQKJrnIHmFlKV88U1MNl8bTrK9wH2Kt8pInMhhHAHNoHCVB7Q5DozKbyc8217QUkDWLxA2UOfEpXL9vUO4@vger.kernel.org
X-Gm-Message-State: AFuF++mRsRuvJG5WTtKzyRPco99mtAcH+9PsDpNNJ0sWMTpOEYDCRkfJ
	1ylhrmeGkp8s+TKQirmu8MCDDVgimlXRPub7jumP+3Zs6lRt77vth4bTkurRqf2KCZSB9Y8PpkH
	OP5zHm9NdqlMXNrVOIxxnWvGDC+Se4ygRKEHR3gd/
X-Gm-Gg: AR+sD11pMZINqWgQYNczqoydUWKtkm0s0zVdSMvn45dTlMRuzIeFABH0skP4kjAPKj4
	0Ox2+OwHCHRpHLaacNnGysNVM406xVIC1gbm1wDkmk4/T7oEf3y3u3lAL9PzZcjS1Vc3YrMMTJP
	DP8QwShq35/+ahbtwEZSyNvy5SFaPxtFYPdDsewX/iRIaT4TVLpNKzKmneNvnZ4TEz3E9LCfLFF
	jbKgPQs+EwrGLPD0K5a6vA0zjCnEzL64IkGaKQpYVc8AGW4JsXO4nPN4sQWqV4zzaPpkPSrXxss
	dQlFmkAg3Ojim8TZdnHHqmVsp5ycsOf9V2qHtw8VeiXv7RMpfCZUMF8GrqaZnvMQpMSCxK0Nd2N
	jKqHw1+Gbk1/e1WYqJKjUYGJljUhUbmlO
X-Received: by 2002:a17:90b:582e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-396d0fabb3amr8959710a91.13.1787896200987; Thu, 27 Aug 2026
 22:50:00 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:50:00 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:50:00 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:50:00 +0000
X-Gm-Features: AcwNN1VB4Lu0vx7OeyLBFvG_yf7maW27jBuMibH6lUCi0Q10SkfZv_mKR60M03I
Message-ID: <CA+0ovChyLaYfEN19Fomt6qWx6dYtX47Ptyaej3gfMeNGB1xoFg@mail.gmail.com>
Subject: [BUG] general protection fault in sysfs_do_create_link_sd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/188-general-protection-fault-in-sysfs-do-create-link-sd/

  Oops: general protection fault, probably for non-canonical address
0xdffffc0000000006: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  RIP: 0010:sysfs_do_create_link_sd+0x4b/0x110 fs/sysfs/symlink.c:35
  Call Trace:
   sysfs_do_create_link_sd+0x4b/0x110 fs/sysfs/symlink.c:35
   nfs_sysfs_link_rpc_client+0x3a3/0x590 fs/nfs/sysfs.c:343
   nfs_init_server fs/nfs/client.c:770 [inline]
   nfs_create_server+0x7e8/0x2110 fs/nfs/client.c:1155
   nfs3_create_server+0x1e/0x180 fs/nfs/nfs3client.c:56
   nfs_try_get_tree+0x1fa/0x11a0 fs/nfs/super.c:981
   vfs_get_tree+0x8f/0x290 fs/super.c:1754
   do_new_mount+0x341/0xd80 fs/namespace.c:3834

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
