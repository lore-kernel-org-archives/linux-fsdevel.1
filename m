Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738523D2A1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309727; cv=pass; b=pV9Ad39ZkxjXYZqnwnB4iuQXUdZ7o4fxOv46bEddShd4T1q+YyEQgd/arINIQwRHrjWBXBF1NRjRPy9Ynysry+9h1Aya8L7pg+VSCDxjskbPNoJvdo0cd4MxHBMfawapSDVUzahC/sdkX8qCDUligagL4spIjShnrjQlvWi2wO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309727; c=relaxed/simple;
	bh=eFqcaGB/cErX84H78RZaw/LyxqfPSspGf9M6iQ2GHpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpWQKkZue6apyYrLYQuGiMClmyB93ARFOT62Y6LEpc0qZzwTxOtAT4ryQ04j1iBJS7geNCLpuwEfX1McuMEQx6qWd0EpP9hadnl9DOxHjlqY5mU0mkaRkLV4pK4amBh+AKLNWKV1G12dsaFQPUcgbwWDFqp/DRzKjLLdJpBEq0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b=D6uw6VQ8; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b="D6uw6VQ8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84864086bfeso435897b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 17:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788309725; cv=none;
        d=google.com; s=arc-20260327;
        b=lex+1/j+e3uhvOPJckCm69yGmbKNg7YpQsFPDFYdGi1gDIxxWkOxdJhEa5higIKqwY
         bZ5YWopKmAtQRSVL0GgRrlJLNszrTzP1WTSYYn3MJiRe4mNe0G5kSynuCoMnuxYuM+IR
         wpz+Xc81yuK+0ileIb8vIIKjsbQYml8i/EOtKzpj2ukmidvVYExs6dsv5o5cTor8gppE
         M0i8Qwy2hKisO7FUbBu2yjIwAnaYJVqcjyw81xRkHXUHyW6E2bWQLxjnOQeg0iNYBTzu
         jQo1BQt2s5VUKDJS8rhWEsSatEJr2dkv76wbpVoItaGY1Ff5BbHjwwQlZe2yP/e0jctQ
         bmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gFUJHQZD1+cpYALjaZMVpkoL1HXZLD9SkBo8CagnxPc=;
        fh=NtxiXLr6KGX2rp7TRJP2h8tRp8nbQzQtj/WgtB+TYEs=;
        b=n2apWNybJ0MySH5acWZF0NGmrv3DaJWSE8SVFMFRBulBnUw+wMitmfmk5pcX8R7fnx
         czl3GMmkSCGII1o2TbLH8mukZNWePhSwDxbs3f5tMjnsrPLgJHN6PpOQNBH9bWBPNMD/
         m3e0auKK0lLOVQQe+K2gjHkjcodp/1FLq6QWdjKxD1xjFj/iRFukHI8WcxWGgafONTv7
         kQ6QgYi/8BAhA96hbL14pYZgXstvoBhjMbRfMSZU124c9bGiz8DoMI13V9cbGx4q+b/H
         6n9/CHWaZWLHCCdbwqOwpKyJOjJV78CrKQHBMlRLQjKWrQsQpGkM+0a4CGUA1+DCeJNx
         tprQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond.com; s=google; t=1788309725; x=1788914525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gFUJHQZD1+cpYALjaZMVpkoL1HXZLD9SkBo8CagnxPc=;
        b=D6uw6VQ8HWR9MjR07k0XwM/Vm8YvPkNOwhiHVssyXlWToB6tnEbx/mjhJXp4ueYvKF
         +liOYWHvUZuo8e2q0RGbQpUEJkhBY0ZjdD/DWIH5IGhyfibcEyo4nNdjX+mbzVvVAgWf
         EVFa8S70TsVU86UjAuP1QUcgxZwfxjyfD/bz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309725; x=1788914525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFUJHQZD1+cpYALjaZMVpkoL1HXZLD9SkBo8CagnxPc=;
        b=n1JZ+fyc1K+VcWN9fSfhr2Ewn+TNf68XBfz50vT2buDR7jVPlBPMfXSRtKqXOxx9BR
         9SM/dxdIAJNe1DIDdmiKqV2U1QCVheBZ8V/dx3/rWrm1vPMc3PZB5hHc42vq67zeGUok
         0lVMmndNH5k4h1OEaOfM7+IeBtrlgOZTA/rOqkq0bT4we8eSj9R7eHRwdbpdUSjIHYsQ
         b5efu3xjJZjN8yhSaC4qBsmkbRrBn/9u7P20qGC3MSmr2Il8lV1A2X/YOKnInZfhAT03
         rZdap/Bffx5TlvLMUQTFn2TaqkDaEvIV+p2J29mVL0hMIdJwyt4fIjx6ptY1d/Oxf7RD
         MO7w==
