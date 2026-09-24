Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75513BBFC4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277457; cv=none; b=CHJ/c0NfDDHF+fmCvU/P/e+PSb3D8+bS3UoTUVP9P3UETcbxp7KprOQiG0ynUJgDtNZDm2DldAD72O/vIKu0Pvqx5y2V8pCKhrIr3uxkdapE7AiBtrnBuGD9LUIr/yXxXY978ZsW8SY6y/I/bnvZe/N15Oc5sjbifv8FQNABebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277457; c=relaxed/simple;
	bh=hvVhg+aYOQ3FIHCUsZmXPOdl3GO5m/J5KeUDelJbR+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLRHSjSgTvLe7XTrcBfn8s5zu5Zhh2pUjxUseDih/gvoANUkM6Gm2WEupPnjfPWoHORhPjX6mZso2cxNp98K6sqenkJB5FTycjkAa7ZpMrTzVlBW4RPKef28JMaN3DfFBK+I5nF9hY8JhBLO5+e8rNbDUk4mk8Hkrijh3UEFfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwsJr5o2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwsJr5o2"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso213095a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277455; x=1790882255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+WPKyUAs5bceQgDWCS1geYvYJl9Cc9+dR6UJDwEd9M=;
        b=FwsJr5o24U1CKqGr9nw9kLKbNnv4sxeopzqL6nPP+HFT2k6zYz1Slm7/dX+U+4+P1B
         6VBYlf2NS4jgsz3C+o8j2+mE+wXXDTw0P1oT6E+FC36V5BE/IvHi5dkIoXtSh7DxjfRS
         yk76ky6pd18Jc+nj77rJIwbjE8LBKbLCAA1dpPVneJs76JaDZrwYLPhOJH39qN5USY7s
         mbznRLVLq/nAmMWMlyhK489Ma2EP3Vz9Y8e/n+/IhF3plJDNtQlgF9QrDyWrgdJLhrSg
         BM9lag+BieybUfPCwwI55B+0n1YybSQSEbyiwtM4mxAU7UoqUKKHcy0w4Y7YSeHdf4Cz
         iWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277455; x=1790882255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+WPKyUAs5bceQgDWCS1geYvYJl9Cc9+dR6UJDwEd9M=;
        b=N70p+ROhLA2Rc1S/mlRQvoFHAiQSw673nja/QvKSQH9pJ740C9v5P81FJXYO0IDsIS
         /xkmKvU44SYK0aYKu5hNI31rmmxSqN4srKMqAYsjYAf0RsQF7dg5+xvBRw4OQYHVVx6w
         Mkkzop5WeiyGe4GfRo+ORxJsiz3Jz5fpL3J6SYCL9861O89NrGpoqM/femgNedFWaa6w
         rZLe0QPxESm7QFQVd39oH7FxfGvxBJccmc2bZx7QZYELWBqgexeckHwSfZzoUc830+9a
         SmUtHvQWP8mKXYZe8fPN6JDz8pd3HvqJ6ttfF6nZh7GwnqpM8mA8ZmdyXr7beo5fGv1D
         DyyQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0ZDvp0BQpFafaszKbmmh6y05aHWkj+/4W18A8may9g8aXwCoPApm3ZU6tMNS+6yM6QkA+INtwrs3gr+lm@vger.kernel.org
X-Gm-Message-State: AFuF++napPjm9k2wJXZjYNsn36qbah/COQS1fPslAGuG3PdX6rhWuDav
	CXvIf5xDSQdIhPBfy/sGcdrtNnLL2r88VWkDrtRfaRTy55vr/5+fyZoz
