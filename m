Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6838D018
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895895; cv=pass; b=sHtzMdFtNdWaz2p+gg0Y2XdLaOSVLVrhOfVmeDHOaxookNGYwz1oJ0z25+uv8eZm7RNnFNMSOcag9vzj2EDlf2qSGwAbxJkE+LC8PhiEQ/Euu2ozogEvdDDsNMy9uhN17H0NSK2SyOkU2lxnqP9RmkcIBDJlQL3gh3VANSDDZh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895895; c=relaxed/simple;
	bh=TyNvMMqIrDrrdQrNSTAkjwcw9uAfd2HiNJdpFGlLXMw=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=DMy1NUgSbo8L+C3GOEfaeFJ3HvdlvbZeqlPslo2YMl06UtT/YMtXIBGVecEqc/bHaM2bJb0aTk3jl7SsHltK8wCBJRnaS6/HUnKL1vQSh1OqgU3iFCxSb4FbKwRF+oX/ItNDsA991mfP89qUzGK9m1lUV1w69q/kvcKG56Sri9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=nZewbbOn; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="nZewbbOn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccf2360620so6087425ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895894; cv=none;
        d=google.com; s=arc-20260327;
        b=Xya1MC6zA6gAEXDy1of+DoxRNI5LWDnx6kpSl69t2Qlgp9XdvEHWV6KgA6JLJm23kd
         qaysjWOuyRXB9838oI1d1ySFV4jWZPn5ZAqFg7RsX+51RAHWTUnaW4gLCs8ytG0hH/li
         vYQP8XpDOdA39E3Urg4obWB0BDZ3tDrzjFqULN1tujXGYxwvxf/2TqDEuRc2afYT24ZZ
         uAgB4TiFNJJj0RJaPWGSJgbFtOyap+nfEb4QC5ZU4nYtS8cZKIfeUVSaZfNx6DLk3v8j
         glwVJK8t42nfC4ElHnoOweAblLqxxUTzUwFV6x5fpqjgPPB+zX3oKfwqWLEtvj4UZ4GO
         bimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        fh=jliu7snrQw/baseMrH0Zl6OTq8iPxG7W/nBF6tvHs04=;
        b=P+iq6faOoUn0t3s6JhDbRXrTF7hbxXxqahFqqtUTF92ytBvCNanJSVebNrQQFwwAiV
         Khx5SpVuNXYbpdkkDdnXjTkvT9LrGUlHox+5sj4dkXpVIz6PmyWZGuDKplRe+RP46dUt
         DDxJ5I6nUXLpzBX9+rAI45iz5kyttq+t/cQZncXTp4ixYC0KM2Io4JsqmaS5uBs9NN/A
         InCj2Kqhm1u1uRPcQi5cLykfYyG/f5+vWyXhpezF5RHe776XdkBBCcf7W6aMYQFHJ6nB
         DyR2hkdGrJ/qbbXfNZkYfh3yuPXmgdln8h7Ut/LtMcqj6I+lUOvAb5TK0B4H/RsASIlV
         iuog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895894; x=1788500694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        b=nZewbbOn14tQBRrQuiwSJTZ08OlAxVu/MDYknSVUwuOVFpZwJR/OyArHF0NZfnskn2
         OFVwxnxrWUjsqgDy8WVX1YGuYb54IcYDpQksoyJSLX14QiIHYmgplQiS0ub7k0z4Xh8f
         xAHFG4J4pcee3+sFqNMgTaIMtVMkN8HQ5UMxA3ohjLxAIR+ZIIIOdWvi8sAGjtUZKAT7
         4zUk1MfgW3/ADkp4iiuAatVsk19EhqxT6i7G+lu2hd7NsGApUsWQFGDJ6GDZD5ivwXvQ
         7MkH28H/prhSeuTrCPlNBumEgF5HC40HacH7iC7Z/PAJG4lrRm5YylBbzpm5prmyVhXl
         RsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895894; x=1788500694;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        b=TzLlm7wBZDA/w3naM165GY7WGrqkl2q03W+Z1Ou2fozG3mN68cxQIEh2sHEjrPPYBb
         Wm/W4ii6ZiP54KamopUg95uHiz4hxMpiyZC0+/1vvujkFSKxq592j7WI7Bxc8vQyxIRr
         mAXYzSp/yNUWNZYBfys+zflyu1uPwxz5uu3xQdtybUL+g+9N+eJYRIu/PMmhvViqpsuw
         fku5vmpMidIsZ0KTX1XQKsBvvk7G2L2c4LJ/s6cK0/x23Er1td1dfW448VcIYkY1ICnL
         OngCECR4omd+bDUC0Z+AAJMTzdbhNwtTYskpJN+UAScf5I+oKhZJte+2skja2QM5jdfG
         RjlQ==
