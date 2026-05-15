Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068883F164E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879693; cv=pass; b=HzUTzeQHR0GMSmbptln5z7d8JjOz3JtXooA/OI44OJ2RvRtXQni0T/b/DjZ6oCqNcEMLbpEL1M/woNVe6edgYRPkjaFsO8FgfoIuu6Y7oNJx773bO99jlQnInfPEladIo2qCSUkZl+FlCYG7NSiL3CKoqyMXh0QhPCKN9KFMu9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879693; c=relaxed/simple;
	bh=DuT+nlnLaglia7ZNQ7wKTzwqTFOUk916TijZdfnB/Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct8FUX2MQXjGnn8IKIkiMP4RrksW1YyJsEcL75xsr1GWYWJ/+KiQd5MNCMyeLXWDe+VNLDmAEI68mI+iEJtEa+LphR/Gmw73xK8vY9JsV60v3t8oK/Czqa7DqnYK+/iXkuksROf0YqgeF0y7jLuocfAB0W5e2pg/RWvO6xPrfxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npgxZAqf; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npgxZAqf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso512059a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 14:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778879690; cv=none;
        d=google.com; s=arc-20240605;
        b=FwQtSfO5ivVOcocJ5hFRjCiRQa9XQ7nFPeZKO3BigpA6efTf5YA5f1zRYkxS7BNm5O
         YJ3uBc2lFEPQhrkDjRPM5A9oYwUG+bsc86bT5wn5YqrKaieSB2hLombJt0mCXyQvLwDL
         v42lajxPx1oBlcaiPZLZcke9bRHQMZxt/OJj9EY8GK37y6pV1oKP+mS5wIRdMFyDLts5
         zexhBTXa5b4iF6jW/LCqJr6TrHWoD0bmxhwwX/meJ/osN+HUFTk+cuFcuif3yccUSZ+0
         pO9UH/ZqKfkIBRodN/0GflePaD5VFOS1GNwTFTlfHcFUAhBJLQiSclN9Ss+Ct/VVBreK
         cObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bN2Odr3esQrA9SWUUUdwtrw2+pd4bqhfvSZwexzSm4M=;
        fh=0ghpCQ/RTbrXAU89tXdFsk/zJx/5K6JQAixfDYKuve0=;
        b=RoVoVRtRs9uKarDWGo8R/WZrnRv22c8ekdcrxJEUBd3l8vbGOaK4kVyFKlvYAvm7rA
         a01PxzhvcX4lxHunG24tRNfVCz3CG+FMojJFzZVHvrLdr9eEaZ5li2AvqDsMPYTbGfCx
         ubULAYu66y/YyNeJefX+TLWGwr/tnZxzNf5K39oMCw7AF9qHcD+SWUc6jJMCxx4NWAOh
         HBA+ojUk2KATbbJhk8E5jpfuRtuHmTJNxvtY3mVX/3AmAPP5PlQgbB5A3KTLsq08+A5l
         u/pTk50t2xm0aTyripAiUxYQnOCajARcKNofzbDzN4mvnqNEgCuEzS5r2TjCdyVVRZlh
         tbUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879690; x=1779484490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN2Odr3esQrA9SWUUUdwtrw2+pd4bqhfvSZwexzSm4M=;
        b=npgxZAqfTOM5GnCh70rJKyrhTbaftRDDKFSla/zsUxlKuHiaz3Eiu/0gPpJJ+qowWS
         eYNrztayvypqVwD1TcDVMBQ/z7U9F31FT1KY3BKfLRenzyYMr8Z8DD2P23llzXGQERSo
         coFZzFCMixuTWTE1iwy7N7qYedX7Ay4xDHohktTf+aYExejaCJhjn868J1Sz35Y9crbO
         JASXuvsDcKO3gkzIHHUU+B3187+h/j0R7GHsPzhE+qlGZl7U1DqzbVhi3pEwBu9/Q3MS
         QfiefglaIDdqmYZJbDIXUEZJ80mYFAF9vVL4OstzG0pM2oPMYycuBf183PDYgt4zEcId
         QAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879690; x=1779484490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bN2Odr3esQrA9SWUUUdwtrw2+pd4bqhfvSZwexzSm4M=;
        b=iDpm6F8cdQk0fs76vwaY1oNqi6Q9j7TF5v+2IRodFTgkn+4rj3vSLN/PM1DX7km9yB
         iDwOERomLk0ZoD3b2iZkMeYtkek78CUGaFxHu7GwhaeizkOqa2TCkxMnhqe1Hs1MDepf
         X0hNSsbkdRCB50kjxAGQ1URU4uim01ySrusjgbo+sZwlceOaS4cNFFKKR2wzT4KnHFoG
         EXPBzwPtgJJXm4k4w0SWoizb90QyVZWnkfe+AY8Bbx2JTOrq3zLfCAyCAq3rtU4QL44r
         FKe2YI/BzB7XDJzKtN9aAtydiBKCxPadrqd0kIMzj1oXYFK1rClAUZO4x/zDqDQs/sgn
         760A==
