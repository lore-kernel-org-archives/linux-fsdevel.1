Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFD4DC528
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527690; cv=none; b=TM7wQfT+qkRedPlJQpgyXt+BuERNIhZMr+t+THMVc4m9PYzSyvLG6FyQQJUHH6zmj6JDKkBzhQV9slPlow8dq20dq7lDoTYkkdlG3clq9jhhmal/TMWaR3tRUTMAdwWc7u8P+q5RBz08LywWTdHyY4pZ+k8UR1JIHYMNjRKRRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527690; c=relaxed/simple;
	bh=kjRfpHBz6N1AcpGrp9EdxI0+Sil4adZV+IHhFHCAUwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/NpGfzuPzulJ2XYeez9NkN4BVCg4yfxGrCArobewY5DPw6mWFsBUsviTO537H9H6vgAESzwIhQTqiV6+B88YFzzAdjYjJIkB7mdHsIN9/AQbDy7Dbs6rO5PbPBKrd6wXukqqGT1UDXls+aCpL5oJ+XptzhuVdARAzT/GqDPZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSo1igrI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSo1igrI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso773645e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780527687; x=1781132487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1JUsgVJ7d9U2h7quy8Vg4SoAkC431+Nv0NzGMCDYE0=;
        b=gSo1igrI1wL5kJ6UndiT5O9wUnbR1ViIc5P0v+f/a9cvwzfdZslrpvEaunbWa67vIe
         31TaaKNtbR+VHWyYehfJqdyRei6AVCW6mqotiAtD2VVx7+q/JglzSRcMdF/851mR8Q7n
         RNov+1+1zmXH5Csbf5l04SQ4cD+quEhLfsYisaAIg3ABL6f8tB/yGzgW+b8/mkebpG6G
         b1D/6AytXXY2hZX48piRkZoX2hmOfWlu095Yk7C8kKj1U20o2xzi9U5otCA7VKv0sMtH
         Y3clBaKa707v8cLN95oQbwUdTCGQea0rw3AraP1GVr0WTrlwgFoGb5TJHEyu0C3YyuCh
         KbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527687; x=1781132487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1JUsgVJ7d9U2h7quy8Vg4SoAkC431+Nv0NzGMCDYE0=;
        b=AoxDSon3jhKK/Sm9OOH4JaFl1K+MEEFaX6mjD1gHVHEhDA+jn3mXIh4hHWldLh+/hI
         L/i2gqqLQVMcAvXtLj6KJqcpdqcFAtmCnUppGOy2hZRBWfd9gSQ1zQIjub4HRl49Hq0X
         zu9FhicBk+ibTUi2dOFrjcdtgjGa51dA/ftFINCRba9rVecBQTmH7NdFI3MEBklBQq0l
         oLXH73VDmbCKH11GUOGvPRdhq5v8NWAOVcnXjpQ9mFrdgCaTYPi/LEr5nb1BOx644IJ1
         lrkER+1W2NM594DsB/r4/KXo8Zd3JTS+Ly6fPqxcmcwRW3k3PRl7qMCtjAxxHeACKlaT
         oEAA==
X-Forwarded-Encrypted: i=1; AFNElJ/AkE31ASCGcfJSRMws3+dtBGOHkhdgg0NDdXiUO6HuCHRy3dvpGQO+/IOQH20iNEGewUz8pI0XKWUXXy+4@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCNT0LcUrfUuGiKibh9FzcZA4JgYeV65tLNvCzcHAgx/fe//3
	3r1AH7+2VsW6x2ncCLrdqBAkj5dxc/o0Cp8/GHZuCL4W06GvmXjK4uEq
X-Gm-Gg: Acq92OHIeD4Ret35PWVFjIWqf+0+8HfT4ZHbyVzm1VeUMBcWxXvBkwENJVJCfeb6qV2
	NI6nchb+y8zzwTwadwWqqBTvjbbwbd5xnIN+HrYfH3AXM9AJVHDAG5njTC2M4/tYUMVtYC1qdHs
	E5t9t82Ll/JYtNvrg0mVujb6nY77dEa5HAKOlfYNT5zj6T5fHoW7x6HzClBSJtVlpxfDycTW32/
	sI2KdPaYZ3lHN22/cCQmuBBuO/E+uX1FUkvFByJVT1w+IdvpkEOXzKvB25e1xogk8AQXH9ro/Eg
	TwXMDCxUoWc5MW0DD9aXmf7Grk7fvL0JhPGNzdWP+jNLNqK2K8v8AE7QSo663PZN7IHXiJ9l11L
	XUYX0qAv485s3QkqWdxKOQWwhAgzFUuyC4X7862p/LDKTUwUg4CkgMdNntvY8j+JkySGp4SBmGl
	qL4KygeLwYKjKqNYL5ivWOpDgkXXccow==
X-Received: by 2002:a05:600c:4043:b0:490:b2a6:8c2a with SMTP id 5b1f17b1804b1-490b5e748e3mr51931455e9.5.1780527687138;
        Wed, 03 Jun 2026 16:01:27 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7e6c6a4sm45890145e9.2.2026.06.03.16.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 16:01:26 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luto@amacapital.net
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
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
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 02:00:25 +0300
Message-ID: <20260603230122.851517-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
References: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andy Lutomirski <luto@amacapital.net>:
> On Wed, Jun 3, 2026 at 3:43 PM Askar Safin <safinaskar@gmail.com> wrote:
> > Finally, we can degrade tee(2) to copy, and hopefully this will
> > allow us to always be sure that pipe buffers are not shared with anything.
> > This is possible future direction.
> 
> I'm a bit nervous that, if I've read the code correctly (a big if),
> then iscsi and nvme will still send *shared* buffers via
> MSG_SPLICE_PAGES, but that normal user code will not be able to do
> this, and that something will bitrot.

As well as I understand you correctly, you mean that if we remove
tee(2), then there still will be subsystems, which will be able to
send shared pages.

Yes, I totally agree.

So, if we remove tee(2), then we will probably need to remove all
non-standard implementations of pipe_buf_operations.

-- 
Askar Safin
