Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36747391512
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487127; cv=pass; b=ak6qoL2R5p9gOrPojuX/NCrM+MWEXDF6w8aFHIl4PkW0/BxW5R6okE9f76bNVnAdx4PiPwlWjhappF/rz9M20kZoNOi/vuQ3WpFJeGqguLaKAk5tMStGphVgo+cwhXTDzYtnubwCtF8BcsCskx2Br/+86UVvTe0+8fNsA5BnK9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487127; c=relaxed/simple;
	bh=mVP2TUHCeB/LjDfIFLuoRmoPYS8ySiFWCJ8p8DKBKuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATo6GtInrLhlN8g4eIU4ATzAIRitXwAayVM6d+tuoNw52RzMRBi2OCD0rgiHjsOV82GavDwZirC39aO5y+GFtA8RRtgZR76zlFshTQu8767iZ4eVFOIycHD0U6ivxrGoPK/oqNeGhEYbZeV50BvfFetJIWytpCICTOM+IwDvCgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmCqssLN; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmCqssLN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so2426903a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 08:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487122; cv=none;
        d=google.com; s=arc-20260327;
        b=WRkNwkR9r5n3YjrxQl9E3tPKXP1C9w2t1W8LsQoQuDjqNWRTfN3r+9u/lYrYvJAm51
         wpGynU5Kp0TBzSd9i4dfFjy5hXLsCh3gj+Rhc8VVUQNm/Q4mi53/+yHmiT+8Bs8LtkS/
         J2FNYHhgu3iCBXbavQGcQq0nMrw3LcqLcu7goON4ZgPM5OjEZUpTVrH+llE46Mo6H8Tr
         FjYA9QgdcitXzndmGssLc8aUcZa0N0o04GzV/pI2WmOKyLbjWkuhv3jyE8MEVL6hTVRQ
         W3mNaqpG6nxlZoYFPY6jvX4BljQrUewcWIwpGi/sel7gOEQidOerLcvmvjw2zq919ohp
         XwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVP2TUHCeB/LjDfIFLuoRmoPYS8ySiFWCJ8p8DKBKuk=;
        fh=KHPWiOClFjV+xtxcVCMi0JLvp64YWNKnWZprrRAF8KA=;
        b=oNq1Dh3utU9f9WCZzsFeL6h8Vj8D7T2t0zVLzs1VKzVvH5dX8n6R5UulKUlCb/DiK0
         /JHsRUqtfwT8vT+fTGWgh3nu3HEPWExR0VboQmV2RRv1fdXmCUZi5N1gPb9itfSZej3X
         tG8pM9SomctuLqJO25vHqUTvufg27eeH/eiVma9q8FVXTIdTzLDPgzZ6Oz8lCaqPpS+3
         aKBnhAIPemjKKv3adQ+lyvaspenP0JvqTZhlH1Ib15H4OovOZj9DlU6LC0b+zZyhfHm+
         wgW4ZXIcYqDKTQnz2nWYGqrcRDYYBn1X/Hs7LOYl3aAaNLkB521sAusfSXUgeBkgwNjf
         P5VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782487122; x=1783091922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVP2TUHCeB/LjDfIFLuoRmoPYS8ySiFWCJ8p8DKBKuk=;
        b=fmCqssLNpl3dvJXUEdnuL6lGRzjspPiOg3xyAqpxVOrGRLmsGHPA+31ztFKyEaQ/Hb
         IZa1LGFcsYdAcvpRdhphz0zZuFxPQpJ27Pkc+R4Td2csCiGE9tNRMzxcpQBHBu6Mu21M
         2ek6yrcfdvzzygl5pZ7NAw+rSzZoGGcN5UW7gRof+nYf5bvpyigLVMV+yTqOsM5TjICX
         KFhiPOxo9Ziv//E+pEVWPM75LCuupJPUjbJ4+/Cvs7GCFd7xm8ld1X9yJW/FD9bIEqLQ
         eakiPIyd0CE7qu1kTqREy7qMixGuYdari40Kp8/wjuriTX7GyW9BYeoMQ5hYLVDkogPt
         2NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487122; x=1783091922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVP2TUHCeB/LjDfIFLuoRmoPYS8ySiFWCJ8p8DKBKuk=;
        b=brmPk2r68G6VOZdDCV0swnSprC9yTd0/7k0FUHOO6GOGpnbfwoJD+DM/6duWTFz89B
         LYEr9ryqvPTif4qiBjGjBPFGYoYA65sLWA/sidwwkCS6nharjbevcGXTuFyBK7jDzWZR
         N8FhuDANoORwNZGktJptgLIBMNzhYyeFHKKtUxGRe0uPHPF17LX5PMmNz1NZ5KE8ynrc
         1jtjQQxhSZi3FkKpdyGsUKX8nSw7SFLAqJgFh/qMP+IH3y7ei3ekOJX+2Owq0/dOxhA6
         xufl9sMao+o3lcOoTZ8rAABePEZ9+GfG1RDiO8LLvMUf13FiCptA/Oux7hoOGQRePDpd
         nTwg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8TBlKOzrR6h78ge/tuRIT3yRmqLpnhtCOA9yoyozEoUaTiL86VN/9qTU+K0W2ZjNciosmrv5OEOiLawes@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTrIissNf/UwrU7Awmb9kK+ilvxaW+gq0hmU6T2patmFia4Ng
	bcUqLICXjQ2c62xauqwS0bUKiZPDFXCDrEAMp9Sjx57Ep+L118j/xSWuodh/JpNx6vmbFYImOue
	JRDQu0RY4JM6RKE0wOvNaUjQBZ/beX20=
