Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99978F3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456523; cv=none; b=eXvVudM+wpNO96TB18CqMkThR6grL9sUP5tO9iDmHqrL23Asch9ETI+6J65yYoqAkeerQLWfU5NT2/OIvEQoyJWPvk95PPrNuPdiJYE3yyJ0dtMVKLYoaF2nNsfQBwp02DAMdVDdy3OICjUzS0zUSVuqICBUXAdL46OXgNkb4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456523; c=relaxed/simple;
	bh=56x7vzC4zMOgfO+kzkvS3sEu0G48fqeH6zTFdAxNlEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbvFYydaWBnhQahBYAn3l7cw6OkJCFray+4U03zM/jmxnAIV6YF/EDuLtlXL69Fh75n6OKESED0GxHI4XUU7DWeW13SxGUcek6glCBUrs+1pdlvYx+fF9ivWzKKHBz2BJ5ws2hAITKV7hi/6Be04afNarK4kjkqRRMZ3GnLDilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqY6ckqd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqY6ckqd"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f707e5d75so167159f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456519; x=1786061319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GIOuifRbm8yofop0/0N4Z7E2N0DbY2C2hD+PDPxriAE=;
        b=AqY6ckqdqH0P/e+ti4ILhJ/Ba9EmeNVi/PwgMQ1UuOGZYwltfnexYENt0m2TG8qMNh
         uQce0a2s9CJfWPqr427aGeqyUVgmQEZ0WT1CSSYI+qNNR0eTQKdoDQljdDiTk0jUszqK
         0PYuXrJ+48Bel4Fkc5qnKPPnjQtfwp9nlLGU3yGIFhmJZh8kGL2jTPPqfO0dwq1EzB3W
         oAxtWQNlteVxyuK5AXEenhxo8Q+vQH7Dn/RkCBunScLCQgnDUHEI0gy7k254LhYQGyFn
         2MFGcTwUadSTdJWFKmvZt9dTCeKvXhK92b2oOcCcX7/6aeMNWk4YPTU/tMI/GXY0gC10
         HTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456519; x=1786061319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIOuifRbm8yofop0/0N4Z7E2N0DbY2C2hD+PDPxriAE=;
        b=ajm2OyJ9incTjdG9SIEfB2SHR7yvUqz5y6qiBVuEHAd5ir/FujME5nbQM6cqw+/3Zu
         MQIgVsqk5KNF6lxhUOUJ2H4FyOqPJM3y/S1IE1ufCjVZ2dzu0b8q7f0F96qeKd+byaQL
         g8SPD7w4yeDTw+WbXUX8138B9Tq1GsO1BnBhDKCbKku1co0jhmngeanzI5L0ItdZQAcU
         EsQ/DfhileuWsVBI72XUeMi6eG+wXgBQxfM+Y7wDYniWJDFNNa12kMebifpEuP9/n4Lq
         F8+0IUsbgLsYWzYtHnVqygB8iOpTjIcDjUwmig72FTYEHHHBbCNJx5JWrdIIAsJ6sMMq
         TZvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEK7f1FeU5aqg/Cg/gepl7rbwR9cgObqs2lFeVukwhp9CRj9uWAayx+ieo+RRgffDLZMkJpn9Vm87w56Cq@vger.kernel.org
X-Gm-Message-State: AOJu0YysHTcwMFTIfRRtwFsb2FgEwB2n0m4iKkQM2STtxf9L3sYMp1ka
	JLvXQjWZK2X5nemN2FMSIz2WrRwNCXyGAR7F25v+tYKEEPHHHK96sBuM
X-Gm-Gg: AR+sD12Im4O7xEFkdV23uSVcVx15MDSkfHktRvN6aSgJHEovUDFhKYpNBGbmSJsxhqI
	RAYFb0JVcVd9UrOZ4o2ne96pD0WHGS23Lg9tx/M8hppARnlZfLNQHTJ/sHPbZh4nHutAd3T1UtO
	zog3vx8CAXTwmbnbQ3r6F5OTDRgTmCayGCAH7BkRVqFGpdDdSRBsv6SGvaG/j8SRGTnMAOBsDZ5
	TX1FdS9511TNIqhIHMFpzGSF6LZeZgSIfDPwWHouEN2lGqnYiZMoQtlbuHhXZjFFIDUHimzCv3F
	OABqukI38l0BBEhjZ05Nidg1Zv5N32ztgkVuJJ0ZR/Ul3YnGyO1SBrRbRzT1hePQbY8/DBN6RrJ
	Q7LyKpIoaLrvgeQElySjjiFg+erJrQaewz4Bm5+POqO4NkM2FTuV2RbFkM4tKOa43yToDooGhVA
	jr/327reMkHnA3qQXYy4myZ/srwZNDV0ulL4edXLwpmawHRNnQlx/rKeR441Oabp3tuWoXxQC4Q
	BD/uOmzNvQ+Y47j2kIg6G3xzachyl5FAS0/2kjiZ5vB5qRA9bVfegy3S66Bmkq8tEP9ZFQjH0KN
	yXGiHrkVjMwJe1K+El/rM7Hqt9BVYCJ7cG+PGmD5FpkJxeVwFHneKnf032LuXASi
X-Received: by 2002:a05:6000:1864:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-47fd2ade32cmr107117f8f.22.1785456519031;
        Thu, 30 Jul 2026 17:08:39 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a433-6e01-2027-dbe2-056d-7bc4.310.pool.telefonica.de. [2a02:3100:a433:6e01:2027:dbe2:56d:7bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d708bsm11142640f8f.6.2026.07.30.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 17:08:38 -0700 (PDT)
Date: Fri, 31 Jul 2026 02:08:36 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dcache: keep shrink_dcache_for_umount() making
 progress on busy roots
Message-ID: <amvnGb0faDy9X38h@gmail.com>
References: <20260729005933.15858-1-kmehltretter@gmail.com>
 <20260729-sohlen-ballwechsel-codewort-389f639bd3ee@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-sohlen-ballwechsel-codewort-389f639bd3ee@brauner>

On Wed, Jul 29, 2026 at 12:01:48PM +0100, Christian Brauner wrote:
> 
> Wouldn't it make more sense to move this into do_one_tree()?
> 

Yes I agree. Your version is a clear improvement.

Thanks,
Karl
