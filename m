Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103048;
	b=wubY90THGFfV3h8y2IO+aavbp9lJVmbfAj20rWUsyHi0zNokqz4+ne/g0quO2Gl2gh+W
	 R8vqmtK6nni5CeqQo8MyrSTojdMbtFBGwxFI0XrEcPM89GSr7y8i7/kA/5/OyI+c4gR58
	 RujKvybucwIoFTcXqrf5V+sYbenGIUoQnGVrRHMsFRTs+o+Pe5CvjCVIqJLdCl9aonokM
	 7TtXG7lTHjInndB0uL9tuMo69R2FkO+cKAYdi9pUBFnjGsN2yhxGmhVPP8KrdL7PhUOQm
	 idPuNQ6f3jH+rs8X0A1nKERew/0P3UvuS9d1itr032pN8UNfWgcPjl/dcDWky303E8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103048;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1VQjrw1Euxi4TbH9hbPniZhHv8s080YQR+PmEDM4C/c=;
	b=FJCpsBexPYutu2zF9MDsAxnVgn6nBcyKhHd4K/c0dhVxSvueYRMvPv9e+7zR4yQ7Tr9I
	 a0L4qmKo1qada0EmLMFsJ3AByH4PxSDguFBBMJaJeCQgROppHIMCMyxl3z+eAskkjweGS
	 mNYX27ym2fdnwiBviWhWFes6axsspo0qINvl98Qgzf3BvePUhZsP1+8F1pllLspGolnkl
	 yBJAdRczmz7VpOqL4AAnqZkTa1qW/Mw2xj9Y4mKm1f+ZpaL0BsWppAbDYy2z1B+0WOZjS
	 Bv+4tIZifWfCcufMU6g1+KFbC0qxFgOWRCyEIMvILHLiYDSgEuoNP2ZUi/W0GJUC7vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB20606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 12:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB20606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b00aa033bso577456f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 05:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103046; x=1793707846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1VQjrw1Euxi4TbH9hbPniZhHv8s080YQR+PmEDM4C/c=;
        b=lNeKSDbZoKlKxDV/MPJkaVAxsWp88gegh8qmtxupuTIA6FQ+HZ4P7m4WNAMoc1WxcH
         Enr1kBo+JThpLAmbRltNQiej1Se7syU3geE3UfPdPS0ts1YAwHbSU7HZM5oQ3EcrwkxX
         P2hbtChWAxTuTjFGD/WXnE/pFKxAV5HmUi0k5/8DLF96qFmoz5koeaQjMNwScKcWXq9X
         eyBB3EDiHHGPsx9D4VqjB4FF9Hji7aP6Al6c5HvcYC+GsuQRt2GnjKrNareOjbsEYA/f
         5sf8U68F176lK2WYO1blY/cRcxn1tm8O6u5s7Mf93BNhyTyNvei6n1L/esPbVanrZGlz
         nPUg==
X-Forwarded-Encrypted: i=1; AKwUvBx/1vMtIpoMX+PixTE7NH4J3CroFyEEfCOOuvWvOKduRDLCgZmZ/k3YduGE7hsQNpepxD0ud/OL1nw0PW5K@vger.kernel.org
X-Gm-Message-State: AFq9FYKPBD+glhlTUvTx99BCGumvOOxFTuo4Cz39WgwAJCrHfyx7GMJY
	WnFbXJGA/YX5/rstOOpMFfbw74CFIlqMZWx+8GM2XCoZDw8QrNA/3+BT
X-Gm-Gg: AYBFou3hUkfvoR/tfPIC6pRwFeHFlYehbTrHYBqMkjfNURJgp8Swx/EzpXDg0IUxIcl
	8F3DodRmDfh6uwUXCHmgrKh9jP8J4xcr5Lr5yz6xVmOMmAkWffgp8wQJ2vWXp5L8OTqeTce4Fgs
	ipWPyfdw80iT3ikNRCHFUTO1WDBGrnrjkC83mDqH4UhWRIgzxzLZKhzTuOkN+RtI7bNALquJ2zo
	lFPVsTRvj1XIySFGD1tvTyF0uExyytL2xQBGomEGK3YLVHEbU3RbLDDSNApWqrJAsCnj96n78kh
	no++5VkijZmDozTLe3G7vZucuoIJzbknMUPbZiM6Z7J9LN0iEirWZRs65tMf3AOr5mNLWsq9wAP
	HXHmATDFX+WWQBMsW087pGlUNqeI5nb/uokcTbtgRJD74nRPzO+1RKoV6HH5ASY81a1OzgFA90+
	eDxxHqhkhHEoTbvTwTxQv0K2RtCuGTFbSZC/Nmo+hdaBUEBKD00G9XNSSMi2xydk5dFBb8DjCca
	SQfwtVvTylmLSpu6/z/jE8D3LyPRo/Mqtofv99sI5EBD+rbaV4iRi3bp9JbMPxofOfOhsPyWJ+F
	WxkgJ7YhmDXan72Jyw==
X-Received: by 2002:a05:6000:2406:b0:48c:6611:82 with SMTP id ffacd0b85a97d-48e3eb2b637mr20593069f8f.1.1793103045646;
        Tue, 27 Oct 2026 05:10:45 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm22239473f8f.4.2026.10.27.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:10:42 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: jack@suse.cz
Cc: brauner@kernel.org,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	aurelien.desbrieres@gmail.com
Subject: Re: [syzbot ci] Re: buffer: warn when a buffer is attached to a second mmb
Date: Tue, 27 Oct 2026 13:10:41 +0100
Message-ID: <20261027121041.68485-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6ae064e5.768774f5.3237ab.0015.GAE@google.com>
References: <6ae064e5.768774f5.3237ab.0015.GAE@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue 27-10-26 01:46:29, syzbot ci wrote:
> and found the following issues:
> * WARNING in __ext4_handle_dirty_metadata
> * WARNING in fat_add_entries
> * WARNING in fat_alloc_new_dir
> * WARNING in fat_remove_entries

Jan, thanks for the Reviewed-by. Before the patch goes anywhere,
syzbot answers the question it left open, in two different ways.

The three fat hits are on crafted images (two of them print "Invalid
FSINFO signature" first): directories whose clusters overlap, so the
same buffer is one directory's and then another's. That is the
multiply claimed block the cmpxchg comment is about, on-disk data the
kernel does not control, and a WARN_ON there will be filed as a bug
for every new image syzbot finds. If the assertion is to stay, it
should not be a WARN on that path; a ratelimited pr_warn naming the
device would say the same thing without a splat. I can send that as
v2 if you prefer it.

The ext4 hit is different. It is the nojournal branch of
__ext4_handle_dirty_metadata(), reached from ext4_xattr_block_set() at
the "reusing; refcount now=N" point: an xattr block that mbcache
deduplicates between inodes, by design, marked dirty through the mmb
of whichever inode reuses it. That is one buffer on several inodes'
lists in turn, in ext4 without a journal, the shape the warning was
written for, and the window in mmb_sync() applies to it. I have not
reproduced it outside syzbot's repro and do not know ext4 well enough
to say what the right fix is there (mark_buffer_dirty() alone for a
block with h_refcount > 1, or a list of their own, as we did); that
one is yours to judge.

Aurelien
