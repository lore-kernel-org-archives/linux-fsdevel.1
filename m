Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F140F8E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542817; cv=none; b=aMnH/vhVjFNCOxn/ze2q5GqxPOOi7e6Yt4ZxFjgE8AFlet+iIWb6DtKZO9SfyONzeM5C2xCoZWjU9hQNX4sWaLa+3/yEUXPp0MIqVJ9jjojx6znp4DKqHOlJTAc40zQ1z+mlohYA1KgIHpOxcYAjlVYzps0k6tFVb26DQeujq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542817; c=relaxed/simple;
	bh=q7aShcXg8A/sepftuwkU+rE+fRMUvh4OXVb/rOzurJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZT3jem1aJ6e4srTZ3Z2t4wS2rQixSe1FE/d/WWRYuve9PjeVC3BVWapOLJTIOWScbKfUKnRxBxje9ft3s2/byBG7/U11T/LQDwnd8zLxt70bVkWRJb9EOWNBngYrj0dFb4AzxVvkUbm+AAY22xBFHPklUVIxyqGzfO94iF/bJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LPgwVrU2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LPgwVrU2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so13666895e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774542813; x=1775147613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dDSYTWQC22Zszdgwn/RUsIPDRi71Exya4bherWeuhw=;
        b=LPgwVrU2IIDyAk6SmmHWmOmH4/Kd6ZB6npcSXZczFKnkj/5mPTXDWTRPbNTlwTBnbM
         4PKyGWSeSZkuRSVC8rN+toymJ+BGA0Gmf5KGtMqSUPlXdJlKWbwIY5OqXsocT1QHgzzC
         FmN5IwY2UFml0iO8ZxbELVeEo8lPxTOJ5+DnfS+chc6+AgFbZwyVrAC7WcKrAEAbY+an
         kE6apmo04m1Pa39xlLeVREqim8XBQdCgEUjy3DqtuvquSo2UHoZJABKRW0iz24nFSoNA
         dhLYI/I1GAQLA4OWnCEr7PyiOKabDbVS/u2BW4vkhmQ4QE4ps4F28myg+OH+tDy05HY4
         ypIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542813; x=1775147613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dDSYTWQC22Zszdgwn/RUsIPDRi71Exya4bherWeuhw=;
        b=r9zcRY2Eny6CxHj3kSdmOCKGhCUUGSGOvhJkSaFvaUk/NVernJxx5Ir61/kbipz6J7
         ra+hjwTppAxpm8bbsxA0DU9op59heZYDDxw3rJCIAY5llUKnBxGbbi9eZ6LhTpzUr4YT
         WuKoZKJRy9OesUrtoZZzIpRUx2pC9I1cUEoQGUbjJ+K514gF5XVUl/9EyIb0tfQ87ftw
         z8LzoWbxHqpT2xh/U2a8lUUEcPFMMny+E0pgWaXVtG4BKdZt13NMPlrEV1yCBiyx9jts
         HyvF6ee9Xb6k6ycIw4+nLtl2g7sCp4/xo4JyUzCc+r8jU6mwjuSHjiu8L8bRIuNSpyaW
         +8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTdh8AgoymBM4ckygJ7uy6of1OReBUz9/cPNq7Dx6wUx8tC8807dYSWQgXnTchI3AvBTFQCvsXLZSZJnc+@vger.kernel.org
X-Gm-Message-State: AOJu0YxerN1IjZS62ejwXfMeZJMc63LvtC5He8rmnTNBE6jJePtJyj4P
	U+u9mwTAwg5wb/Ybu+cUcMRHUsk1yZAn/+gpEcxl0VG/eUKPAENVzWNCYl+kTcv+clU=
X-Gm-Gg: ATEYQzzivwC1Hbo9HIZ7RZjeam4rL/tiZ+UQgaIB0eUGIqzBZ214gHKJgmXUB+WEt52
	Z9/v9Q4ML8HRVgeLe7MhPaPhnRX0OPHwRkmZyXc3uhF0fKKjp6UyKvT2YtYSm/78m6lertKaI/+
	i8/U2bG8oGFPJHIfh4QzFSNHsFG+qM/+XwAgopIMR5Mbl/9lS1OJ0+8k9CKWGQMz6EjB4lVTsoD
	KZS2fKj2XRkir9RvorQqCJocqDLKqy31Yt2yWrvw2Xbpxs5psRYcmUOPI1Od1U4HxNSliyes9Hn
	O43ERzHK9sInGIQhUKzLOB0x1x0wLNk8X7ls4d+hsdEgXhAW15ZRRbOrHHtgxw2EKO27tf1IiJD
	PKEUYAdNxVmT+1DpEYO0UaGQrGa16AX6JbUH4/R9DjC7uubvlWvVsOqnULejqyMAJjkoRgwjjZe
	nBC2IJ6r5w8Bvp1kozDrmMTVUpdA==
X-Received: by 2002:a05:600c:6ca:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-4871fb409d4mr32149505e9.22.1774542813478;
        Thu, 26 Mar 2026 09:33:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eabb31sm134115e9.18.2026.03.26.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:33:33 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:33:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] kstrtox: Drop extern keyword in the
 simple_strtox() declarations
Message-ID: <acVf29cNICYtVEnv@pathway.suse.cz>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
 <20260323150054.3587083-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150054.3587083-7-andriy.shevchenko@linux.intel.com>

On Mon 2026-03-23 15:54:22, Andy Shevchenko wrote:
> There is legacy 'extern' keyword for the exported simple_strtox()
> function which are the artefact that can be removed. So drop it.
> 
> While at it, tweak the declaration to provide parameter names.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
