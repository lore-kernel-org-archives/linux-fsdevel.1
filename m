Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F324A5EC1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144915; cv=none; b=nSqyYtypRxkLQ7qsTaHoPsVM2cqUraf9yjG0oHlE7Vhn28B7m8Pa3R6rs2gdfLCYvhFzBgbA1rfKqUy4QaxQ3Bh0tRJN3H7uDRY7CJOREp8/oGtIE5dIgb6CkXqNS26+zHb+aaf2jPNsQhgA5vwQB2gF9qPmnBTC6lIs9CCcSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144915; c=relaxed/simple;
	bh=iOeKZl+2yYu5n26PAKQjFv7EqGjGpA9xCYCNrpFSoUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XXPXEHb1MTQQK3EuQtnBqhm/OzCotnrFallm1hoAIaXu2KHJ35vXHpG6QlMvpt8U+OHLjEKIgf5bgZS6x6K5znzERnYBVZp9OibSb3W0lE0XGxVf32Qqo+JLq21qv2ttOolYxeXSM2wQiffpdBM6Ud9/r5w1H97NPKph/iJUgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UJsGGxZ3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UJsGGxZ3"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f5934ba2a5so650375a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789144903; x=1789749703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EzuL2B1Q778W6cbggFtdaW2ynfw2sIwJibVyXt7Oz3E=;
        b=UJsGGxZ3wuw31Ouo2AGAEnQWUkP2HP3H49T5x1zYb/JIxtkq2UklaLU5wnt2IwFjzS
         lmZhF1ZRN5G9I5ETzOKpyDPS1aOItyiwoZNTbXUHjHKQ8UByHX6ov3zZSaDERwOFmVQN
         qq9XniE3kmugXXxRmOiwWWib3ll9APvruZEHQj89cyn1mk36HXXHDJW3dc307c2wFFaH
         whbJHzFa1f1cY/bqPz7v8ETLMe+nmASD12/Cqop0JO2XMRh0Wok4iF/5gtfb6inlse1r
         X2dXHoYJcE1m84BH6ER6a2KGQT5B50tCBleLTV9F/9V/I7xqIlCxv2H3d/tBxnuSH+B9
         cWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144903; x=1789749703;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzuL2B1Q778W6cbggFtdaW2ynfw2sIwJibVyXt7Oz3E=;
        b=HveRxCiTdMnKq1bhyAW7UnnzvFg3eIMiyoGjNZGug79PeKxblOakgAi1asbroOgcOO
         FjFRfVhD54lgopVlRrcJyo3lqmiM7mM+Ln06V+flQGWz0ufKWjhWpFTnDubr+r60WtwY
         MQFvkSODE05AKL6TiClzZjbG3XzXEYhcp7wkS+wfKqEWP4uGnIzDBI4RIJ5dBkSW/+XH
         8iUXtWiOWhkTOxJMF40g7gqEO62NiY4eR+0ec8F2DZ2sXwjrSzBZyXocQLu7ZC/UXJJP
         47bSi3tMM9DqKPpPDQy2z4Sx+O5b6UocKQkgFXc3MOkQqKz6lNDVh1QUYDceHxZrJe9r
         o4tg==
X-Forwarded-Encrypted: i=1; AKwUvByRXmMDiAD26FIuASgwIgrudrtlpaTlbTH/QiJcS5pt6Ww62C8Vz06DIzyN8IcOnsLoByoKhBstKdrQXv6p@vger.kernel.org
X-Gm-Message-State: AFuF++khYTi7XnIPzt/vtsxTeyjMrBJ0LzG+pa/HETFSKccl+H2GxDY+
	4tSdPg5owievAdBfi9fkewu9Qqt4lUy/9WRoVdvH7SPjPi9ppRWSMZE3KYOg0HC42to=
