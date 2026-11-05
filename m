Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847806;
	b=a9106gqqDJrVpZQD5iL49mroxUEVIvyGmYN7m3ZHWP1JOteINvIxFrpmN3gJglABqGaI
	 2TTcc8AJbDroWvaELDZSvFEqmWDw6TgVfQc33kVAdHtWXwBA+0zagytmgztgNaR+FFhX7
	 FmP2Vo0sbI/vi3ZOPIy9QPa4j2o+/ZaoO5LNVBA9L8OHNbReN/aMIh+pL2N8X83r7QJ/S
	 JEI86NGuR/YmqYk262u+8iNcYDSuxS4LSP3UbZB1Is8hI6/ibw5bhomJR2TviiBVhuEyZ
	 nprnhMQqsjX3o+ACdnyqS9J9rXT/9v7FcZ3IuK7E5HG+7PAp33aeekF6HTCxdU8Lu4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
	b=h33m2u+lEc2B4YSveSAl4Z9xoDZsjlmrvdKNduZ0qNANtt6tZZmk9PgP8v+qeWWZ49JT
	 NAKWsqnLJYVoF6ueSohh88j9C46SHi+/sq73bJmwIoz+QYeSfZGinzuT+G9x56q2jmNGw
	 2YnHEWHT00AD3thjWY45jHP8g6CIfVmwswEF+JvFgYpi1XmbPFi4N5M2baH1jbs15sEaE
	 S9Q7wRAz+2kTNBKge+8LqKRFTnqp8a1sOvubgqCtWfHUdBjaImwdz4W9Wkha7mble5lwI
	 yET3EEVya/fdEBsaCKFgmdzK3B0fLi7Ekqn0tNpD7R9r79HITc9RgyxJ1B+WSDmiW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.cmu.edu;
	spf=pass smtp.mailfrom=andrew.cmu.edu;
	dkim=pass header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=HZ0rvCUd;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9B606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 03:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F9B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=HZ0rvCUd
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c9cfd8b1bso16567486d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1793847799; x=1794452599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
        b=HZ0rvCUdtiV8k6tqRF6TNPr6BxCfo26C8HCb+SArpySJ7XV0WATODALH96NFOW6e7o
         ZGApbRrZ/QSzYLJ8X4t1ECE/Eu4lMlNDeD5wgFvEw8IqauOWePNXyp9HbuUJ7TnRzq9w
         U3Fio9VNZSRrd/Z/2C9vHTz+SG5PyKTA8gsSf1cbn0lXq0B5Gfq+ofBHPqPkjgfeaBO5
         /DXZLDSD0LWbJgTztTbwX8R2jJ4XcYm23CuYO5ko5CpQToVLBWnMG6CIHfph0jtfZrkO
         8ugkjNiL0OzxmB6W5QvQOvvIzyubf5vGK0UgGFdBlaiG97CwLOofr5AdJpIJv6MOq/jP
         CpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793847799; x=1794452599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
        b=FSKpCV/2VR4eFpVzyv0vY9GHcQiDQM5/BYhRnlvSUGlbiIgm6R6jJya85OZ9Bvpc7g
         PcpTKlWRgG6FESQ/hKuXNrlqxuu0fuKelK2Uh7awAERNRZZrqQm0QQEljrlZ/AjTH+MG
         V1GccPS9VAtHL+fd91fKRba1ND3xcVhGriPvhanS4nWsSXnstWVmcKI0ILWh9T30xJk0
         tJZFb/9XLFPDUX5wasMxnQ+rxPEFEg7nb1uO6FGF5pxaNKiwajYW3Q0kMAdF5PivCpHj
         2TnOFUamXGE1LNkrNXpz5x724J+wBTaW1XUw3DvxwPikVOAtcIhRu3XfJOzvMDZFLWd0
         iGrA==
X-Forwarded-Encrypted: i=1; AKwUvBz3Zts8FuPLXEudynQ5MGunztMD7jGpbSzWPbKL1qvFOpPxJJGWc2782Q/QURs3ts3pT/6hTl0SZwrufHik@vger.kernel.org
X-Gm-Message-State: APuU4Z/3nnE6xQXMQx3FneQzGkdxPJRHymVEihkrQsiLXiHoUznIj/KL
	A7uj+TVb2apyFbt/+dkZr7L9FqP3/d3j4FP86KkgONiC674U4HLtnXxhdQyBLS1+TQ==
