Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFA441612
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450475; cv=pass; b=hJTHbJ6c2pIptc+fJJyn8uf66Gq7Csf9IgDaqva1MCVfVnzIxh9Q+UGmPKICsWWg8T8YTO2QAX7/k/WEyvtzwGVdy9IBGwznjC9lqcJ7T7tqA0vip1vsk0ov2jmHkF0Lmwa9wOK7mwvqh/BDAQ5/ronkR+J6gdskNHSR0f75wNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450475; c=relaxed/simple;
	bh=uKswzyf3oANr0x5zb0bJBPrPAkNK77rK/33VzGVtg1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brcUE5KViM4byGbx8j2H3phL225Xm/6v2CUExGUET5qzKSUbyaqK5wM/3VeC9YfY453lqBry+cmy72hxkLIsUVmUHcAzrf3v5S9Oi0k4xpMGnZa69aXDdzX/Q1LKF4AbthpTilNaxD6cO62L69lM8mQHcSdi98yevVORmmUh7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LYhhybqo; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LYhhybqo"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0c45c580so4403921cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 05:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786450473; cv=none;
        d=google.com; s=arc-20260327;
        b=r+3ACUI5KK0M0MXZjiIwJ/vxiBksaeJ7Ki9iWOcMgZTQYj7ycON6bOaz3v4MzGfS5X
         XlxGJ+jj1DIYr1SSNJ2MeqUilvgEQmnfbg4MkDsUzer5qZJ0lJyz6CKT3IUnM9jR2U3S
         c0nC8g451t595hMHbAPE4zblqpUW/99I61iBrsSLjwSQsW4m2rCgwGh2IC3mM8oHJgLF
         T+qXV6tf6z5UGVRGoKjxIXjsvyFqb3ECHquoNiaI6kMef1tLWU+8+8JIiroHdVsDjCzn
         9Czw97ZbrmNBpR20GfCOJIAWR8ERH2zKojTHiR7TKC7mrowQAHUXzB8hFciDkX+6XRAa
         p9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        fh=kay/riEft+fn/DRejjR0fcIhNoGpgBcNTjck061LU0I=;
        b=Bud+XWJPjhKQ09oVH6JRA9JaEB34E8tZ1p3yktsSLgUz3gKc7M8XvHsnqJiNPpQwpr
         yZvaU/oHUoDuDBJbaioOLX8h87yQnPHRs9euKqP8xfc9odxuszukq3sZRXxKzSDLoFxf
         ubogVpQdvXPx/Aaw9kMrk3ZY4ziWgr/6LWfjPd8Y4uvqQMwlW5wUJRjV020xTu4VQ656
         gnJc1NYx9SgZ1CD2pvFun+IZ5+6MjOf4nUSWY/C9kZIgF4sqFbUeGiV8WUndfru+FWVh
         lsny19AWEtRgr/I9R6UzkOr7h6cVJgEqN5G42C1iRCya44UWo7Tc70Ix9AmDJHpIsvFw
         AkoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786450473; x=1787055273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=LYhhybqowWX6ZR+Nf5Xxsft7xXDxdFX3reI2VxNHFPBCKIsh8yC66ANIAQgBMBikIZ
         99mOfXZFzwE+fla4yJjoCv1zBbfR1iPecQ7opVFYRx2aUa01sY/qYo/E7B2JCkdw3MWb
         feyvqbpjBXul4yjwwI3Ksk3aN7ddKGi7W+kCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450473; x=1787055273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NrfMxAmOI1dOmAoAUYNtBxs6J6vBQ4QSPSkOCCv87C8=;
        b=BS7j5qOOvT0WrcoDI67es+BBZy4qo3jNbI3yzaZReHhjuUOqKSLxSSt5rzLohrIUV+
         1CT6Nzc+p2W2PFK0WZ01VUUGipkBeD+0c31UuLfXGYm7Z65m6Ds/JEIAkphESnRvnwcn
         mLj13WZT2mpJgN5yQGBAH0735OGCcrf/ETaUBTMzNJFQjrNx8qDCgLrmjNpV57faRnQY
         F+aR3N9QdYey7kWLMsu28RKaSjoUCvwaVyrCiLhAPOZfa+4GdxfOZpeGjM2B2QOhqExZ
         q+WC0SZKd25VdCoppNGrIccdX+JC1GXAyKjkGt6blGRKzrjJyP7kNYrypcRUKKceEo9S
         Uq6g==
X-Forwarded-Encrypted: i=1; AHgh+Rqv6p7Ld84rh3plBS3Zy3eVz88WYaYYA5TRbQDw4OSMGg8VHk58sVLnHBQZ8JFjq2rF0Ps72SKSomuEVF7Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70DARcFdol2J+ZLrISIJSlXj+aqwqLOVTSFLs4UcF0PArpo8j
	Q6fgAMbBsIKxX4QX3CKRQsm2DDJceig+Q9Je2uUGrERJlZp2Jsqmh4CepNlDubrgzYSmZ1af0jv
	qJM4RIhD7xsjF1UE/1moovkdXqMF1trtGn03lRW9BSQ==
X-Gm-Gg: AR+sD110qHVS3ec9NZVXJ1QbTEwgHe6Gx5AGktc9DB1GvBj1iutiFKzlmUcTJIG2QJQ
	lTaNB5tSyE1cIUH+Q7ZsoH0goBEa+uXnzFhs1Q6O0i/2onrQv9WcWk/w2l0KCG+4wTpFLR/e5q9
	TBpnQUULLLEYLEAxssxM68qxeG+OnlMxqXE9hcoPkfwrTEo2aPAGOx2/qkze4lhddoBteV4lN1o
	NQ8z7dASjko47NkoUKgpL4uz2Qd+2/UxLX/WczJrc9K747ctWmG7B5Cft9lIK1xP8kYXF5ojYYX
	X1N8w7A9DfP1pe52WKjyzSpYDedfWuCum84sHaghWhTeE7ewGvmSK6KZAzabVnZ+XkjNXCoohqM
	yYA==
X-Received: by 2002:a05:622a:1389:b0:517:906b:c043 with SMTP id
 d75a77b69052e-52d5869769dmr20988111cf.36.1786450473109; Tue, 11 Aug 2026
 05:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
 <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com> <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
In-Reply-To: <178641431036.2852630.14175693646176331672@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Aug 2026 14:14:13 +0200
X-Gm-Features: AUfX_mx5_QZpyNyj5Ni2I_IHkZVhUDCHgR5x1MospzmB8YaToZll8PeS64_iAm0
Message-ID: <CAJfpeguZh6Bo7hxVW5f-OvKJ3UazJTn26Wkba8+rXY-LC-QNWA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Aug 2026 at 04:12, NeilBrown <neilb@ownmail.net> wrote:

> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -169,6 +169,8 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
>                 hlist_del_init(&cursor->d_sib);
>                 if (to)
>                         hlist_add_behind(&cursor->d_sib, &to->d_sib);
> +               else if (hlist_empty(&dentry->d_children)
> +                       dput_dlock(dentry);

you mean dput_dlock(cursor)?

But that's no good, since the directory could be repopulated and the
cursor needed again.

Thanks,
Miklos
