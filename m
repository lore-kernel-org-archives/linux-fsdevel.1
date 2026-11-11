Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415458;
	b=NhOaOs4NOl+IPm+N+t61FmWDMyYCtW8MvpJcjxIcbtILe1TTvUd5dBlPh25ELAY69Ug5
	 4/LQvbhn44rkGfZ3Y24OUtvbCIeny2WfJXGl3IHHMgxf86IPLI5HJamDoP6bhmQMr9fWu
	 2gQKt1WbC2Un6TBXxoE7EMMgofyLMOBCCl26QDacG0DD8CpxZk7ISB/uKT/m0zpiNAQOY
	 8uBjFTUXWzFo93GmQ7Ajw3LrH0FPuLt5I7AdR7m7DxihBTPEPyUp7mwxHqBCO9CeOdKOp
	 wd8ZldDsFfij/UKz9t/FYNehK+kDAA5Cm2Y/nHxmYyso/Htav6KpztYgf8iteE1iIUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
	b=x+awsCURupn20IaDQkdHQG559pBSZEJsoM/8FAbhXrG7hDAMSlCb8apaE6WGJ0wxoY2g
	 t/tYqiDVDmnsRBlGYDWY27bT2DgFVCWfmmpxQCo06SPqgzLAP4pT186L8qX/67HfSox7D
	 MemR0BP+Tw1HCM0fE4N5oS4pFpm3hkcaHPlps22rYjLF+Gt+gd/m1y/CxNqwKoEb8rqCW
	 5guTEeJGDkfUR96gjZqij1/2ShJK1ZyBbOfBK0Qa3zIZN58Ng25wo3XRSZexUODpt7uOy
	 i/K3nEt7pTKNfAM+z/dgC4FlUMuN/Qhp/cUvoU6ckoI6t9c4YxNraKaXuQPEBj/Mx8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RlnO6Plk;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7600606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 16:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7600606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RlnO6Plk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdd89d84521so3714a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 08:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794415457; x=1795020257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=RlnO6Plk7dvbSysvOB/ID3k5DcKiC4/56cqtP22XDbI+b+yOaZOevB/mi0166VHoDE
         nmMdxqiq9SvORfklvVLg1CJ1UEOt0M7T2bJTudVoPMjMS/yR+3MSHVBRu+FwIAW/VJsb
         PKaE3E/tj648mENds/a775P4W8FGyNt0it5aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415457; x=1795020257;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=f9LndSPZi6WLI5IVohOobGb4rRCwvmcqbaMOM2UQ/HTkHBRMj6wWED0FwMBZGP5jUW
         vhKijeFPGebH2XJEs2E2uCjgr/LVDiqVXSW/7ssnalg/zc99JYlhgK8eodEc4MQRmA/a
         keIZiyx4z2oWNcVOYhGH02lDL+yAtc9uzsT0d3/uHTVmArhSk9wLXC9CWDI2YSmqcJay
         PPltzdcxWCG/kpekM9uOB0cCievOu7cTOvtH0KJAlLFmyr8VM4dbVnzDuN88HZFB7TBx
         g7Z/PZpECqpTsf727vEegpU7gF++75NRJ3eLFBryO9p3NObB5KU9gjfwG7fml6aF29Hz
         mz3A==
X-Forwarded-Encrypted: i=1; AL+hErGgkE6XjtvZKGkHCch4xMyELj5iYJ6vIAm1H86UeBasHBazzjJhUPWqNIB4Hg0gbBFOODBzoS2LfSc+IekR@vger.kernel.org
X-Gm-Message-State: APuU4Z/hV3EGsIMSfKXp94nlmKNvDCBRlZAh5yWYjdV0FadOfqtQwfTK
	dHL3spJag60wHyOWO03iG2yL8BLtaVo8ewqhE62rjNyOL9ikcZ+0CWZlWvGAE/WDXnaj96YKOzy
	Nw4vW
X-Gm-Gg: AYBFou0AvDt+5wzSfK4JwLDwCbd5xA+KeYHhJJL2dOFiGKD0x4XdbF3xs3bnCatWRJ0
	IMhBaiFKU9XOkEWZDFsTH/k25k+VdNkFE/0ZxKFmVNyKirGmQsyGZx8HHvT27aE+ldMZ/kdF+LO
	I3c60K+tFxIgfec+Ybby77EYmfxbpv9rRF5bQBUBRzHFCtHTMoN3CGGmh01rNlMQ1ax03h9Ld4F
	/fiTGbuoQdUnwY9H8YAoRWAPkJZqKZ99HIB6r4wt0TC92veO4lOTel5hzjC7SJdYHO9F0sxR9fS
	dra5yAjIHFmuahAR8X6WE3eos3CUWuLsxhjiuEZKeut8F+NHcMhjaCQzXzjK9Hh3rHfzeU6+t8K
	9gftOrlffsTWDGRbag1xyFOcjqDHXBzB4V/uoSlbQY+UUxQlJfOhNyQGjXPhyQdggqZS+3/9iyB
	2SQLkEcvyxsuYABSq8K2tmYYi7JrvVhXLNpS5WiZOeQPkse5qnoSaL3nojvxnXlzkFEbzRGcvpm
	Sxf9X0HC1pWEuV7vq7kWXO5vZE3fR7ew/vDbbialjUgXhZCPRfA7To4QDZlGcdwAtZlTp0iXzwF
	jCEVRXYRvit9Mjsq+7lsaBPZb3VsNmrxOTlhLbI0Xb59O9fI9IcwevslIBR90YM+9LSS4waufiF
	BLjQ=
X-Received: by 2002:a17:90b:540f:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b197caa480mr22240a91.21.1794415457134;
        Wed, 11 Nov 2026 08:44:17 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c502bfsm66386a91.8.2026.11.11.08.44.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 08:44:16 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso16071a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 08:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE9FFmBsoNbJTqsxrSQezvw5sdOGk80G1LQlBfIISh6rl0uMt5q56JU9I2ZIichQbMKHE7DQ/w+l9ADan4P@vger.kernel.org
X-Received: by 2002:a17:90b:1d45:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3b197c817dbmr35589a91.7.1794415456305; Wed, 11 Nov 2026
 08:44:16 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
In-Reply-To: <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 08:43:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
X-Gm-Features: AclHuK9b6hltBFcCGqxpbtG8UmrJwldogvwXrVDW7-YQ5_XK3IWVlpv59flts7k
Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 05:42, Christian Brauner <brauner@kernel.org> wrote:
>
> So the fix below is what we've done before for pipes and I think it's
> the right thing to do here too. I put the following on vfs.fixes:

Please no.

> -       src = kmap_local_page(buf->page);
> -       memcpy(page_address(page) + offset, src + buf->offset, len);
> -       kunmap_local(src);

This boils down to one memcpy.

HIGHMEM is dead. Nobody sane uses it. It *will* go away. It's already
effectively never ever used.

There are some broken 32-bit arm setups that use it, and legacy museum
32-bit x86.

Don't make one memcpy() that can be inlined become this garbage:

> +       /* The buffer can span several pages of a compound page. */
> +       kv.iov_base = page_address(page) + offset;
> +       kv.iov_len = len;
> +       iov_iter_kvec(&to, ITER_DEST, &kv, 1, len);
> +       if (copy_page_to_iter(buf->page, buf->offset, len, &to) != len) {
> +               __free_page(page);
> +               return -EFAULT;
> +       }

just because of broken shit that nobody has ever complained about or ever hit.

              Linus
