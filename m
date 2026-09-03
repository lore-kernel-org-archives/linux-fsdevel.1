Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45784389114
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465057; cv=none; b=JhNYXg2HtkfD1Qk77iwZFMOPJ1lLv7cujRJwf8y6MO/hJ7UyEBEy6HX6iRqEbfAM5jf3ZsyroCbm7nn3nGesuMrJBIvHTIWAgMI4ECJQNYs7MIYDbLk0tr8kAOe8k8Goaku0P8s27FQwO4f4BY2ZDu0IzcKIM60QT2aet1OnWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465057; c=relaxed/simple;
	bh=Vqij/XyfWWBAn/N8UeaWu2TQyOe9gV4MPFIdlCvWqd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX5P3b+yjlDgZVdMsHEJJmzSEJSwrStuw1Ic98ep2svOftAxIBCOHvpv7TpkTXUaBuH4vlzDA5tl58t16nxQXQkiqdyRDEz/fgvTkFyLajo8cYnJmkUBUnAzCwOfv40pYsjlBcxPhF7V2rQSLIbbjWPPhinEfdR2ShQXWE5jMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAsPqqXD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAsPqqXD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48586861639so163322f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788465048; x=1789069848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GL8zkxepuP0M8EFbInFuzbe9GFtIatxdF7aVOTnQFtA=;
        b=nAsPqqXDfs8Mr/u2+hJp5acvBXtJsKFxZy45UHP6zD1cbsOzsA5LvYG6HUNVDszGf7
         1A1I2U/+l4wH1Xe56sixyLKTjr5ufsf1+fCtuTl72o6i0sMSgmvEu9vHQXEZJgBUoWSX
         ER5Ey7enG66zASspuOwqql1/6dN1ZLeVc1S6f7F2NuhOrl62pekGvpq/a03+ogtZ83D9
         aln5nuQjw5MudHjoB8UXCs0Pva6HQYS2hXG8UH6jCx01soYUbCugeEAaBnmVCKec8nRv
         4paSmzo/u7CmvLlMj0nG6x5iOqsVYzzfIhfHPzE5bPqhWBOxef11vCD9KfubHyX7FPuI
         1a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788465048; x=1789069848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GL8zkxepuP0M8EFbInFuzbe9GFtIatxdF7aVOTnQFtA=;
        b=jkQKQPms6NMS5haHfbMFu91aDn4XuVLK3c15kxEDjo7ITJhsLOf9rvhWO4HOv4c9oe
         PbbK5qOJyxPRQRyBcveLKRFgN8Mq+64TUoIyZVe4Stw6yryFq4gZZIAkwl0eebEmkdO7
         OZB/TAlBJdycO4d6DqMxA9fRc9Sqm8xsSRf3iEuZXfAPu32Bb3uZRG4iZ+pcmZJFaMA7
         vn67vL4zIbC2ILR81f41gOnmLTT6bs3bCNWtGRmtb2Erp3kJJcK7LN1fC8MepEVeSFK+
         KqSfPGjkUXQEPLBlhzOSFHkYmpb/af/T/VglFzZKSoKwS3BfqMkdZumT/j/242Hl7i/u
         gQjw==
X-Forwarded-Encrypted: i=1; AKwUvBzKheX1SZRatGKjWlOdKQp1iYSJPyMQ/s3JvG5YkFmslBdxCWMenjq7U3uT+QBTHpQPZusmr3qaLmmC0wwr@vger.kernel.org
X-Gm-Message-State: AFuF++l5hc3m3eViZBEBB299vk8QDsOiGG/s/wQataVckz6dCnfAarAq
	VjafTqASkvCLF96avr6Hc300qkqn7lc7ys6lSESQnbp1tSSM8AyC5A8CTqjusqsD
X-Gm-Gg: AYBFou2pEDssf7g7ZKfMsDQiehw5ZnKRt62zFNgau6TVz4/9b4qfHWRl5df/84/xT3P
	lA+aV5XQ1f79wK1FUKztC9UKP/yE3N8l9KteMJMsnaKZVWCdE4391GAO0ZYJY8qDA53KPcdjLTp
	6iWmmjfIM/QOmRXGUAG/X5HvvJ2OS1ce79ceQTCgwXe4UAY9XK1XS8RHG/HgXTIgZbK/BM7GLpO
	+J19veD79esqTtt4SckU+YaEV4Ih8hcqbIzJckxUzpYFu1t8AcDewZyVsrnD/howTbWOKgLhw0T
	vK0uEc8RNGfUhs5hYAECVoy3tlheI0PPC/yp7rESYv6danj6E+mLDYdnX3SchoyMRmqUn19Qm6/
	1JcT4f3eM51RrA9KSKpUHJd2b3wYTz53BUoudjjC1gEdGiOrWhG+g+Ri21fYU68WLtl/bk22P+d
	lCJqwbZ62fDUaOYScvD4A6acyzRsuDmXrqL5eY2cFuf2zzzF3n8Mco8Qm3CMAcFwpvqn809YR/o
	0prF9q1/hY947hn8mjj5UiB7XHTHywskYsbek2qhL9Lz244iRoE2bprxP3GxmeB/Kp4D+ZQJniT
	6vxxu+IrUgcrXcrtnrGo2NE8/qSe45/7QkNaPtY2wmk5Nv2SIb7tieuXD9uFAK77o+RadDY/0R/
	w
X-Received: by 2002:a05:6000:460f:b0:485:8226:c69e with SMTP id ffacd0b85a97d-4858226c95cmr7200438f8f.29.1788465047884;
        Thu, 03 Sep 2026 12:50:47 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm792490f8f.27.2026.09.03.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:50:47 -0700 (PDT)
Date: Thu, 3 Sep 2026 21:50:45 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: remember whether freeze holds writer rwsems
Message-ID: <apnNew8Exp44CgQh@gmail.com>
References: <20260903060855.4610-1-kmehltretter@gmail.com>
 <yly6lgithikpjfvmozn73zvcivoftko7ou6qozsf6xntaoi6yc@44aw3yj4i7rh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yly6lgithikpjfvmozn73zvcivoftko7ou6qozsf6xntaoi6yc@44aw3yj4i7rh>

On Thu, Sep 03, 2026 at 12:40:42PM +0100, Jan Kara wrote:
> This looks like one of these theoretical issues LLMs come up with. Frankly,
> I just wouldn't bother. If the fs gets forcibly remounted RO due to
> metadata errors, a frozen fs is likely the least of your worries.
> 

You may be right that this is not worth fixing in generic VFS. I tried the
real filesystem paths anyway:

          Without patch                 With patch
ext2      next write hangs, unmount     write and unmount complete
          gives three RCU warnings
NILFS2    unmount gives three           unmount completes cleanly
          RCU warnings

These tests use FIFREEZE, FITHAW, and corrupted filesystem images.
Other filesystems have similar error paths.

The f2fs report fixed by 930c6ab93492 exercised the same sequence. The ext4
change d3476f3dad4a removed the analogous SB_RDONLY assignment because it
confused filesystem freezing.

The VFS patch only makes thaw release what freeze acquired. It is needed
because these filesystems change SB_RDONLY outside the remount path.

Should I send a v2 with the changelog limited to the reproduced failure,
look at filesystem-specific fixes, or leave this alone?

Thanks,
Karl
