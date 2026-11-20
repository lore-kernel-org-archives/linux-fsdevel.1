Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795201077;
	b=C6RNccKscVLj4mTgGLLgasEYR9dEHNXBrw6LSJpzQIspksEBgfFVaf7jiXqOlR0Mn+A0
	 2OAHSV1x13iQGAlYOW5WMuT9yqpKvHAtAVY7KaPMsguYOISvEEYtYGRVp1qQvxa1FFqTu
	 vzI7nxCICqqKeAFIsYZ2+A9O6414GDc/NCzo4OoP6d6yyMSIFiUONV8K5qjv0kV7NwWkT
	 wjlptqNB+rMw6P7jEW7M/nFK0JGzHzkQk58rFKSib5JDli2bL1WoSoCs5BPx8L0Q5RkUa
	 qF20uXSDDOhNqdBLqxxo1ifnldXMpGXb6Hjj1aSMuIOuG9wcPcm98APg7qORgz9ticg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ar/I9wixzu0Uno/udNMX0pnEPUMbJ11YDRSQnHpj1Cw=;
	b=K8XsmOUncqItLAvkulq91UjlHKFPWHMgIVXfaCXH4zZQnLCbTGbtG9//c2nVvALAq9G8
	 oHOFu/nWQQk6GDYqMJZJN9vlSLjKn/DFG6XYU8e/aY6uLfa24us2sx4PkCYFN0E0AN4z1
	 DZJBCmyOsMDFdD1rn6NldOQp9Qg00/v4E3tiuGxWuzL45n4Rz2ZVW0xJcw+fxcS/FfhzO
	 fj0U/mW9Z/nUQf4tktMuP4j80kNziywn8thwl10E/WwRK1BUCDChTo7IT7YdgXGLyJMOX
	 r5FvQfZ4YjHD3+V9A7xNZ5oijLu8+Ucpj3fbldIA8tJD6tUcihHQzFojKbg6mQI9BNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+JJi1Ab;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632C60A2621
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4632C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+JJi1Ab
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso3165e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 10:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795201070; cv=none;
        d=google.com; s=arc-20260327;
        b=fy9JGj4D3WtQcxcTtaI6DnPNDHGDX1fmHS/XQF9+1pM1hoS80AQhIy5y9D/LWfoD29
         EtVdcboRm3rjkKC1bvA0Ws2U0A9dMxcCRys+rM14nmxTKuuZVZUu35tujLCtNI2k4uj/
         NoRM1YXQMJR8hAlCoKdfpM0k8pjAgwqJf50hRR5/LC+hDXcPiTSTY1MBUTPrMyYmgv0L
         +9kmQn8e+tfsCzG4FQ71AiDDGeOJ4ynTFCK+ERsBH/f44H3udLpPwg1vuz1xnjdt9s0a
         UiHKzUFgmi/Scr6m0uGUJv+Ul9zn0dm9k4yedM1VIv16oSE9HtKn2Dx6Qu7gQ2rg9tmV
         XJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ar/I9wixzu0Uno/udNMX0pnEPUMbJ11YDRSQnHpj1Cw=;
        fh=Xnbmd+tB1dTq7fFMvrDLwABN+JJbjT9241px+19NtbQ=;
        b=GxqpZLIFiqE/YldTyLI6U1Pesss+lOZJr+nXqOZa81BxXVU/q4uGzxrZCVWOVUs8Zk
         kjGAbulgxz411gw1DiGyAW3jBBGYDXI2oqj1WS2uqor/1HCgbYngPEhxTSndKjqpRn3M
         1NSxAyj9lN+aZkia9mByRHXq3PvF1gJJZpYAwCtvULG8teNkKQtD1rrc8SdW13rGpq0X
         HLsTaFVLZzaBKippSxihKWVYBOg9r+s4/kN/gJF8Bmsw03bfnV/+ZDqXWh4JHu1f6TcW
         m+CT1w4OFCPQt28QpyrKmdSUo0PN0L/RGyGtqFRCHVFaev0QdXnXK4DYA5SBTyGV3aMU
         WWjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201070; x=1795805870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ar/I9wixzu0Uno/udNMX0pnEPUMbJ11YDRSQnHpj1Cw=;
        b=G+JJi1AbBd9rTsTnDIsz9Ag/cHJ9af2UPqG2XgL9pPzhaXckNqYtxIuAfGu41u0/Vn
         BIISlVSbBaj8z3es3k3FPB/GNS8RTFDiMRHHaJ8BAh0gsoGqgfErKR4qJRrRO2kW+lDF
         E1krPvh78Fr5UPhhf2jE87dqRrKmSPzKnX3JuBl5qbbzdMbsUfbHo1R6DJ91O7wnPtge
         jMbcUOIHi5xYk29IsSPxyX25b9MlkPnPK6w9ZgOyoK7HepcCY440xUsCtR99w1APdDMS
         9j2Bi9hfz5DZeu59/Wh+hTyGY/uZIhnOK+qkJqjg47JpeNMZfkO2ODX2qDtRyGUxPpwe
         Eb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201070; x=1795805870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ar/I9wixzu0Uno/udNMX0pnEPUMbJ11YDRSQnHpj1Cw=;
        b=XXHkPxosmgFNxinVnyvbQLXKUntbnCN9h1i2uDNVum1p0I/kpWSaH1zmn9+ccY58Ht
         qqDeqrYAJEBLV7NL9yFgIfl7hJXMezi+VJe7Y+czmJ6GLv9/mbnQBgnXuqGpVU+IlN/3
         dFK71kjDwvtnebX8ibOqQBCecaHehBhD2+HuZ+h7jDd8o9qMqL6Mta2bwsn7Q7X12W4g
         lBYrOOmBXlSN67ZMCGyXOD/WaTvllm+Um8Bndg1LPmsqpWgccyDDJqCUU0uQ3NoBXcMX
         R4pF5Kgef5EVqrOR2AZMlZlpEV/SP47HEACojlHTmLqdY7YDqWzB04unyN1TWkRxHBA3
         WySg==
