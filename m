Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A81A6801
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238494; cv=pass; b=G3kcnQvEByW2vSY/lfahJ32j2e3s1t+/2JcOPPH4V6MN0khhj5SZPQzvj+GMwV5anXOTFI70J2pDqm64Gos08ye5moa5IMny87W0uHfMIpR5C1rGwN0BNYGDjkpE3m9/YKLMv1+iXKfDZTUKp0oPL8s+8k1PaiGI/H06uyGTXEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238494; c=relaxed/simple;
	bh=zj+Z0KiMal/nGLHoVOU+5XdHKpkvCLj8TjrIhNEocnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etlXeDzpJXrdWUPsvBnsxs52ZEhqf8qtzSdopeRAu3rZgRXyC8hIBcQfZwZpj9KiJrVAKFFScNO9rPmbWAVUhHkKhd2X3S4/Iq1PqfQjNG6kYcWqVt7G1CHpa7SOgGW0bCGPXXzhw/s6uI7/5mcCYlbwYk/04pE13B4qsyGCvWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeuvYcBi; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeuvYcBi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso25446605e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 17:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779238491; cv=none;
        d=google.com; s=arc-20240605;
        b=HTF/UbRAhZqZYYow4iyXCY11AkyAXqFjeqSAPy2d3XCNZZF1ob/ZMvKU6SVwIZkqT3
         hqbsSoYWdA6lWRsQJt+E7MjXZZURv5VweMxEJTZlxo9yPkRxyJvSQo6I/jUyo9Q8h9RL
         UjzuS7sb8oLzv76SuapL0Ve/hEVmnfzvkabITerUbxOQcwd7S82SblS6uIL9opREPQVr
         OUenpqJ5KkAk+VZ0HFyqfMKgAD6jCVDGYprc+V8/3PXGsOzkuPCEYXp9i2wPrwlylplK
         cQ6kKPaBSypDJSaFT85zwurWlrhuHR+3XN7QsZIVWFUz2JJnHJPfSXOCB8Xvv0gTG/qA
         KZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r0dKpvEhsK/6EdDtCzi10MWp4UZTNnJelXtlcRYUbVw=;
        fh=+CeIe7l9c5yhx7X8BDLFnO2CZzJdJ2h99dR1HJEPc34=;
        b=Iva6siwcea9Xf9fqDvMKnvZUh1Usfl3XUYODwohmPbbzDcOuCrQzkAigis4gMc3/op
         B2kQysKQ5EjqZalXEhc2uPNMM28i9lRCxlj7UO4tYYtEApO1Z00c2X4eHw+xMNgI0QUX
         znIA3u8u/XDCJ+am6mhABbvR98IC/QwAvDoWoovOu6e+7L4aN2Gc1Bd8gVsXnZXuVSM8
         WjfiS1ZNAW6RwdrYwEcb86jBLnhotlz35AdP1e+isP6JNvHpGRpbuDq64nsrJZigmgxn
         1oF/4c2Mp4GL8XY+r2/BM0T01rt197Wz+G8TvXrMMFvbLV8X1NxwuklzU8GRnYD7Aw0Q
         Zwpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779238491; x=1779843291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0dKpvEhsK/6EdDtCzi10MWp4UZTNnJelXtlcRYUbVw=;
        b=VeuvYcBi/v4WcLKNUho6Negu1S2GLxQAxehVdTO9JIDa2P0c0Zv8GRSFA0oO4uh4aa
         bu9F/41iNmrbJHsqjqajBYb0bpaoYhG6Tx3d0eW1w5kWJtZoOyrTwkbP9nNkCu1w/GKS
         uWJIHIeahWFQAwcsWGZCFuI+62vwAr4D9afcbsqQZtl5pD9gwIDB3Z3VsM7D1XdAFzym
         2zbBlbn8kQiZ+Jzr4WTdCFj1qM7TonR/jU6Kc3/Dh1lQYhAiux22OMMkcC1jmJ2AcccT
         Klto3bfsxdp9SA9Mtlp5h8S0CsbFDcqnm9Utso3RpZHMU+Z0+xeYir4m4ACn3dL/bpMC
         SRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238491; x=1779843291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0dKpvEhsK/6EdDtCzi10MWp4UZTNnJelXtlcRYUbVw=;
        b=ZZvwKfUoAmx5LUh6ec4ag+Y8CIeyOmFFXDEuxvMNJ6g1Tz2bsS8bf2bDhntjtyc/8n
         pvDR8q8X5uPQj4fEUGeNQo/YROki9ASmYWaAzjRzy2RH+SF5w3bYA5vrpL9MG2VGecH7
         rQHou0mCNLypNJ1+tAkSxLJZPMVqP1PyCrNqPKRaOTq6PnhlzPvuR3+oOQ8YKwlzneH8
         0cPDyW6M8zEMreZxHI7m44XQTlQ3MHKKy1me4vOv7du65IOfiJrXBvhMcqpXQneoyQRb
         cQFCtoAf4HJzrhqQi9xh14HKClGgijP3nYAa1Xqq4PMjlZeV45bWIDDOSEYkWM+WDYV4
         0Ijg==
