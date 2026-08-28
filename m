Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83439C631
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887107; cv=pass; b=J3tTNA3IwieRmqvGOyr+awIBSOsiN/sWr60niddkoBtQbBF1wvVdq1rAuM9NSAnUWphFr8sawr5I04aeTybwuQ34hcKdym2W1GgsTGkmsXHGPrUjnHX/Yl0/MHhO5a+UwZyWEVDo9/1qmF5wsiijgmWksSxPJb1AzimTBTt/99s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887107; c=relaxed/simple;
	bh=HQ0WnQR17PYv7KRSkhcEskYCEIEvo6me8U9g6cEGAd4=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=G6OVPJ0bvb5/tpas9vabWcq0uNbC9gAba+rWiF0TmnTdVF044FCziSpHRc9X83EMinYAYwGahJuYP4mgD16MvtMoSgWD0J1ThOBotE++sxsUGfjEejrq46XL2TlPjgKYoQjHGvNjXBazYHAN5LwiFuXSkJnYDtA0YMSrJKlq2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=VFH70jzd; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="VFH70jzd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d6e954afbdso4060935ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 20:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787887093; cv=none;
        d=google.com; s=arc-20260327;
        b=c9gUTDHzOncM2edWFoRHKqFAiV8HyqYoZwlHM+H3BT4N5hTesy78YTBcuM1dwJpCJD
         X+8D7Y6Kx20tXPxrP+VOJTaKqZhbZUAMoQuB2sWVjuBmyG5qUvPdQ2rxoQExTlFfkKie
         czxM6WSG0QszWsN4ttNqDBeKXnuut9KwT2S2G92bkdk/c+a1M3EVubrXXk8YaWTVWtX5
         AWOvGFzpCd4sko9PHriisSRyhmmRNE/2ODU8ZaCpn4BkMN6xI+xpoGUQl8JdskAKzCt4
         tpXJnveu59sF+ZRZftwiiv4gZpe3JzC9MUwaEvHqI/ZWM2T7n9WBy3vDZ8liJ0kj6OQw
         a3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        fh=W/EVirO5954p+TJH6ZcPSPkaCt8aP8RFbpxgu999grw=;
        b=Z6SD9coxjl4tX1gSIv94P8kk444AqN6bRBwetnWducq879gjmXnHbxwFrYq0Lw3aRJ
         oyESvHQX8S/THew2JT+rdJeEgiKDy9sIcyugIY6ilJM/HM+6D29rDQrkT+El6qfmtQ7s
         5FxjzbPzCKt8C7Dtki9LNvy4P9/ElusIQQSdYPNuHYNKFBIk5hpumY7YQ11f553Rq++v
         ud6EAcEFivqRrLVWh2pswrHARJQmlkICV6SApa4QOMr1vEzatQf7MbNJu0vUf2oE1UPt
         p+kLxCXUuGbyJs0xu1V5J4gizUGH1MGBeF+XjX2W2M5SEbGZXDvwZb25x3YGmoBZbAaW
         piVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787887093; x=1788491893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        b=VFH70jzdqS8zgGI3gE+SQbNwQrRlaT6XDnWXTDnjVih2Yes3iYu0591m2QMX7ypFbx
         fkEynZIAK98WDQXwEP9eAULpnrOYuddPOuzOvUc7HbdbJXoP0mjN56Ct/Po0dVS1kCSu
         cQLf4GJ2Z1EDplwj6fU/SUN1dGTwRC9PNatRN7iyXwaEEz83o3sS0eqIyqEtB/dJRY5P
         ss9Q/c+HygNlfNb9hygwuoTCZcwqWzwWz7xEAgAf8f46Q2nHtCXsL43hEeKG49XAVxtn
         RulZNEg776bCrxlH0O+L5EB59YHxm/QIwPc8w7f5m8lu6eEgz1STCp0v+z3a6Ab62YBb
         PVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887093; x=1788491893;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+pcBwoGootdTMgC9yQZBi4o63OAS0ou1pi32Jt08/8=;
        b=mB3DcEzf8N2bsf7/s9vKbldxFT/sKRwSBK92QTrhussw5Kj/HdfcBeWMlFDpOzDoLX
         lt1jqddJW3j7yv/OwUlkK0f9Gh/mGS+fVRO+t4ZmxO+am02hBM7ajhV1fJndA+fZLxB5
         v3FYVHzEzmTtcW0NO/jSX4Y9/VUHzt2OCacllUYK6UfJK16NrBnRYZDjC7JcRxlHehcm
         z85yX1r1lUSwb3xB2nEDeJ+C05By3sU5+wG4IDBaYjWtvJ9UeV1gRSfvHenY4aX8+E5s
         DN+7wuRqsSphgL4R3XVtVy0yj5CKLV80iS6nnLwaqVN4l8M3zZl2dNfaXRL4ufdqcGTV
         p6aw==
