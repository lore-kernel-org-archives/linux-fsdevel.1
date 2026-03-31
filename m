Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12A366DDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923244; cv=pass; b=fyThILjJEfE8GjIfU5z/2BMHr/STY/IzZbdkTKfiWopmLQSpbiGtSF/X60nUXVUR1Laqfv4Tq5Hlos0WlTpSZxNAO/EK6zfiRV5lczHPdhDgkNyiWF/meZAeMAWspQFFEGkgllftnM79NStOqRIpwmwwcgBbF/KiKidHdG3C9Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923244; c=relaxed/simple;
	bh=kuHXhiMZpV8pzgclUVPNNZAJrO4wx07kTO5po2LMqSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd5Yw931SDKyVZZj9TxZoEGWx0gV4YXSRTwIXXHkQLak3TAK6/mY/RU2LZ3u0mDizhfxi5ZKhxitgBF6gas5W5hJvnKaQ9vpIq91PFcgHZZec3TG8a47nnG1NV3eTMAPsIX36PvAcS44w0Qi40zOG9G/fmBBpk8b+GtFZV8QUXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GYGCT/NS; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GYGCT/NS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2998552a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774923242; cv=none;
        d=google.com; s=arc-20240605;
        b=Aj2cCuYE6e8fr6xYOSm27qRTMSamsgfM7QrFcqqQLRH5TxCDzcl0/eTyGABqtogfey
         yTGAJatG4oeVCch33WduMl3sbB8ITLtIhwmWIDH9oVv3ahIWgnuEkGjD8Jx0v+OFHg+e
         nfHPwFGdWIt1GDvXrozUyegnrVZgqKb6kaHRk1oJ9esw95aUbZ+/b3Jhygf/3TuPB6gX
         UQhcA8zSaJUHgHkWySrXwry3enb6GnqgEp5QdmEFffQjLm6KTP4nrnc5JXXrmZmj7gM/
         n5bBcM9Ng4aw+TTiZy9fHqY0zqdKqyLOH1xojz0yc2+7Q86RTi3N7lEhhDFhJB5WG42w
         hfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        fh=qcOtCnOnAVid85hDkP/Ae2ZhOot/hZU7gb6B93RbSgA=;
        b=Fve/W4Qw0tkXsWGRDtOIvdoBXg+G6YQLXEaUrATUDLKU282mgEwJJDkX56LxlOT/XB
         8LVY6QkASFFbh5mRbXUQOMFPa82+UK0sNqwOVixahvOLY0cFsCnVZvxVaiiOg3iyYvyL
         gEhDERttkdCBata1Uge/fBUJy+Evs94FGdALry1DeNE/m3Gai8Dg0hKqutQ9EXp+tNmU
         B+iHOvOx0CFpzn7NHJUU1iFn0MWEC4E1iaOrrWTJCwMhUlTd21DLdnKbXI2EbWjXqVjX
         N/IN4LkHxZ8RSEk8iy4ZvhBgRJMzd3hJVEzDGIMHuurAts7AWLynQEgUCPk8cD4Zue+C
         3Aag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774923242; x=1775528042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=GYGCT/NSXsOi8vmwL5DlhSSh4I0Ja1JeqXScEjDMtkGydO6MDYcNwbPBuyi6AL/0gk
         8aeEnV5M73vYmilF4UnDnaD9lw68AJSwi/mrbGJu6/X2S8kL1o/fjwaFi2qtnO9Gux63
         8uW0tJA2iXIWKcWULVPxGbHGThdqvHpYWA3tdHkhJpGTqTiEdrh/GtQ1SMnwEhZHmAME
         gl+JtG2JY4GkeQtUvrfJMRYk2Cuc0JLLAQi3BZePNnRz2VyhcbnlqCSjZHXvFr5hBBnK
         mvxiKzyfoK5ytQAJySI0ZXdzbc3EwvtOXSgMOqVMsyrK57e8CC2etHkVLyjCya6cr374
         AKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774923242; x=1775528042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=TnlkEgtVL8gADOsCQumd85Xl/4LwjNH3MHKgE36OdzJNxv04Aa4hjCTEYofNSenb/A
         aoViMcVWlTIZ80pmCPMecC+ilQpvhz4qliIXnm4H1D+FdiJ2Vmf/udsc+AKvnbVLUOOV
         61J76hQaHlaAKg0P0NkLylpyV2mVcikdKE0LV0wQxpR76DBr7pGXokG19FvhllaPV02B
         P8eoepfcRX8ERtEZk0tukWbfOFohLVI7Qe5tkhrkF66KUiy380U1W7euqYbobFrl04gI
         v+dhjCzEpV5HH/tMfDocsQls+XhJcyItwHBirJcHRos0xtsPrGydFxKIUPeMlyYC/bDu
         Reig==
X-Forwarded-Encrypted: i=1; AJvYcCUVVdjHxr8kJ01cJEfRSBxTamiOvBIT8MfhR6tENOKuciUul3om7gLbFC/qk5VTKUbRiLtITShv3gDnRacG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPiSL9hO6paCgwMkHBPAxvUVk2phrZsP85dCj2kbGz7P3SYT+
	EQTvjKgn3eaPtKqkSOFs1fle3dD5XM5BGx8umrHwkwWoTvFM/iPAt9Wjj7ilZahm3XH82LYuspl
	Y5Z/oZnxd4e9rIYB/tCqilphoqsDiMVZkO+Z8xPsi
