Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002D37BE6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594316; cv=none; b=CWyNuL5a5yTvsaGwwvYFVCsxP2ys9bUnioNx6a9Kuw27F1sz8d6uWjl5ONpl0b4QpPWx0VyQBVuEv/mHerKNrvGSU3rb0FLhroOv1VZccC9c/d+wHZ3+DeFUjoVWJw0Owf1dlHoYoAKWpILN83b8zuLyUfjgIBaKTvnc3fUk5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594316; c=relaxed/simple;
	bh=Gnzg7LxLmW/AaeD3Pv1ryB6Tex49wbpWBcRevOIJ/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8sSDrmqDXkJBG7IRG1d5pS+nC+/kUhg8NvJgdFKuzMYtmwrpwiExQ+LlviPZuLNvNbPuzNQLR6Ype6KCZpt3BPvMLrOzGQL3dRc/u/WsvlUz8m+G39CI2qPShLbj5JCd8oSvv9CinDvmUKAfNZbCoyBbllsdDxjOB1KprZPDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVMbCfDl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVMbCfDl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so338038a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786594314; x=1787199114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gnzg7LxLmW/AaeD3Pv1ryB6Tex49wbpWBcRevOIJ/7s=;
        b=sVMbCfDlTfIv4/xVpIItYsFiNHw9hjA8pH5oWjb2SVG7QOhoY//S7FxxUdNlsngf7h
         rB/7Voc650rDZACEqxOozA+FecWj63KbnyIcxgFqYsWICZlpAVDfq5sQdsBpuBrhQb2S
         4pXvE47jxM+z/hnBhkw37LpTFNEdiydf8D8ud07xzbBL34AEkvJ7i3VTgWUulws9gvwy
         lRkmfWfo2gZefxcDRoL6yR76/pVjgmTjPw4/3LC/tSPtf3YMTDnZP/wihMDtsrYL9tSc
         8Lje0WR8kXCSeZjk/+YK9r9Iv+ENPWKz7SKiJ/w2nK8nB//Q1fjvM5JemGrysvF9gsAB
         4Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786594314; x=1787199114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gnzg7LxLmW/AaeD3Pv1ryB6Tex49wbpWBcRevOIJ/7s=;
        b=mFYJfyeA+2CJwsy0W5Jnlnna0MagjL+7XA5xJa/rzWGd3nRYmIzHdWxFuYc1yZZsuX
         +JyOgVItgUAMH0GR+cn9CXktBQWlePTw7Z2O+0rHUMD/smSVYyPnTpActI/9H4f0iDGW
         ePLSgHyDMJrAs2bFGOKmhLVhBQtflH3QAcCyZ3RYq8ssbmiBVjE5+CtEme2+3cmCKpiB
         u7IOMjJ2c/f/RIpdpoA6PRUI8eikIY7H+yn+4vPFEanzZoNfa+Om6zeUzcXyHCimj3M8
         Y5fFtMvgMjKDEAC8qU/hGZooAM2N7rxdDQH4n/JWjd3Pxn0tr2MnXHb5TgN/ApClVCdA
         2RCg==
X-Forwarded-Encrypted: i=1; AHgh+RpSkCQhbr46teM6DmwOv2DOa344JnJRhiYbOmh6okpR9FoF+614eGEloLqbA1Pt1XXL55Ag4Bqa1OktiAF3@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGA212gzor/oYhmospokxvnewk8reCPliW4KZfLv/2R6QVxRj
	qQuAsbeRL03Yq8ba8KPTZ+Ky3j/aXkykcE7QcFgoAh5TGJnffwQ+WIKW