X-Forwarded-Encrypted: i=1; AHgh+RqM4CxsQ2tlgq3W6+V9x7gn2QO0QxMwwYgT+Uw2jVWm+sFlus0IScpOfaRsXEywwlyVKqe8MD4YubIi3c4J@vger.kernel.org
X-Gm-Message-State: AFuF++kGYsDCLOir7o9OdzBYtfyDLZ2i+XOu68MAZ82Q5AhXFW4DJfIx
	aJuTOBeEIAq39sNQ+fCRnaJs1tOmfOYo5b3YNv6cvx5SIS9HThfcrPasZtZq4Q/apvI5X5kWsd2
	JAa69o2vc12rrciBB8NCgqHsEHEBugNc3KDd7KXat
X-Gm-Gg: AR+sD13dUHuihx4M3qqorMJOlEwxbS/Rz/3sp4VGKiNtBT15z+rGne9RhpdkE0A3HHq
	D18QFe4KnpnCC1XokDgho3v4Vp5fgFlmRbuOONjZvMdbm48fbofhX0I3tPsYGmHKEDuCcl+DFBj
	ltaKjyLZLERMgxB/fIu5Y4HBb8LNOa+YGr6RYyv/MNe/XG5NbDhFEP0CrtkXkQsKTcnfhZ/BueY
	JxDH2EBQwIk1iOFjMqV4v6KtOP1nmobmqQdl9mPXIjetm8TwcSAi7kKA8fhfP4/Uy4Ou1hGRgnW
	hjISxj7GkoQYYtptIk0MeUUS1U/I4uyes1PeHlBdXayGzfpCNaMJrHAjUG2/aNAaOIXdr0O0ydZ
	ggONiGsptV9400sUvb7t3EjruWnNEeFSG
X-Received: by 2002:a17:903:1a2b:b0:2d7:11d2:1455 with SMTP id
 d9443c01a7336-2d74ddbe12dmr74674295ad.4.1787887092175; Thu, 27 Aug 2026
 20:18:12 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:18:11 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 20:18:11 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 20:18:11 -0700
X-Gm-Features: AcwNN1VRnFOVAUc9Rv-gIKBNA-JVvlf1956tLSNytGprkbdWOWJLg0Y8x5Gg6po
Message-ID: <CA+0ovCgYP920GT68hAJK6Trjyv1kGv2dZAuem4LEunycQ=POww@mail.gmail.com>
Subject: [BUG] ecryptfs leaks an inode on lookup failure -> kernel BUG in generic_shutdown_super()
To: Tyler Hicks <code@tyhicks.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/128-ecryptfs-i_new-inode-leak-lookup-failure/

  ecryptfs_i_size_read: Error attempting to initialize the lower file
for the dentry with name [victim]; rc = [-26]
  VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
  kernel BUG at fs/super.c:779!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   kill_anon_super+0x3b/0x70
   ecryptfs_kill_block_super+0x44/0xa0
   deactivate_locked_super+0xbc/0x110
   cleanup_mnt+0x437/0x4d0
   task_work_run+0x1d9/0x270
   exit_to_user_mode_loop+0x14e/0x540
   do_syscall_64+0x317/0x510
  Kernel panic - not syncing: Fatal exception

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
