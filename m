Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793735860;
	b=V2N6UAH2O0ZBg7lp4KMrtkUufHAtQM1vj2wVW6WwbUYiORcob0N4Tcez0fHex2WuJ/yM
	 Y06mceWI3QNwHxdpTav1KPqytWhiD/Su8Z5R9/lG1fBldB6VtT1+uCW0wbHj3Gdc5nTzL
	 3t2P6Pkzc7vWoHmK5HMmTN601gMQ4GF69GATbaGIptrLfvFQrrt+pLI3xQ2+KCvc4TTT7
	 bII1hn6p2Bk6A53XYZUfAIFzmFlRdhFuMZKNi0lmV3Y2nz3JR6+RbsAtPByP1LKYadtST
	 gkz8ZNVJMAMnWeQ5WTVJvlLyAaJcdfzpZbIAPS9hQJ5Qr+qQ1L3HrtPoLsswxVBUa3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+KvUAdd82A2FrfHcfd34zVZTNXZ/zNcTHH3fL0iHdhE=;
	b=CK+vjRw5ufqFaPR/mNCDkhOri3E072fkkl/3D54XAYv4EdRmQnUUXSdp+L5WN+YhZAro
	 HRPL47Z+PfsynyNEroJqsrfeOtMUq0UBLTURD7jw9KkiPbnnx8cmua0sAhUC8BFQeRGpD
	 CBahXHyuUDI6kTn6UbTolJFwymwkN1CqAP3vk2zeDNiKAjVKp5Rc0C1qlchr/BwCADcV7
	 uX5Z+qucrNrqnr5s+2aPW6xnM0jDdrEpAvhNgYoX8z9yJ3iom2l1xPxy8hpzw+Vu7x5WW
	 gqdekbNlBahWm3qKGzikCgOxi93m5LVLfN+ie1yHE5tyEQDdrHAw4n/Zh85ttg89j5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kp77IwLk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80325606A329
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 19:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80325606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kp77IwLk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so34673435e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 11:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793735859; cv=none;
        d=google.com; s=arc-20260327;
        b=JsE6WXYfJt0s2jEW9pxI7Fh3Y9/gbxlC568N0e0gBfCIWbq7wbrZF4KbpGddMDJSfl
         tVhk7wet2swCCeQ/GR1e6/J+dH9zUreTx48Fv/gdOAp8iG1TwunvmVXnue7lHMq3St8I
         J64Zi9iGeiZlyGBzHSXSkmJTk5NkwzYmQhTFGnWk5MFXjAIfSZ9WHcLziepWAVYsc/S8
         b5HAHfQIbwGKgqzcAC9LVN2wQHOPn8P9g3UIc2CoOAzArv4WPWFgmQj7vJm8x5DVhzOe
         6L9m68734OlAzBHBS3Z0jXlx/C4qI+kz5YhlW8u7GCQP1VpeIe1VPx+5L1vDcdK+IsN2
         LMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KvUAdd82A2FrfHcfd34zVZTNXZ/zNcTHH3fL0iHdhE=;
        fh=ihWZfyEVnnWba53xOTho3zXdoxDbki3nnC6Wgn178Xo=;
        b=HfM1IUznXNliyvmCpKxAlXrWPPURrtVcjum+aPXpb7jUDBS5PO1+MvNs8ooLjpxg6V
         1g1XngP4cqR8wrK57mA25VKbsK58qv5AJ2FzYfma8fqAyqjRyZTIg4zLdzoSPasOQf/5
         3uTfO36hy4r3TUMpxgFe4m1LEHyhUj6gIN174DG9ifWmLzNf8QU7JyJ5TBjP6ehXL4Z5
         aHtu/fxaAsVE8WvkwkAPfxFt8rthZEtTIQmlaRIj3nK6UJJGX+0LYSKUQJFo7PyV3WX4
         k4gfpvWac3B+JUYHPpJnZQqhFYx0nWVZgYYa38kuNh/tfQgAFa7XCl3nreaXqkweQ8my
         KX0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793735859; x=1794340659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KvUAdd82A2FrfHcfd34zVZTNXZ/zNcTHH3fL0iHdhE=;
        b=kp77IwLkVV1TMxlTLYbUW8B4pQGw8p2W6+pLr302qojpzyD2CWp0FN0tVCAq7pNQ1h
         zhRB418jU+jC51gvZSL3GIflLJDJMP43hsQqlLbA86UF2feBVmmQyFYOUBGk2Vd6ZlvG
         gJJoDmX/QP/lOE0sO/JvOwK0rS/20EwxBHQfjCARDkrc51cXCiWuuBi8tzIuD1I/CsWD
         dhupRH+ciNA8oBDnbziJGyTZNeNus+3EDNnkCjUzsa6ym2b9Ud7zDEE4Ff20HPoOdD+m
         AxxYWZLVaJ+sZcgk+CteJMfOIDkybvQdv50QizZbgYDsBWFXdMhRwvGIT6t1vAQLgA2u
         5vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735859; x=1794340659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KvUAdd82A2FrfHcfd34zVZTNXZ/zNcTHH3fL0iHdhE=;
        b=pBHUFhcYBdnojwCgw7ajgnc48gEkc4Jj2K7mSBEGg9VPTju6u8OfdU5OkPaSVcmPvr
         J2AuKmdHv6W5HcC5n3uk7l/EXYN8h/gmQZp3VDZeVtnVUAU9EouhwzpYc0k+o02Q81Kg
         Cb6qhM3EQ7ySSAicKmu4ExCGbREBohqUFDgyf4Az/0maCY5LpjSlLr1R0883Tql+Bm3A
         rOvw/kdjzvydxkwBNhL1Yb3mwdoOKUn8o17xz56Tu4gimsqMfZM01iGPZ8KKywyteH8F
         QmkW7ZSaUByTZzpQE/uOJbqO7nw2bxzC8GgnpqYsQF3fSCMH1Dxooe6coNxmUblJRtBC
         ZAvQ==