X-Gm-Gg: AfdE7clUWBE/1fmYGy48kluKuNvHmYLUK2z+muw7rV5+UedHhPttrRnlbecRQk7Oldm
	oLxLwnf10IvNoujVRyFcPt1HwWl4y5P0S1LHuFiCKPzOJZboRjgwH8KSPYtX7SWeiwaQ1rEaIOQ
	mXh25Idz33JDYdt0T2fZEewtL81PZn6E2kOSb6WSrf3y0KTS6jpc3BXlDI7z21Ic7j+lfcdE3F1
	GNaNx9HGKA8t0O0J6uIGFWuzAOhHavBLr/qSpcH6pnXA1jEjnapfjnKZfH6Ln1ZvDCNdEPgf/me
	ZwUEYGbbgt0A+Fv+CDTYUU+ZScYDoPk=
X-Received: by 2002:a05:6402:2551:b0:697:833b:845e with SMTP id
 4fb4d7f45d1cf-69810aefba7mr2419788a12.18.1782487122292; Fri, 26 Jun 2026
 08:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-2-ptikhomirov@virtuozzo.com> <ajqOyIA8tPQsxfz6@cmpxchg.org>
 <3f6392aa-c1f6-4263-8892-978dacbbd8ca@virtuozzo.com> <CAOQ4uxhras5YAr8_HBpuHSDwvfiEF8vAr0NDB0R_PXtGDhnqjQ@mail.gmail.com>
 <20260625-lehrbuch-gehalt-wichen-1b2f3533efbe@brauner>
In-Reply-To: <20260625-lehrbuch-gehalt-wichen-1b2f3533efbe@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jun 2026 17:18:30 +0200
X-Gm-Features: AVVi8Cc5EZwXlZ5GECvSYG7NzrqtiA5br21iMjGhuCiWGLWSPhjsckXvxs-eoOw
Message-ID: <CAOQ4uxiNrEZ8rsRc11mdjkMWe3dfThE0DJ2vXuO0yiNemnpR6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs, mm: add ->cachestat() file operation
To: Christian Brauner <brauner@kernel.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 12:36=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On 2026-06-23 17:34:47+02:00, Amir Goldstein wrote:
> > On Tue, Jun 23, 2026 at 4:55=E2=80=AFPM Pavel Tikhomirov
> > <ptikhomirov@virtuozzo.com> wrote:
> >
> > > On 6/23/26 15:48, Johannes Weiner wrote:
> > >
> > > Yes, AFAIU in overlay when we use realfile we should always use it
> > > with_ovl_creds(), even though I don't think there is anything cred re=
lated
> > > in filemap_cachestat(), I still think we should follow the common pat=
tern
> > > other overlay helpers use (similar to ovl_fadvise() and ovl_flush()).
> > >
> > > note: Actually some places get ovl_real_file() and use it without
> > > with_ovl_creds(), e.g.: ovl_read_iter, ovl_write_iter, ovl_splice_rea=
d,
> > > ovl_splice_write. But those look more of an exception than the genera=
l
> > > rule. All other instances use with_ovl_creds().
> >
> > Use with_ovl_creds() is a good practice to keep the mental security mod=
el,
> > but it is useless if the security check (can_do_cachestat) is not in th=
e
> > vfs helper (vfs_cachestat), so please move it there.
> >
> > Also it kind of makes more sense to check (flags !=3D 0) in sys_cachest=
ats
> > before checking permissions.
> >
> > > Also there are simingly no other file_operations which return "realfi=
le"
> > > for further processing, mostly the operation from fsops simply replac=
es
> > > general operation with its own logic completely.
> > >
> > > Thanks for your review!
> > >
> > > ps: Hope overlay maintainers will correctly if I'm getting this wrong=
.
> >
> > I don't think this is wrong per-se, except for can_do_cachestat().
> >
> > Just be aware that the real file could change from one cachestat
> > call to the next (i.e. due to copy up).
>
> I'm really grump about adding a new file operation just for a
> special-sauce system call which is under a CONFIG_* option even. We're
> not going to set the precedent of piling on custom file operations for a
> single filesystem everytime someone adds a new system call unless
> absolutely necessary.

I had a similar reaction.

> This looks like it could just use a new helper in
> fs/backing_file.c that the cachestat thing can call to use the correct
> file.
>

I was considering suggesting this as well.
Having f_real_file() complement

but technically, can_do_cachestat() should be checked against
the overlayfs file/inode AND also against the real file/inode with
ovl_creds.

I'd love to be able to provide a backing_file "template" for
operations, but I don't have a good idea how to do that.
Do you?

Thanks,
Amir.