X-Forwarded-Encrypted: i=1; AKwUvBxk9SKdXHFh3vWYXMegUyzSz6AfAquWJPRPfvPHS/yUx42DfHFRW9N2rGsrkmhDzZqT4yqUH3p7axt6PePL@vger.kernel.org
X-Gm-Message-State: AFuF++nS5oql7UrbU2F+V/QbXumgqP3fyHUjL4gT5a2fBaS2SK20y3QX
	O/E91JVy1mQGdor3xiHaT58NP/2W2IgPGn/lPgt163y1UZ/tP6BZhZz9aESDPgJqbn+t5TQHEuh
	INLA8OE/AyMxI5tMCipASoVHISQQZCH8pUM3SLOwB
X-Gm-Gg: AYBFou3QNb+uqQwacqXAXuAUxfC0VOvFNyqLBZCQk6XaofNgFWOikSYdA8FyXsIZ+yT
	UQxO5TYmA2CgP16TUchzzzfRLJZG9aRZbEQIVdMDlC+bQfVm6NvPuYryoaHJP+4kUfVzGcBTTR+
	Rn+tVIfuzCnFFCVRAoO2U1lNcWn9LPnTVNp7wV+RSD3bOnJIc9X89Ci5hfwOQPgVNLfBcwUfBP7
	bIUAsDEESPKHCrPCl6FD5tFRhe0NCkgy9H4V1NAPXl9COXT17CkE40+u5cEorBfnxjTQKhkqkJ/
	ua/ZnA+X3xnL8O053jKOlt8v6OSso2ub/E4j7cNWev7UKc+Xg8ycrQa1
X-Received: by 2002:a05:6a00:1307:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-85ed1d08ca3mr1936483b3a.4.1788309725553; Tue, 01 Sep 2026
 17:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovChOY+cRnRkfRWr5X9gcdXsz_L6BkBpXvL6=zdFBWFfUwg@mail.gmail.com>
In-Reply-To: <CA+0ovChOY+cRnRkfRWr5X9gcdXsz_L6BkBpXvL6=zdFBWFfUwg@mail.gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 1 Sep 2026 20:41:54 -0400
X-Gm-Features: AcwNN1UeaIRdMgnISX1x_ZyNeAp7_vNJ7FJwGcw8daOY9wP4Rylu1WZVoBn70ag
Message-ID: <CAOg9mSRYepY_OrnEsdLjz-68ofScdCeqYt5k5a77dUH_uBisLQ@mail.gmail.com>
Subject: Re: [BUG] general protection fault in orangefs_writepages
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, falemi@asu.edu, 
	devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the oops report. I have a potential patch. Please
send your reproducer program.

-Mike

On Fri, Aug 28, 2026 at 2:11=E2=80=AFAM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> Hello,
>
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/176-genera=
l-protection-fault-in-orangefs-writepages/
>
>   Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:orangefs_writepages_callback fs/orangefs/inode.c:144 [inline]
>   RIP: 0010:orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
>   Call Trace:
>    orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
>    do_writepages+0x328/0x550 mm/page-writeback.c:2571
>    filemap_write_and_wait_range+0x332/0x3f0 mm/filemap.c:685
>    orangefs_flush+0x44/0x60 fs/orangefs/file.c:566
>    filp_flush+0xbd/0x190 fs/open.c:1467
>    filp_close+0x1d/0x40 fs/open.c:1480
>    close_files fs/file.c:494 [inline]
>    put_files_struct+0x1b6/0x340 fs/file.c:509
>    do_exit+0x6a8/0x2360 kernel/exit.c:971
>
> Our reproducer.c is available upon request.
>
> Happy to test a patch if that would help.
>
> Regards,
>