X-Forwarded-Encrypted: i=1; AKwUvBywWyfvJggtwhvXcD1P7ozvC8XxAEDvcCEZCHiO7MgqLLe43Srdg+gvNPWgvOg0DX/wyXPPyj68BkV6X4cH@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bxbe4dTneZ8P9dZfvgUSfGWgBJMny7+7Ru3laf0HUSp77H5fx
	V5kfduENe+UKA5lRSzfqBrNepaVyAMYPOygjYTPLBlt7dDh/pWylUlMK/amT6fWZSs6aiDt4HzI
	lGRrfMBxXsQucqV20H8lUGxLR4pXSyZo=
X-Gm-Gg: AYBFou3y6LX3QFmF1HP+BZnA7t3RRVmJ7j3xpURAKFZj8HxwQTEvwdWe5tmOiMIGVWE
	+n1Y6NC8ARB2+aOGco8/aMEdA7vd+YZIbN1haTxH6Us/vDt+u59Q8ll6//DZMYGU88OZ09xdrbT
	BgKQEKE4+uhwbCAbx8kdGdnCEh+tyTrfIOv0UhAQcNHGqOkgQAJoKdcaCHQF66SAtM0lnY/6Ioo
	xTeCv680RRmyQmlQ7R8roH68V4Itv3OYMsE112Ir3UuaC4zh6sU8kGwEXja6tHRog5ERJpj0UvD
	buT/WgNqmP1h39QQS7LZOW5FgeM62+dSOZ1Pg/jxj1BDWRDfNg3kxAaRIMm2Re872Y4oi8ix1yR
	DhcxS3n+i2KETbArj3QOBdi/GaxnSdbavVoYkn88P26/PF+68dypJci1Xh4x+Ln0kOiqVEQDflC
	NcalQjdkk15USnyDkcoQ==
X-Received: by 2002:a05:600c:8b54:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4ac16bc547dmr344461405e9.9.1793735858729; Tue, 03 Nov 2026
 11:57:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031070515.3042848-2-thnkslprpt@gmail.com>
In-Reply-To: <20261031070515.3042848-2-thnkslprpt@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Nov 2026 11:57:25 -0800
X-Gm-Features: AclHuK_JytKkKfU5M6CJRcikf8vCv1-AjVOSiBNPYKxP4EvAaHLb1svGn_IQLNI
Message-ID: <CAJnrk1aJ32nWqoSLYBOhh6zhM51BMk5sCJGpZBOtNGj4A0iRUQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: avoid unnecessary strictlimit
 background wakeups
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 12:05=E2=80=AFAM Avi Weiss <thnkslprpt@gmail.com> w=
rote:
>
> balance_dirty_pages() includes pages under writeback in
> gdtc->wb_dirty when checking the per-wb background threshold for
> strictlimit BDIs. However, wb_over_bg_thresh() only considers
> reclaimable dirty pages when deciding whether to start more
> background writeback.
>
> This can repeatedly wake the background worker even when there are
> too few dirty pages to write. In a 15-second FUSE writeback test,
> background wakeup requests dropped from 2657 to 682 (74% drop),
> while writeback_start events remained nearly unchanged at 99 and 98.
>
> Check wb_over_bg_thresh() before starting background writeback through
> the strictlimit condition. Leave the global background threshold
> check and the wakeup required for dirty throttling unchanged.
>
> Fixes: 0437906841d0 ("mm: start background writeback based on per-wb thre=
shold for strictlimit BDIs")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  mm/page-writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 499a35473e4f..cb0c58715b93 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1826,7 +1826,8 @@ static int balance_dirty_pages(struct bdi_writeback=
 *wb,
>
>                 if (!writeback_in_progress(wb) &&
>                     (nr_dirty > gdtc->bg_thresh ||
> -                    (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)=
))
> +                    (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh =
&&
> +                     wb_over_bg_thresh(wb))))
>                         wb_start_background_writeback(wb);
>

Thanks for the fix. It looks right to me. I think an alternative way
would be to save the wb_reclaimable value computed in
wb_dirty_limits() in struct dirty_throttle_control and just check if
"gdtc->wb_reclaimable > gdtc->wb_bg_thresh" which avoids the extra
wb_over_bg_thresh() calculations (but is slightly less precise for the
memcg case), but I don't think it matters much either way.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne
