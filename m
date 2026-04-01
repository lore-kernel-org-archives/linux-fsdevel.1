Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748D405AD2
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048317; cv=none; b=hqF84UmrAAyVJIadFu77OEj1DNJNSHfON7K87eKnwIM0hPHgT63FkoDxCxGelIy5xq30T49YwlAJJ4v8D5CBlvPrDFGgjUAB694l/iQz93bN1z2Bg+knKbR9sEbJk1F5DUkWBwkGmd79PEKTAWsc3nRI88PdGGfrarZzB5lZvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048317; c=relaxed/simple;
	bh=TAT5jk3CNrQ0/FXDIg5I2L4YZIQIRn77uMPGc63EDFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn+FHpdldZfFqmBBeFJu0aR+7tWiM1OqYUrc8W0/1/dBk3QzsxKBvsjftIp5f32Y/7off2K54UQYEY+GPjAIA85Jt1QLIRqoOea1ZSzsDx71iICkm3imgTdLTcQ7oc9kK6aQtPLQJRZ+YPqX7ceuc7E7bvL2Tn0FOca8kPiGrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gKIxYm9E; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gKIxYm9E"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfce3a195so2137149f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775048314; x=1775653114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRzJg3vjtnmMlKPJ+sffM/QbMud01hausiBgoVLg6Fs=;
        b=gKIxYm9EUUSfPPO3b/cZFbs6Hl7dXTkwsemO9Tl5iR/hZCGq5V0aodbd2XHRkMlzTJ
         UeWH5+ZrlWuWqFiK1R7q0ySJtaZV7rmwnvNEBUhK3nVhzldYn/nz2Cd951Q/EvVRtHZl
         cG+KiqUjDcrR/OFLNxJyeIfcAqH7mC4k5ky81Y33liJv3OOjJvDYySTmEHhxhdZlBCBL
         3wgKq1f71iZPYXPmQqSIutJpFBfe+aY32qc5RtwUyXfl3gkdn979bUA70/38z+xRnNqW
         hJd2WESOMbf7OPQA73qnr0O29PBuEAk/gj/kYEjGwVm6BAiYjHtQIOPcLAnNSXmhrnpY
         j8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775048314; x=1775653114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRzJg3vjtnmMlKPJ+sffM/QbMud01hausiBgoVLg6Fs=;
        b=iXRrSF5BoODlzrs4+ti2A0QEc/+cKFH4t0ZwES0LA2LbA7mfh7jg5TYp+efOJ6gjLh
         rYTIx/GuVQxhU0J5P5mx1QF1Q06urrind2NynEA2jp3MljSOSQY/QhWeqXAFVHJWHq2s
         plBmrbHPnOwKhSR9jreR5Hy8pcVNyTMIHTKMO2x0OqNMRGhxyV+vBW1orhYI4MKZgzTh
         GBZop01ZzL9G3mbwiJGzAxsmvxARuLNEYMMvepae1yGVBtui23Lq6UJbRnYwRCBEpNYc
         MDIPFZpFP0YmvSKyKyvudvImCQAGkHGq9bv5/w4yeHyVnZdvObYbJl3zNBPcE+Ipyp5E
         ePfw==
X-Forwarded-Encrypted: i=1; AJvYcCXicNebITfqTcHcRuEBWOjOIoPs7oPvJXCyaFzg9YuwyGopjQEICckh/peTxQ3OYZe/9S7gVHxAb6PqNSyv@vger.kernel.org
X-Gm-Message-State: AOJu0YwXizT6GKzbsjM/N74ComTEsCbSi7IMQqqeqIG+8jVTJiU/GOGC
	niPNMnz4B91cQGOzjxWQkQTd1wd+rqaKXv/KFIqIJzaK6qfzxMftQsMKKW/Uvc0cTqQ=
X-Gm-Gg: ATEYQzw2+jPin1EwpXSSZxNLlIBMeEr8z2Q66UMBq9Cgk2WPA/P4qtAZXTAzTlk+PCF
	0lpQ09iAhHWLaxdhea33MYF7PRwTTK3rxLPyO4kqgyRiRiKmUlk7IK4NDwIjpQml9LVIet2ymSU
	Pmk/pGCSNtiHXfT52GtplmFQjpj5qnb0UApovcL+oWCdDShf9QZW71VEEN5DBybx7/3yGClTxI3
	qxieG9QCG8DrGran2HAgHHSDgPRUrMy/c4bYEAXjcL/8Ksk1VO0DXcDXkgTl4TfFpucQO7Lh0aR
	tXJ3MHaFAgQJO/6/LQezVfD9x28lcagZgmLwlDwfSDd76YRRfBrDFNrwF/ync8XYutTtuiF0daA
	53oB1Gb+/Y0SqrIB1gtLjeYuqQhW2XOPktj7WVR5eBeuU0G9S4efmoug1dxsguC2VFDHhFM58Oz
	8UrPVxrTPVf28Vq+wNpE5EM5u38Q==
X-Received: by 2002:a05:6000:3112:b0:43b:80a0:d92 with SMTP id ffacd0b85a97d-43d150f81a5mr6011249f8f.45.1775048313685;
        Wed, 01 Apr 2026 05:58:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm33292500f8f.37.2026.04.01.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:58:33 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:58:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <ac0Wd1tmV0ndmE1-@pathway.suse.cz>
References: <20260331070519.5974-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-1-ddiss@suse.de>

On Tue 2026-03-31 17:57:30, David Disseldorp wrote:
> v5 changes:
> - rework 2/6 and 4/6 test comment, as suggested by Andy
> - 2/6: initialize struct kstat in tests to account for possible
>   init_stat() failure
>   + drop Andy's review tag due to this minor change
> 
> ----------------------------------------------------------------
> v4: 20260329105307.2876-1-ddiss@suse.de
> - rework initramfs_test changes to use an inject_ox parameter instead of
>   having tests pass through an unvalidated format string.
>   + drop Andy's reviewed-by from 1/6 and 2/6 to account for changed test
>   + 4/6 minor changes for test context and comment
> - add review tags for 3/6, 5/6 and 6/6 following list feedback
> 
> ----------------------------------------------------------------
> v3: 20260323150054.3587083-1-andriy.shevchenko@linux.intel.com
> 
> The series that introduced simple_strntoul() had passed into kernel
> without proper review and hence reinvented a wheel that's not needed.
> Here is the refactoring to show that. It can go via PRINTK or VFS
> tree.
> 
> I have tested this on x86, but I believe the same result will be
> on big-endian CPUs (I deduced that from how strtox() works).
> 
> I also run KUnit tests.
> 
> Changelog v3:
> - rebased on top of latest kernel
> - squashed patches proposed by David
> 
> v2: 20260121172749.32322-1-ddiss@suse.de
> v1: 20260119204151.1447503-1-andriy.shevchenko@linux.intel.com
> 
> ----------------------------------------------------------------
> Andy Shevchenko (4):
>       initramfs: Sort headers alphabetically
>       initramfs: Refactor to use hex2bin() instead of custom approach
>       vsprintf: Revert "add simple_strntoul"
>       kstrtox: Drop extern keyword in the simple_strtox() declarations
> 
> David Disseldorp (2):
>       initramfs_test: add fill_cpio() inject_ox parameter
>       initramfs_test: test header fields with 0x hex prefix

The patchset seems to be ready for linux-next. I could take it via
printk tree.

But I would like see an ACK from a VFS maintainer first.

Best Regards,
Petr
