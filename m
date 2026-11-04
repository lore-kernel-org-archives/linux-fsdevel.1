Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812944;
	b=Gv94NIBKrceV8gps3j+2JX4wEr4xbTdbcHseLnxd2tpVYdNuParCSnt9rnpIfMgtsLs9
	 4ELKpdzdNWjiqnu4Ig4ZEtOioLpYDXVU+3dTVJUxd5a59gYjZFqg+7VKLx8ll3YZzuoaO
	 OijI3V1hhk5iJnlPuY98Jqdq7gUQlhgFz3LqoZGRua8U3BITuC8bjpEcyTZU78IhRCIV5
	 n3HZTSqc4w0oNmAuZCtMnkKPI5yOYFOS/pzV0UeqUXjel8goq0xSDl5eovmuMQEoyDerD
	 e5OTJdCZYE23/JFWE7j6WqscOIkxSLbXulKYjiHeJi83ty1iK3f5fX9RvIWpeq5nO+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=trCudkRlowf15KXENTfDgxDj2b+EYhikc7lQRV8B0y8=;
	b=iHLPGVa81hEJm4HOBfEjdd5tAlpcyaCBUaYHLV2C/UApMG5JzjIFA6FLBdmg9Qw86lAj
	 dgtQ67gINvo3MCKF6Yp5WBRCWc425MUePr6+2OPqGrcXhyGZ625IuqkLdMN2M4nJSNLe1
	 23/VEGCyF/TGJkqx2JiU1impDQvhfFu/TVGckl3MqpbPt7ptvI7Qs9kJ6Mj4MSkBO+fDq
	 e8wEb4Pbt+DVSt2pq8d1FwG0wgHmHl86AbnFjcVD12nJJHJ0vvAFUB2TGn8Ycvrnyir9W
	 s40u6i1ruGqkWPwQqSdp7fDWOWlV7eYG3XRhtrX3kSSmLG502lAfrkkeUCdHT9vy8jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PC6+0cdo;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B20606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 17:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32B20606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PC6+0cdo
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5430f70c827so9735581cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793812943; x=1794417743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=trCudkRlowf15KXENTfDgxDj2b+EYhikc7lQRV8B0y8=;
        b=PC6+0cdomG5vROb/kLHJXErM98cBbYg2LDk3QMVqs3tgW+MeYmcAt8D8Lw80tojkt/
         1OXfgL7nlz8UbSznmRrrZCoXiUBswTXbHzZic8VJi5U4V3RBSCsL7vubZNlaxEI2u3D3
         2SbqarhrEhewIDDsNBmEXANEakDeX+DziPUOIuF3Ilwg2ZuDU4IEkXpdCAW9S6N6Nvkr
         Z2hKAy9HzQ0GRHj3ilAQ726MEqZ1+23842XHDu8ChfFw3rtImkuZZoFJkolBWw/D5Sjz
         GZYbhJRfYLuvm/HXLEdM9ZzrKoU3Mj96r3cDMTmZUbPsCimWJQFl+LdmtZH4OC25LSgG
         pbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812943; x=1794417743;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trCudkRlowf15KXENTfDgxDj2b+EYhikc7lQRV8B0y8=;
        b=byZ+uEdIxONrj8Ws57I8TYFZrzdwBjTjca0jbFKoS05/GGxaRSmvvS3ALp9sabIlx0
         cHTERsxabp6lb4GpK/7UjCkadTB2omUka2u8w/hl1TVGhQZnOtOc9/30YigtH2sI/xFi
         q05IXNzGXu3kY2a/o8qv+XLWRP0Zvo6g99hloaCdBiwXqaLu/kYiUBlttYKjVK+n9kFM
         j+vURN17XVy0+97ni1jmn63UCr0lrv882Jth4K1qbS/Pw31ChXDG7bMWfZXf/V/osrKC
         hmsOWZmA/c0aj2AkP4RAh1JLDc5lTEW79789sbSjB42zkmi+C60YphMhFlhSql0NMPqF
         8rVQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0xHCmko3lGdth+9kZSX/PUyoVrNvKm0hjwIL30W+hBnK6QY5VbPo81sqER0zB2CtLs1LaTIV4AayIlDNB@vger.kernel.org
