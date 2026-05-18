Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666333876B8
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080769; cv=pass; b=DsawZ3Y4QNA55ymGYnm3hbA6+l3DTEC63OmK5VJMGW/t8mrrXEh1cPyGfJnb5h8SfXRqKg6DNpFAeGOtfj4baS3hO1JCjo9GSQ6RTgmInezkKbKMQxN7PHxjm/mEWM/hxPMZGspKXhzURSI+cJNI5CV9v1jUPILqNxM+KIEvT1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080769; c=relaxed/simple;
	bh=qPsaENR0zwttibseiL5xNlM2jwq5mUueTZKJ27YG6EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUrwbHof7pYEJP1bH4tt8j/S8WayoivmRMjpKmu3Ns/Amn39QB/ozmDQhzSIhCZ4420t0GT5xeZxExD6ySDaQy0IEfNHZiTa5ocAbM8OaBX/E+mSdDY7HsWq8upvJ9zlyUVT8YmR1g+LkE+nFoUVUfRukT0Hf5lT3mbW3hX1Msk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=wIXSU4Z4; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="wIXSU4Z4"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c23248f3a3so11333337b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 22:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080766; cv=none;
        d=google.com; s=arc-20240605;
        b=T/qwtXkThjGoKPGoFVbEw/6ku3k1461JunT/ddG24fwTw/ZaZ/pfk1yFNAUVahsazL
         cjcWCunoRmVQNlJDxrYZFIDraWFve/rXB2yUhiQZCUnQnSB+wllXKxvkd3UMkDJgHvPe
         NL7cvjetKAMLaCE83XyRS1pgxoAVe9PxNbZMTp+norKqNqn4lcr7lVOWjhtSwzS3RQ0r
         2OPOAzaQwyPY6LdVrcC94CZTgrQHmEdRbXOXnx2ydQPSlnlFP60s1m8POQeJXI10+fKw
         60o3hfJO9vhP7v3FdPyUkWRY/5m8APoVlKafuAi38rzgQukp3K4Dlnixyi661rBzRCN1
         RpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zoebJlsA+63tuoGHKcXMN6kYNaJMHSUEcIkHT0SDOFU=;
        fh=zkLgD7Wrxuw7pJOsrlH/dzuZtUECXRuhxYA55YzfByQ=;
        b=Gt1OimPqK2ePjKqvIE9sgDK8sigZdWI3818aCq73Gj9ASS8PqYtE4DQn0Ej6DHzun8
         cJ9M+Ttyin2M3pBRRVAltXzxGpQEQlGnpjLX5PxaNiytqZ4g0+T8xPih1ctBD3Z+spv6
         jAVWi6x8MGfQOlRf0uJuOQQNlNwUy6nHj70K3LUJimtPZ6y6NS4nrJbdTspndpgDtRcU
         vA2JwGQEefmn3GIR2UP1KrrxwtMwvL73017K2Y53ibDgi9IZ5a82nFcnGibvwv2Gr7Fx
         EMM35uiPveR9XDu+cxdtzIjthCIZBJtNFqcAfDlWf77eawgmdo4K+iV549X864ePR+Ya
         vDWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1779080766; x=1779685566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoebJlsA+63tuoGHKcXMN6kYNaJMHSUEcIkHT0SDOFU=;
        b=wIXSU4Z4FnDA5TRzhFTGSqRWgyywS+ZD2sXhC6X3eBDKuKl1o1GV0T3WUnP21N9A41
         Gv6c9J54mPyFy0uxnzqxL0OT/YrKOnTOB+lny6ErkCbPvxUS+9t/4pGTOXMBYc+FnvIY
         zitd1uAG03rQGbBNVXuPUFDT0m0hgM+tOuvX5yXCCpIy6FiQxprpL+bhRkKsT2BI/dSF
         1yGOg+HwSUSCtG8duOFQIZwKqFi24XlleBSA9anf4M/TEds5/uMpoYz0WlgKX8qox4vw
         lCv0SMfZwPTrsKDtMc1LlhHg0eviWzsuHLf9Br0ZaRb+HWvAsxFheXvMQEmAbWfW0ntz
         tRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080766; x=1779685566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoebJlsA+63tuoGHKcXMN6kYNaJMHSUEcIkHT0SDOFU=;
        b=qtkMVybKRl7WgwOFcNMJG83yU90bq1vAruik+H2M894tSaTgaL+V35EPGnucyf6B+X
         Qz7NP1lQa9PUE3CVfCDwDyPBeL+FNS9MLkhpGqCUZxCQCGPjl3DxTm9kCzJdSeG+hU+y
         8ytauGaS5DBOTgdfOfdMVL3gc1wm5yQEkRnV3e8uIghW8V1eOv9XmR3kXw8dRt38Ds64
         gDzTT40PplurTKeX7O6ae6i9SODmgsMe0dU6drcwj6UVlQ0Sow15fRGd5sfSUuSBgCMS
         XgqpNeXLRPk07kDOJMJa2rMLjlZeKRiBBxQp+yz02dgbF5zS8hOcdA1S+K3NJNdYxp9V
         lKOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rAGWEXJIFE1r2jFFPytafCrYRc2QvVX+5YlyTZKWNdlJjBc9Zw4Oulh/QF1JsK67KDHW1LeTruNYjIy9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5xr93hVwVzENP7AH7reJujbxmk2MGTOTzy8XJv5+udPUzpkA
	wZptEeTCmwSw7BV+TMFSOvxcqgkTguMxQ2HEdxasSNc/dueMjeS2QCu7tO5DCLUSPiLDwAuAYJU
	LhqpPJxXoONph0dzM/gf8gjQuAK5uZcuqqAbGWRYbFA==
