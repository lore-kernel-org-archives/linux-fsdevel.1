Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754132;
	b=l0aK4FMk8YPrOLOOeTCarWHj+/yLlborwyiLbmDFwqnWGUUHHFoWBqkUDOlO+5Te+2np
	 KlQqo98413SR3PhmIwu+sDBwk6kgDIENoUxsZSailCRoLKqI6YmEsvCTclkIWwtUAUVNB
	 7Br6xnuMeuzf5hQ0aVaghF/5u8vV/lWpaAgQ5NJyaAIeHM8NnH5kFiWwrlRadQ0gslZmA
	 uicTen899r9cxfkm5qKsu7ypsXX4IWUuu0TL3EgDoMuGitn3AgjtVwRkX33BovfBhAVYK
	 uEeAAGjr2G85/fYYagBKdOwyTqfEdLgHahKnfZnd42VH3U8Jyfdz4/oH5pu+jz90WNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
	b=ssEYmjfrB+wzxOzqiTPZ4qy1R70QwpCj+92CsPzqntE6WYFoVSO7JQwMT7P6YAyexmX/
	 N3CSklGiToZIjwnEtpHv/RdZhg+ElXKWfjlvoNyluXwQ/aGCiGdJ2kC6MJjsESZTjcGh8
	 uPK9F9N1HRXh1zwwjAa30OkbeqFBhzhYBeUq7+iEYPGUqjXWWv24k/14brG2vY3VeV1Yg
	 sUeB9WxU0gYlcKDj2xoe9G3mroQCDzHbwB3b45s0nwEEJQlL7fT1/CKXWOKCOfhE8wE3g
	 2dRXAWRoSAQwEa+RKvQrrwWiZXtYLacwyLSH5ABwYUr4DFHQMXNfZenujjJh9z82LlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5g/XQ3c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E7606A323
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 725E7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5g/XQ3c
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so4154487a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 06:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754131; cv=none;
        d=google.com; s=arc-20260327;
        b=mDkqWrmixUqqqB0bm6YodWb6FwNFjuWhJ1XsTQKtJdzXVvYBbBpZ0rGTkg8++sAM/x
         CKLGW7cLF8luRgvCNDgzUptss37fRJiD3G3EllQcV3CG7ExMh+oboaHzsF+Xw0BoxBXx
         w+DtRCMbggY8g76NCHINgc4TI1D9dDFkswjN5rEIAkESxH3LDYI1vcKW61CMR5aCGEiG
         wFQ/nzKXM4Xj4tOguJFNjmthicxHSV211DSzowdeydNSWQ5/lsbT+A6qJugx0HNlWNKQ
         njC6foUlawer9je9E+x/J7+mzDk2QtgdvH2v78CUpoX8Oy6vP2QSWtPIOooyLGwMFsWY
         WFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        fh=yhIVx4MIQdls10njj6mbr6OlezYa8g9osUJM/k39Jf0=;
        b=Q0YgSzOEz5hSfFRStruZndBE5Y4iQjhleieBfrkdLWe4E1wO2Pi4SkoUsFQ18kAOu2
         Vit5Gnky7dFWSTEfaHu0w3DT8JJ26t5JVuWBzN1OifTd44wKr0GqAthsM5k9wfvm1Dzo
         XS4klADi7xCraOQGyqN9sojnTpztfEZy6Vp+q1Nc/bXNpRrwZYSicMeNrBIk+yyHjrSQ
         5icD1OTiWG43Z3fea7byf4fT3EY9T1jPmIu+aDHBnlP6Q9bbZXgAj13+DzeO+m63fLyd
         I5+sqo0K/fPtTpQwguY2qCIRyCRTEQ06Xo7WOAgMpuCqj1pPKd8pZBHlb4SFD0va3BWG
         /fFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754131; x=1795358931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=w5g/XQ3c9k+Vmzjr8H8faYY5EnV44gyfCeTqkUEnB7IDVxBorehzGxTmotRUcFMd2k
         yEd9UzOdm44dKGOB9vhvuqA14zDF0izirGlMHcIkPmvfAWV6oC7EWoZSr/n7pMgjOayy
         4XbbykfX2tOLXKQEY71fD4ubWMAf5smyh0PUCbn4ouKSDid+wdpti8tnvMNzC9U0omm7
         PfP/4oysMFjcZt/QSyQgeX6xWgKvlNh0WDaR4PRzqjFkBPghAucojPZwp0HxO1dsPk5w
         0TrSxGukXHJtQczzx+u36Zh+VEpUmtRmnvhCaIPp54UmNZzIkin7PEC6+n43usjPmyxQ
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754131; x=1795358931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=YmKsXllX7KQZDw6Mh6V1BpoXSc+opZSfLKk5SMHOUbxrbvXJYsLHIOhAIGisKwmrDc
         8aizcfAGX9aGfwpzokRAQ+sw3UJN5qYMBeGKIOBVBennQS+7WhZQ7Z0eBNzjdEEH0I3I
         6S8nm/uqzTz/XK5+cil4cizZDfoFLYthOii98kcCWVPa34Zclzs9E+OKy9V45tKbu8HJ
         4J4tBi8+/sSYjgVHllwTVfo8CAX7hjcC0bxdecJeBzq5dem3lHckRyzhVdRhpvwj9/Kc
         E/5Li0UKcNxe3L55VygpAG3mfD/ees5IqsBBugplokkg9c+bw+0LOhRocfC4uRAvECrc
         mZNA==
