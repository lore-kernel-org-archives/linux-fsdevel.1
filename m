Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC583BCD2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310319; cv=pass; b=cMdoE93/q5bhD+eswW5cdQbpyIRiIDhwwoEunJ2T0t6fNxpRE+vIJUMzLOQ2c5+89QYZ9N1xPYL+1zRS+xcSeu2naZm1fawYl3mQ3VabUNjP5bt/CIQtBNx4nTecR4K5bGeE408ju9gv/+DjGF6h8kltcMRCe+EMm3hrd+npgrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310319; c=relaxed/simple;
	bh=lReMwpW9Ma9bFWZKkbvYIhQdFsGC9J9mvewCrG1dWU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+fLEwbJGW3uswn/HXdPzkcE+i8oYPJBxyT5WPd061K+Vt63sSDq8jRjROQOVr2S5wGBJJGezkM8SfwRz8bI9N/QIgXxuu54LK3kMbi18nwxbkcPDJmFkIHph3/59L+hyhcLRHSASbQoJMYV9nPpEKNoYtbovgg2LGaQqhOL7vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLxUgC7z; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLxUgC7z"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1901519a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 07:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782310317; cv=none;
        d=google.com; s=arc-20240605;
        b=NjOuFXXQqx5otvo1iw21aVkXdyERqVMvC5SqiJI74tueCIBRqWklUs6iXsNGl0bTZ8
         T5v5RvcaQ5yAvvgtRd7x6778ePXgS6tauR2BefOip5zwaY6nmB2CMtqgHitJiBjtfckS
         BiuxcvQ9znAX/aoToBdmDyjJLGYS2nk7X0TpWwefjankeWb7ShNWyG7K7tc7ATLO9VBS
         4EyfNCLuPaPf/2AV7o3xBnACfo411i8sc5a4/84UzgkWOGEJXU/NBGRUgqljhmeChHYS
         +YoGzTOoqo6jvqlyzhQvvoSPcuWwXZ5Oi6z4vz6oqfXCxRCaefTLkEZKHTMsh6mk0y4b
         F5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LG+grWd6UceBYXX1nWiBnDgEaC9++nTof5X97YF4TKI=;
        fh=ltVKc+tQnGKfWT/u2Kun9lRb5dRkmB1fzlQ68GSYZ8c=;
        b=TlP3iIDvOV9epg7Cv203qQPnAU8E9BQMxtYT/JSPrEws+0b5cysWcYOKwRDsehM5Yh
         1XBMfGpRz/hb4H/5LsFhuG4mYg353Y8X6+ea82HFqt/COM/dBTPvhmMfAHIvc1hTNqgf
         mWd4DHv8rPWlbb1XA5YZZSh8wzEUUKUmxLCXwetREWWYxkrDj1emMoDGXFMgelj6ftHB
         rmptgKgBc0j8WXRRqSpSSgHisyG7DOHiFw97hEoK3qu06poC5JvY0dSxCZX1JsO+y2nl
         c5dyISFWvN0aA4r8yf3tVDwt3p/U5ArblpkKooUAg0rYMGYx7/hVfYVrM54VmXe/b8NX
         be1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782310317; x=1782915117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG+grWd6UceBYXX1nWiBnDgEaC9++nTof5X97YF4TKI=;
        b=qLxUgC7ze1wp8fNLbbDPdUEt2hennFa92aZyyfQuledAyZt5en9tJL22oGG+LhwHEU
         qZdwo93q7KGxIg1b+RbY6oSNZn/bmCmrfm+jQYgQ8qU6Mse49dJFF2/NQ9HcmbAEB1yi
         pV2LRvYRfdkZzFSAvrmrG/MH9L6+J/8C07Qg4puxZdmIm3npY2E/xDneYSurQkPRCrsy
         FkGalcIhaNnrYbOpSYePtwNDbeQVWeZVs4508fX7eZOCWY+zDnq1xzNhCji5gQgEM4Qs
         0MQv/CfmIxtDHpO9QZf/2RaXfl335ZyEL/d30mzHym4Af8bQI4MzEdnl7ezUw2cUpeFB
         691w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310317; x=1782915117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LG+grWd6UceBYXX1nWiBnDgEaC9++nTof5X97YF4TKI=;
        b=p2JFaz6W79FbuqJeb1k4T4gu5NHmveg1DRVStLhvJNuRKvXuKU9tIVwtPY4aQqLSuV
         a0PqDWFpNungLHWXEJdothjdD8CbzWB6CM5Z2WTN8lPs5GleQicAa5PVWyetFVoiqHTs
         15vpp5rLs6DVSTYrTV8zGYaSARaUnYSnYQDZKZtIIPcs4SjXTonDHjQkEDmb+i01KThz
         ZaZIioPel86oU1DEr2S/j99wv4ECyvmVemp2gZMcnVtc7qT7d5WPIN3RWyM3XXgX+3R/
         xRIt9+S6yfIBhzdqL1E4nB+0ILVpMLJ5MrfHruhM68TWIKCHwEOPUVkexSy6SkZTsfrQ
         UoSA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4gSiDrhlF2VR1pbBz9mvkNjzuYkLn8g9hD86r/bSO00pIEmILmDKTBwrNvjWrvXHE5XO1GL2Xe+lNmLvP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6XFiDQEcsd7JPsTmL2tvPEA4AoHm8LPqVvkQHO84n1QsnjNV
	bE8CV0n05T5gzPq7+wwdI5ZR735/6sYNCI5C3F4BJR3+LXBnp6ItLIK7qzA28/5/xDbB2HULkMR
	k37MY8eQc7i1qLx5uSg6Kz59+ZMQeTAk=
