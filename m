Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E203DE454
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947073; cv=pass; b=iX2WIWI19nT5/SfG585rlXnNFnVoKrxKNg1sbP7N2+Z3Cn9+mpMgPnnY4NNF8b2ESl5uLlzQ+1sHelXu+jI2ypzDuaKMM7C0E8MX3GcM+sKFAwe++8vlbf9o8JgScba1JVcnyT5YYqMIaG6RiWmAviVK3WLDnfqPImOjz9erjRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947073; c=relaxed/simple;
	bh=u7n+kDZSvbQfr1YSkE31HarWEYjFEM6wH52Gsy+c8+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRkbLJBwZSRwGknVOeJZSQpSVeWFSGUZqLx7lyof5d513JZPCtL1repe2ysDQAOMd9QvLGLHPsQweuLpks1l5eTFGo8/CTNod1DqcvDy50h+x9G+LGV45znYL9G/7ztD8Cx2OZuirKsCMDRXOGWjwHlHiVlgntxTLv7gQgbzjlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0MCEhaS; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0MCEhaS"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65003f40a22so6640158d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 01:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947071; cv=none;
        d=google.com; s=arc-20240605;
        b=ezmxsIcMrrKPyh0URhATfq6X9c7U7v+s0L2hlikspricUj1poVlSEX6tVlM6oQgb01
         D0dpUVcwTtyKRisYjRuoHzuCEFRKQjdzKkDYN4o+yXclkYa2Jo5mw51y9dJMDsjdiE8k
         uAuUb+/9Eh5UIaJVw6gVvbFpPAXI6B4nQcNiR481/Xt9Iixs1g9HzMdwuhMtv3S5Xv7P
         reN6Dmihl97VyHmwMY/P2CdGnKphU2mvLyJrDHmW4YxYJ4bKyTmsycs3nne4GblmFUmf
         YUnuVQ8a1TQABw7XINT+Xu6vtx4SH+eG2QxOL8ma4QZtl7JpxEFII3JsryQreGUA2/mL
         yS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dveVYD9Ar6UnkY03J8ytlK65B4YnjUcwPdoJl8qxUxA=;
        fh=uDhMQV53kLv+JBXUO9y9pjzgim8u91X+LJPVwO3vbEU=;
        b=S6YPYuLLCcang0cy4yDGq322RWCa84QrkLYjPo7hJg3/lTmdVIpja6xeGg2pMMf1WA
         7mC7RkwpwPF+V4GnEC+ag8c/Ssozz3KyAcDSj5pmAqQo5Gdd+ek2EUbNwUziPwyANI8U
         ZpXJgoOF9sx4s7URDWeCPfjY/eddsChusoDSuW4pSlQwYd1ZHtXUZo8gkeDi+T9GmxtQ
         sfU09kbJfyl06EyjvqBv3Jk4NvX2WtgRDyZI5r83PsAc4XLiDi3x6ZlG7MINiaosEzy4
         NmetBcABM+nWwJmH5Pki8J/bJtGqfnoqXeDuKnZdyjCD8bE9TYqe78gTKVjUB9JOPlXN
         IMwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774947071; x=1775551871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dveVYD9Ar6UnkY03J8ytlK65B4YnjUcwPdoJl8qxUxA=;
        b=X0MCEhaSwc4mwZj32ob0JCqvdkZA8xftj0XpdGoRy41JKJPTrT41hoVapv9UfvipYb
         YgO1lgQlYVkpdVWmKNwg/Kjxh+O+Vu/7Kk2CyQMKE6usI7YUwvkkrkLrortjSQNN0faB
         c66Y7BCY5kdNN/ruRvVQ0FZGKebHoS81KMEN2yTHDOHWtL8+acT28SOaBbjAqtbVRsm8
         OqvxX2G11373LBe18OzdyfVbZse+BprTjBXVygRn23HI1z+nqgxhC2zH38h8UyI923WE
         d10c2Q4phcZbsljotOExS31A8Vk8XmbIIWWo8sQqRXT9ozXKmz6fWl99yal6kh9wqASr
         jExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947071; x=1775551871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dveVYD9Ar6UnkY03J8ytlK65B4YnjUcwPdoJl8qxUxA=;
        b=mJtwcjjWW9lP+V+BxOiO9eIg+L8PhH3pA4OsKXyXgBXRAid7Z9Ol/tmCdeQbj6U6f6
         IwR5lMezamY7qvR/B8E4oR8Mhrm4su2MxFT4Db5yMHhQ1wlAT4plhs5fNYXBDCnXCVoT
         OAJbhAZIFEMGT6IM/UwjKCiSOR2KRyv3rOgixmzBPx/tfAfvZ7BlNVqo8D5Ye8lJveZd
         GJgC2XDopmIWtlZsNZ9sZ8D+vM7qQLnpN5uplOXvy/yXcd16Rr9GKn2EPBvsosCgklf8
         S1Y5vpmrMFgv9hu749n4CRVWugGbv5VS4L1ZrW4YaDGYPgxjOQsBYDav6aCyI+nsimEt
         f1NA==