X-Gm-Gg: AR+sD13UIrgAZU25JDeCSGeafm3p0UsG/cV66bnlS3XwIKi3AF2WUavfRwwaWTw2T3N
	e5K9xBgLPzPZ7AQ/5RZ/4RiJTHmECk74lKO0bZZF3eMktEqwZkvsXt/iYLyNpfhtdzm1GcPQlLQ
	s/HlmHTOKIASlglv+NJrJsX6JnL3BkjJ01vyKH64/nd0xwcCAkJ07yj4YslWJH3p5urk3Xt1ngX
	Elt2OIQ6CU/NDEY3BnQEbgwhKajJRsSFYE2jBN+pBtPyKsgZ07neWbFntgGC3yS77F5/qLZlDuz
	fEn//D07LG7HX4zLlnQXaJXpLIbnA+QB87WhIvkNaIr3HFLOoUvfFKFoa7xKCRJ7lQVxAjxBn6v
	98bqV7pkYfehb6bAkKp0BlTBynuaXvJl8NfYtfZ+BSPwLBDakAuOQ10BgR23/UphSJ9497P5pqF
	nd5IvknpCqu8SI8JfhAtERxDoiQqDz5Xvor5o7XyGskrsSr7E/bIUB0cMz6ks6CqtsKCi5jUZ0Y
	BD7za9+f4ps1HXuItnFc4OGgBIqAajOM+ZIAaph0CnDJnS+agI5ligpDSppRJ5mUt83+XvzTWaO
	3LAAEG5u8e7xagYtALH73a/sMDRb/zFU4yUEKgycS669OVYMyJxS
X-Received: by 2002:a17:90b:3846:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3931e2a32bbmr3024404a91.15.1786594313939;
        Wed, 12 Aug 2026 21:11:53 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f478658sm1127538a91.17.2026.08.12.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:11:53 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: syzbot+b3fba2e269970207b61d@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	cem@kernel.org,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net,
	kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [kernfs?] [ext4?] INFO: task hung in sb_start_write (2)
Date: Thu, 13 Aug 2026 12:11:48 +0800
Message-ID: <20260813041148.2302176-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a75a39e.01d0871a.3a0d52.0042.GAE@google.com>
References: <6a75a39e.01d0871a.3a0d52.0042.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C reproducer neither demonstrates a kernel bug nor matches the
crashes already collected in this bucket:
https://syzkaller.appspot.com/bug?extid=b3fba2e269970207b61d

It lowers hung_task_timeout_secs to 15, issues ioctl(FIFREEZE) on the
root filesystem, then forks a child that opens an O_TMPFILE there.
The child blocks in sb_start_write, as any write must while the
filesystem is frozen. The reproducer sleeps for 60 seconds before
thawing, so the hung-task report fires only because it shortened the
timeout below its own sleep. The default 120s timeout would not
trigger. Any CAP_SYS_ADMIN process can produce this report on any
kernel: this is fsfreeze working as designed. Whether a task waiting
for thaw should be exempt from hung-task reporting is a separate,
older question.

The pre-existing crashes differ. In the 2025-08-01, 2025-08-23 and
2026-08-02 instances, the blocked task waits on the sb_writers of a
filesystem the fuzzer mounted from an image: lockdep classes
sb_writers#31, sb_writers#13 and sb_writers#20 respectively. In the
same reports, the root filesystem's writers class appears separately
with a low number (sb_writers#5 held by udevd and others). The
reproducer instead reports sb_writers#4, the root filesystem that it
froze itself.

The captured console logs for the three organic crashes contain no
FIFREEZE call. One contains a single stray FITHAW, so a freeze before
the captured log window cannot be excluded, but that must be
established before treating this reproducer as the explanation. If a
fuzzer-issued FIFREEZE on a mounted image caused the hangs, the fix
is for syzkaller to sanitise FIFREEZE, and the bug is still not in the
kernel. Otherwise, something wedged those superblocks' writer gates
with no fsfreeze in sight, which is a real bug that closing this
report on the strength of the reproducer would bury. The mix of image
filesystems mounted by those runs also explains why the subsystem
guesses span kernfs, ext4, jfs, xfs and bcachefs.

I therefore suggest treating this reproducer as matching the
signature, not the cause. A previous generic-signature hung-task
bucket, "task hung in do_rmdir"
(https://syzkaller.appspot.com/bug?extid=e68dbebd9617a9250e8d),
contained a real ext4 livelock. It was fixed by commit 54b6bd40898d
("ext4: stop retrying saturated xattr cache entries") in the ext4
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=54b6bd40898d

Such buckets can hide real bugs behind an uninformative victim stack;
the per-instance reports contain the distinguishing evidence.