X-Gm-Gg: AfdE7cnWBeKi9xzHLEOyvYyQ+Ug1wKzAZX9G8JHm7jGxf7JqVY4WOm76G5+n2SKRN5B
	QJoaYFW/3b3i2+mzNJ6yzUI7DWowf7DDAi+F2N184jpib1ex3u6MYT3xSihqC4ET9JwLJtIcAlO
	une9+Ozxs8RjljesoSJ2t4IFr8cvS2hz6Y5MOTP+GbSCCsUcgKp2+3lbbeJhzl7kzsTQw6HJafK
	QFszC07avmOJ1h2TVXQFY2EScNFSIJIM19JoIwZWbZqaZjf2D5MmhYyQj347GlaGw0Q+McyCrmq
	z6UMVviR+Fajuh5xgISjO+dz8NXK46Y=
X-Received: by 2002:a05:6402:4310:b0:68c:4424:a08d with SMTP id
 4fb4d7f45d1cf-697f37711abmr1918540a12.2.1782310316342; Wed, 24 Jun 2026
 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-2-ptikhomirov@virtuozzo.com> <ajqOyIA8tPQsxfz6@cmpxchg.org>
 <3f6392aa-c1f6-4263-8892-978dacbbd8ca@virtuozzo.com> <CAOQ4uxhras5YAr8_HBpuHSDwvfiEF8vAr0NDB0R_PXtGDhnqjQ@mail.gmail.com>
 <5c7e8c24-0981-4677-aa42-9a74b67bac04@virtuozzo.com>
