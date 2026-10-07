Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705149D585
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381942; cv=none; b=AdfLsW6SU+BTBkexAPOah/f6gV5pYzW7VNzHz8hkuDAVZu3GDJiQvUf9E4rf9rnaPGh5xL4QzUU5kVWJzgE5K7M6ive8Fj8mmDcKXlf+4G0vIytopUQw/+RBTREeoX2lCF7IxrKEJXYLgXErEn+Nmt1N3joq1EYNumf3qaQbiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381942; c=relaxed/simple;
	bh=V7wCXFfMiY8I3U4QW7xgovTFawhq2OF8NsZcAprNCLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZxJnB0Y19yzXOEtb/vPVguBPKyLRGnbPFx69xnsx5+Zg1zPjqrXe/A4IzW2PU/R5n+5Zz+mcuEExJpd322NtiUv0wJZfSKTHX9mfAs+K2+uw7cL95HQ+5nti14/ZFalCbekFMOd3CNlTrxRHjeiDigl2M4kEmPghlIJK1mdhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PDA4CzXZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PDA4CzXZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2680112a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791381933; x=1791986733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tZULonu7kKZiIqDdMHG3M16ndJSJFse/YYFR6ZGm68=;
        b=PDA4CzXZVp6XIMVR4rSohNCjpWBfkxope7IT5M2ZWrsgom480Z/UP01vKISCHF2G2Z
         CCpY+z5xLDtaGFvhS2U/L74Jm9YVzBJVqHUn+OBzaPEXtDCna5adkSXhG8h6FFIQ87ks
         LvJEMmHWWSyWBy9scoIlPZjgNX/EtGID24DRyYNg2B9sfk8OkpbDxeuXhUeNjhJwEpmm
         heiICQJXz+gjxuQXlR6+Pz3YwyEj1fXtUCkRotDcOuNbpEmrhtt7LAM8WvS6CF43vj7L
         Vne4sw9XzFQ19KaacvBgudTsfUoept3pFiO5znr3scvW1kgrig6bjCR/tRiZI6VBFc+2
         rJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381933; x=1791986733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tZULonu7kKZiIqDdMHG3M16ndJSJFse/YYFR6ZGm68=;
        b=GN2iZQKjsye0YsAEyxXwKjkoYzMjz5XR5uNgYuGfISkyfCawZnJYT9vXND58Nhwl2/
         o7bF7X7PL43aSHzeH/uRiohLsGDQhUFubMEKgStbxs1wZ7HvmZ86lY+c2rgA/TrOTrni
         ZJDPjj/XCCfzfdsmBRc1py1I8wYK0/hakedKD2YPP+0fUHvpUiBFvWUTDjUsdXOzbMIa
         aLFmy/MuZXl+GJLdKqSjaraXHNzRHl0IUwhSJnFyoIh33fSY5f8JJole+EK5S1DcDx8o
         1e5/FcuiqFurCOlcwIIG4wueNj3YDoOwvOnzOpkDJPEaipDKk+xEOclFnoScCYk6hZO6
         lPRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLjF1PuPwQ8m6oGLGz6YKrDbwLMH6Q+S+n9SA50l9d5BgV/+64lXQyMw+i6fXB/oYzAV/lwGbTQiqVQHdF@vger.kernel.org
X-Gm-Message-State: AFq9FYJcO+HJdrLFr03RM/XESWS7aWP/rFphN+nUdNDsE8ThJNm7LDrI
	2RH8t96Mm2NFCyl2bQhT636PwfD6RmIMhB7bTxL8rPZOL9mLgrcXp1LaC3PmIVYHS/4=
X-Gm-Gg: AYBFou30sp5AAMTWvFxk3NdcyNOEY5/ENCrBAjCUO5iCQ9laMF6LTtX2C7FK1Aiq3Jy
	ohLR+H20dWok0ui9juPm5KLhBD7XneQtjQekU8WrW1z95QlSJYxDoVv3Bwzir2ZLIh37ligrcnM
	1mLxyUg7AVxiHxHxIZGvYE7+pd0BywCChF+eG8RUcoHgEJ7JcONGdo/PDSwB0zgIWfdcfcVt59o
	ym0ZR3XplUeP2182t8L0yHBilraEX6JcH/lr5S6/yf8TVpiBiK8MskL0rDfjgA0ONLJalnLU5vJ
	t8p6xBlMMcBkHZnN/OYPYnfJvKINAv0LfJwQf9yoRqzzRhqVxZPYbXLAb25e8jmH+s8kuy5MTVP
	JNrycZ72WG+RVOwOTyja88+Bnbk1CoNIpNaJriS/5TQRqxedlOgVXBeSov/FTUWWS6pvk+lcCk3
	nw+QNMPy/5GkpsjccrfQr9HcBaqSLy5izFlBM623NujBx5VfsAKy2kk7/asOpm7OWP+HEszJK8E
	+xQ5k+fAeuPxjk8b6qUmHBJvaxQBzNBn6c2FEBsfMpmv3eYb9pr+MCKLw==
X-Received: by 2002:a17:90b:4d02:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3a8a1ac0562mr1978385a91.25.1791381933049;
        Wed, 07 Oct 2026 07:05:33 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543b0c1fsm13716636a91.14.2026.10.07.07.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 07:05:32 -0700 (PDT)
Message-ID: <960b1305-c5a6-4554-8bab-1cf4244fa11b@kernel.dk>
Date: Wed, 7 Oct 2026 08:05:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
To: Tal Zussman <tz2294@columbia.edu>, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.garry@linux.dev>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 5:56 PM, Tal Zussman wrote:
> A set of independent fixes for the block device file operations. The
> first two were found by Sashiko while reviewing the RWF_DONTCACHE series
> [1]. The fourth and fifth were found by Sashiko's review of v1 of this
> series, and the rest came from asking an LLM to find any similar or
> related issues. Each issue has been reproduced, with the fixes resolving
> the issues.
> 
> Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n.
> 
> Patches 2 and 3 take i_rwsem around the direct I/O write fallback and
> the splice read path, which race set_blocksize() changing the mapping's
> minimum folio order.
> 
> Patch 4 makes the buffered read path honor IOCB_NOWAIT instead of
> blocking on i_rwsem.
> 
> Patch 5 makes IOCB_ATOMIC writes fail instead of tearing, and patch 6
> stops the buffered fallback from retrying an atomic write. Block
> devices can reject both paths into the fallback before submitting any
> I/O, so we fail rather than issue a WARN() like ext4 does. Patch 7
> makes iomap_file_buffered_write() reject IOCB_ATOMIC, so no other
> buffered fallback can complete an atomic write either.
> 
> Patch 8 fixes leaked page pins in bio_iov_iter_align_down(), and patch
> 9 removes dead metadata handling in the async direct I/O path.
> 
> These issues are currently unlikely to be hit in practice due to the
> specific configurations required to trigger them.
> 
> The reproducer for patch 1 is in blktests as block/048, and tests for
> patches 2, 3 and 8 are posted at [2].

This is based against the 7.3 series for some reason, can you please
resend against the 7.4 based branch, for-7.4/block.

-- 
Jens Axboe
