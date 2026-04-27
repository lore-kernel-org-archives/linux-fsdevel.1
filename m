Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2D3DBD69
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317879; cv=none; b=p6J2e4yU4fq75IiVd2K+Zfc7a2jmthvf4tzR4n+VR2smjJpAGmbue3/58LTGuj1fOa3GiL/u3pXoSDqLSI9EzGP1bUmYP7tJGu5dpWNgwvZaFyJ/NjiXxnMzr0Obu9kZikqFWa1mg1SD3pt2try3zlnfGWTkUA14m8+WTFbdngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317879; c=relaxed/simple;
	bh=QuUokkY+4Q2XP6vae3Usa4NS9FTMDLDODZzPvq8b1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUThYLOyuOFoxQ7b8uYv2YNagIjEAYwluJeGw8JBHG1VPMsgz3AuOk5NmPsWmaXkZACfGJplKlYGb5pBGYHc6gTfWVpNhCJzBLmJimZmG7x6OwhwdHCY9FVlrtYL1e673FzfXfjqbzNjkFCMU4dEBgrSLtMzPJ6aC81TMISr3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ/ZVGxg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ/ZVGxg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so18632613a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777317869; x=1777922669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RV1aio//lRH6vrC7iKsNXbkY/M33Jc85/wH3A0aXXHE=;
        b=cQ/ZVGxgVTesu2ZOBeUfUNrfJfJHFpWUkS3Xg/XROFSvAW3wEo1WtVwPcC7ZQUxhkA
         tL0/C7RsxGK6P4GxYs4N0TK+abHQaJ9Bj1vFwQEGJLZsfSF8RJKnKkEtKWK1nSO5Im+m
         Jq/J4navtMK3APE4c36xXn5/FdTf5Wy9Y48GjC0lwjFziFmJ4P6mVzq/83W7Mv9JjGtv
         qpvtZmdmcmA30A2C3YssI/XBUS1wyqRoakEYVDcYqv2o5aFDQLBZHaxE/g+sAPw7mS2p
         xMD4EyqQsXDvXVvibtVy4JNkpzKrLAS4V7uq1eeVS/n7TSZGNig93M4d+imvnrgbqn2l
         orAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777317869; x=1777922669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV1aio//lRH6vrC7iKsNXbkY/M33Jc85/wH3A0aXXHE=;
        b=dD/WXOWRcXRxbsxD37z2MLa+SpPwVRXlZp2QXslf+I7S6YIgr7n40wxhxvNTJKOCf5
         cKsHJ7iKO3pzYsthXgel80HOnXLXt1mnCZ8xaEkEq7Z09vIzpZUqijNSFkM8Rdinj93C
         xC2Bh3ymyCoz/02J2GDdO7XHv46vnzvR0Q26mSPHU4x5pXFSz+Yz35VnYb3RNAenVLdy
         i9Ib58nQEdyJ/HlIcsO069LLJNmJIDCI0Rjt3s3RUje1VWlJ3Jr44/RkAv8+Ll1W3jb+
         M/DCi5a/a10wk2zHGtHTPW/Py5fmlayVDhOEwbZftKK0SinmLyNMXH4Oxsxe+dO2JbL6
         lHvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+F5Yp4ytcHyHddkFDY+6gheQQMfkTAe822i1HAaNoMTWiH9sgG7cYWhPsPK2hWpitqTGq5wEOxH9fMDt2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzVG9To12scx4jYuyQjJawvNat5aIy85FVAMZfXfFmukaWUuMJ1
	h/x0xE/2wRLIg47bzRFOOWZYFEte0XGUROwRJU4Y8aQRu+zNjJ1bTp7S
