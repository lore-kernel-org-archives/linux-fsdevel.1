Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF883FCB0E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047618; cv=none; b=Pr8vEm2DCyt6Y+ldPD/cLeTENztOLep2zI1J9+lVeXj7C/tpieFZj1PRUWhfvwaTSya9mY+zX/Po0nGWXVESgiLDcV/ck8d8samhf7VtP1nXLI6D7b7HTQwCe/3N25DzzRS/mOZgnJ257KFPRNjbxPpP8yHgoIzvci0hN28jATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047618; c=relaxed/simple;
	bh=I88XnEUAsWTxijoNcZ8+/5ewG9Ha8puFqtp4VDa5Jis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRBVdl0hO5ULOJHMvY5sVqjhdRd5t5ciNsUZEVPyNJFw42IWkF/BrIRltaTL0XjGrH4HQ/r+lqifUB3vGsXJNode1EWPOM5h+arGcU7IW8xtmel9Ftisd83ZcF3DFINNNny21U4ZjHa+kRldmHl2a3rr1XgYaIcGWmTjrZt3XF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AYuf7wNQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AYuf7wNQ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d02a71526so1764374f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775047615; x=1775652415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QR6+/avNR6j1nf7mvlVyGUxvlu0+VNHQ6oR8mghN5P8=;
        b=AYuf7wNQ5TCr5qedQEaI2J9pMkgE/pR8Hc6Qt4hPl3+6aSxLm0sP+7qviQlniwi46Y
         NhE8iBrDm1fXQ/tyFH3eOdKXTfDkrP6zmFCq2iesnYh+tnWfHsrMotMTIdyCOyPhhRZU
         snhY5W8IT6qPLolOEHjVIJj2gTtJ1GBrclTDS2mGYxyF36saOog1O8C33AEwGwBGo7EZ
         fqtMtbJ+LoWbpOjkcFvUSN49V7Pf4J0cB9wT5CJtxlvst9FxQS9OkAtAThblIj4rVEO3
         xvw9Ofo1b9wnIRwshMrmj0QIyQqFXk9sZhTqItHUp2I0MLecbtxyDP8OEXUiAKcU/Cf/
         pTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047615; x=1775652415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR6+/avNR6j1nf7mvlVyGUxvlu0+VNHQ6oR8mghN5P8=;
        b=bxO6Kz69Xf8Q7QcrqimSj/llsPcD4VKUW54dAGyxhLwDJzf+enRK2FGA1clYqwGNaL
         C2pom/FWfixZwFX7SUCzaEvqt5UdOL9gHyNKXbF24ae4E6/cBABkJndxg/KDLUxNrKys
         QQmTvk/KxT4P9LaFx9NsxQBRbxGg2cLGuUYCLv/K6c8I8eh5/hqFHILQeT8s4W/MmvcS
         NR1wS+Fo8wQkx3ZE+BFbu+5DQq3YAWr5xUT8+rCwNF0z489fRWTpufJZ07V6RcgLH9UW
         pVzYqu/Kc1tLK5ycBQS/XtgT38IDKsAjt9xNYjZ7ooOqTOMGjlyjcwjB44mL53Y8TjbM
         9cAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7FqwSHFnEtZYKDc70FEdPFA/aWK1o8geMaTtsEHROn971ANAZ6ewQIT1Cnul8Z0A8G6LxDFHdTQSMOjXm@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKU1Qp+HsSxUwL8CGpiHPo9EWqMDZbQO9dtlG7qBCwMhPXYoX
	ZYwR32Cv7BrUZz8QtYNG3lei2NyLigqtrhAz+WHWLmN59Ji7qeWjw20Ii3n1Gc2zcuM=
X-Gm-Gg: ATEYQzyhJk3A6BDCf8UJlBj4FaMYKu7FqPmteEoTL1SfgGIDoj6L3JcsB7ilVyNnnrm
	/hw/3tNLDQLGFLEtWL4P59z9evKklk9rtHpQmpKVR/LG6gK8rFL8sYqP64hRjWTvRGOMooE5Rjn
	xT9kmx9st7aaOWgF47t05LTfbMRDX5KMjt+Fwzi2DlgndOP+BiOxBcbNAfk86Tt27G2p6D9xlTu
	aktcWw8rgkPfJU4F8GLyTYMIBIFUK9YK03fx16ofvwOlRiw2RxnaWwOJfDajG+wHT9I9YLtl2xv
	y964YdjaBpLDAMa9VAiMsvidUC2nfrxyYNs0qg+wz//MZPGj1awLDZPFNRsS8ElGRKzSy9h1Var
	fxI67Oip51t2yMPI5DXFWA15vP+dGucbhcEoDf4/f+TdsBJZMV2rqXILO2/L3+3ommt4XdgPf+c
	2ra/0Jci8B6VYX+PvNy9vkMTe36w==
X-Received: by 2002:a05:600c:8488:b0:486:f4d2:eac6 with SMTP id 5b1f17b1804b1-488835682c8mr61400095e9.13.1775047615554;
        Wed, 01 Apr 2026 05:46:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80148csm121472415e9.5.2026.04.01.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:46:55 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:46:52 +0200
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
Subject: Re: [PATCH v5 1/6] initramfs_test: add fill_cpio() inject_ox
 parameter
Message-ID: <ac0TvKh22GX1fd8x@pathway.suse.cz>
References: <20260331070519.5974-1-ddiss@suse.de>
 <20260331070519.5974-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-2-ddiss@suse.de>

On Tue 2026-03-31 17:57:31, David Disseldorp wrote:
> fill_cpio() uses sprintf() to write out the in-memory cpio archive from
> an array of struct initramfs_test_cpio. This change allows callers to
> modify the cpio sprintf() format string so that future tests can
> intentionally corrupt the header with "0x" and "0X" prefixed fields.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