X-Forwarded-Encrypted: i=1; AFNElJ+0KVTUt+fUr1vZMmQDxUhvSjfZtC5DMiy0jrs3w8KXcBcoWKWppjhfsA0ynBRDe44nmVD+crxYSEFNgcmC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2eoIeSDfcyxAcx3sDWiyoFQeCYvYgZn+PvlZ2+307jTETprp
	JTrfIsNXKCWO3MphZWyvGlLS5A4oNNPgIzeFFW3IKk5qd2LL8MLMqH41HjvBc18VMP4kc0BMEac
	IZs2wAwymhaVO6pee1uUD7Idz91Ya1hY=
X-Gm-Gg: Acq92OEeENLGug499A+WDw9E3boWdbCFHb6OQr4D/lVh2ANlNzSUWdArM4GliF5LJg2
	ZFKn52jM0lY3HRsat4alhS38JeYSh8pNRyQOdE8EsYNCHiec48eF2shO2OhWIVQsyLROdrO0eqx
	PgiTWd0BATyAaosyaDKu9ySe1JTd7Z7/YW/dhdKM/9fe6ZOeEdqJ87TQ9ECSYwjbJdfZjGN5i88
	nuIFb9hsmiwzXJhEyVynfadkgOm2VxmwH2ONEag4PqqVfUzRtB5lv4VJy2JYkU24wta0WEici7L
	A/CYIjyRRSV/2pGlrTIWLEasjE1uN2Xboml5bEbdCg==
X-Received: by 2002:a05:6402:46d6:b0:683:1cc8:84ae with SMTP id
 4fb4d7f45d1cf-683bc6b76e8mr3008766a12.7.1778879689943; Fri, 15 May 2026
 14:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206552.4103309.6736684975553576273.stgit@frogsfrogsfrogs> <20260514221439.GJ9544@frogsfrogsfrogs>
In-Reply-To: <20260514221439.GJ9544@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 23:14:38 +0200
X-Gm-Features: AVHnY4L-Ntf5QTc8e73PEBQcDqpRfuAunh2WSJB5bCVAbcLQMwr5aJfvjlmHXAA
Message-ID: <CAOQ4uxj-JandJhCQ8VzsqqvkqCCenMFkAQxNwm9e2RRiqQqACg@mail.gmail.com>
Subject: Re: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:14=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Apr 29, 2026 at 07:33:51AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > There are three inode flags (immutable, append, sync) that are enforced
> > by the VFS.  Whenever we go around setting iflags, let's update the VFS
> > state so that they actually work.  Make it so that the fuse server can
> > set these three inode flags at load time and have the kernel advertise
> > and enforce them.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h          |    1 +
> >  include/uapi/linux/fuse.h |    8 +++++++
> >  fs/fuse/dir.c             |    1 +
> >  fs/fuse/inode.c           |    1 +
> >  fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 61 insertions(+)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 95b37f4660cc1d..3b38b98dc0096c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1651,6 +1651,7 @@ long fuse_file_compat_ioctl(struct file *file, un=
signed int cmd,
> >  int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
> >  int fuse_fileattr_set(struct mnt_idmap *idmap,
> >                     struct dentry *dentry, struct file_kattr *fa);
> > +void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *a=
ttr);
> >
> >  /* iomode.c */
> >  int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff=
);
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index b6fa828776b82f..bf8514a5ee27af 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -249,6 +249,8 @@
> >   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs g=
eometry
> >   *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
> >   *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
> > + *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of fil=
e
> > + *    attributes
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -606,12 +608,18 @@ struct fuse_file_lock {
> >   * kernel can use cached attributes more aggressively (e.g. ACL inheri=
tance)
> >   * FUSE_ATTR_IOMAP: Use iomap for this inode
> >   * FUSE_ATTR_ATOMIC: Enable untorn writes
> > + * FUSE_ATTR_SYNC: File writes are synchronous
> > + * FUSE_ATTR_IMMUTABLE: File is immutable
> > + * FUSE_ATTR_APPEND: File is append-only
> >   */
> >  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> >  #define FUSE_ATTR_DAX                (1 << 1)
> >  #define FUSE_ATTR_EXCLUSIVE  (1 << 2)
> >  #define FUSE_ATTR_IOMAP              (1 << 3)
> >  #define FUSE_ATTR_ATOMIC     (1 << 4)
> > +#define FUSE_ATTR_SYNC               (1 << 5)
> > +#define FUSE_ATTR_IMMUTABLE  (1 << 6)
> > +#define FUSE_ATTR_APPEND     (1 << 7)
> >

This feels like an abuse of the FUSE_ATTR_ flags.

Seeing that Miklos wanted to convert LOOKUP
response to a compound response of LOOKUP+STATX
it would have been nicer to get those flags from fuse_statx
only there is no STATX_ATTR_SYNC <WHY?>
I shiver to suggest adding it to statx.

Oh well, I don't know. It's up to Miklos to make this call.

Thanks,
Amir.
