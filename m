Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE233EEAF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817318; cv=pass; b=iptPELxmKYFMh5Ucg7j+qeSxp8kBFMlyf/Yw8ERia2We1FkGSpCbEFT5KJ3XWD2gAfYS4UVNOcAWE66hHOQza8Vq6KAUDPg5QBgVyyPLAbhLl+p+DPPsXgx2vEl0yKsIu2fndO/eoLJJWkrXcDokbPo1l9qZK5fJP6hj6DFEHNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817318; c=relaxed/simple;
	bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f79FBm3oVFEpabHBh4IGj/0vgaTvySr23xGvykc+5bxP2XpqThlPmuEiRn4EvyZaNx2RIEXgtja2VpfYIQEyjzVS7McOFTEZYsLkrPEkhQO41KmHc+nXkchCwf5AWUzpi8v3HhvtxHU3GC5sKiT4foWOd/yS88rLu2YYCV5whv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/cOEk4; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/cOEk4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so8525337a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817315; cv=none;
        d=google.com; s=arc-20260327;
        b=TFyueiu7rc11uWGKke3hUaPWp4igjLFS8tIu1ze3HI5A21s/a0HWut4qBeWnRnCg6N
         SgCtymw6G8MPRlM99BrjAEwCngl8zQZyxXUmeeXMnhT7TD8C8GIz84k/rpfHq2lOp6wa
         iBbG7WseDFFN3SO3fuZY05M9oTIjokK8yHzmTtE+yqF56V+xibKyAbern5QBr5e5MI8n
         brQsZh+pbWQqwOKlC5n+rCfmgF1FjPgk/GR0zAKWkOpwSlFZ2pgKHLWZXkZ5R3fm0Xh4
         73kqyCGHpMK5lchL4REFJiHQB6TLtFwxoFuK+1d36A14zSgrY/o5P0y7ZC3oSiT1HxWJ
         I0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        fh=Ps08BZ0qPMsj2noxdBsrb2PElXA7JB0eoqQeP55vgvc=;
        b=rMSOeJZFF+8H1VuxXkdVDM5SDnXN5EWUQkFvBeryNGDKBIlJMcwdXzyPEGR4bzjZkm
         3EJbOE/olA+NBSZNLAHxROCGITj/9Cr9T3QwYd2xZJbSCVYduSdYoHPe/ohJCNA41Ujq
         1vTx3FJ9Zc5FPwNnbsX7o3NxBLOm/wEIWleor2yoPEUZYuGx+g68pw3xDv+z8PKuk2tE
         uSQPb5F50LgBd2FMgUnzjLBkIP7eno3KY20CAastbqe260RDdayhpRWfGmPWsXRb2Gro
         utFdBdSz1bg68S3Jb08/lEJ9nY4wPuOuMdtkrQNaLyXA8uX9sJ5niVazciMTagkKMKzE
         dtKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817315; x=1783422115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=Vh/cOEk41rYPNWUDRzL9fV6pGiGys+jgYv56yyVM5YLQG+CQ6HAz8bjg+2yhOi6Z0R
         HX5dq5MjKkDCK0F0V42AmSr9XYvoGMwSY8++X6KpGHvfsB59EyMe/afP90eBPd6RVRuU
         L7n25ctS5VPtXZFXOSehyvn8hizxq6TuElNJX8Iqm3lyuU2vWeZaWZSlzFn+po0im++h
         6dXOnUDzBwgqXpKdQxQeR6rYoXT3d9Jo00Fe2t0MpjfrJ99DhicDwTRG2/Uz1zEh9e4R
         eR7AWSSH51CU2MO3xvGY9EF+7aN4NbA4bV/dCilNCPOg4BUfkwmVFQbMOtZGFMCByYKP
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817315; x=1783422115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=A7f3WW8Ih0vG/c5AMmhnPRJHMkS/AXKwJC43CE+yqr2N2csOUel4BbLZDAcX1YNM0N
         NoS4KFt6JTElYEHAVw3VBz/JTkL0NKm2DNc0jVJghmGGEsnMsYeQt3IwoPzA89hxKAxT
         s8DVBmvP8yPIdRMovQ3d4OWiDf5OH9IpenLzGF2J367LzG4lpyF4t4vorB0oB42swHMn
         RrpbT9pSgws1BdhtodWNz7BJ69JeoWm6Ts57r4GbjvcUN8GUDWBihP5HgoCDzY3R8XWJ
         U+WOJX13XKwjZJMBt7bsGKld8YOQTHllC0WprFPGs6IL0+IPOLWxWR5kpksRv8Yozh1r
         bTgg==
X-Forwarded-Encrypted: i=1; AHgh+RrglwL47HRgqVOfce5W4heq1YufzC1MXmsxkYPag3+pNuJ7a9p7+P5QQGK/Yv3yQUOd2Bry20fvPlDLJVOx@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRigFhiZ/HZqFQ5VPDgXvw1EjvhwBpvnrjNXhQBfXe87Tozdp
	BB7MvNv6pvGccuF6M4D7BJ+dTc8ic3VAJHvTmwncSGbuq0Oa5uG1iINqywS7SOuHrhja5pMPuVY
	UwbY9HHtUQmUMiBLaIfPFE97fF4MNevQ=
X-Gm-Gg: AfdE7cl2g45z6tDxhpsgDSX+8faXj5PUP90JxkU660KeBxuVYRB1HTPwcfc8rrDhVVB
	PKMl+ygZdCVTEMu+5oiZ+7T+/Wicf1hbLMyP6gCn+1mXn8XiILhq3nJQh7ayQm2+ZrTTw6WU/Gq
	6BL1LX7fBBeiFuDRKy5Bg43GzZDytYRydcBpGi9q/WZKDPXeMxcZEv+RVPRQ3FGPOg5y0WY8q3o
	z82qkP/5/KAEEq3xl52l4+1mbFXTxUv548WgCcRqAzsl+4DwlBi0XKh4RK74ZoMW3HQGKbnOooJ
	qbVEQ/8LfQP4xijnEbOG3CodZ4FMTgs=
X-Received: by 2002:a05:6402:5248:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-6988789244bmr120235a12.19.1782817314715; Tue, 30 Jun 2026
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com> <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
In-Reply-To: <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 13:01:43 +0200
X-Gm-Features: AVVi8CeRSS7JXqOJC8_jFJY-F8O-_1zMcUusRfzqJnniatTSJdpzkrHWbWs8ruQ
Message-ID: <CAOQ4uxh4-LYt8VUW5o+0mMrHpnZm3t8k4WD6x2kRqEj=_ZpLOA@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:06=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> Thank you for your reply. Regarding the two points of feedback:
>
> First, 6.1 is still in the process of being adapted.

So do not propose for 5.10 please.

>
> Second, this patch set is primarily intended to fix CVE-2026-46054, but
> it seems that for lower versions to implement SELinux checks for overlay
> mmap/mprotect checks, some dependencies are unavoidable. In such cases,
> should we add more tests to reduce the risk and integrate the changes,
> or should we simply not fix this issue? If more tests are needed, are
> there any recommended test suites?

I have concerns.
The burdn of proof is on you.

Thanks,
Amir.
