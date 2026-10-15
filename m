Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5B488231
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062291; cv=none; b=ej/PDmHHzEZ0n4T3XkjvAAgOtEbiPX2V8bfjhWfXtNRbXzh2jos1/baI8Jh7SZblEKYkBAFurypl8jyDW8/RBSXZhSj0Kf0zJMey6tt42TgQxFYp8kLrBKIkpR+DFRW+k5mnGlWQXwohuPkVfNlqCPoROvydOsitzB8KltugbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062291; c=relaxed/simple;
	bh=NmmZIT/hqLMK7Z70iQPd80UtpD+b1u7UZ75zdFcA3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLdcQ+QPyahcsP4u5PoZSC3d6po692+hVUgZk1OOU5liIJxDQ2kI6ow0Sa1fExU1bl7PLtmyPH7KL+x1Kx5mI5TLUZX3XJWvCCxWtf7V3dQaj2hZUxlWKlDRZKbBb8c+dxyK5dulDQ1295ybBzhloSlOgkbqZGB+i45benX6hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhvRgxeT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhvRgxeT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a061a13884so43020305e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062288; x=1792667088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xXDNqJcNZaQ8TKXGSWpU6zqwH8ZsCn0r4wit+9iMrhw=;
        b=XhvRgxeTRGttmbp16XDcVRLY29FYg17djlfFbbkKuf0QPZGa2v4HgHS65pzKT0ixeS
         at3G+Va9QcXRKQWYHItli4mHaDodiQjr2ojubvcR4iv5ID5mcVwBmmsexWBBw2C2/0Rl
         QYXhvjRe7ODvYCjcUo8IUrHA+gjS7Ld4hq+rjKvJK5LULzOQf21nEWJUBSe4h/56ehj9
         bPRaWlkVOfWx7JUn32r/4coX0U6lotW+LC1+0R+D5XsbMuRA2j5Zte/rs67hxXblzYdt
         QB/N5gWCiimxCh0wRBDdt+BRYBqD9q2CJVRUPWBo9h6RHlK2qxO0cKMP0Am0vgYsAQct
         fFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062288; x=1792667088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXDNqJcNZaQ8TKXGSWpU6zqwH8ZsCn0r4wit+9iMrhw=;
        b=GhAjjTApHxomIuWSwewvt2Q4eZ1yTOYyEG2qQ1I55WCZWKUbJCtU6C8OJymjv5Lve3
         MMCdsLEt4/aXNzhXfQVssqYgIZA8Yvj4dmIuxR8AIXHSuE0v4Skb9vorkTby3HTaPUYw
         vsZTgAPJ2EBvwfA0CMbZ3taAamUZo+G2f8Ot8QhqXriPyCZWmQPvVok7G+/8172BTAu5
         S37fdokCjM8eEjSVd8Te5dvjTJUVmzzkMNAHJh2vJfQ0nN3euFsT6OOG2Xk5RKi3z5KT
         hyTCVHPNno0bove6ygAC+Kq7/2zJ93GnwNofqn/drlAar85SsgZs1k9bB+6XMMU10Fir
         PcCw==
X-Forwarded-Encrypted: i=1; AKwUvBxBqaYn8KAtnAR8AgB+JSOlAWwfHv2I0NqmokO15dbv65QdmCSETM8GoMzW6lBD5pci8CbqRBoRZxSbpUmi@vger.kernel.org
X-Gm-Message-State: AFq9FYIsTEZtSsJw0/6yOtDzdHj372S8giHiobqi6+V1Mq762m8seUms
	wcTo4ZzsS2S9NWQk3RTq93nR1kEQYuttNwzEAkdP0Sx0LzGzm6onryor
X-Gm-Gg: AYBFou04j7aYo6SC/nZ2F7do3qcMZuV7bWFg7hMvjNlMX8j8HyQR2ksyHldim2iu5i1
	x3L6EwIImQju8e2ujSx4WYXFDw9X5XyKVMDrw1ScayC8iC0VXh+E0YdSbA14a95O8T5mVs6/Oah
	Cno+T9vltmZhrOpBK9xdVK3vgAe4LVuOU0ZYWzJEtF54ucuuYLDHterz0d2PgNV0B/atV5ul/wz
	7HBDA3P4dXs3YeAS7ggwA9n2TNGum5ybAR+IDsjAWx/XsAdy3SWdF7S6TvhUzsmma1FIToyyJEK
	kh8UsFMweSyoE1/IghHPnK/kgd/Wisgd2sy1aP5/ZaA+vsU6IkEjaXwo6WsTgVH/atRsxxyO83g
	UAEBJESnglKcxgfXI54RI1KSeCXw9KsOefsUNc0enVZOtswhSG39jgHRTGwtLFUc3WBS6bPD2Cz
	1WidKn1pvVg/A6kaoC7rFPjjbBO6W2pKIVE/ZjH2LtcmoMLB1CwVYVREYPQbhLRfbYG/No5MVGC
	Nt2nvqQ9o4ZKwWyFHx2iIgksHH8UXzmoTvJsq0oWtArsA==
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id 5b1f17b1804b1-4a1a7f8c1cfmr177900845e9.9.1792062287875;
        Thu, 15 Oct 2026 04:04:47 -0700 (PDT)
Received: from f (cst-prg-86-123.cust.vodafone.cz. [46.135.86.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm57956945e9.6.2026.10.15.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:04:47 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:04:33 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe: bound new-page copies by remaining iterator bytes
Message-ID: <cm7xsdvj6ij3k2ad6jp46eojgazlr4prejrqywezo7p73kzagm@myk7rx2cuae7>
References: <20261015085326.340074-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015085326.340074-1-liqiang01@kylinos.cn>

On Thu, Oct 15, 2026 at 04:53:26PM +0800, Li Qiang wrote:
> anon_pipe_write() requests PAGE_SIZE bytes even when fewer bytes
> remain in the source iterator. This causes copy_page_from_iter()
> to perform an unnecessary extra iteration after copying all data.
> 
> Limit the copy size to the remaining iterator bytes to avoid
> this overhead without changing copy semantics.
> 
> UnixBench pipe results on Hygon C86 7490 (Hygon 4):
> 
> | Threads | Before | After | Improvement |
> |---------|--------|-------|-------------|
> | 1       | 835    | 854   | +2.28%      |
> | 256     | 179293 | 182895 | +2.01%     |
> 

If you are looking to improve speed here, the real gains would come from
redoing the loop with scoped_user_write_access_size machinery to avoid
repeat SMAP trips.

But that may be quite a bit of work. The patch as is seems to help so
I'm certainly not protesting it.

> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  fs/pipe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 292425a834dd..da5583f7f37d 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -595,7 +595,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  				break;
>  			}
>  
> -			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
> +			copied = copy_page_from_iter(page, 0,
> +						     min_t(size_t, PAGE_SIZE,
> +							   iov_iter_count(from)), from);
>  			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
>  				anon_pipe_put_page(pipe, page);
>  				if (!ret)
> 
> base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
> -- 
> 2.43.0
> 
