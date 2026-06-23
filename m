Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB83CD8D4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207766; cv=none; b=d2MPTc8sF7BG6TiK43vinMhAS+EK/1/WcDYHZ33qWGWQxyldJF7eOXOOQsLR1zDm646BhqNUj95oMcwwKqzpljCZBmNm1CbjnTraSJ/NNHQqDxr2jXPmfMhonS9ePzt9hlUiY09edj7fc62q3tgxNAmX5gConcNqcTgYVwxbrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207766; c=relaxed/simple;
	bh=B8aiSRXgNzNgIcTsqvlM+jiX5YYMrahhBOPApOswCwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUdWYfNaGBLL0/SIr0DOlh40/GrGbCD60d3PSmAS61DdzyJRPqkwf0kUWlI0Q3M8g3Ts32vZfSLuttuLu3Q4gUehugpuTZCp7cKmAP5OsfkDTtMsMv9g3+ncI2uJtNZ7Jws/rlJ7EApC5ptK3gWzvLj9D2qtVH+DM5eMfu5D7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGHMw40j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGHMw40j"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49249072f03so16358775e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207763; x=1782812563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=YGHMw40j4hj6TfkUnHCRzMeFQvWey1PFjYwC9WxoimkjXSyYUToNiCRRG3XizMJyVX
         R4ai/ZAAtQDz4f0JWVvcuKQwNrd5Txlkb06UI4Ip+E8l4eB26vkuxuFn6OwMwOYXB61O
         kCwX0AeABcbrjheN/oka2jvup/pAupU+T8RVm3c6KdjPN3Cw8ivsZFWQa+3luBAcmyHJ
         J/ccU6I5B7wsmabeYLLM2iBu+F6a7H0unq3OEVcxPr0XIQHv8J7AknumxKhEAFyiYQs6
         +mqpx2Bs3bCk6AORQ3O0om6vm75JrMhz6Uyb5FEYTnIsi88xM/cBebtwCOEISqrxBiUn
         GWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207763; x=1782812563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=nU0G7oetb/ERgJ5HXyDjmcsFVVG7Vc4clf3FXI81plptIYR3EUFXE/CVxlRXz4AGCy
         VQJyBjGdXa3arl2RKobUiUrf3bLRiyuHAFoCe6p1ztxDACZp7BL0ayVeYwQdsvoFLJa0
         ss2w1lZoylWgctAyRwy0po6IxKHHMZYo8He1ft5V+kqmJH93JwF8Z0KDu3Vl9zAIOboI
         3S4WIwsLyCYbIMeELqtYtKFIVMAR3jfD4Sn+PCL7Ot5NQGWb+s3hUNsuM+MxKMUdFfBn
         trpTTgkfthLQPO+f4xNqlDYTtRexzSLIAkX62mxTsYrSFICOn4B3rRZt3ddKYxcaFdsz
         It3g==
X-Forwarded-Encrypted: i=1; AFNElJ/Q7Y7E7e07+TphPyVbsyPV4GW77itII15wCglWnL5bSwrrZ1IsUOfXZjhkCBk4w1HsuLLiFbm0f+H/YOvA@vger.kernel.org
X-Gm-Message-State: AOJu0YxY28cvodOeJtRo02KwTES+ogil0OxcD7QGDZndXbxwIrsdDRqp
	W9RCdGg1zn136NOKudUYqqw2gwxyIle1jPRmp5PUkRWgGq0A7WG1OfWA
X-Gm-Gg: AfdE7clZ5Ygwp/o/yJTHNlOybdwn7E5gHd6XoR+PA5WSeXRdjjN+3viqiHUSjXwum8R
	Z9QXST79i3y+iVCkD42hBRIUtChvDxambQMULjFvXbPwPHjITKcl4K79sFTu35qhsSzdHlaXLs9
	IeA9gzs0ZSoDn4LHfDCOhICqT3fYUSqd7LdTGYz3z+rfPgebToejivevRrgz1+meB8D12J5IaRk
	+SWb9NCEhUgA+z9WfVQWyrmP9s3dTdz/8cPV1kry6JDv9YFsDajUi7kfVZaH3Cz9pALtxHCmtWn
	0yx+rhJdUXPCPpZygBcKsl1O9HICwsU0PnqhaAYjs+K0Xj4CBFk8ZuivwKVcqI0TFj4OJu7wXSj
	NzKe/6sydPik+NY/w/OxrTJ+nvOr12m6ibvrtyt40GZAAy1mreQy4Eotsx4//EOq1timsJMJTRF
	p2mUozbruV
X-Received: by 2002:a05:600c:8b8a:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4925b389b83mr30093645e9.4.1782207762970;
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49249455302sm280248525e9.15.2026.06.23.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 23 Jun 2026 12:42:11 +0300
Message-ID: <20260623094211.1080873-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
References: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrei Vagin <avagin@gmail.com>:
> Actually, this change introduces a performance and functional
> regression for CRIU.
> 
> Here is a brief overview of how CRIU currently dumps memory pages:
> 
> CRIU injects a parasite code blob into the target process's address
> space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
> pin physical pages directly inside a pipe without copying them. The main
> CRIU process then takes over from outside the target context, calling
> splice() on the other end of the pipe to stream the data directly into
> checkpoint image files or a remote network socket.
> 
> I ran a simple test that creates an anonymous mapping and touches every
> page within it:
> Without this patch, CRIU takes 9 seconds to dump the test process.
> With this patch, It takes 18 seconds...
> 
> Plus, it obviously introduces some memory overhead.
> 
> If these changes are merged, we will need to completely rework the
> memory dumping mechanism in CRIU. Using vmsplice() in this proposed form
> no longer makes any sense for our architecture...

I just have read some docs for CRIU. I found this statement:

> #### Why `splice` is Better:
> *   **Consistency via COW**: The `SPLICE_F_GIFT` flag ensures that if the process modifies a "gifted" page after resuming, the kernel performs a **Copy-on-Write (COW)**. The pipe buffer > continues to hold the *original* version of the page as it existed at the moment of the `vmsplice()` call, ensuring a perfectly consistent snapshot of that page.

This is wrong (with released kernels). I confirmed this by testing this on my current kernel (6.12.90).

See the code in the end of this message.

If you actually rely on mentioned consistency, then, it seems, CRIU is broken.

So, in fact, my patch actually brings consistency to CRIU. :)

-- 
Askar Safin




#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <errno.h>

int
main (void)
{
    int p[2];
    if (pipe (p) != 0)
        abort ();
    char buf[1] = {'a'};
    struct iovec iov[] = {
        {
            .iov_base = buf,
            .iov_len = 1,
        }
    };
    // I pass "SPLICE_F_NONBLOCK | SPLICE_F_GIFT" here, because this is what criu passes
    if (vmsplice (p[1], iov, 1, SPLICE_F_NONBLOCK | SPLICE_F_GIFT) != 1)
        abort ();
    if (close (p[1]) != 0)
        abort ();
    buf[0] = 'b';
    char buf2[1];
    if (read (p[0], buf2, 1) != 1)
        abort ();
    printf ("[%c]\n", buf2[0]); // Prints "b" as opposed to "a" on Linux 6.12.90
    return 0;
}