X-Gm-Message-State: APuU4Z/DWAiQVb51q6LGU6xNU5UguSQv+emVUcwCp5lpSZvexcuMuL4L
	mY4JrBuRUrmXm0u/Tew3H/xClwdSDyua9bXBfoqU5GCJ3pL08HhywtvmiOyKVVBZxGXmPNlmrKG
	hYEL63QIJj7T6TN09TvWWypZ37ebHQzU=
X-Gm-Gg: AYBFou0weKedDtanYTIW6Dvhv32UfQPsOYZsi3od+d1xRkV12+CU/Lw5xAMA7Z6zvHN
	HNw/sI5R2ocmtsUpVIdFGrldaXGJmT/bxm0awcVLLNx1m/4OJR8/uZoeYanSBLsET1ohjAKlRiJ
	Odzvsywe/MhJyZuzR2RJGAQz1Mt5zs8DQRbojiLvEWd4RLcrW8skX+axiVSikVFgEXBiDwSDCr3
	n1l9g2e2cA1kvpt9WJdzDCJz4rZ7gRKACZXuATTQiGSsi/MYzQmcJj6OsKDSemxtkUvlzYV11XV
	NCGmzwsknlHfcMyheesY6m2K4Y3gV7mcCMBRjp+Sy2eq5w4xU/qhRRjvpOaEAx73B32bS8FObca
	fEQgUdxhOYUrM82aMp/T6EFna+5H7N4LD7l/mJjUlYkkCjDAwpToSyHaWK8DfR6jtfWKEZQ==
X-Received: by 2002:a05:6402:1944:b0:6b6:edd7:790c with SMTP id
 4fb4d7f45d1cf-6b7c0d2c969mr5932123a12.45.1794754130672; Sun, 15 Nov 2026
 06:48:50 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:48:39 +0100
X-Gm-Features: AclHuK_loWLpZnEsR5-ArAPNE_f3U8cZmm7GbEpqPveHBdFtxvcWfTtvtccYOKk
Message-ID: <CAOQ4uxgiwKsadtv1Me3ZkSsTawjNey3wDDWVAnx6U0+Oe+uoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>
> Add a porting.rst entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  include/linux/dcache.h                | 13 -------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index c38f5df755bb5..28a24b702f2a6 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *. mnt_idmap=
() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified i=
t
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and return=
s an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a metacop=
y file
> +in a data-only layer. Use d_real_data_inode(), which returns the inode h=
osting
> +the data or an ERR_PTR(), and handle the error. Use d_real_metadata_inod=
e() for
> +the inode hosting the metadata. That one never fails.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 5b3b34d271bd0..2b15179e9baf9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct dentry *d=
entry, enum d_real_type type
>                 return dentry;
>  }
>
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real ino=
de.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry *dentry)
> -{
> -       /* This usage of d_real() results in const dentry */
> -       return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
> -}
> -
>  /**
>   * d_real_data_inode - Return the real inode hosting the data
>   * @dentry: The dentry to query
>
> --
> 2.53.0
>
