Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26153D7D70
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980313; cv=pass; b=p7zPcAdTA/bEBRo9vwrKKgoJH+Q40Y4Dw5qzu9ohW2ipFCvyXabP8tekwO30Qn+B+zFyH51iP5SI8hNt1Pz//Ow7ePRLPb2XkPjH3dXduYy19+hT07cgD9quQjOPp7lUkIstlrb1fI2CglvJ1zPDNy7Y8umwnGS31OiuscZra8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980313; c=relaxed/simple;
	bh=O2v7CCoTmBk6BSeiYdroP4qLhY+976q9kLJ3+fBMQMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQprUu1BsCc3Vzl2nbD4R2ep0mXfdaveXlhJiSPVLYouu1gq/xWpcd/0L4z+kIskQwph5ZzOR3x9yOar1q4+EndKg+YFhAvF3kBrlO7rtCS+cYxdGqWPkEOdGmxAeI9Qhz4bfWSRKpEX/VmTwSPHyl61sqLpJv8iyHqBlWt0qIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNDOKlf5; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNDOKlf5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c160420289bso470016466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 08:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980310; cv=none;
        d=google.com; s=arc-20260327;
        b=VUgsuAism+jNRXD860JheO2FfQP6Ht7ssJIqIY2HExHzlNXTrWb/3CD4CCuHGOKwao
         S28SC3eW/rzNcxUX7b6r6PYabt3/GVQDWo0v5ufTFhOCePMI8XEiIKZ+2hFPsHQ/IY1U
         vyKpNRezZBINZjz8ScejmA7oUQ4Zp4lS7eHgMhAiJu2iYAvG2xQKo2E2WZHfAhTUH6BP
         UEEtZJW2oevlOMciml1ZbXgNnzvMtLuZozp7P62d0BvnumbMjSUEWXh7VBcrTXXhem7I
         hO/ncOtwLTq2b83R9E4/OEV3Mdkzwtkdx6RY90dEq/VScvjIys7LK6+ptqwwexb6Y9vg
         dYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GbxPH3BG62dH8ycsWvWKuU2cvxvYvEgvNkuXGEMv+z8=;
        fh=XAt6A0k8IisTSUNEGVGDXbDkiCLQ/jnBqccc2qSVjvw=;
        b=je7dfGt+2bfBrZopIiOCRgtmXdmXkGRxbuRY8dIdZkz1RMKK7v6o+gALJGeJu3lmag
         tFqShnll0HaAp4nug4nCPgpEe0UbPItDCqWbMiVZaaO/9Ka/bJJnNjcJCj5YupcD5mIh
         Y/YCqqtDcx3S8hVQXEKfckgPMgXFUR9i6+4Je75elQNWIiRgoV5wyNNcMhfhB0qAqAWe
         qR+SNlZ50BK9i8s3Ue+FNCyEUzIjTzpZjaaxCxmEYoxBt7uejaRmGwbDKwSMGThbW0Es
         dcVsm8UxzYp53tNK3BSqVhVQ/CEOXxBZ51BQdVbhemRLF0IdZltnWK/DW/uQjNxbizPk
         vTtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786980310; x=1787585110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GbxPH3BG62dH8ycsWvWKuU2cvxvYvEgvNkuXGEMv+z8=;
        b=QNDOKlf5F/qvwW6K8DOk2YsCxXCk92xIL0rfJ/lT32ZLLiGfhvaRtSS41hpzODXL4n
         d8olxVx7KRZc17ay8qmHgZ/bnq6bRveejI3136v2SsBry9US8N3niFSf05gLAo+5cgE7
         7hgRjrHgmHLwQ/cVm1UpcK2zgjhbLYSFK1BC9kUYq3/Tj+1KIG2D139fATKzdyG4Qa2X
         nyY0GNkgh4P7N/VJnOpunnk5u1/olVZ76PyqFWluIqmvij6HhRq2UkrqpsBAFHYaDM7/
         UOkwamuDWp32zq3YaXAhGpafOCHeevM9+/4zVxHNAxHyFuDLBuYXu+EzrzJbzIZk27yb
         Irhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786980310; x=1787585110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbxPH3BG62dH8ycsWvWKuU2cvxvYvEgvNkuXGEMv+z8=;
        b=ixmQ2j+GEjJDc7yE7zjcW3I3L5NLMZI4get84ucc0zDDnhAe/RmN+Vv+3jKC7nZinJ
         6k9U8NfFmH+cKInznOUl4mAq/dT7cFmdKXKBd92g3OC1uwxEh4jq/NPwjFzaSWS03AjB
         nWzF/2zyoHEj+z9aZGbPt7/cvfQnHcdfus4QJuVtQF/qyYyWgnEJ8zVz4h86tAg82bhC
         70CPeueOK9pMU/Pj3kAPAYkEDI8huCptpIpGnDQJqsLnA5gOIjNsi1wyfQTz/JN4dnSG
         HXvUA3bfBwWqH0OE9an21aCICodhws1bq2zNVoVztQG2iyvZX9PAAc5Kit22SnJKCiut
         B/XA==
X-Forwarded-Encrypted: i=1; AHgh+RpWGdZwl8mPbz5LislK1KOGkCfDHVp8OZbt5gvtKMeQmj9WmArF5r1UxqfNJlCX3Se+/8D8fqlNIAN38C/7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HBMN54fq75/G61ode6ntjCOTvnGz0lJdicjyrV8j7KLjfX8J
	XeTglytBVVOo1FUz1AOj2oVojfAWR0kWE+NNXdPY0OPbdMHHB1h4w8JyXKRl+THBLnMvG90kdSD
	fCUF9+iC9ScwmlJI/fVDR1Y1JWpaMOt4=
