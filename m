Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3382D73A6
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963067; cv=pass; b=k4/b1fww4AmJ60+6B0wRb1eD7DDjKdorh5y0xHVq0jcbuiWLPT90q1vTMOgi5BPOVrp19gBG3gDm0WSA3Pw65oU6LMG6I9yGr/ZaXt4YVTuiXv7zLvKPWveYfVHzrTep0ic0dqV5+cLMxZpqsAf3GWvQpWjBvWeCcGFxegKcEP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963067; c=relaxed/simple;
	bh=ANWdGO//5boF9GBkYHCN31xwjUrlONPsoA7yg0gRGT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4JgYO6bC/O5IYT6eo0KFRwGWPhaAj01+yIe4gZnVXjj9f+WBNftnn/RG6u1PKpPNT6eB9kYDBMfcAVBGLUmXBsfns8BZu+oaU+ZYC6X+VuaiyF7hNK9wRwrlmD7eUkebVR5OtZVPQsj6R+mo0+qbdNOoh3Ex3IEj0vdyrnenjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiaqrZyf; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiaqrZyf"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39669bcaadfso34642411fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 16:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780963065; cv=none;
        d=google.com; s=arc-20240605;
        b=QpvMECcyjPkXEBYakgsjj1BaNndu3SFSJ8n2BZj5enu7hri0x+E7o0YYimDnl4p4Nl
         r3+5kdfvytr3nyx2ZfBbaD4JGwYsoCNfYCyyBZNMlrhsmjsvPyyPEge/9HLCkMzod2Di
         hUEChOAfCbumTw3aDEzpdU9fUj0m2832ibmVMv8ciLystg7qTWzOXIenTnxW6cnK0lT0
         uhh/QmSJX4nuoXkZ35cEzptMe/XXtJ23F60j3VkiTxg8mgNQoaD+ufC1WfFy1w0fWTsU
         /AIiAv+Hl7Oeg3VQ54eVVBQvgsYVLzbU93Xzffp9/lLjGfkFDetHiblhoxaEZxFx0aDB
         Rttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IzMDgrIJqvdWz9r71O2r7LZezY5wUbLIeYEDtdSiek=;
        fh=W7r7MZ6hSzyL0Su5Hu2hiWH8kCT374TjsjyoJYJ00Y0=;
        b=geze+HvPpiftQhixuDK1kUBbITbeInc8dGCQ7fOnbO0gnDRkF6v9hsR3UfOQqygzAe
         y6W8jt4cQSS7FkVzmEq1MyQqjoRa3NjL4NW6nOnxbV1yRshbugToJLod7BNCIq6M9b1p
         f/hV5GxhazTTfypFMjg6Ks+YZQt8WjX2IJfYJfQafoIQb3zgYcDXGEdo2X4tX9htsgpH
         /BYmcAVa631Z5liOK0mkaN8AUNdNCeQJaifM5Y586cy9Zy7FZj1GHUfIE/vbZni4b7J6
         pClrQ1rkqZB3dH7BE1Bo7WfBC265emsdDJWH4paRMJnCM10uEsFPHgTzgTykm3qFzah1
         NC1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780963065; x=1781567865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IzMDgrIJqvdWz9r71O2r7LZezY5wUbLIeYEDtdSiek=;
        b=ZiaqrZyfb2iNw4W8D6mHh8TBwI7mvGDlbRB9LRi8375tykRw1Q1U6KVKklha4ZNBsy
         8MJmd4J5vIF0tbIt3Kxc6/VWIcaHi0+x5CdNTObJs0xSBs/FuDNIgoPk3rNur3tpSnYe
         s7bjAFCzpDEWHdRu7yurw2NRMgU3riua8A553TMbkB35hrqfDWnv/tcZwxajQhcVb0uw
         EO/ek7BHt4ALBq00atJcY8BBQ0SpMssmHx9ML9LhdAMlsRXHf04WurPakiBQkEOzdi7H
         MMvsQap1e7Yn0DFyeJeC0Vko3SJZKaRY6bfm8f/mSIqN5LXtgJPiLetexM1UcV8isdWF
         I20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963065; x=1781567865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IzMDgrIJqvdWz9r71O2r7LZezY5wUbLIeYEDtdSiek=;
        b=AnvWGowfrJhoN6CggGYqmlxGqwwP/6Bbk/QL7j6h2afTjsbInt1l83TgOn17MqjQ/h
         8bSBuebH6N6oHSZvvUcrr6q/9MW2iHy7kojpJJ8y5x2+XSZVCykbOxD6Ec4yQaADNGoH
         n05wPx2DP7YoxTckcyQ4hJrxFBkIH5/XINIKpvgMCfQ5vQPjTUMk8MuDqQBGa8WVBF3u
         dqhdAVmAltFzn6lx6rqkha9dGaq5uKTsVntFPP3z0mvrNdQ2CVusFnJp5jy0J7qeiysd
         sEFoIhD5qzcaRmt5qwE7wafF3NzhkMWjGJHufQacGO2IF61cvAJt+6ialB1LQToAZnCs
         GtEw==