X-Gm-Gg: AYBFou1nLTbzBODNjebfGl/8fhCsQTwoxowiAfDOe4b7/Fi06afifzOdwlXSkMYdNb2
	EHAXE8cXRa1bIQ/jk6XopQ1XY17grhE7x7Gx2fl9Xt9e6x5B/F+5uFEfzZhpHornOIgNvkPQvY7
	XPm3uj5waQveEDtVh4wwDaiFTllyR/jsfD2rriE6V0GondYRp06EsrbvqNbd0/Wl88rMCwvwNQ0
	mIyU/RqQXKtJBW2Hh5peVWKEOcolEteZExFZVbwvRvzTCqGX7LvgRusuEL7AS4iYf/9cyF3TII2
	GYGCZJo21M4EfU0vatsu36my/F09DN3EvHPdm57boPNduU0J6wWmGg5j1nwJ5pZAJ9AwmPsq35S
	PBvg3sbmmjhwgr2aMseCdP0XiQ0jnpAHHGb9pA+Y0xNLAyVNA8PjYVSzzS+dJo8i3dc61GJ93CG
	eRyTNRaqkjeve273EtHty8QajkzZlSv1aJT+wC0KEuqCGNFMuCdgH9vvd8zt0g/PPssLSYSkZAx
	KNIK0CLZzL3F3oyY8XYRAeeI/wlzcXNxWefWe7exDYs90DffKo=
X-Received: by 2002:a05:6830:4390:b0:800:bca4:5626 with SMTP id 46e09a7af769-803ff447ademr4057338a34.19.1789144903340;
        Fri, 11 Sep 2026 09:41:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80477ea9138sm1764401a34.1.2026.09.11.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:41:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 Christoph Hellwig <hch@lst.de>
Cc: Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, 
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260909060924.1102037-2-hch@lst.de>
References: <20260909060924.1102037-2-hch@lst.de>
Subject: Re: [PATCH 01/16] block: split bio_iov_iter_bounce_write
Message-Id: <178914490220.653901.14299562273015668594.b4-ty@b4>
Date: Fri, 11 Sep 2026 10:41:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 09 Sep 2026 09:08:50 +0300, Christoph Hellwig wrote:
> Factor out a bio_alloc_bounce_folios helper that we'll use for a
> different take on read-side bounce buffering soon.
> 
> For that make it and also bio_free_folios available to callers outside of
> bio.c.
> 
> 
> [...]

Applied, thanks!

[01/16] block: split bio_iov_iter_bounce_write
        commit: 44c209f294b88bfa55fc5fcb9753ed925ceeab6b
[02/16] block: export fs_bio_integrity_{alloc,free}
        commit: 7848da3b1ec374620318bba49328093c99e846d4
[03/16] block: add a bio_prepare_reissue helper
        commit: 584e6e36b6d0b95af00e0ee38bab43607152c981
[04/16] iomap: respect maximum I/O size in iomap_dio_bio_iter_one
        commit: 1112619902b89849da2d05a1125c3bc029d8f576
[05/16] iomap: add a iomap_ioend_flags helper
        commit: d3ff80dc0c51e0a13cf8bf5c06656175377147fd
[06/16] iomap: add a IOMAP_IOEND_INTEGRITY flag
        commit: d06c1744acb73ea1a4c21873208b971928ae5a97
[07/16] iomap,xfs: move T10 PI handling for direct I/O into ->submit_io
        commit: 946df943d1ccc826e4e66cd12a5fb13abcd99e59
[08/16] xfs: move PI generation into xfs_submit_zoned_bio
        commit: d0573f6a723f3484627c046d7dad81bf48d8fd3d
[09/16] block,iomap: fix protection information verification with initial bvec offset
        commit: 71987f0e9eb53492de97e7ca0037e04e2f818620
[10/16] iomap: better read bounce buffering support
        commit: 7daf4cc7161e92765a6a8b21f7b2abe83b414b16
[11/16] xfs: use BIO_COMPLETE_IN_TASK for bounce buffered read I/Os
        commit: 4427c12e8ae5c5cb6ced698d993cf75cb3b52040
[12/16] iomap,xfs: move integrity verification to the file system
        commit: 8a70309165a78ac12c0d3fd8e9da334b0b4d8d6a
[13/16] xfs: add support for lazy direct read bounce buffering
        commit: e5c3fdd8a0af34c1ff75808bb60fdcbefd37639d
[14/16] xfs: add error injection for lazy bounce buffering
        commit: 715f6122e78bac6a502af6f694dd4a20b4b064ae
[15/16] xfs: log a message at mount time when using integrity protection
        commit: 30f76ca12478237ad6c585f9d5996f57f44e3e29
[16/16] block,iomap: remove the old read side bounce buffering support
        commit: f6c63fe642795117124d6ea7eca39ba8823e30f9

Best regards,
-- 
Jens Axboe