X-Gm-Message-State: AOJu0YweOh9Q1qCOFGlZ44LVq96cFmNfFQ2ouwybu4jHXblJUa9gSXuN
	1SE9Aak6+2JD3CZQPjgfEjgeWBFIgb5tWcagTqFQA/HJuFC9hktjXV8p35ALc8T82XYDjW2t4Kt
	asZIsWQMVG22JX89llHWEIk93uf9yEM8=
X-Gm-Gg: ATEYQzzpTi+Q2mXXkwalmtfkXYU/nPTv5wI5++c/Jx8Hq4mn7mZbj4g30r1Evp/4Nn9
	vpVT/J7NORb/Y75hujrk4ZGvctdLzOwj/GSSIyNJB+ACw/IowezKfROUaE3P2pqKXu54uCyQ2Nl
	jrDOuxtMeRKcExe/UC2lUG5e+JIWCBTz+YZDIG0QtYssjUQ2XN+zjjuTFJ8/qdE/onVgcTDZbJR
	kaSJGuZH60crK4fpP7yfa5uFkGk3spdccZ+LyZV57K6rw4uFZw+VR8O9PlUQzT7P6GFDFoWOaAy
	XgZeUQ4ryoLlBIMeJno9Jld1B1G1V7ES6zzouJd9w4Q2bxp3MwNRMLgxJKq4csIfAGkaIv2448u
	gCRF6huo=
X-Received: by 2002:a05:690c:dc6:b0:79a:8e1f:2611 with SMTP id
 00721157ae682-79bde0f98b7mr152960927b3.53.1774947071434; Tue, 31 Mar 2026
 01:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130615.1109449-1-kartikey406@gmail.com>
In-Reply-To: <20260320130615.1109449-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 31 Mar 2026 14:21:00 +0530
X-Gm-Features: AQROBzDeJChHZRm3QfcNZXQaLFscGZYbGU68_lC5tXxlQDnRkRR6BNtzKQWWs-4
Message-ID: <CADhLXY7LnKAdJR_fb5YOa+oG=ebSH6X1n8tCT1YJzpbiwvPTcA@mail.gmail.com>
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:36=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
>
> When do_splice_direct_actor() is called with the same inode
> for both input and output files (either via the same fd or a
> dup'd fd), it causes a hung task in blkdev_write_iter().
>
> The deadlock occurs because sendfile() calls do_splice_direct()
> which tries to acquire inode_lock_shared() for reading, while
> the write side already holds the same inode lock, causing the
> task to block indefinitely in rwsem_down_read_slowpath().
>
> Fix this by checking if the input and output files share the
> same inode before proceeding, returning -EINVAL if they do.
> This mirrors the existing check in do_splice() for the
> pipe-to-pipe case where ipipe =3D=3D opipe.
>
> Reported-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd31a3b77e5cba96b9f69
> Tested-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  fs/splice.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 9d8f63e2fd1a..c0ad1859de34 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1199,6 +1199,9 @@ static ssize_t do_splice_direct_actor(struct file *=
in, loff_t *ppos,
>         if (unlikely(out->f_flags & O_APPEND))
>                 return -EINVAL;
>
> +       /* Prevent deadlock when splicing a file to itself */
> +       if (file_inode(in) =3D=3D file_inode(out))
> +               return -EINVAL;
>         ret =3D splice_direct_to_actor(in, &sd, actor);
>         if (ret > 0)
>                 *ppos =3D sd.pos;
> --
> 2.43.0
>

Hi Brauner, viro and Jack

Gentle ping on this patch . I have submitted this patch on 20 march
2026. This patch has been tested in sysbot.

Please let me know if anything else required.

Thanks

Deepanshu