X-Forwarded-Encrypted: i=1; AL+hErG2Ni/7414uHgdnkPDhFcq3uIbksOvy3F+gtU4rsYrj0cE9k1tiJDye20TA7tfGD+RS5y/8ppBcTjvct/K7@vger.kernel.org
X-Gm-Message-State: APuU4Z8deZviw1TX2FTP7jUTsQxFOrUV9xMouZ5GkU4WNTu+XLxC3Znh
	3anQMCXhZVzGk8k2dBN3HEyBOIi5k5AwJUCZtpM0LDsCfVa5hN9haay9BrgpYQ0x+vow1k/igGL
	39/3Xk/6ny+7J1WdNg2Xn8t+z5YwAS4L1lEyCHj/y
X-Gm-Gg: AYBFou15LqimFSJkhMPapa3kX0MJfCWVarCySl65DKNE8JS8YozkIOnUd9eE9NA3en1
	a91hxTn2GFic8/8eHpcZSJNg3Q5/uQjiKSMyss4fldlGcKEv15oYuXqVSqRcSle9EJRVSXmqQRX
	1L0k6N0dvGo0hiEWoS0zPqMfFbWNt6IEJawh1njSO9Vju39j0FGkyZz97luT9k/gCm6/k/2OvaZ
	KxXB5vZbuX6WILvym292trn92VJLDMUpf2AfmQkGpZIagPKXT100ZX0b18R2/s7/rGNnA2rAs1X
	qBHm1xcmWZ8gCwWqW3a6fu28lfQGxF2JlIJ1I0YRHQbadAJYzIkBgJ9s/Ljn8k6rfFotiR+qpBc
	/aXLJwtmj14wPyK3TVGYMD1qubce0fMlR9mX4yD4jOG/PbTDOuC+D1dzUZ8JX3p2d7Sg=
X-Received: by 2002:a05:600c:10c5:b0:4bb:7ad8:9d1c with SMTP id
 5b1f17b1804b1-4bb90c5a063mr9505e9.6.1795201070230; Fri, 20 Nov 2026 10:57:50
 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118220154.2965621-1-shakeel.butt@linux.dev> <20261118220154.2965621-5-shakeel.butt@linux.dev>
