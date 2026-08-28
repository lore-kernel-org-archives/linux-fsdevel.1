Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C728287E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887254; cv=pass; b=RznVsPtrL38LRJ5PYifs1q/Ptu2M+mz3f1SxIrN0fnX1SwqsKRaTRCsO8NwNCxtbouN9aG3wHy1pQ76CH7uQZa5k7opTnALN8Opt4VpbXBHyghzeAPr2QGOd4opVutHOL9R2pkDpd+OCmpwthxmoUdulPNK8pbyYJ4e9cnCiPP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887254; c=relaxed/simple;
	bh=icOa9EGbmc1WLBk+PWgRJ2bum2ltIyAV3u5EU1L6H7Y=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=KjbpZ8evG0yc0Q4xuTpsYQyXbkH3duERTRM/2MpK0IUd14o+PFh1brJk0MwD9hE1vSeEyr4UsRdC90PJjE8gTIlU7DuHJUfQPX7BCxSBY0p8py8Lth2MSBa8l54jUU/42zl9rskPSwouCohqJtXfSt7heRu8xbpjR5uu37Ymims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=Nte0+RrT; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="Nte0+RrT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6d28aa26cso4332805ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 20:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787887252; cv=none;
        d=google.com; s=arc-20260327;
        b=BP89R0Uzz5SXNStlv+a/8TFWiAl+kh6nyFe1aZ9yxmTglOI3NlAQ1UGXy9YAqCnseN
         0BuJlQr/a6tjb+Nu7VidfOBymE6XCnO4wHFOQ1WBrPj8SyZmgKwR8dTTwt0dNNjh72vK
         5hOO+oTP5BcuL0ct2atzhdca4sq59oHgooYAxOsLRPEzMa7wTwH8h/zPVFevJDVZ1LDL
         y+wsuDXrwN6BaogFib4Xx3LCNrTmGY+6tC8QEnaHFq9DMpcmAfj2EqTFuGdoA+idV6eU
         aR5SbT/XymF+8OjsHNHmR+Ke2bUJF4X4y488Z0v9uRqJufj11q9vSQF4PhpC2QoRiQ3K
         rOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=1E6Kcf/lHHF0i15AP4vDC8gxkj17C5jINRJ/Q9+RblM=;
        fh=iDppnTXJKNXGcYqHR1hkBRB479yLsrV9TrDQmsbkqtc=;
        b=sJvfzUfRxy2NXy4oyf46nRKDk3p0RYZ3nAm9pWRtw3rZKCPf09/SbXV06GIu+IW/rR
         ZKsFwdgQxpELLWhdAVWVX5WP53Ng7CAyriMrYziBkvI6eRbo3wcteQdOM9y70VErYg2S
         PuXsGGk11uxo9TJ4/C4AWgBi9XlEAEMFp8lfGSw42MUVmJ5l2TsoXmWU8HEPYrPNeov2
         m/FA63nkey/1f7hj2hRT7/MSMQt1lqMFqEYNCzlIxMOqS+AfnWK4ySeHQEJ/aI/5hkm/
         3tKkC0DQHgNAwt84lqtQ9XSd7tXFP+ggxAT6H2FFNpqH+Fn4uTR6UwXSfR2WfzIKeJde
         kQ2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787887252; x=1788492052; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1E6Kcf/lHHF0i15AP4vDC8gxkj17C5jINRJ/Q9+RblM=;
        b=Nte0+RrTpxt6YhEz3ZkGt3H44asyhuUXj5bn+3bkB3f4LRyJ15MfsGihHYAxFNUQPD
         gweNazc3xBslCkvqHXyrm0QcdkhYGvjUoBhR1NdCDAoum9sI7+7VdhrnhyhhR3ugF1e9
         BPTeZ2bBeOSVNUgw6mjhMFqOlZWxi2xvAh+0VZBDXcw7PLAHs+/XEIiqbY2YfnIVUmDX
         jkPR7jYAHDom+Aq7CvsORHmBItqbOjQPAu9XUN8M60ykLHRc1jElZmPtHHdz6H7bMGGb
         lOvJwZ3oFhZ3Is6/o+DnwFmxese5C6gdECZzre8mBaIJJSe+5US65MQ4kNEklk6e/KaU
         b5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887252; x=1788492052;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1E6Kcf/lHHF0i15AP4vDC8gxkj17C5jINRJ/Q9+RblM=;
        b=dJ5wRaDtNeQHE4XESPP4/QzzxNrDOfFaZC7zvQqvYQvVv0IqWrkDo8lUEZ971Qpl/U
         ldi1/xC8+lfe4GgfwxINRxcXPl7oJfux4Oq0Tt++uEyuB4dWqnntTe3sMn+eg3llzawc
         1pfVWrGCtNJAPxUClPoco7GY2ZOVyUAr2Em8muq1uIBPsbqu1vuFj+vMlEtm1Yh/XZ+j
         CBjgl298Y8IRm5qCohRZJc6HeYQM5G+N+IyU3bsIbfqEbpoWNykXcRG1y4Ur+ZOUVKiu
         9XuJVqcp8cnS2U3JVRY42NMfaG82Ru/0a+CHQX8IMDXcXwXhJApxPvjNDmO+vBVkaAZs
         HUzA==
