Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019652;
	b=RywjAfKQzgXmQQKguSLip3KfQz3voIPB1BFoTBXrYOfMYSGBzMhNzjI+6VrtPHR9J61D
	 oax8CXxf0uSSKRiDUcBf3I9CVG8F+OrpbjQXSrLQtnKpSOuJ8MNAnyL5Ujq/8XtwLOgHr
	 ZyZaQ0UrKUCBqEgkujpT8kWL/bNaTnY7Q66IuCDnyEWLD9Zoaoj/IwXxjNeKkgB9NjymN
	 bG5Q2k4FC5RZ3uuPw/l/HcWgrTgDf8asofV4jsgksQT1ma1KHT40qiA4pt+Py2i5kA50D
	 9oLQpDScmD3ISdralI8rZ1rXN1x+hdF3KutBP+RxEetucQT1gmuzlRCT40Ga0pxv2AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=N6HX3LXsa4mhOdLfCTbxFIXTc5FHr4ZNGQBe4lysFkI=;
	b=N0w9ZNx8DglXq10zODVdNt00l2IBD5arYk6gril9LSvxyZYdkshvGRHdQTf+ScuEpE8M
	 FrCMXuZ0oHdbrNdo8uR2MYe6mQJSFPdOyAdpGM7ako5Bg5gWAGiHsVIhqMfRIhGmKF+BD
	 8kIbbV+lDwp0uj72KTq0Ij3AQgR3w7Aot6PqaqB4yKpqNXPVD7yoTd1SWW+WJbH7vyGI5
	 qJjrJEk38r6m9VCkdbmsgkrClnQXr0WgKX/bDbzd3inf1AiR5e1R10CzVd9TsJ8b8FCLZ
	 mG9bEkBRe8PE/icoOHNcz58tZJWtb1WsNqF6f2FZPbD65h4KsEklMm8yTAGPQ5c90uA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edDD+3HN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34491606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34491606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edDD+3HN
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so1851370a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:34:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795019647; cv=none;
        d=google.com; s=arc-20260327;
        b=kz7lKn9OXaYkKTJQUxRriY3l2HRfcoN7I2uh4McxfaM9dLuaS5YqCc3TCNPGG+YDx8
         9EXH9Z5JVSPF60T4XOUb8+vh7YlEIQ92zpTdwUKS9PAUSFBlQtIkvJE4Wa20EOGyS5qY
         Jlik1LBX9BHLHGuyWxj2diCyttCcTUQEeDK4MRQcpgYqAvfbW4xWsG/GuYlYcekwTC87
         9J5ltuQvIPSZu9p0iJtGSXePrZ52K7G5tJI8BqclUxy4QYvEUBZm5J91GwQBjHoXklnB
         SWXxweq4lGUp4hAHiDLiqdt33uXf4sBFKsCtxDIStnWe9wpsrs01G2HNuciD1MYgyAPl
         1vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6HX3LXsa4mhOdLfCTbxFIXTc5FHr4ZNGQBe4lysFkI=;
        fh=swbEoOtOq9d+XfXVVr3Kx7pt0fJkY8UHj6QbA3pQY1U=;
        b=jv9X8sh6FTOP6sZg//S7iFIKUb/uQ5x71HS/2W7mpS0sQ9E/S0VOnUweaU1TfRZ/Jk
         GHsUz6ixH/+Us+cfi6m9AepmgLcfKfsIhf2UhEeYmHULzLAK6PEbe8rko/ZEzGGqhSWk
         5m2D+aZ5u3KL0UrJb8od8q2DEpgY5X4kluUyCK0+Z2coCCjuQUAqbxDGfWfNAJ1IJUO4
         aFCzCTevYRYXhw9fAdO2/XlmO5a8gwJ7HWrROTCzVz53qTh8nPYlSlX74e33ZPcuitH8
         YFvZw7EoveBCeeqK6q5x3jLKYqVrFfSo0SxLC745z4YcR8cIj/piIP8F6QWLNgd8KOYl
         iPkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019647; x=1795624447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N6HX3LXsa4mhOdLfCTbxFIXTc5FHr4ZNGQBe4lysFkI=;
        b=edDD+3HN3eSgxPe1vLYMsZA9DrM5whP4dDb6n+MqzrRN7ZqOif36k7v2vBh/SURUzl
         h45+n5470/Z1jV0YhRHqQGF8vCKxYixCoW96DLDba2renWvH3vOO+WEsdwtqHwRM2bly
         rGjZ500zdbUecLbTi7KBVdGOT58lTeKB0SbBCg2Gdmp0szBqM7jDK7Qc4QUQ+SW/KHyS
         pYbjN2WhdxX24l9f2g61LHIlBuowbE2fzG2sUPimi1+EANR3GhB9jK35eA9Dkb3JL+D+
         g3ufmoSo9e5O/Zu/uPruXbqCKquDzeHhTWiwpTLCOWYzi5kI5gkCjFHqRHJUjE+314hb
         q1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019647; x=1795624447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6HX3LXsa4mhOdLfCTbxFIXTc5FHr4ZNGQBe4lysFkI=;
        b=Zq+1LTqWj1fOW2yPEP21yv3hDJxn6zVgyGsqLeCe1mfZ5fBTRUbDYAYf5dUs4mq2MW
         rBsyfEBC1HL9aLmIaLRwlcXSxUzSMXH83IQ4aKB+9ANOncaem21EJMkRcfALwXMS01LB
         Uc22Ypkio9Iy/T2heBl6MyuMe6FEgf9jRvuk8IhsraVPbnoTcKVN+ViRGn9oHflVyub3
         wB9yO6RXXVRZ7jW5HDmsxCv5lWZdf8fGmzq6trYFyjXVaRBbcfthyFFnhroTah//UR/R
         kazTlgF4isOtmJVpHwBc7LafYwwo82HhHmlVnz5I4yAoom98BsYhPGwha5Qmf44TWot1
         J48w==