In-Reply-To: <20261118220154.2965621-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Nov 2026 10:57:38 -0800
X-Gm-Features: Aa3M54qYEmkoCcL8K-eS_MrHU--U7Q8sr1Os1o1ROUSCVqxdCeBq63ucWRqqKwM
Message-ID: <CABdmKX3-2UeZpOV0hHX7qh4K5cMWba6E5JiURhJMyp87sY4RtQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] kernfs: don't take kernfs_iattr_rwsem to publish KERNFS_REMOVING
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> __kernfs_remove() takes kernfs_iattr_rwsem for writing while it marks
> a subtree KERNFS_REMOVING, inside kernfs_rwsem.  Commit 507d8ce13f5b
> ("kernfs: Don't set_nlink for directories being removed") added it so
> that a refresh would not set the i_nlink of a directory whose removal
> has started.  The refresh no longer sets i_nlink, so the lock is not
> needed.
>
> The flag is only set here, under kernfs_rwsem.  Inode setup reads it
> under kernfs_rwsem.  getattr reads it without and reports the old link
> count or 0, either of which is right for a stat() racing the removal.
>
> Drop the lock, mark the store and the load, and read the flags once in
> kernfs_dir_nlink(), as the type bits share the word.
>
> kernfs_iattr_rwsem write acquisitions (lock_stat), before -> after:
>
>   5 dummy netdevs created and removed     1110 ->  740
>   100 cgroup mkdirs and 100 rmdirs        4500 -> 3000
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  fs/kernfs/dir.c   | 10 ++++++----
>  fs/kernfs/inode.c |  7 +++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index ef23eac684c6..890aca5d8d70 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1604,15 +1604,17 @@ static void __kernfs_remove(struct kernfs_node *k=
n)
>
>         pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
>
> -       /* prevent new usage by marking all nodes removing and deactivati=
ng */
> -       down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +       /*
> +        * Prevent new usage by marking all nodes removing and deactivati=
ng.
> +        * KERNFS_REMOVING is only set here, under kernfs_rwsem.
> +        * kernfs_dir_nlink() reads it without that lock.
> +        */
>         pos =3D NULL;
>         while ((pos =3D kernfs_next_descendant_post(pos, kn))) {
> -               pos->flags |=3D KERNFS_REMOVING;
> +               WRITE_ONCE(pos->flags, pos->flags | KERNFS_REMOVING);
>                 if (kernfs_active(pos))
>                         atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
>         }
> -       up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>
>         /* deactivate and unlink the subtree node-by-node */
>         do {
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 2f463c0354a5..ca234f69882b 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -165,9 +165,12 @@ static inline void set_inode_attr(struct inode *inod=
e,
>   */
>  static bool kernfs_dir_nlink(struct kernfs_node *kn, unsigned int *nlink=
)
>  {
> -       if (kernfs_type(kn) !=3D KERNFS_DIR)
> +       /* KERNFS_REMOVING can be set concurrently; read the flags once. =
*/
> +       unsigned short flags =3D READ_ONCE(kn->flags);

Hi Shakeel,

I'd like to ask for some code comments / documentation.

This lockless read relies on two rules for kn->flags... the type bits
and flags set before publication never change, and the other flags are
only changed with kernfs_rwsem held for write (except KERNFS_NS).

Parts of this are explained in a comment in kernfs_dop_revalidate()
but not on the field, and that comment doesn't cover KERNFS_HIDDEN or
KERNFS_SUICIDAL/SUICIDED.

Since this series adds a lockless reader that depends on these rules,
how about a comment on kernfs_node->flags like:

/*
 * Type bits, flags set before publication, and KERNFS_NS are stable;
the rest change under
 * kernfs_rwsem (write).  Lockless readers of changing flags must use
READ_ONCE(), taking
 * one snapshot if they also test stable bits.
 */


> +
> +       if ((flags & KERNFS_TYPE_MASK) !=3D KERNFS_DIR)
>                 return false;
> -       *nlink =3D (kn->flags & KERNFS_REMOVING) ? 0 :
> +       *nlink =3D (flags & KERNFS_REMOVING) ? 0 :
>                  READ_ONCE(kn->dir.subdirs) + 2;
>         return true;
>  }
> --
> 2.53.1-Meta
>