X-Gm-Gg: ATEYQzwm5U3KtzOcxBon5U5QwMOZTrCz3EjqY/grL3uFV7R3EOlRXgRsfgpCUhLTf4m
	hmoJSL48JQgekFIi/S7uhsObUUiUzeZ8+b3uCgpVe0X7C66m/kMNiAgOQrwwsV6WBuJ9RDFK7V6
	RhvpY0fA45GgpszZHlHNwXngmEqvnjFigMcYy/mcSKp8ehQVujqiSwu3fiQCFiJp7Y/VP8Byjjf
	WL0RX2956OdFMvSYPHYV10uQLpM0muk84GduZVpP8rAXO6hTfg6H8oH455rTBy1fm7xGqbikrRL
	LaKactI=
X-Received: by 2002:a17:90b:1e4e:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-35db8e5d15amr1344113a91.2.1774923242128; Mon, 30 Mar 2026
 19:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
 <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 30 Mar 2026 22:13:49 -0400
X-Gm-Features: AQROBzAeO-pr44FHCmrznY1FfG77xj1P2susMVAMZI8kAhJNYbfNcCYgp9cpQWg
Message-ID: <CAHC9VhRvJwrp47-A0frOjJcTmiLr0G218idQ9obXBrNpRWuDUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:35=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created ...

...

> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..0bdc26cae138 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -50,6 +50,7 @@ struct backing_file {
> >                 struct path user_path;
> >                 freeptr_t bf_freeptr;
> >         };
> > +       void *security;
>
> This needs ifdef SECURITY

Yep.  That will require some other changes, but I should be able to
keep those fairly limited.

> and the name should be user_security

I'd strongly prefer to keep it as "security" both because "void
*security" is a very common pattern in the kernel when adding LSM
blobs to structs, and we don't know what each and every LSM may need
to store in the backing_file LSM blob.

> > +void *backing_file_security(const struct file *f)
> > +{
> > +       return backing_file(f)->security;
> > +}
>
> I prefer the name backing_file_user_security()
>
> Terminology here is very confusing but when saying
> "backing file" it is more natural that one is referring to the
> backing xfs file with overlayfs has opened.
>
> The "backing file" already has an LSM blob f->f_security
> which is fair the call it the "backing file's LSM blob" ...

From a LSM dev's perspective, I would call file->f_security blob a
file's LSM blob regardless of if the file is a user or backing file;
the backing_file->security blob would be a backing file LSM blob.  If
you look at what the SELinux code does, specifically in the
__file_has_perm() and __file_map_prot_check() functions (newly added
in this patchset), you'll see this supported by the code: the
file->f_security field is basically handled the same regardless of if
it is a user or backing file whereas the backing_file->security field
is handled very differently because it is a backing file.

While I think it makes sense to match the accessor function's name to
the struct field, ultimately I care more about the struct field's
name.  If you really feel strongly about changing
backing_file_security() to backing_file_user_security() I can live
with that so long as we keep backing_file->security intact.

> > @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
> >                 percpu_counter_dec(&nr_files);
> >         put_cred(f->f_cred);
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               path_put(backing_file_user_path(f));
> > -               kmem_cache_free(bfilp_cachep, backing_file(f));
> > +               struct backing_file *ff =3D backing_file(f);
> > +
> > +               security_backing_file_free(&ff->security);
> > +               path_put(&ff->user_path);
> > +               kmem_cache_free(bfilp_cachep, ff);
>
> Not directly related to your patch, but as this is growing, IMO
> this would look cleaner with backing_file_free() inline helper
> (see attached path).

Sure, I'll include your patch in the patchset.  I'll also fix the
comment style in the patch to match C style in the rest of the file
(I'll note the change in the metadata).

> >         } else {
> >                 kmem_cache_free(filp_cachep, f);
> >         }
> > @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                     const struct file *user_file)
> >  {
> >         struct backing_file *ff;
> >         int error;
> > @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >         }
> >
> >         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> > +       error =3D security_backing_file_alloc(&ff->security, user_file)=
;
> > +       if (unlikely(error)) {
> > +               fput(&ff->file);
> > +               return ERR_PTR(error);
> > +       }
> >         return &ff->file;
> >  }
>
> There is an API issue here.
> in order to call fput() we must ensure that user_security was initialized=
 to
> NULL (or allocated).
>
> I don't think that we want security_backing_file_alloc() to provide this
> semantic and the current patch does not implement it.
>
> Furthermore, user_path is also not initialized in the error case.
>
> Attached UNTESTED fixup patch to suggest a cleanup with
> init_backing_file() helper.
>
> It also changes the variable and helper name to user_security
> and plays some trick to avoid many ifdef SECURITY.
> Feel free to take whichever bits you like with/without attribution.

I think I've got a cleaner approach than what you've proposed, let me
code it up, test it all, and I'll post a new revision of the patchset
soon.

--=20
paul-moore.com