X-Forwarded-Encrypted: i=1; AFNElJ8EXG6gyuryf6vdsJZyO24xb8/uKIvJYf+bjuHc5jHgI7kN7cDAJW7wlMs7gTbzJBCPhiAFw6eO/y//3ycg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZblMPhbPg0Nlt+yYj7lC5Q31WCw+XbRnDLtZar0vToYxmtXg
	166KOqGwk4DuGTLuBlNwBqFg/+I4itYLMgZMrMlYL1mCTaMIhLXiB7iCeXnva6ZaivB5CXj5ZI7
	opKGcpN7N9/yeFRXb2IWynIQwm7dB5bw=
X-Gm-Gg: Acq92OGRp/IHj+4jCQAbZm6lXBa1c3Yi5hM1cdM0WwogHAp/7YTJEsZG1HcIp/tZ867
	nldCH2RR7//Iw73NHgYH126X7bPR/mYlPj8niSlD0LLtNmZqzpGB3KLBdYk6kx43CRzVxxhhUja
	YSxw7qZwuLNKf/5TrdKqbE7vLp8EvNi4xDzRrkrNWqg4iH5Jvreyy2nrMYWob7pAe3+LD29YHoo
	GZCAfSfQWZgcZYNfOu0lw3BZDQOrZw3FCkK7IRSxRwgNFt8WBDpPa7ZJGG4hkOy4ReMHd4As41h
	QA+m8E8/5UXG2TzY5Q==
X-Received: by 2002:a2e:2203:0:b0:396:9967:cd69 with SMTP id
 38308e7fff4ca-396d08aa2d8mr34816321fa.13.1780963064577; Mon, 08 Jun 2026
 16:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608154917.2703739-1-charsyam@gmail.com> <20260608154917.2703739-4-charsyam@gmail.com>
In-Reply-To: <20260608154917.2703739-4-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 08:57:32 +0900
X-Gm-Features: AVVi8CdqOsjxAVe6vNNs45XlQE9r9vW1TLz9AKlqyI7lUU1WB47ebdXF07eIQfY
Message-ID: <CANFS6bZu2O4Ucv_5DXCxe5vvjqLHrmDpZcz-a2gEHw+Se=Mdvw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] ntfs: update index root allocated size before shrink
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:49, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_ir_truncate() currently shrinks the resident $INDEX_ROOT value first
> and only updates index.allocated_size after re-looking up the attribute.
> During that relookup, the resident value_length can already be smaller
> while index.allocated_size still contains the old larger size.
>
> That leaves a transiently inconsistent $INDEX_ROOT layout and prevents
> lookup-time $INDEX_ROOT validation from being enabled: validation can
> correctly reject allocated_size extending past the newly shrunk resident
> value.
>
> When shrinking, lower index.allocated_size before shrinking value_length.
> If the truncate fails, restore the old allocated_size. Keep the existing
> grow ordering because the old allocated_size remains within the enlarged
> resident value until it is updated after the relookup. The shrink path is
> safe because the new value_length still covers struct index_root, so the
> index.allocated_size field remains present while it is updated first.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/index.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 052d80fddbbc..c5f2cf75b750 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1365,9 +1365,16 @@ static int ntfs_ir_reparent(struct ntfs_index_cont=
ext *icx)
>  static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_siz=
e)
>  {
>         int ret;
> +       u32 old_allocated_size;
> +       bool shrink;
>
>         ntfs_debug("Entering\n");
>
> +       old_allocated_size =3D le32_to_cpu(icx->ir->index.allocated_size)=
;
> +       shrink =3D data_size < old_allocated_size;
> +       if (shrink)
> +               icx->ir->index.allocated_size =3D cpu_to_le32(data_size);
> +
>         /*
>          *  INDEX_ROOT must be resident and its entries can be moved to
>          *  struct index_block, so ENOSPC isn't a real error.
> @@ -1379,9 +1386,14 @@ static int ntfs_ir_truncate(struct ntfs_index_cont=
ext *icx, int data_size)
>                 if (!icx->ir)
>                         return -ENOENT;
>
> -               icx->ir->index.allocated_size =3D cpu_to_le32(data_size);
> -       } else if (ret !=3D -ENOSPC)
> -               ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDE=
X_ROOT");
> +               if (!shrink)
> +                       icx->ir->index.allocated_size =3D cpu_to_le32(dat=
a_size);
> +       } else {
> +               if (shrink)
> +                       icx->ir->index.allocated_size =3D cpu_to_le32(old=
_allocated_size);
> +               if (ret !=3D -ENOSPC)
> +                       ntfs_error(icx->idx_ni->vol->sb, "Failed to trunc=
ate INDEX_ROOT");
> +       }
>
>         return ret;
>  }
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