X-Forwarded-Encrypted: i=1; AHgh+RruB62DPoc9kVmTt65ee1mn3roWC/9PuBwrSAhbYCApq1U5q/bHkiz1dN37Ebp3mbwMIxQYMPlFYqO2shbm@vger.kernel.org
X-Gm-Message-State: AFuF++mPUatSkptCeSCQdbwPxp4wrVBBMlQRtVRiGxzZnEs6oSkXQ7Qc
	hsCwqkhMygbl3prgl5uGk9NYl7uKnh4qkKNZehlbEyyqsoFcJGZ8GK/4AHNDdcZ8kxDri6cy/6D
	KZ5zMRMFLKba2pvYzfitAB7hX67fXQrTItT1VWxrjT1WyihRE8S0aNw==
X-Gm-Gg: AR+sD11Uf3/JMBZnPXjEiCb71vjjviFFGQ7SPHv9yX65ayrOO53VB8DTZvzmzY9CR0B
	3Uuk/9S8D46LFd9X0JU9u2fRJ9gACN/SMCiQ2qA2IWFluACBMiATfF70T+OvmUV2Xl9otK3rXii
	Ph/iwKTut1mLa1GdHLTnFfV89nXjcuXfGNPHYHr6/TkazA5RL4hnA+xK5xuu5WtpMakeBK857L3
	j0s0Mb4hkiK1U/1Q+M4cUELog1YL0JfdXthrFrQFRe7bCtoxGdDBAq9byRYRQCAJDhTs/XyovWa
	NaJCUrGGGaVep7eSbSYQz/Ap80O3CzYR4oT7y9FBTju1+S4uZp8UVFz6/7YDU0/RfM01wsUIoYT
	Jcnq1D9Uy9znJ9YGJVwsLNboybzn8YMcI
X-Received: by 2002:a17:902:e74f:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2d75ebeabbbmr24264815ad.13.1787895892791; Thu, 27 Aug 2026
 22:44:52 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:44:52 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:44:52 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:44:52 -0700
X-Gm-Features: AcwNN1X8SEHOkHuj9cQDgmFe2kkXov2vM2emNM_BCi0ltZI-VSEqYIh1j3pwqxU
Message-ID: <CA+0ovCjLWPoUdo=W93DQ4vKj-A+Xo0AQkjzcM+SQ35ph0VzukA@mail.gmail.com>
Subject: [BUG] WARNING in ceph_fill_trace
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/171-warning-in-ceph-fill-trace/

  WARNING: fs/ceph/inode.c:1632 at ceph_fill_trace+0x493/0x3a80
fs/ceph/inode.c:1632, CPU#1: kworker/1:5/11236
  Workqueue: ceph-msgr ceph_con_workfn
  RIP: 0010:ceph_fill_trace+0x493/0x3a80 fs/ceph/inode.c:1632
  Call Trace:
   ceph_fill_trace+0x493/0x3a80 fs/ceph/inode.c:1632
   handle_reply fs/ceph/mds_client.c:4050 [inline]
   mds_dispatch+0x4753/0x77d0 fs/ceph/mds_client.c:6384
   ceph_con_process_message+0x14f/0x530 net/ceph/messenger.c:1425
   ceph_con_v1_try_read+0x2f40/0x6f20 net/ceph/messenger_v1.c:1430
   ceph_con_workfn+0x1f5/0x1440 net/ceph/messenger.c:1577
   process_scheduled_works+0x881/0x1170 kernel/workqueue.c:3397
   worker_thread+0x988/0xde0 kernel/workqueue.c:3478

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