X-Forwarded-Encrypted: i=1; AFNElJ81I+bWi5AIaeuTKgR38N+umCzsw1gTbrVg4/A1PHWyUU+lwKrYb7BIj3GX7GaR2PY9xnDS7Skq5QpFEX55@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+Ti4bfWMsS4rzQbBHnPtgP7LwpUmatQE2hVYU5MzAsjRJGMD
	PdV1K9n42usXPYW7cQAjnsftRH2oHLcVpVgPiqRtGdC9FJ5V2tgZZSXGod4DFL24NvVSfSJV1Zl
	XHuQwtJnNUdiARTyQV/qvxpEnYX1WcNc=
X-Gm-Gg: Acq92OEwwwH9jCJHPMZ1RopOrjX6+4yS2vOxoomOcLX9CB5cFaG5+VxBvjHLfMF/rcP
	/tCiyGxooZfbEQcHfSg6lfcZNnJrv9QX2Bacyf0F24TnMD3Ac/7T+ROSFpyCbIGug2Eoivn2BmB
	qUErUBQzQ/jOXnKigSQiaF7HYSbaoGB1hmdIUfa2inonR16ZSSKJm1YoEdkH3xqZrKi26oeH3jT
	O/0AAI7MvnN4IpoUrYgm8xEYO2JQ0MlvbAFjXJK9CqB6z9HOb869J9vsRi47qxD2oO4zFBlSIXE
	zKWDXQ==
X-Received: by 2002:a05:600c:8b67:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48fe6325a52mr390582645e9.29.1779238491463; Tue, 19 May 2026
 17:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-14-joannelkoong@gmail.com> <45e57cb2-6b0c-46b7-b614-a32eb9aa394c@bsbernd.com>
In-Reply-To: <45e57cb2-6b0c-46b7-b614-a32eb9aa394c@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 19 May 2026 17:54:39 -0700
X-Gm-Features: AVHnY4J96SxPAOkCLI_G6Shuj2-IW5bCxXSt7r-lxGQMLDQD9WiqTNwTbTSHI8U
Message-ID: <CAJnrk1ZM+3a+kHuyrGeF4EUpY99w_3Lgs5BGBzs+rEcTbfpQ8w@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 4:45=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> On 4/2/26 18:28, Joanne Koong wrote:
> >
> > The request flow for the zero-copy write path (client writes data,
> > server reads it) is as follows:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > |  Kernel                                   |  FUSE server
> > |                                           |
> > |  "write(fd, buf, 1MB)"                    |
> > |                                           |
> > |  >sys_write()                             |
> > |    >fuse_file_write_iter()                |
> > |      >fuse_send_one()                     |
> > |        [req->args->in_pages =3D true]       |
> > |        [folios hold client write data]    |
> > |                                           |
> > |  >fuse_uring_copy_to_ring()               |
> > |    >copy_header_to_ring(IN_OUT)           |
> > |      [memcpy fuse_in_header to            |
> > |       pinned headers buf via kaddr]       |
> > |    >copy_header_to_ring(OP)               |
> > |      [memcpy write_in header]             |
> > |                                           |
> > |    >fuse_uring_args_to_ring()             |
> > |      >setup_fuse_copy_state()             |
> > |        [is_kaddr =3D true]                  |
> > |        [skip_folio_copy =3D true]           |
> > |                                           |
> > |      >fuse_uring_set_up_zero_copy()       |
> > |        [folio_get for each client folio]  |
> > |        [build bio_vec array from folios]  |
> > |        >io_buffer_register_bvec()         |
> > |          [register pages at ent->id]      |
>
> Somehow I find ent->id really confusing here. ent->slot_idx? Or even
> ent->tag?
>

I can rename this to slot_idx if you prefer that.

> > +static int fuse_uring_set_up_zero_copy(struct fuse_ring_ent *ent,
> > +                                    struct fuse_req *req,
> > +                                    unsigned int issue_flags)
> > +{
> > +     struct fuse_args_pages *ap;
> > +     int err, i, ddir =3D 0;
> > +     struct fuse_zero_copy_bvs *zc_bvs;
> > +     struct bio_vec *bvs;
> > +
> > +     /* out_pages indicates a read, in_pages indicates a write */
> > +     if (req->args->out_pages)
> > +             ddir |=3D IO_BUF_DEST;
> > +     if (req->args->in_pages)
> > +             ddir |=3D IO_BUF_SOURCE;
> > +
> > +     WARN_ON_ONCE(!ddir);
> > +
> > +     ap =3D container_of(req->args, typeof(*ap), args);
> > +
> > +     zc_bvs =3D kmalloc(struct_size(zc_bvs, bvs, ap->num_folios),
> > +                      GFP_KERNEL_ACCOUNT);
> > +     if (!zc_bvs)
> > +             return -ENOMEM;
> > +
> > +     zc_bvs->nr_bvs =3D ap->num_folios;
> > +     bvs =3D zc_bvs->bvs;
> > +     for (i =3D 0; i < ap->num_folios; i++) {
> > +             bvs[i].bv_page =3D folio_page(ap->folios[i], 0);
>
> Hmm, I thought everything was prepared for huge folios? Shouldn't this
> function here be updated to handle that? Iterate over all folios add up
> the number of pages and then iterate over all folios and pages?

This works with large folios - here we are just passing in the head of
the folio and the "bvs[i].bv_len =3D ap->descs[i].length" line below
describes the size of the folio. io_buffer_register_bvec() supports
multi-page bvecs.

Thanks,
Joanne
>
> > +             bvs[i].bv_offset =3D ap->descs[i].offset;
> > +             bvs[i].bv_len =3D ap->descs[i].length;
> > +             folio_get(ap->folios[i]);
> > +     }