X-Forwarded-Encrypted: i=1; AHgh+RqZqesPiVnsf19KPrXcq4mFozpVNnoOzBBcbElDS2QdXlppKDRn2R3UJyMZXDCT/bfJ9XNTgC145a3HARJ0@vger.kernel.org
X-Gm-Message-State: AFuF++nncR/IUuBfkHczh47mQV60ESkshEOEq0SaBUB/PI1+H2XEApHW
	iqAO7q7bimn3/d9G3ZEE7t9Xcj/Q9ldtVzPorwhiMLMaqRM6j3I6/mdGCgdZMNh8ybwmfRbE6qx
	lyOgIq/62vUj70I1m9sL/e7FsK6/9wDJO537xxs9E
X-Gm-Gg: AR+sD1318HMoBRFZDzZ8HzzDLFCXBtA/C3axqmiSm52sG4S9y+JSwPNinogU7ebfCbs
	3ayiWru/Q86TVf2kG56zNlZps5R6FcH08kJaXUEFI3DidNNPWtZt0NyFrBHcNSTzz7Lzv0vZUHT
	VfedPQzsZmEpEvpfi8AVkpAKw7Rje6G6COacrpT80ZdyGpeRBBipxYtXgI2yh5qQvlLPIUR9YnM
	fBQWaSiJJdQWjbBeNFPm4JSJyZgOZehbTURwoakQ6y0q+CXJz9Za8hVc/oT18E7dwm2ul4wwcRi
	ZB37axFz7Wl3Ldncx8EvAHFUsLnA/s1B0WgjcY/HKBwbYqX394zyOsRtX4oZi37xYELmj3ZZPrn
	dvxAW4OnL0s3yrTNIHbKEodXdIWA6zUgeTrSnm3sbKOE=
X-Received: by 2002:a17:903:234d:b0:2ca:660:b1d with SMTP id
 d9443c01a7336-2d74ddc6daemr57509085ad.11.1787887249023; Thu, 27 Aug 2026
 20:20:49 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:20:47 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:20:47 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 03:20:47 +0000
X-Gm-Features: AcwNN1X0Png3mCiFpg0qr8t12Kvqb0UYEZhWDaRDZfSHDZploBz1NogzadCsAoc
Message-ID: <CA+0ovCj6dDADF1Q+qYyFCk+X1ZeJDaBrz0FzTqMbnsH8OnCeYQ@mail.gmail.com>
Subject: [BUG] afs_deliver_to_call -- ASSERTCMP when a server returns zero capabilities
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/131-afs-assertcmp-zero-capabilities/

  AFS: Assertion failed
  1 > 2 is false
  0x1 > 0x2 is false
  kernel BUG at fs/afs/rxrpc.c:572!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Workqueue: kafsd afs_process_async_call
  Call Trace:
   afs_process_async_call+0x82/0xe0
   process_scheduled_works+0xc99/0x1900
   worker_thread+0xa53/0xfc0
   kthread+0x38b/0x480
   ret_from_fork+0x514/0xb70
  Kernel panic - not syncing: Fatal exception

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