X-Gm-Gg: AR+sD10LiGK+ye6zjQ7SH7CD+we/pWgQNe+c70gCAcy/Z0gGN/y1MjDweQB98VF5vOX
	iMNlTiuL/FvVPaAdsmZ3XPjB0tVnh9x9EK2sQmKS7lYkITajfrrIUAFjzox0fKZ9J2xV7WC8J4p
	6nem84UgqYSNht9Vk4RaLU1fVdoAKhglbkRl43g5tqq3cLVN4jiYh0bVK6dbvB808MTVj0tNwtO
	agraIv+G+I2gJEP7fSwoK6xTGJEQUdwhJCRdgpujGGLg/peGE1QwFU4342Y9TpYq3Xkpg3ilTVr
	CGT942p7mVQT6z/d2hyfRsVHM4gwF7nqD3BTOopaNUvT9/CkYE6U2H5X+akB+VqtIEDY3qtpWVl
	Q
X-Received: by 2002:a17:907:3e9c:b0:c16:13c3:b1ef with SMTP id
 a640c23a62f3a-c218880838bmr42009666b.24.1786980309549; Mon, 17 Aug 2026
 08:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817081756.4176757-1-njilav@gmail.com>
In-Reply-To: <20260817081756.4176757-1-njilav@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 17 Aug 2026 17:24:56 +0200
X-Gm-Features: AcwNN1VNmTGYMCkZ8FQL3fRglVqmIGoFBLg-KRgm4LTx8gRfqGBYDX2NKq-mt10
Message-ID: <CAGudoHEgPLtqzcsgJp5oVGWhTST0ZMVLA=kVDiLooh85N+LVWg@mail.gmail.com>
Subject: Re: [PATCH] fs: do not cache a symlink length that disagrees with the string
To: Narek Jilavyan <njilav@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:17=E2=80=AFAM Narek Jilavyan <njilav@gmail.com> =
wrote:
>
> inode_set_cached_link() stores a caller-supplied length in i_linklen and
> sets IOP_CACHED_LINK. vfs_readlink() then uses that length directly:
>
>         if (inode->i_opflags & IOP_CACHED_LINK)
>                 return readlink_copy(buffer, buflen, inode->i_link,
>                                      inode->i_linklen);
>
> and readlink_copy() clamps only against the user buffer, not against
> the string, so a length larger than the symlink body becomes a
> copy_to_user() of adjacent kernel memory - reachable by any process
> calling readlink() on such a symlink.
>
> The only thing standing behind the invariant is
>
>         VFS_WARN_ON_INODE(strlen(link) !=3D linklen, inode);
>
> which expands to BUILD_BUG_ON_INVALID() unless CONFIG_DEBUG_VFS is set.
> On a production kernel it type-checks the expression and evaluates
> nothing, so the value is stored unvalidated.
>
> All four in-tree callers are correct today, and notably the two whose
> length comes from on-disk metadata (fs/ext4/inode.c, fs/erofs/inode.c)
> both re-derive it and reject the inode rather than relying on this
> helper.  The API should not require that of the next caller.
>

I'm confused why you don't expect filesystems to guarantee correct
value here, but I can agree issuing the strlen is not a big deal
during inode setup and I'm not going to insist on NOT having it in
prod kernels.

However, if going that route, I think the proposed WARN_ON is too terse.

inode_set_cached_link() at some point had the following:
       testlen =3D strlen(link);
       if (testlen !=3D linklen) {
               WARN_ONCE(1, "bad length passed for symlink [%s] (got
%d, expected %d)",
                         link, linklen, testlen);
               linklen =3D testlen;
       }

As in, it used the correct value to fix up the caller.

I think it is ok to refrain from caching.

The important bit is the extra information as to what's going on,
namely what's the len disparity. I guess the message would be nicer if
the it also printed the filesystem name. You can borrow code from
dump_inode to do it.


> Validate unconditionally and fail safe: if the length disagrees, warn
> and leave IOP_CACHED_LINK clear.  i_linklen has exactly one reader in
> the tree and it is gated on that flag, and vfs_readlink() falls back to
> i_link with a strlen() of its own, so the inode degrades to the
> behaviour that predates the cached length instead of disclosing memory.
>
> The check runs once per symlink inode setup, not once per readlink(),
> which is what the cache was for.
>
> Fixes: ea3821990719 ("vfs: support caching symlink lengths in inodes")
> Signed-off-by: Narek Jilavyan <njilav@gmail.com>
> ---
>  include/linux/fs.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 50ce731a2..e1d8f2614 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -946,9 +946,19 @@ static inline void inode_state_replace(struct inode =
*inode,
>
>  static inline void inode_set_cached_link(struct inode *inode, char *link=
, int linklen)
>  {
> -       VFS_WARN_ON_INODE(strlen(link) !=3D linklen, inode);
>         VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
>         inode->i_link =3D link;
> +
> +       /*
> +        * i_linklen is used as a copy_to_user() length by vfs_readlink()=
, so it
> +        * must not be taken on trust. If it disagrees with the string, l=
eave
> +        * IOP_CACHED_LINK clear: vfs_readlink() then falls back to i_lin=
k and
> +        * recomputes the length with strlen(), which is what it did befo=
re the
> +        * cached length was introduced.
> +        */
> +       if (WARN_ON_ONCE(strlen(link) !=3D linklen))
> +               return;
> +
>         inode->i_linklen =3D linklen;
>         inode->i_opflags |=3D IOP_CACHED_LINK;
>  }
> --
> 2.43.0
>
