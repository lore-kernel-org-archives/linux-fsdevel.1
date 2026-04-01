Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8F3F789D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047754; cv=none; b=IoEOzjOttWlTju6nR32/HDAmABftJaxib1YcZ6PNxSVp3rBcc/elg+jKEXBVBQVFIA/D/RhvURpFrCoNy/V9lZzpW6/cNDVd23idn4/Oqpx0fwSJe9NkNRuAvdoCixkGKN+mPJnulIKuR/tkSOoEwPIvvaWQwB5TaMjidTcRpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047754; c=relaxed/simple;
	bh=g4W1QNR0kByB1wI23Vjqn5zE8qHPaAnykdO8CweSTn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/WLc+F+qGNIbKePHC4xpzSkQs0mzTddPj3nYvIlT4wjwSEsrXnmrnjMW1IX8MwmRP0bqZOH5VgfcSLi5c0dvlYt7FxS0DuhVrVPxm+bra8lBcn6Oiwme59RmRmpXfon67HQSB7bt7KyrekOjGxCrE7P/5D/4ZPJA0aC/Unokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cqOrM/UE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cqOrM/UE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so54124715e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775047751; x=1775652551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQeXG5Jf7QCeK4iNRYwUn1f2BbV6yJLctk9rsoco+pY=;
        b=cqOrM/UES3adJ6lNaCJjOKR2AAWQaKhgZSKuQSZtLT57DRGBiwy7JPK+Ki5d7s0qBK
         cF1L841hi3W73tHjKXBROOKbAQQB49HbLIqu4AKmr87XHTbWqkBEBM+9UqqbSbnY/ym4
         Px9FZv8Ax30R+XaWzve09kGiMkE3I8XuKFjatUItLEzCRHSlNGlD1Ip13GbVwawdm5eG
         k8aQQq3bzAvgGPs9nVug2+XHAjpVPj21GznRGhgZt2PaS5qvaklxSrrIMC6k7Wma9PuV
         5XoKipBdLsjbK3syCOQIdkjml6UOF9qua5pjkI2xduPW5LV81mPNH6I+HbLkVkTBAk3o
         35pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047751; x=1775652551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQeXG5Jf7QCeK4iNRYwUn1f2BbV6yJLctk9rsoco+pY=;
        b=ruTblM61IWuctmEK6BVz4EmNtJznqUoIz+Y/QFPUD8k56eI3kHDaRFvxrtmQzaulpw
         t6nKa5oohr7dvS1eS2t5xEgTbBgs8cLEqI6qzMEzrjTF1+8N1FbH9wbDUxwbDd1jchKo
         J6kfJCVzV5fJ8WZ2TAuRGmM38dj5RZvXT1hfHzjEhSsplmEKOuAT1YCigYY+hWazmWFz
         b3ONJS1HTIYV7VXrcjw3bNm5JWP+TS4XwBMMgKpH6/2nVt4kNKlJVcwkCxUdWIR1uh1F
         XVBtpA20usGLqPFV8ai+ZiEEmI8Sfv6LKsf5yB/roTkKkkkYSzXbrclBtVASf7IuhiJ0
         R7xA==
X-Forwarded-Encrypted: i=1; AJvYcCVEXeNdX0O94JiXW+lpsKFYlqgMkRPQepANj+FkfoIVzNIz/BJ8E0J/v4O+bc0u/VQL7v1aA6X89oseGcpC@vger.kernel.org
X-Gm-Message-State: AOJu0YwJV30JLgApGj0R8maKaLxyeSXH5NyT42fMAEW/+6fXJXWC9QEI
	KYGnHK4bXIN//Wuh3MmlxxiEVXx5OGjrPRcJX2BQHzRXQG/JhnH7/H1HhZRTIZwkjdE=
X-Gm-Gg: ATEYQzxKTWPDXrg0LwqqBowb+t0uQzZRDHo2arg4JrHBh5FHcYI11MmedN4Trm0Mm0l
	fU75xnV9e6ZBEI6KFFyOOpWa8T6L6DoanT1egEKJNuaF85XU+OUOfo/gohmMveJNCh5ZplaBWFb
	52J+B/NohVUTp7pPc5RMBWpx5GeYcHyhDzhpYQKHuusFOwTDojCv5fy4UfRWdQXD0bzWxYt6/cN
	ozV7l/5DZQiCmTmhwAnqsu8v32j0M1FvlBmDIq04o/ATfSTCjv7pMDWv/yRprOSu07fv505b9YA
	Smvn+aG69LHtk0eIFltW65cIcT7N4s6qVibxKqtSydtyzlENvaKSo/zqrtDxvfd5R15f1+/L/yv
	GOqtwuZkO2OJIchlOJ8Zo9+4GJsNsJEv2OHW4O7ZfPyqTtZoOsoOEA2d7gE8IzoSCiIyBPw99TA
	2e4fYsmF76Rg8rkVbnUf4XGaQhIg==
X-Received: by 2002:a05:600c:4f12:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-488835a1820mr56116055e9.29.1775047751545;
        Wed, 01 Apr 2026 05:49:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e72da6csm228378315e9.0.2026.04.01.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:49:11 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:49:09 +0200
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
Subject: Re: [PATCH v5 3/6] initramfs: Sort headers alphabetically
Message-ID: <ac0URUCyOxN61oED@pathway.suse.cz>
References: <20260331070519.5974-1-ddiss@suse.de>
 <20260331070519.5974-4-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-4-ddiss@suse.de>

On Tue 2026-03-31 17:57:33, David Disseldorp wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Sorting headers alphabetically helps locating duplicates, and makes it
> easier to figure out where to insert new headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
