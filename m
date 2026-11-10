Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343259;
	b=hyxeBscO1Qw+Ag8608oAYMCYgJBcbOmTu67R/8ExOyOfYYEjtebdAwhFFAO+GAiorav7
	 U9cs+qxbXGF9bva3QMluhWehrEmE1vqNgIZmLd4fHk2EGgkMhrMzPCzVje+g23swf5L+l
	 S0daS1H4KVUa9+hSG+1a+FFhBOBPmw4cpzMpxN7dtzqmBNqWhDcogCMXV0HAjpJM4OjSt
	 bL4s370P7iggqHcD1v1QuRHjk2mDhekwCG3TQuvfJOCzRhey7B0m5iiDaRmeVbOksMPUO
	 PtPl5+DDE4zrVYFvDTMZUinwp6MA8uNy6gJeplN6a0M7Rqa7w+cVQ9KJrKz1Onu7MjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z2r/5TPOj6xlBCwBMvS5lY/uHLFbDokwBpHEPZnfXAg=;
	b=3EUPNQkucU6eJ7iBA2tg9Mlbt+397QFtj5/3jHFsRu3/6UOnpYgmTF8oN6m8y0pYToer
	 wHtOKjEUjew+9RssopN3zRqmP0ewZsgH4kAFR8avmuA4F59d0iOO8xbRN7WnxoKkgdOdE
	 oThEgVhzNkZ8MFB2o7GjO/XQAxFrU6CIOAK3jVl4oRaK0NW4/ERdV4OWu+yD+VyFfWvLO
	 /trVGVA2bvKPp5WePhcboiJqXUYMwX8WkJOOEvQMtxsgdnt2vCAAYJJnFUjIlbQ4SljaQ
	 pg6N8I3NZLZLZa2MIpxSRVhZVa/oPHRO8dY4FuGfwu+d/aUnBhXSr0CReOXJSMS8jUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDNonfYx;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF7606A336
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 20:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84EF7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDNonfYx
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-372bdb942dbso3212177eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 12:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343259; x=1794948059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2r/5TPOj6xlBCwBMvS5lY/uHLFbDokwBpHEPZnfXAg=;
        b=oDNonfYxV3uPERsEfmZktK78O1OYzkH6GfwFoa6Q28trPcc5e7NsrchzQxsI28BIXa
         XZlW/dSuycFbDvY+eqLdOolB8u2hU3zOxzX87h59Gz8ZeVf3c+5gd5vfnDaPjET+HJwj
         ydlIJb/nNsSUrt19d1qWpP+mDGLRurZiCHegGrgLD3IS2n+nKIEP30pd0s3XkAy8lxbj
         ikf41kzJAtRqigyeQtGfofjWZpx9aadU30zFneLo/LvweW8/NjzQBjoN1xJHGKOQDfeW
         dNY/vPhznM7JEWkRoXMDRFJljKljRX4zgA9SP6tzX0NfGuuC+pf4wAzDMANKXxHtzADI
         I06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343259; x=1794948059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2r/5TPOj6xlBCwBMvS5lY/uHLFbDokwBpHEPZnfXAg=;
        b=clQ09vI/EfYz7aZ1VgTtPrFSSlPxC/ncAuCydTH3Posg/OINNtqQug3iWTNbhiTJiN
         sDi44M9w8ilKzVu9lI1oP1ypWQS87urd1TJiXec8+wwCNiE6YEfCKEZ4YvgAeioCRVHf
         DBRzcMmnQ7ClIHyrl7Kh82KGlv2LgzIl9TjCRirBeJeGDl5OetE8DFU3aWHWWkm1M+r5
         0VO6ZtvwcVyhlSeXIsBmIO8rFYJcXkdjuInBDwFpEglZ5sc52I178SXwK6FH3w9O5MAN
         Xf0Q7AzvNlPUsKGtZfLRSDN1UemZ5enNNQh8+jBKl/gI6eIhc5HdPm89MkAwLR2z/AAB
         cFRg==
X-Forwarded-Encrypted: i=1; AL+hErHf09FLNIKNiiXD8IfsaD7fN26kntQa3isIVqzebKoUs+zsGAPJwc998SLRVJVVsOHkwL9ON25QHLX+dr1+@vger.kernel.org
X-Gm-Message-State: APuU4Z+2uL0eOQpL6HH1oUNKK28sPynpLzxk0ET0DMxLezrJNIjT/O20
	CyxIUHkBRbOP8p9XL3VGO1xKkZMVD2C47sLrfQoYHKph1IT+eFwjskMe
X-Gm-Gg: AYBFou0kiy/rE7k7A1S6IKbS9nVwcm05gyShSD32FRM/nherY2V34D1+ju/cB/GI/Pn
	md64oRvf4nDzhbamvRnSShsrWbnUuuGquoTFAib6LG2OdLkxR0p56V9u4htfKWi0xapWliBP8eo
	ks0X8+Q+oWDZ7MXRDjquMA+CToX0hlQwvsrLf496zEdSangCkAyaTH28ivfr984ZcBJfJ8+jgBj
	Cac5tIGQWOeROYkXvK5VWfDreECnmL1Nw3yQ38nlcbqUdeldzs0yy/OVPeshyjjsjrpLTKNzpU1
	gcGxQd1KnOuqFR+TFKc+NqV0XW2n8pxE0SYcyYuG8SGPWXgo+mWFA1x9oSrS6u9jYeg6XsPKYM6
	J5JJDKT0k7XHLc8r1/j/kOgUsT5YqYA0G1tMgB/IGADBbXxDoNYs9am0+HsRH73UaCGSjNEQYWC
	g1OpyhPKJjPPJgXcHIOqgePGxPqqfjK3+8FVqLRrOgAr6JRGGUDRPMwc/YPU2Z9wuBnon2CD3mY
	7LlRxwKUsR73J8bZ05itwwmGX5y1IoO8l6PrF14O6KOOCPgij7XJRee9i0dQPaLTS+AUB5Em8HR
	aoAMjLAQfCtZbG1anzKOxM9gVHeczRylJEUJcmcGmsjR6w6ebpRIoA+CmDVZ3CylrQ==
X-Received: by 2002:a05:693c:600a:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-37686d3278amr499900eec.33.1794343258427;
        Tue, 10 Nov 2026 12:40:58 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.98.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm17473286eec.18.2026.11.10.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:40:57 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	fujunjie1@qq.com,
	vishal.moola@gmail.com,
	roman.gushchin@linux.dev,
	tracekotae@gmail.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/filemap: restart mmap readahead on sequential faults after many misses
Date: Tue, 10 Nov 2026 20:40:35 +0000
Message-ID: <20261110204035.184968-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-206717@kernel.org>
References: <20261109091444.128521-1-gopalmalaviya53@gmail.com> <sashiko-outbox-206717@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 09:15:49AM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] mm/filemap: do_sync_mmap_readahead() recovery fails when
>   min_order > 0
> - [Medium] mm/filemap: do_sync_mmap_readahead() ignores VM_RAND_READ and
>   !ra_pages
> - [Low] mm/filemap: prev_pos == -1 wraps to match pgoff 0 on 32-bit in
>   mmap ra

Thanks, all three are right. On XFS with 16 KiB blocks the reproducer
still takes 4096 major faults with this patch, and on a MADV_HUGEPAGE
mapping with MADV_RANDOM it starts readahead anyway. I am testing a v2
that handles both and the 32-bit case, and will send it once the tests
are done.

The page_cache_ra_order() underflow is pre-existing; I will look at it
separately.