X-Gm-Gg: AYBFou2mCSJhlYiFS0AvJtgl/SxOTzkwtotKTIM+4g4i4PnK/QiAUZT+qqBnrLDB6hF
	N69e9WQcb8mjS5fjB+chgSRQI7cLwvFduzK+NokK+uV3BSdESH79hXP1Hga0q7TGeXobz0ka83k
	oQ6R77zCatecJLiDSErWsiNmju2UnCAWmRvZWaMFNveiG+YqBF9UEr3S7+M/5v6Z3wfiDVlw90x
	s6c91qUxunsZ+BTkDfYoeiSJE8gdwkKqyO1CDwYcEj3VjwsQFoHVKM8C+1evn7kcTE77pUU5BM7
	1XMUmKa1MBWQtilC4zo1mTidFKCEQMfMzsG1s7cLpVtv6cP0MK4wpyoCGt0Kfdh+mjIs5YmKgxc
	KdyYToXwAKGSgDMZD2W9mfNlV9jkxnyDHQh52UOkaVdsrvD8BarFrLjdisnLY79W+QK+GmdiRbE
	2e8B0E8xh/9KelhZddBjqIA92Jwa7gHvgImJ4feDRqAhmrasBvg9x8iZf6w4sgcs+fvTuoUJ8bn
	uD5Rj1UxoX+q8DoWoJywB8wwWtmLGT79Q==
X-Received: by 2002:a17:90b:1644:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3a098967e86mr3378016a91.45.1790277454526;
        Thu, 24 Sep 2026 12:17:34 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm96097a91.6.2026.09.24.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:17:33 -0700 (PDT)
From: ctdk <jbingham@gmail.com>
To: hch@infradead.org
Cc: brauner@kernel.org,
	djwong@kernel.org,
	jack@suse.cz,
	jbingham@gmail.com,
	jkoolstra@xs4all.nl,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] minix: unify the v1 and v2/v3 itree code paths
Date: Thu, 24 Sep 2026 12:17:33 -0700
Message-ID: <20260924191733.433874-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arJ8Mpef2gSLvKos@infradead.org>
References: <arJ8Mpef2gSLvKos@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 at 06:01:38 -0700, Christoph Hellwig wrote:
> I think this is a good idea, and should make the code more maintainable
> forward, as well as simply your iomap conversion.

It should help immensely with both of those things, I think. More than
one reviewer of the iomap conversion has been left scratching their
heads over the weird tricks both required for the iomap conversion and
simply already present in the module.
 
> A few comments:
> 
> > +	/* Set the direct block and indirect block depth now that the rest of
> > +	 * the version-specific settings have been set.
> > +	 */
> 
> Please use the normal kernel comment style:
> 
> 	/*
> 	 * Set the direct block and indirect block depth now that the rest of
> 	 * the version-specific settings have been set.
> 	 */
> 
> > +	sbi->s_direct = MINIX_DIRECT; /* Always the same. */
> 
> No need for the comment I think.

As I believe I said somewhere, I explicitly loaded this RFC patch to
explain what I was doing since I was looking for comments on it. I
erred on the side of verbosity because I was looking to undo something
that had been this way for at least 21 years, and probably much longer.
I was already planning on stripping the excess comments out, but thank
you for the reminders about style and line length. This applies to all
the comment and style comments below, to save space.

> >  	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> >  	if (INODE_VERSION(inode) == MINIX_V1)
> > -		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
> > +		stat->blocks = (BLOCK_SIZE / 512) * minix_blocks(stat->size, sb);
> >  	else
> > -		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, sb);
> > +		stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);
> 
> v1 always sets s_blocksize to BLOCK_SIZE, so this can simply become and
> unconditional:
> 
> 	stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);

Noted.
 
> > +extern int minix_get_block(struct inode *inode, sector_t block,
> > +		struct buffer_head *bh, int create);
> > +extern unsigned int minix_blocks(loff_t size, struct super_block *sb);
> 
> Please drop the extern for all function declarations that you touch.

I figured out that we no longer need to have 'extern' in the header
declarations after I submitted this patch, but thank you for the
reminder.

Somehow this reply hasn't shown up in my inbox yet, but fortunately I
was able to find it. I'll get this turned around and send out the new
and improved versio shortly.

Thanks again,

-j
