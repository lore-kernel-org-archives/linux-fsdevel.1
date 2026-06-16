Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDD33F383
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572527; cv=none; b=qLKhlHDtlK0wdEcF2NJuHntnEaSyMYv64bMUk4lQape8uspdmRW2ochOc0AmjMK3BeMWMmw0C2znpPlXr3XN7G3aQJgxzcHKBR2KcxFF2c9kTkeu3x3PGoMMygJ3mqFkxh9fhm9Iir95xntB1ahDOsS1M/OvBJ+KvwbKE+tR+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572527; c=relaxed/simple;
	bh=qSWoZgNw3PpVwHOk9/H/f2RnG3uRakwqaf1M/1PGtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G75odQ7rRWpw3CyKpgJKo0X8rqrI8oQnS3Mo6RvqSW+5WrJgn3rwC7Bu2LA2Iv/aURa4cwbm0FS1edjHV6Xaeha9VDgJDyhuicAauM6zvH2lRl7mPkg0QeDxviY/eUU9/D4MgckUXCREtlE3CogWApdnmw106bKVKuoUpM4h1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY4GfdU+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY4GfdU+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so25523685e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781572524; x=1782177324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=gY4GfdU+fnf2fpkgHqn+YKSNu2S3tZpA4UYKriInFnsJ2ouxdKifTLZo+v2WRUVzVv
         l6ChYa8hy8b32sF5eihbKfCnq9ej6soPiI1VfrgCx+wpMYPIBffRw/IkkVHkATe3HfsF
         7biBiYvPB+QDdCV8fAVbNNMOmm/duLs125U/h8rlc6UfLQgKO7ZT2w/t3oj7W9TyGV8V
         vugqEIAZUEiatJwF+z+uscmYoEMGGTOvmbPQql1VT3ooCsni4RN3lUOxSjoOF1G0uWrJ
         44gD0UQ2SK5QUqE/od+j4iKtbzcAsww1GLqoTJT63nhUr97UfLH7pq8pzb8H0U3ls0bJ
         Cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572524; x=1782177324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=MjN3Y4Ls4WK9ZEWg2hkQQ56JX8pDlilyuKqr2EKETYxeBRbTDcr0h5T1vLUKYQR2dl
         IoTAIJqUHiJ8AsS9PYkziLO+RCWkPC8g9KSpxcv4IRBiHyFNKngQl+6fwa5tNKIkG1uS
         PHior5G4QkJVh7XE3IEkAJDzKlpH9dcZ6FOrlBNa4kDJoImK9gJ5zJ6KNkqfYz7SmMG2
         P75A9dDOHU8LpZVWkGMbNdOHmsNxVHtLrmz8ChYUEmeELYglXvB4+c+j/uVEnS73xrhQ
         Wh/gjDDfydPnJ2/rI2ovdof+RoUawNLj1Wb3JBozwo1jw9KMAzQqekfc+K4S/vwJCtIS
         BLjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qHnjGCsOHuenpyO+JSuBjiaAtIVm1l8UnJsww7IkgB81vCQ95gBHmS/laHoC3s4L7SAz2GkVn7bjGlZyB@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyVxzW0WV2shfU3OVUe8fXEGI6G9DFHbPJGizHCIT3M6AJif7
	4axFu6wAT+rBc3UmWWYfIL4u1MIzBiuy209WYFgVJiauc9vz94xfCYfW
X-Gm-Gg: Acq92OE/qiiPLGS9DMCyTRgVJfxm4y0vRqjJST446To16ISG2fyY1X84Vly1lhfdozf
	S1W+QeA5w4973PO/O5MBcQ2Vqk8Ee2WclDifYOasywyg/rJlaEQy+U6TJmvc21Fc5rSFabafDh+
	E+lkO1H76b9dt1MMGN18qQLdqe+E5OoZk/+HlUiqnAU6rI7cTq2iTE9VKGZmLtagemo5p9ByOBV
	eVv2xA4+/gEgtbWXl7wEt1TrpRaZ8tl8KswdCn+1w3qCe7gpy8X4VMXxyRXfcEGaDlwVhFRtYU4
	3FvHL2FjNclsZVOQCnZUuNOmhNLuQCukg5RGfPlqjQLpC3OVKW5Hp8WbupoIasE4fD3W6CWQwUa
	jN5Uj6ZezW4oYtU6bQz7Gt+CrgajLRa8mG+D5k/GZ46MKGZ51itUGuCs55DRkRzqLbcXc23T4RO
	vjdltBcvREBnFMAxkbCWg=
X-Received: by 2002:a7b:cd0b:0:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-49220143bc6mr120782165e9.30.1781572523711;
        Mon, 15 Jun 2026 18:15:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922fa47da9sm43123095e9.5.2026.06.15.18.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 18:15:21 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: joannelkoong@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 04:15:09 +0300
Message-ID: <20260616011516.4039110-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Joanne Koong <joannelkoong@gmail.com>:
> > speaking of fuse_dev_splice……_write actually, this series has broken
> > xdg-document-portal!
> >
> > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> >
> > Specifically what happens is that the EINVAL is returned due to oh.len
> > != nbytes:
> >
> > fuse_dev_do_write: oh.len 16400 != nbytes 15526
> >
> > (where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)
> >
> > After reverting the series, there is no error because oh.len
> > becomes 15526 too.
> 
> I think this is because of how libfuse handles eof / short reads. When
> it detects a short read, it fixes up the header length after the
> header was already vmspliced to the pipe because it assumes vmsplice
> mapped the header's page into the pipe by reference. It assumes that
> modifying the header length in place gets then reflected in what the
> pipe later splices out.
> 
> The logic for this happens in fuse_send_data_iov() [1]:
> a) sets out->len = headerlen (16) + len (16384) = 16400 in the
> stack-allocated fuse_out_header
> b) vmsplices the header to the pipe
> c) splices the backing file to the pipe. if this hits EOF, it'll get
> back 15510 instead of 16384
> d) detects the short read [2], fixes up the stack out->len = 16 + 15510 = 15526
> e) splices the pipe to /dev/fuse
> 
> After this patch, step b) is a straight copy which means step d)'s
> fixup doesn't modify what's in the pipe. This could be fixed up in
> libfuse to not depend on modify-after-vmsplice, but I don't think this
> helps for applications using already-released libfuse versions. I
> think this patch needs to be reverted.
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L846
> [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L956

Uh, this is very unfortunate. But I still want to remove vmsplice.
Maybe we can somehow save my patchsets? For example, let's return EINVAL
for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

-- 
Askar Safin