X-Gm-Message-State: APuU4Z8aOiLipwSS85s/24EF2V+dYewmV6QIpvo8I8om4mbq5ytIb1l9
	SvMkyp/XCSo4wXa8iE86OU/8DjBJziJ6H2JTSm56pCIHx+j3pQbqbbPdqoXldFj9R2w=
X-Gm-Gg: AYBFou0SgCXS/FBqbBDXEACAAXgoMLIDKH69su8mHnxPu1aPTZQHrA4D63N/8FuI3Ak
	ih4p0cqJ5M7IGAQV7Ya7FTwIcyCfWXYvT9adTD1BSm0K1QyIuMwIXovKwe0Pehd6XdSRWw2s5KU
	KQLKAAbF/HiRITOlfoazQCZbU3E+jM7rhDDvigx/FD7ixU+eIE9ybs9rAtHdWfw3HDHirsfhq/N
	L2mYQKd3t4FEyY7fbD9ijszvi7yHcDj3ayRpUzxMWA6HceLhMbitPjmFyLqXBRmCFQBjL4CfEaq
	TWXfXudEHWdTqCsZ66fmVNIRCzMkqZL6zBBkNPnH8dXK8WN7h28Tk8BWsOx9krC0utIiMIxJRvj
	Dr8p6kEluDAYVL/OSVh/YP+wbUZlWqz6X8EwOxjFVg0pWl9LwdQXT3iFrQ9Fx8aST7db4LBT5qj
	iMN5lU9IiIRj2CLKBPuKFc4yOHAZwtMKFmD0VNHjE/bz9Miq4U9xjQfAlIiCRXdZQ1Zu/8FXs+/
	/yER64ll3S+kuKb6HjZsDwsHjAVksjf75eFerw11zf4apiGztStn/55F+fS82Sfe2sQzDdAbzVE
	n2LXJlvUFlsRBGJQpjNIkL4FFzbwGGKLeyAkdrNmOW1v3Q==
X-Received: by 2002:a05:622a:480b:b0:536:7dd:16b3 with SMTP id d75a77b69052e-542b86e118fmr251024031cf.75.1793812942892;
        Wed, 04 Nov 2026 09:22:22 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm29121651cf.6.2026.11.04.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:22:22 -0800 (PST)
Date: Wed, 04 Nov 2026 17:22:21 +0000
Message-ID: <b9d94891c6bbb0a18176424eadf6ff88.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>,
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [PATCH v2 00/10] ovl: only sync what was written through the
 overlay
In-Reply-To: <CAOQ4uxhWy2aQV6g7VJcV+NDLPTSoGyR4Rag8uvAwN=LWnApaJA@mail.gmail.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
 <CAOQ4uxhWy2aQV6g7VJcV+NDLPTSoGyR4Rag8uvAwN=LWnApaJA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, Nov 2, 2026 at 11:14 AM Amir Goldstein <amir73il@gmail.com> wrote:
> I think this is over engineering.
>
> What is our goal here?
>
> Make overlayfs behave better for the (many) containers use case.
>
> Who in their right mind uses a host filesystem which is not one of the
> big three?

I mean I'm good to say if you use something other than the big three
you're on your own. I built it out this way because I assumed my
attitude of "I only care about 3 file systems" wasn't acceptable, I'm so
happy to find I was wrong.

> Please consider the attached patch.

I put it at the front of the series and dropped the fake inodes and the
hooks in the ovl_do_*() helpers.  It's 8 patches now, yours and v2's 1-6
and 10, and we only track dirty inodes with fsync=relaxed.  I'll send
that as v3 once my tests finish.

> The heuristics do not always get it right, for example, ext4 without
> journal does
> support RENAME_WHITEOUT, but it not safe for fsync=relaxed mode, but
> this is an imaginary scenario that nobody uses and there is config/module/mount
> options to force the legacy fsync=on mode in that case.

This one actually works, as long as we keep doing the last step of
sync_filesystem() as well.  Without a journal ext4 puts all of its
metadata straight into the buffers of the block device, and
->write_inode() does nothing.  So ->sync_fs() isn't enough, but
->sync_fs() + sync_blockdev() is, which is what the last patch does.  I
ran my crash tests on it, whiteouts, index entries and the work
directory all make it to disk.  I added "and write its block device" to
your sentence in overlayfs.rst. Thanks,

Josef