X-Gm-Gg: AYBFou0SL48A9FbuTdKo3bA8GgTn4SDbKsk4jTQ8ybNmFrF2SwrSDoxi22i4Tvm6Eqf
	L/V7kJE3k1/bhpbF0nj+GAbMoKBwx8dG0gX8J6AiPwj1nWtSDH3fDF1uGY6BgsOaLpOcHyq/wYE
	mK0Q3VaFSX+JUAN5GORKmcdb2MKajOydZlOI0ESVBkxJAAqMly4bK+DvJuQX+TLxBSxOe3IUNA5
	3eY+RhNDdzJ2oh2OxlG71cKOcz0bVpAKTIGBwnQFCuyjoK1el35KdiGxIJXSXCZwMYkCvkJ9XAQ
	V+X7YkkDms0yNjCmIvT5FOH4VTGQa9Y8g58Ihnq81MjwbS4xuVJRk7reEkQkhL19S/rN/9fGbpr
	JeW6gLBLEbe8gLSFaxcoZyiKoYNVvWX+EtplVrA+6I130TEkcCUd4Hjh+urfv8EQvFiN02puHjV
	6uDbQxEV7oVMc5xMaaK1i3NR2qpoYXmN+SKt3UXGWJPpwBAmTokV+PGn5DDfuU3VuYKqYt16Jfp
	N+l9Ft3ZfAQOLmdDQ5C3MfIQSEj6I1KAV4CCOppwFLvS+ue0/dlDk7ngR93xTmXEzySrA658PBE
	uB5YjhweQ3XNd7+kmNf/nxQH5FeAjO0k2vB/RLtHmX4/I/PAPw==
X-Received: by 2002:a05:620a:46a5:b0:93f:2e08:6420 with SMTP id af79cd13be357-94421741ccemr3073423785a.38.1793847799333;
        Wed, 04 Nov 2026 19:03:19 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm362171485a.3.2026.11.04.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 19:03:18 -0800 (PST)
Date: Wed, 4 Nov 2026 22:03:04 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] coda: honor the append state of each write
Message-ID: <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
Mail-Followup-To: Hungyu Lin <dennylin0707@gmail.com>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261104191355.89544-1-dennylin0707@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104191355.89544-1-dennylin0707@gmail.com>

On Wed, Nov 04, 2026 at 02:14:23PM -0500, Hungyu Lin wrote:
> coda_open() adds O_APPEND to the container file's f_flags after it has
> been opened, without updating its cached f_iocb_flags. An O_APPEND write

Why do we now have cached copies of f_flags around? That sounds like a
recipe for getting things out of sync.

Anyway, your patch subtly changes the container file we write from
cfi->cfi_container to host_file and I am not convinced that is a safe
change.

Yes, host_file is set to cfi->cfi_container but then we call
venus_access_intent, which is an upcall to userspace which involves a
context switch and may update the state of the container file.

I am going to have to look at this a bit more carefully because we do
use that cached host_file pointer to get i_size right after the write,
so maybe it is safe and as far as I know our userspace cache manager
only updates in place and never actually swaps the container file.

I haven't looked at this in a while, but I think f_pos synchronization
was assumed to run through the Coda inode, so the append used the
coda_inode->i_size to decide where the write would land, but I can also
see that with the locks being where they are and the access_intent upcalls
that may not be a valid assumption anymore.

You are correct that we cannot rely on the containers open time flags
because that container file was opened by the userspace cache manager
and is passed as an open fd to the kernel.  This handle is then shared
by all users of the Coda inode, so some Coda file handles could be
O_RDONLY, others may be O_RDWR, and some O_APPEND.

So I think the core of your patch is probably right, but it may need
some more careful thought, maybe the use of host_file is ok, maybe the
i_size needs to be copied from cfi->cfi_container instead of host_file.

Jan


> can therefore overwrite existing data instead of appending. For example,
> writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".
> 
> Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
> incoming IOCB_APPEND state. This also honors changes made with F_SETFL
> and per-write append overrides instead of relying on the container's
> open-time flags.
> 
> Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
> Cc: stable@vger.kernel.org # 6.9+
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/coda/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 6ca8bfcb58f2..ae03f0b30d84 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct file *host_file = cfi->cfi_container;
>  	loff_t ki_pos = iocb->ki_pos;
>  	size_t count = iov_iter_count(to);
> +	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
>  	ssize_t ret;
>  
>  	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
> @@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  		goto finish_write;
>  
>  	inode_lock(coda_inode);
> -	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
> +	ret = vfs_iter_write(host_file, to, &iocb->ki_pos, flags);
>  	coda_inode->i_size = file_inode(host_file)->i_size;
>  	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
>  	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.43.0
> 