In-Reply-To: <5c7e8c24-0981-4677-aa42-9a74b67bac04@virtuozzo.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jun 2026 16:11:45 +0200
X-Gm-Features: AVVi8CedTisCQc6-w-aWZxlaYwfyFEiId3iuvNUGWT5KiajuyJpqODeKptPkY48
Message-ID: <CAOQ4uxjoq7VGQ+XHi9TT-Hak-tqiudoG7nRJTsFenbNtZRmvcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs, mm: add ->cachestat() file operation
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 1:59=E2=80=AFPM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
>
>
> On 6/23/26 17:34, Amir Goldstein wrote:
> > On Tue, Jun 23, 2026 at 4:55=E2=80=AFPM Pavel Tikhomirov
> > <ptikhomirov@virtuozzo.com> wrote:
> >>
> >>
> >>
> >> On 6/23/26 15:48, Johannes Weiner wrote:
> >>> On Tue, Jun 23, 2026 at 01:14:48PM +0200, Pavel Tikhomirov wrote:
> >>>> The cachestat() syscall reads page cache statistics straight from th=
e
> >>>> file's f_mapping. Stackable filesystems such as overlayfs keep the d=
ata
> >>>> pages in an underlying inode's mapping rather than in the overlay
> >>>> inode's, so cachestat() reports all zeroes for them.
> >>>>
> >>>> Add a ->cachestat() file operation and route the syscall through a n=
ew
> >>>> vfs_cachestat() helper that calls it when present, falling back to
> >>>> file's f_mapping otherwise. This lets stackable filesystems forward =
the
> >>>> query to the file that actually owns the page cache. No behaviour ch=
ange
> >>>> for regular files.
> >>>>
> >>>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> >>>> ---
> >>>> Note: Memset change might be a bit tricky, I moved it to no
> >>>> ->cachestat() path to avoid multiple memset on nested overlayfs, tha=
t
> >>>> means that ->cachestat() is expected to be able to handle unitialize=
d
> >>>> cs.
> >>>> ---
> >>>>  include/linux/fs.h | 10 ++++++++++
> >>>>  mm/filemap.c       | 43 +++++++++++++++++++++++++++++++++++--------
> >>>>  2 files changed, 45 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >>>> index 6da44573ce450..966b6564707e4 100644
> >>>> --- a/include/linux/fs.h
> >>>> +++ b/include/linux/fs.h
> >>>> @@ -53,6 +53,8 @@
> >>>>
> >>>>  struct bdi_writeback;
> >>>>  struct bio;
> >>>> +struct cachestat_range;
> >>>> +struct cachestat;
> >>>>  struct io_comp_batch;
> >>>>  struct fiemap_extent_info;
> >>>>  struct kiocb;
> >>>> @@ -1963,6 +1965,8 @@ struct file_operations {
> >>>>                                 struct file *file_out, loff_t pos_ou=
t,
> >>>>                                 loff_t len, unsigned int remap_flags=
);
> >>>>      int (*fadvise)(struct file *, loff_t, loff_t, int);
> >>>> +    int (*cachestat)(struct file *file, struct cachestat_range *csr=
,
> >>>> +                     struct cachestat *cs);
> >>>
> >>> I suppose you can't just have it return the real file because of the
> >>> with_ovl_creds() scope you need during access?
> >>
> >> Yes, AFAIU in overlay when we use realfile we should always use it
> >> with_ovl_creds(), even though I don't think there is anything cred rel=
ated
> >> in filemap_cachestat(), I still think we should follow the common patt=
ern
> >> other overlay helpers use (similar to ovl_fadvise() and ovl_flush()).
> >>
> >> note: Actually some places get ovl_real_file() and use it without
> >> with_ovl_creds(), e.g.: ovl_read_iter, ovl_write_iter, ovl_splice_read=
,
> >> ovl_splice_write. But those look more of an exception than the general
> >> rule. All other instances use with_ovl_creds().
> >
> > Use with_ovl_creds() is a good practice to keep the mental security mod=
el,
> > but it is useless if the security check (can_do_cachestat) is not in th=
e
> > vfs helper (vfs_cachestat), so please move it there.
>
> Totally, I feel stupid now that I missed it originally, will move it in v=
2.
>
> >
> > Also it kind of makes more sense to check (flags !=3D 0) in sys_cachest=
ats
> > before checking permissions.
> >
> >>
> >> Also there are simingly no other file_operations which return "realfil=
e"
> >> for further processing, mostly the operation from fsops simply replace=
s
> >> general operation with its own logic completely.
> >>
> >> Thanks for your review!
> >>
> >> ps: Hope overlay maintainers will correctly if I'm getting this wrong.
> >>
> >
> > I don't think this is wrong per-se, except for can_do_cachestat().
> >
> > Just be aware that the real file could change from one cachestat
> > call to the next (i.e. due to copy up).
>
> I guess the copy-up between two cachestat calls is an equivalent of cache=
 pages
> being dropped/reclaimed between the calls, right?

I guess so.

> (I assume old pages will not be used anymore and will be reclaimed in due=
 time.)

TBH as long as this overlayfs fd is kept open both real lower
and real upper (post copy up) files are kept open, but the lower
pages will not be accessed by overlayfs
expect for the case ofMAP_SHARED mmap
if this overlayfs file was mmaped before copy up, the
lower inode pages will remain mapped to process address space
and then cachestat will return stats which are disassociated from the
pages accessed by mmap.

This is documented in the `Non-standard behavior` section of overlayfs.rst
and not a specific issue to cachestat. Just wanted to be aware of this.

> So userspace should not be
> overly confused by such a cache usage change.
>

Agree.

Thanks,
Amir.
