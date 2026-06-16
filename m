Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD827332EC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613378; cv=none; b=WS1BUKRoKNvVHgwG4lgscEJNUACC01ck7sbvH+yBbFApq4r9wm95gTFmmIN7Rx6YjURUnKO1Krmm9f8E0Vw0HvpXOYUf1agSI5b1ZzqGV1tMeIo7e7UFRKbIgwTJLlK9NYfNeFDJw2tyyZs3nCOWRk1vjYW13QYloLoeuAWf70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613378; c=relaxed/simple;
	bh=We5ZGXz91oTGJ0dJSujyq11OFk6rNuSPRZXQZ0H5xKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxdVfG3y4gNwnolFfbGEKWyccPhhJ6tF4/diEh7ezSwcqVZev0MxBZMYdTtAvwnJYi8sVE6/szafwQPK7bwhrGeBOWj2/q0KOTBr+Bwy6VjWtn4kkDl9yQAMc/o0RbVZ+PYNVqFKZ3WvLc7I2TCfDnlL5hrInoUcRqF9K85AmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfJoj4dQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jcmzkd1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfJoj4dQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jcmzkd1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
	b=SfJoj4dQYvwISAdUPm3V4wMsLDeIU21Ib/9hBr3ffmiVJLGxG4OuMewjf2G0/IFDWagiIC
	hWrOp0rDeyi8zXdb/uP8GL5fAFXNinrz8IcMyb6Sijh7KAR2LjsdIzqL7pMAGl26IPJ/nX
	QlnD1nHDQ1ylUXB8BcyHoFgpDWeEOSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-7KmuYWGiMcq4uB4_6zgfXw-1; Tue, 16 Jun 2026 08:36:14 -0400
X-MC-Unique: 7KmuYWGiMcq4uB4_6zgfXw-1
X-Mimecast-MFC-AGG-ID: 7KmuYWGiMcq4uB4_6zgfXw_1781613374
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490afe64f26so20827055e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781613373; x=1782218173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=jcmzkd1U8AZO+33GkNqsb/EQkTiGu5fMKNKLIrbA4p1qV0S8vaiGRy/nExL8CR0fOc
         egHCFb3rXStBZffCohHs7+5yjVH8MFGu4qnF6tL3ya+lOl3zwwxhhVdiQayHu/DTrAaH
         EnLxd9/3ev8McLB9rRF82/NtpZlLTY2UYrxrn2Gx6k42obGFEZMS0Fye8B9GYusCGRl4
         hT4lKawPTG5386E7aC5eS9EwJ1rGTgqiofFafmTipl6INfLiE2INXT2SlvJmxXpahiqk
         BPXB21vA7ggGV1C6/gIsWklWWkF+RZHJ83lulVj/tc6X8005OwF+k35QPg9aTaxEcmyW
         WZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613373; x=1782218173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=K0oaYFUwElL6tHcxEAnPW1uxsVKA0/KbQBpW991ACuk/Du00H8WSe5ES03+aj0mMCg
         7xs7WqNPCa8Tfcd66NcctzQhCoqvX99o/vW5/EXauYd85gBrXxCV0E/T0LSmHcYzBMwo
         JSUwFycdU2bcacb5Oda2PV4SfqmmVWEilBDfg9Xz3ou9KOYTtht9ED+vgVnKPFD6do+N
         eMY5rNRYy85xiorisFk+T6cA3+NTTa2YQYR7sFUqR/2nudl1uraU99D1YVLdGZ1K7jba
         LBK+I4v+PYaXiNPGGhspdHoqO/R0cIBIxzZgpzfSxrHStEo+Ihf4yXoSepsfkM+9L/7t
         whbw==
X-Forwarded-Encrypted: i=1; AFNElJ/jXNPoxXp7apoyb6mUYBY7H8wR0R/ujqpItMMU0qklEEqSELq+yOLrlovj5iUnMm54hZZchoNATsEp4CQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1x1GIP9aGC4P0+UIjKWySFhRdFlkAMTigZzgYPujRxJUDq44
	3dNhfIQfqOgnie/UZdtkERybfMvaXwlWCx37BnhpgHazYAkaIofp4PnxaUU9O/AfuOyKN7CfCMq
	USIcVTaRqcIP1zoxg1zMofmFn6rUfgA01ohIEvMAxgsI/3MqPtBZgJXO7fHfGhyGHvlk=
X-Gm-Gg: Acq92OE+TsHqeVhRTVJau1MXfJxKyISYLZfo+TnDBqGA6fU32OpH84wNwefSC+7XR7k
	tXmQ2Bt2v2DDGIXoOWDxAKC84fv1cHgI2ookdVstWepyS/O+6w3cDdIELHL+MUlBbtGflemLmuD
	8CllARqADTcJC6RDSnGGCl9XUR9C+BT7NSlWohboTX/HWKIFxf8Bjra74ScsPQT58eSb7X2rLh5
	fwHYUS9JBkJ1bIhyRoDjf0WRkiAXgAW7erF/GG8OKVbT99TUKA7FzzcK+4aOf3n8OTOjqR1HDpG
	CBJUAM6S+59D/Itk7L1lVNADm4A3k7IADUbia7AsQ9OsIv9ViLu4FBbF1sBaV7fS3NRsRRuvWb1
	08s9CGqd9d8+5HarAHgfskZE9GAFvz4LGIRXkJALxjhHtss+bk2jKlCmZMBA55bVEjNRgc8U=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52204405e9.3.1781613372056;
        Tue, 16 Jun 2026 05:36:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52200315e9.3.1781613368029;
        Tue, 16 Jun 2026 05:36:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm53027215e9.9.2026.06.16.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:35:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Message-ID: <ajFDIHuKC31pumnY@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-2-tavip@google.com>

On Sat, Jun 13, 2026 at 12:09:52AM +0000, Octavian Purdila wrote:
>Export iov_iter_restore so that it can be used by modules.
>
>This is needed by the virtio vsock transport (which can be built as a
>module) to restore the msg_iter state when transmission fails.
>
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> lib/iov_iter.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>index 243662af1af73..067e745f9ef53 100644
>--- a/lib/iov_iter.c
>+++ b/lib/iov_iter.c
>@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> 		i->__iov -= state->nr_segs - i->nr_segs;
> 	i->nr_segs = state->nr_segs;
> }
>+EXPORT_SYMBOL(iov_iter_restore);
>
> /*
>  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
>-- 
>2.54.0.1136.gdb2ca164c4-goog
>