X-Forwarded-Encrypted: i=1; AL+hErE/+y/0OP9STzanWAtwnJj81Xzm+mOTnp1e6XWV0qRUBwdAbb45k6vMhR09/K6XwL9BsGoyN5o7HIVTO7Bx@vger.kernel.org
X-Gm-Message-State: APuU4Z9CpvmKOBMni3SAz5cfNyzwSgDk1Us2zvDBfH/kFREHQLy97Jxl
	Bwo3NezFe6x2lHkoM4ix/dfGgMRXwUdgHveRZrHNSE2Yc1MaBMEd3FBnfAEPkvQ1S9fkv7nUrZW
	sTJ+Ztlmvv52tupRY1xBzUQCnTdQrfmM=
X-Gm-Gg: AYBFou2F7PmTQfCOufWM8fRZKBHp0Yz+Epa3+2pSyodPXuYFrHB4rEfCFnXz7kCl+uJ
	51Z+LemXSWdISABz38/d9yrhL3Nlr1hE+CDbygmiKolzBG74kqkgplorZaRD1zSOEH+5tKIp0no
	Fnfurv+6leKs+hN5nkcjum2ZaKP1AZfMKHh4ynZaLafuvxbXUxOlu/AeNgOZFjwX/kl9WQfRtr8
	I0leN5xr8zNA/UYQoM6H4Qv3sXhQCmMojAsCl7LsTrMDvKyn4CSOOqdS1Sq6cjSexvEgl3Lodf1
	lEqpZPBIXe+lU5v/Wwm8lwMuQA3ra90znDe5inZwS6yF9lfond0+G+K66lOngTg/BnL5ViNOXk6
	qM/OzZ8zJNwTk3fQsmCuHoDxXheWY+5FVZr6Whrty2W96X4Pt/dlcRMatJ4SxJs1URjrDPlE=
X-Received: by 2002:a05:6402:450e:b0:6b4:73e6:dc9d with SMTP id
 4fb4d7f45d1cf-6b887f1fff8mr2542347a12.41.1795019647204; Wed, 18 Nov 2026
 08:34:07 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118123105.1247627-1-amir73il@gmail.com> <179500653692.684213.4730864102080566101.b4-review@b4>
In-Reply-To: <179500653692.684213.4730864102080566101.b4-review@b4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 17:33:55 +0100
X-Gm-Features: AclHuK-POwvPU_DJejkPcXzGEWdSEeV7ICPQ8L3Z6niqB3lgCgZbU0XeQWMehQA
Message-ID: <CAOQ4uxjHwtZEHu9xMM6zg9niSgNdLXhAu65jA8Ai_SKVg-W2nw@mail.gmail.com>
Subject: Re: [PATCH v1] fs: add ->f_real() file operation
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Ding Feng <dingf3ng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:55=E2=80=AFPM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
> > sync_file_range(2) and cachestat(2) operate on file->f_mapping.  For a
> > file on a stacking filesystem, such as overlayfs, the data and its page
> > cache are in the real (backing) file, so on a stacked file
> > sync_file_range() writes back nothing and cachestat() reports nothing.
> >
> > Add a ->f_real() file operation, modelled after ->d_real(), and a
> > file_real() helper in backing-file.h that returns the backing file
> > holding the data of a stacked file, or the file itself.  file_real() is
> > a no-op without CONFIG_FS_STACK; otherwise its slow path in
> > fs/backing-file.c calls ->f_real() and verifies that it returned a
> > backing file.  The real file is owned by the stacked file, so it is
> > valid for as long as the caller holds the stacked file.
> >
> > file_real() is only meant for inspecting and writing back the page cach=
e
> > of the data.  Operations that need the credentials or permission checks
> > of the stacking filesystem need a dedicated file operation, like
> > ->fadvise().
> >
> > Use file_real() in sync_file_range() (also used by io_uring) and in
> > cachestat(), and implement ->f_real() for overlayfs.
>
> Approach looks good.
>
> Would you mind taking the cachestat selftest patch together with it:
> https://lore.kernel.org/linux-fsdevel/20260623111533.2285005-4-ptikhomiro=
v@virtuozzo.com/
>
> I will test it on your patch and update with results.
>

