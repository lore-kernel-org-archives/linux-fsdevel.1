Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70941EB5E3
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049578; cv=none; b=AuAD5BEI9Sij2b1gYm8L4U5/tCYt9kPInQ9aHaRsFU1Lk6V6pXoOe5g+dZz/cFoCYdu1aaP8uUP/yn5G1gHVleB7TfR7poBnA27PyUgCb4VCiBswdAx2cyVUyfIAhQshTgQJqnJf0eB9+1ITYql8Ab9Z54+cM/sd4qyP4hYPDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049578; c=relaxed/simple;
	bh=zRSq9GBe9RB8pR9poGoz6gdAAzNYkiK3X/2GByHGY5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCKYeJ7NXaMr+2k0Rg1Iym1xJVTKmR+RzrT8hCKeLtIFPaH3NY3WX2FPy/Tht+f8Xmy9jOprwGZgqHQuoLCU0J7rRUk/rRSfBPniNs/FNOHapdlF9OUbnjWvlAkIpl5RdxtdrEsoWgN+t818DroCTP7Zg0F8RVQGIkDnhBaL9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnFDrz6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PebdmVVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnFDrz6d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PebdmVVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775049576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyW12uBXRpbNCpKffg0iXnMuUrdM+MfpJppnsHO2xnY=;
	b=KnFDrz6duhNyc2h770tthcRVuE6XDE0GlzXSDqLLQt5/Cuk3sFfUqpQGiD52rm/4Kc5WYH
	lLA4gM9QaJ4ax42twsRjMWIWMivbpuSYN7h/Z0V3lWtzXuxqtVeuV/1FqBOpkAQA8PwBXD
	pLzLFfw2IWe6CYa4fAg0hGqW+xw9Lzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-33QRnAJ_NByl3NNtkupQJQ-1; Wed, 01 Apr 2026 09:19:35 -0400
X-MC-Unique: 33QRnAJ_NByl3NNtkupQJQ-1
X-Mimecast-MFC-AGG-ID: 33QRnAJ_NByl3NNtkupQJQ_1775049574
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853466655dso49515155e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775049574; x=1775654374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyW12uBXRpbNCpKffg0iXnMuUrdM+MfpJppnsHO2xnY=;
        b=PebdmVVE4cdNJ/jzEPt34+I9zC//EA29Ttu+HT3YKvXH9GNOER/JDErPV5JL5JwfH+
         XjxhP5qORrHDRxegzxqNo0V2rG+5N2I05DzDcdTwbLWkDYxfBmxvXbsymicLRt3PCI1e
         cvf9/2RvGPu97LIl5+WuxYxcPnFXiSrk01Z48FcFLYWu1gU99GGzY/6xSnka3Xz1UbJ4
         /64qtZkRd0806ffNceiW8ar0y1MpltkCdkdUJQpOhMaAy2JoarSXKQ6dkJN+E0dCZ9Ir
         qxDF+ubEUcsFQ0q9+HlyVT7gQwu3aZL8i85lF9cXRWq+JqGEuuRe1F+LSNMCMlaawEc6
         o9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049574; x=1775654374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyW12uBXRpbNCpKffg0iXnMuUrdM+MfpJppnsHO2xnY=;
        b=HfqZ0bgbLQjAgPwVT6EsSWra6wuJLVmwozrELuhvqfQ06VvsEUNM0R0/z/7vb0rUUm
         u9hwQVLSoZm94KPsoN5gjMbSaMF9zhmReY5bqp6sfDuT8AI3mByNCMDx4n/8re5s85gj
         GWYu5Uligv3c3uFv5GRZlZr/WkikGcJ1IsXX02QP3u9ZZXs5C8pfJ77URVqLToycV2ZT
         nIDRGVxunfAe9N1ALq+AhjllgM+ZO/lqZp3bFiddSQTl0vMfmKsfKftPDn6d0qHJh5tu
         P4N/x/U7ZZuLf56S+sV3a415NU9BCIfjsvV5Vw3nh11kCrHJsP4DIJJ6LwLE0i6lGS0a
         tRNg==
X-Forwarded-Encrypted: i=1; AJvYcCXyHljMGmZm6ir8JO16A0xD3kz8W4PVTdBk9+0DHIFJt41y7t7iGRjxIsrIabLGYWm2F0G5OmOc3hrOmDO0@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmyyLlcmMmgpMohR7eIkkO9qVJdRprB3gj+/+NNmQLRg2TtTc
	z/QMjS5xZHFM424wCafxLfzGGiUfAngT13H6VYPJwHe0OChXv9UFl+m3XKSxCBmNWLoOHFSnmyb
	VjOBy3xrD61Qx287DGwnZ+e4Uiq/pJYQHsiL6aUiN9oyzmBRD+Sv0CwfLOZqq4Hnx8Q==
X-Gm-Gg: ATEYQzy3Ozr1np3hcErVWnUm5WiWtVx02DsztsROH0cEfipIm+4BJADHDp8wm4ohAsS
	2veKfL6AgiSu/IHB7jWqbidmAPZUafW/FXct61y5+UmiM+2GXKb/wdXbHzsTzOrpsAkuIViYmvj
	sTTYV/R8DtTicFnFlhtCFVThdN99mbzCBWWSaSpuxlEowFqhwEglsIRCuae7ucXkBDj/qyY9MeL
	7x2epO9LHSwDZT5WKwoXo92gghLr/pM6djX7F0syUk6dL8XFuNDQN8bbDAPAUgMK9OD9ckSqUPs
	+mrWUy052geGzfEbCuasGfuuLWwOQR7kUwj1xWiP7S6iiGixOJZMH66JFlb/6sR8p0H0fXN73Z4
	1wfWMdxVa7Mz/+A==
X-Received: by 2002:a05:600d:18:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-4888356847amr45594775e9.5.1775049574202;
        Wed, 01 Apr 2026 06:19:34 -0700 (PDT)
X-Received: by 2002:a05:600d:18:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-4888356847amr45594115e9.5.1775049573591;
        Wed, 01 Apr 2026 06:19:33 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc52b2sm43924305e9.12.2026.04.01.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:19:33 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:19:31 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 21/22] xfs: add fsverity traces
Message-ID: <oxglumin3yplbpc647rudg6vqptkcfatf5mayzqdjcowfx7q23@p3flnabfpd4g>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-22-aalbersh@kernel.org>
 <20260401063146.GD24459@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401063146.GD24459@lst.de>

On 2026-04-01 08:31:46, Christoph Hellwig wrote:
> Wouldn't most of these trace points make more sense in the core
> fsverity code before calling into the file system?
> 
> Otherwise they look good to me.
> 

oh the _file_corrupt one seems to be not used anymore with new
fserror interface

The _read/_write ones were pretty handy for debugging issues when
block size < page size when XFS read block, so, fsverity request a single page but
filesystem fetched more blocks, but with the current implementation
it's not relevant anymore

The only one which still make sense is get_descriptor, which
probably could be core fsverity one

I will drop this patch, this doesn't seem to worth it for single
trace point

-- 
- Andrey 