X-Gm-Gg: Acq92OENR956iRlFcUnWzVLuNlzNgby6DQgQ73SksPDUHQNnBso4U3yQpBIJ25whejQ
	vb9ZGNmkoCF9VdqO0gzTrH8Nt8Dkr0+fNb/Rkwv2gFUcZc6Mwrfr+3cuRz3UNSqi5c/S61YRaAQ
	9TSaqOt3XG8DC7Y87JXHBhRvGoiBClD5GT0MMNeCIAIM6pBbr6VOZg45Jyw/SePyt8VHXU1p9xV
	DtBOXx/3O7T7Y64IcmibSa6ZcDFABxEUubaICpirx3P4pRbFXjo/X5sdsbdUkkxhR/U8Vig3XOS
	L6TiiEA=
X-Received: by 2002:a05:690c:6d84:b0:7bb:712:a74f with SMTP id
 00721157ae682-7c95a66b906mr142527207b3.17.1779080766321; Sun, 17 May 2026
 22:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
 <20260517184141.21939-1-rochan.avlur@skydio.com> <CAKYAXd_PUKHpL4xtkcS+5iDGwf+WgEOFvM4T_XZ4SRtk8-jCyQ@mail.gmail.com>
In-Reply-To: <CAKYAXd_PUKHpL4xtkcS+5iDGwf+WgEOFvM4T_XZ4SRtk8-jCyQ@mail.gmail.com>
From: Rochan Avlur <rochan.avlur@skydio.com>
Date: Sun, 17 May 2026 22:05:54 -0700
X-Gm-Features: AVHnY4L0m6XBf1iqPzUKy6Z5ffm0umKBF0asfWuPHnh8GMw7eGLtlOxcAzbB6E8
Message-ID: <CAG7tbBX6O2x148dDbrHs+=c0LSdw=8CKXEWZ9TniyxFYy5Ln0g@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: preserve benign secondary entries during rename
 and move
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Rochan Avlur <rochan.avlur@gmail.com>, linux-fsdevel@vger.kernel.org, 
	sj1557.seo@samsung.com, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

> > @@ -523,6 +523,20 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
> >                 es->modified = true;
> >  }
> >
> > +void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order)
> Please merge them into a single function by adding a bool free_benign
> parameter like this.
>
> void exfat_remove_entries(struct inode *inode, struct
> exfat_entry_set_cache *es, int order,
>                                    bool free_benign)
> ...
>             if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
>                            exfat_free_benign_secondary_clusters(inode, ep);
> ...

Will do.

> > +/*
> > + * Copy benign secondary entries from @src_es to @dst_es, placing them after
> > + * the new filename entries.  Updates num_ext and the directory checksum.
> > + */
> > +static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src_es,
> > +               struct exfat_entry_set_cache *dst_es)
> > +{
> > +       struct exfat_dentry *ep;
> > +       int extra = exfat_count_extra_entries(src_es);
> > +       int new_entries = dst_es->num_entries - extra;
> > +       int i, src_start = src_es->num_entries - extra;
> > +
> > +       if (extra == 0)
> > +               return 0;
> It is better to move the calculation of new_entries and src_start
> after the extra == 0 early return.

Will do.

> > @@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent_inode,
> >
> >                 exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
> >
> > +               ret = exfat_copy_trailing_entries(&old_es, &new_es);
> > +               if (ret)
> > +                       goto put_old_es;
> > +
> >                 ret = exfat_put_dentry_set(&new_es, sync);
> >                 if (ret)
> >                         goto put_old_es;
> If exfat_put_dentry_set(&new_es) fails, It return without marking the
> new extra entries as deleted. This can result in duplicate entries.

I noticed the same issue. However, this is a pre-existing issue in the
original code and my patch doesn't change the error handling semantics here.

Would you prefer I fix the error path cleanup in this patch, or send it
as a separate follow-up?

Thanks for the review.