X-Gm-Gg: AeBDieuWLKpeWbv+Ze5rzVi55VPkRjotE8H441GgZ45lVdLGaLDdJc5AE+yFj3UDQve
	zq/OIiZ58cC+96RfyIC5EAZidgFJqX4cr9im1ruDSnJ1dmMGPE/Pkxk1n1qKsMOAxnLSFWITSev
	sN+1Jx/SFtoV50fsncMoKG+jS4td6WXN7yNZKIMGqSV/Xcubua0Iw5cRyYcnVHGReaPV6V9q3yG
	XCuKJfxcPEG4O7DWeMGkh99N9o30Y/6LVJzluXGFEtqltZ4Cix6rCP3LK99CnrN9aAl9oe+EliN
	JuHDYDm2RWkF4BqC9CCI6f7CS0z0MZ/ATfoC0F6HC/C2g2MICYQ//ABOmyO2gvMQYNBssk/Zyb8
	HUe7RXJan7mch53oKM3/2pXHpmigmMBZEetnDQnxnxt3a3LF0fbfQBbVn4PQ4eU4oEy76p9oB4T
	hNRzHuif+glniuJXLtFFvRtgmepWGQjKJ2RVa+RwY516iFpRugIwh8h8tPBziqLuwM+NEWgK9iN
	c4ieIfA0T90JfjUHxyYvqwTnFBRlwhi/VlsL2A=
X-Received: by 2002:a05:6402:8cf:b0:66a:8002:fe17 with SMTP id 4fb4d7f45d1cf-679b670fc2emr230141a12.13.1777317868371;
        Mon, 27 Apr 2026 12:24:28 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-b693-672b-1361-8711.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:b693:672b:1361:8711])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b68523f3sm69374a12.20.2026.04.27.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:24:27 -0700 (PDT)
Date: Mon, 27 Apr 2026 21:24:26 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Matan Cohen <matan@matanco.space>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH] fuse: expose backing files in the daemon's fd table
Message-ID: <ae-36oamXRxbGbbj@amir-ThinkPad-T480>
References: <20260424144553.6241-1-matan@matanco.space>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424144553.6241-1-matan@matanco.space>

[removing irrelevant lists]

Hi Matan!

On Fri, Apr 24, 2026 at 02:45:53PM +0000, Matan Cohen wrote:
> FUSE passthrough backing files are currently not installed in the
> daemon's fd table, making them invisible to lsof(8) and /proc/<pid>/fd.
> This complicates debugging and is the reason passthrough currently
> requires CAP_SYS_ADMIN.
> 
> Install each backing file into the daemon's fd table on BACKING_OPEN
> and close it on BACKING_CLOSE.  Add an fd field to struct fuse_backing
> to carry the installed fd number.
> 
> BACKING_CLOSE always runs in the daemon's ioctl context, so close_fd()
> targets the correct fd table directly.
> 
> To handle fds that remain open at connection teardown (e.g. on umount
> or connection abort without an explicit BACKING_CLOSE), store a
> reference to the daemon's task_struct in fc->daemon_task on the first
> BACKING_OPEN.  During teardown, fuse_backing_files_free() schedules a
> task_work callback on the daemon task that calls close_fd() from the
> daemon's own context.  If the daemon has already exited (task_work_add
> returns -ESRCH), its fd table was already cleaned up on exit.
> 

I am sorry but both the approach and the implementation are wrong for
several different reasons, so I will not start to list them.

Please follow this discussion:
https://lore.kernel.org/linux-fsdevel/CAJfpegvaCTxS_wC6EGFfh3Gim5DEgOtuju=_=qCsouzkCRvJog@mail.gmail.com/

It does not end with a definite decision on the best way to export
backing files to lsof, but it does pave the general direction the
the solution should take.

> This is a prerequisite for relaxing the CAP_SYS_ADMIN requirement on
> FUSE passthrough; a follow-up patch will drop the capability check now
> that backing fds are accountable via /proc/<pid>/fd.

This is one prerequisite, not all of them.
See "Resource Accounting and Visibility" section in
Documentation/filesystems/fuse/fuse-passthrough.rst

Please CC me and the new fuse-devel list on future attempts to address
this issue.  There is no need to CC LKML and selftest maintainers.

Thanks,
Amir.