Since you found a bug, do you mind adding the nested ovl test case
as well as lower file test case and re-post your test?

Merging your test is independent of merging my fix, but Christian
can take them together when you have approved both work.

> >
> > Tested-by: Ding Feng <dingf3ng@gmail.com>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Link: https://lore.kernel.org/r/20261118040056.6543-1-dingf3ng@gmail.co=
m/
> > Link: https://lore.kernel.org/r/20260623111533.2285005-1-ptikhomirov@vi=
rtuozzo.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/file=
systems/locking.rst
> > index f7363ad770c76..db9ba2a8c13e7 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -485,6 +485,7 @@ file_operations
> >                       struct file *file_out, loff_t pos_out,
> >                       loff_t len, unsigned int remap_flags);
> >       int (*fadvise)(struct file *, loff_t, loff_t, int);
> > +     struct file *(*f_real)(const struct file *);
> >
> >  locking rules:
> >       All may block.
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesyst=
ems/vfs.rst
> > index 1824462a43711..e4ce15545244b 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -1038,6 +1038,7 @@ This describes how the VFS can manipulate an open=
 file.  As of kernel
> >                                          struct file *file_out, loff_t =
pos_out,
> >                                          loff_t len, unsigned int remap=
_flags);
> >               int (*fadvise)(struct file *, loff_t, loff_t, int);
> > +             struct file *(*f_real)(const struct file *);
> >               int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned in=
t issue_flags);
> >               int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_=
comp_batch *,
> >                                       unsigned int poll_flags);
> > @@ -1162,6 +1163,22 @@ otherwise noted.
> >  ``fadvise``
> >       possibly called by the fadvise64() system call.
> >
> > +``f_real``
> > +     stacking filesystems (e.g. overlayfs) whose file data is accessed
> > +     through a backing file implement this method to return that backi=
ng
> > +     file.  It is called through file_real() by system calls that oper=
ate
> > +     on the page cache of the data, such as sync_file_range(2) and
> > +     cachestat(2).
> > +
> > +     The returned file must be a backing file (FMODE_BACKING) or the f=
ile
> > +     itself.  It is owned by the file and must remain valid for as lon=
g
> > +     as the caller holds a reference to the file.
> > +
> > +     The returned file is only used to inspect and write back the page
> > +     cache of the data.  Operations that need the credentials or the
> > +     permission checks of the stacking filesystem need a dedicated fil=
e
> > +     operation (e.g. ``fadvise``).
> > +
> >  ``mmap_prepare``
> >       Called by the mmap(2) system call. Allows a VFS to set up a
> >       file-backed memory mapping, most notably establishing relevant
> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index c601b27f0fd35..1e0e85515b4c7 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -102,6 +102,18 @@ struct file *backing_tmpfile_open(const struct fil=
e *user_file, int flags,
> >  }
> >  EXPORT_SYMBOL(backing_tmpfile_open);
> >
> > +/* Slow path of file_real() for a file with ->f_real() */
> > +struct file *__file_real(struct file *file)
> > +{
> > +     struct file *real_file =3D file->f_op->f_real(file);
> > +
> > +     if (!IS_ERR(real_file) && real_file !=3D file &&
> > +         WARN_ON_ONCE(!(real_file->f_mode & FMODE_BACKING)))
> > +             return ERR_PTR(-EIO);
> > +
> > +     return real_file;
>
> This will go one level only AFAICS and in case of nested overlay we would=
 not get to
> the real file.

Good catch! but the bug is not here it is in ovl_f_real()
Please test with

 static struct file *ovl_f_real(const struct file *file)
 {
-       return ovl_real_file(file);
+       struct file *real_file =3D ovl_real_file(file);
+
+       if (IS_ERR(real_file))
+               return real_file;
+
+       /* Handle recursion into stacked lower fs */
+       return file_real(real_file);
 }

When you have tested this please report back and I will post v2.

Thanks,
Amir.
