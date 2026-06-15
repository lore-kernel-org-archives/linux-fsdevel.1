Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C33D9DB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516234; cv=none; b=N59p2UyrghmFBVmSP+kuCrMgRPQ/F3KCcPoujnCl/z3nrUx9k75OolEIiaOCtLy9rELafQSfwhSQ9V+//ba2r68kJCYopfkdV+8cXES/giIZvhDw1pAXXZWDWSaLwzdtK8Hz4oXBt1ntCzlRe1uh0eUlYssWRTfj8i0vosCHqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516234; c=relaxed/simple;
	bh=dRiTfvPuz0uOTjxwXXsICapoLRCRba1nlDsnZsuhs9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWIbktYQMAJk/BSYQLDHksclnXvbUwpKoO6qxlX9uY4aJGuXfF9WmhLs/DGKon0kPCtUxc7XO9VkhKDK7nHgMVxFUFb4fHw09eoHdA9WQJWZtr6XX6r6Yi43pB+y+ph5z8X5soB4DjdKFuaoke2TbLaIiXwHG+lUne9Ion+ejh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cznQ+d/h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cznQ+d/h"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b3e03939so23087675e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516230; x=1782121030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Qit3fOLnVUZbAknwqGVtnbhSbyNdSDqSlvCxq11js=;
        b=cznQ+d/hMnIms9b6jOK9lJZuk/29or6GuIfuvUWRIi+PBSetL8ljb/raYCQTtI21vt
         qUs9+D7Ci58VYv5QJ9ypoRiJYaCF9DxoNPKcrSzjZjUbtSj3PczzN8QGZiFr5TUqJaeK
         WfFBBw0kaqZsOCixlxENJhHQyxp6GYi+MqnwaJJATxudefG4tr6IAGvX4Sn8SBoyJ1yl
         Tp8uYfyvleMTQ6pI1+gts15pya6sqzjFOVLuKkvpYVfLZ/d3dkqQpnch6HX/GnzqPTqe
         2V/zAZ3dj6ZsEq6T0RBj+nNAHDD4LKgWkZx2r5KmFj0IdkeU8vHSdjWX/kfKohM/2WLf
         GZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516230; x=1782121030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8Qit3fOLnVUZbAknwqGVtnbhSbyNdSDqSlvCxq11js=;
        b=qLKsof5z7jA9dryApn2EDs1xzRP0VenOJ8aALfD4qDocIWKCLu2sgvXdu8n/0PSiNj
         ABFDoJyrHdVF5QiXhD8ok03FnvLXzv+7u+vhKGRG03zfpvVkykTExMEl7rbZLwRXCrFJ
         JHOZU/bfX7+z806WWvo29oHCyk0CftRg6SNOBrGrJ5VGJ1r5l7Yc9R+FB+Oj/UsLg3vF
         GC5zwfKyuOTD7MOLhp23Z/z5g8yD8gkk3f75S11ascNFVUoMJgz0ULJPKavHtuVsakJU
         cKrdZDXhwp2h3084Vamw7Ufwr68VBpgTLBsWRhUzRC89i6LgKsyjeSjRBOSekff+KnaK
         PMzg==
X-Forwarded-Encrypted: i=1; AFNElJ8t5Tu2OtgoeJmJEObji0hOPlhB5JPfAJ1H9/dLVaHvjeAP/iUTXU2hmDM66PBvhKG1SM0BIovrKeyiv7Bj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpo9WYwO3+AT2baJbntTK9k8M4705oDHxxtQxoODvThWUiZSoX
	kxQZIfwyENQP9PApqPHvVbvN8OfMmCbJLtFSgPWq5cY2st89TbPmByno
X-Gm-Gg: Acq92OEX+V7rgHwzguHudx5octJo2Lts8bCfcUbZzARI/jfWviEs8mG+SLyXv61QThY
	rNuScobVr9DAWxAcanGIoS2NmTFY+jVWamdt1y0UlVkpgM9N/Yzk8OXr6qSpPoEbYPbV4aNQCJU
	OtAwBej8RYOVgGt5ypDR37BsqZcN7plA2itGQHViTQcNl19YN/u0eFGtFAvbdIit+WabYaZESNs
	ub1YqwuL7YMyYbvGI4NQmL9yf7+XEfMQ1w4i7xGIDjmwAQSrAVVpNYB2uV4FZ2FGkD+boPfxZ/y
	3UvR6l95M83bEa45kwbZxX+gpgv4WF7dn3LX72hs6g2TIve4wcgdOh5rqF9qZm9HRsvv+RfP12H
	shg2wBg/rOsE/KNbfnVVwvHKU6Gd5wc87zbmoZ2S4eTVFSPbN4exbuvyzoqm7xWi3i2UL4adwz5
	Ejn/cu6+76xfs/IRJom4OyM/XnivpyducLxjOqjtILsI4VK+yNWewrpuNVw+gv
X-Received: by 2002:a05:600c:c059:10b0:48a:5f32:62c6 with SMTP id 5b1f17b1804b1-490ea9dbec2mr115674365e9.11.1781516229679;
        Mon, 15 Jun 2026 02:37:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm35657715f8f.10.2026.06.15.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:37:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:37:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] fs/namei.c: move create error && negative dentry
 case in lookup_open up
Message-ID: <20260615103707.1a55bab6@pumpkin>
In-Reply-To: <20260614164438.2980769-3-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
	<20260614164438.2980769-3-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 18:44:28 +0200
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> O_CREAT is stripped when create_error is set in lookup_open(), so when
> lookup does not return an inode, the case
> 
> 	if (!dentry->d_inode && (open_flag & O_CREAT))
> 
> is always skipped. We can get rid of this cognitive step by handling the
> error case first.

You've just added an extra test into a normal/fast path.
OTOH the test isn't ideal the compiler needs to reverse the order of
the arguments to the && in spite of the unlikely().

Perhaps:
	if (dentry->d_inode)
		return dentry;

	if (open_flag & O_CREAT) {
		...
	} else {
		if (unlikely(create_error)) {
			error = create_error();
			goto out_dput;
		}
	}
	return dentry;

-- David

> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 64b91ed9efb7..f169d1123b17 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4499,6 +4499,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		}
>  	}
>  
> +	if (unlikely(create_error) && !dentry->d_inode) {
> +		error = create_error;
> +		goto out_dput;
> +	}
> +
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		/* but break the directory lease first! */
> @@ -4518,10 +4523,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		if (error)
>  			goto out_dput;
>  	}
> -	if (unlikely(create_error) && !dentry->d_inode) {
> -		error = create_error;
> -		goto out_dput;
> -	}
> +
>  	return dentry;
>  
>  out_dput:

