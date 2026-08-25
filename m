Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C733BAD88
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640233; cv=pass; b=VocjIyBxcqdcJ3NkxkfyrhYRv7KLAv0YrdCusoiVdD8crK11mt8/i0TS8DBGZkXM7OElUHJEniTyD+7pAb3Xnqgetvw88CBmQZvwg7Tb6XINhvEfW1KfWgopz/H4/a7WXhecZOdQVOq8clsyfdi2sFKgJR+2Y46DH4KfKsx7oqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640233; c=relaxed/simple;
	bh=w7CvR+LFMAh5RyewUsu4APqwxK1gMuLsaW6KayNAcNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De2rFkl19YTH/gQc2qafquh9MNQ0nWGvs/7wVBXl8TxYcYOrQlV++7VttcroJunrcHZozNVcNJecFaVSEFfA+Ees/nIKQoK4LIXhHZBYzJSIoq+0iIVI4kYP9CmGG6DtVqNpyg79UAYbVG5TpAkPVmJyQCd2ixqeeOzNtAOb8Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38Mxb2t; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38Mxb2t"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so6085919e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 23:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787640228; cv=none;
        d=google.com; s=arc-20260327;
        b=kF89shu1iwsiXhdDCx3I52SIMKFBrIFeGMkMFn1wOga/DN6sWaQ9SpKCY+vnqFQwAd
         A+WtZNEdckQq+MaFGqUeflFQAL8mffNJYK1D858pk8WSHIu3TxTHYmgFq4OavSQzwgzk
         wDKy6EiRHVqTp1Xt2z1LZZY6QZGpKJz2QnoU1DGEvOHnhGdZmi9MebYQABfDv5uaGe0b
         DFbSfUT3WGQOAlCIbRD5j+dN78jukNC+mdQDXkzNrva4rf33f93yz4ldk5B+HdHRmSCn
         JS2UeqGjXKai8+/kw5Hmm0vtFFv0kVF0kFdITrdBBPgjRjY7J0qOAZaZAFYu9surptEQ
         Nx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
        fh=qzrujVm4RFVbTSspNeRLg0jgT5J4LX6GTGNPjGyukJs=;
        b=JnWVbFr5Jl9/7ypjcylgspLoT34S9yb3nUI3CUdhccC2zBIlIqim4jTJjjEAM8bSsP
         Vm1lCDYPzLm645uf51V5XlPOMxwGJYCbT83mVN50HDAo5Eo8dGZ0MkYxGj/DwCzHw8jV
         FGNH7V1cGVYGHQAQWTPsL/0lGhK/Qdf1tgy8ifRUVaSbJXHa3pP5KWxmgsL1X72YDsIK
         UgZQ6BLqyuzGQwJTO6bEntkjb4GRsS6ajhXwos+f5uFI8+ZMnbBZn+mmXCaGyG/e5Gvo
         96KgVKX8g/BR2zSDQ8p5/0z40j2EvqbInfWIZycrVRf6DbEZpVRERSAPbXmuwe1YzVx2
         +VbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787640228; x=1788245028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
        b=Z38Mxb2tYmHyfn0R8OOmPQPiitbP9qs6sFDRtIJdg92rLXuGDCLvyYhy9/NFQ1LQ7x
         +v+RPPDnDhxC8H1qiHIaEOtIzY0mJmvv08jyx4q7lNQqmEzmtnkJJiqI4Sl0mOIZ6AyR
         RnNPhc0z0U/DdRzRf+blpC9+yz5f//KmS6OW+fkF7A6jJpdx/Op5ms73w2Nf7W0uiBdF
         RoZwWPAW2Q+QMHooUc3zrWGLLBrmPIiel52zl3NmvWp9X7KDGqWUp8tRzlqIdpkZouVa
         HF180k1o/ekp5dyFxwCuP0xr8axbzteYlyIVyTZbJEZcb21QO2yDmsVnSX9qnQMsgabc
         CYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787640228; x=1788245028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFFnhjcWX2esFqzTXKdNV82QT3BiE47cZiKBya4IY2Y=;
        b=U/O+VpyQj6Fd3X+nWXvl0+nHQXamwaQaNFswyEPOsRs5VnQcoFsm17aDv1YQ8SOqon
         y+TccwuoMA5UVbQ6x9IJJM5ilO+Drak8OK17fMwHGosn386jG/dElmSHm6cIs4tJ0Ov5
         WfditvVq7dLX9ZFqkMuwAXiQ6Q1Ob41GFeMnEoWE9VZS/umS58KRnMRU7HRyziKobm3B
         ZgEYilDNw72IO3ZgDIjsaprYaeoAH5cMhOoSToLVKJMdWb9MkHWWL6oXJ4mhjl3AtWsv
         UQto9A28lwt43ohLoTKk097eHsPASoiq4OE20c3ppStmjzGKgh5Ty9PYhlmnlaKLZExl
         42DA==
X-Forwarded-Encrypted: i=1; AHgh+Rrr2vGJSDB/eAIX9vSR58r7GpOGT55lw6KVB65mp0sEpvilqVv4GZvYnmZIR07bGRAa4DTW4gt8pjvK2qbm@vger.kernel.org
X-Gm-Message-State: AFuF++lGPtTbvWBHnuWNG22DGbgo7USOrSIp8Orv4WQzvmw8DyrGyJZW
	qZ3pTR8syxw69WU8Xw930b8PLyCsBCTkU4viWE9mkXkM7zikFic9+q1AJwhQS9Zp00yarj4/LUG
	iW974jg7crXQAttKBQaUeW9kk3az7xJ0=
X-Gm-Gg: AR+sD12zJyR0Mp4vqsx1wu0TTte5TffKJnFnifaeHqq9ERlNKSiETMCGp6+RP2WssEj
	YIPoYGEdqVYKNQwHi1tx/gqoMiNfP3Mn6RdaND9KN2+AqaGyAcpNkeLJvLLmf6NOeYreLsMATDQ
	ngto2WPfY5D5oExwsPYwFMUPPdb5gDOvR6Tx+B23EdpII//GX2Q+GiKJhZb4AaA+eae58uhpqgc
	J5AUEfl4/ip3WsTobNsIIAUoBC3eNmWwQyT7SJNE5aUwur3o0cGtAwxdGHAdL6dUptG4AkQ7C64
	oSOWTLL6Fm4poQYMAmT7hLhdWt66vi9dGepqbFJzb0XiNg==
X-Received: by 2002:a05:6512:8349:b0:5b0:113d:8ad9 with SMTP id
 2adb3069b0e04-5b48422248bmr7654211e87.12.1787640227948; Mon, 24 Aug 2026
 23:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820071438.695893-1-qiwenjie@xiaomi.com> <cover.1787564706.git.qiwenjie@xiaomi.com>
 <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com> <ao0stlR57iUgrY2Y@infradead.org>
In-Reply-To: <ao0stlR57iUgrY2Y@infradead.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 25 Aug 2026 14:43:36 +0800
X-Gm-Features: AcwNN1XlfhuMbQQSog0MnhYGpEbeFP_-um6bcH3M-yGPRIQpgDsdeDCHwg1wJxU
Message-ID: <CAGFpFsQmT47aXkRb=6csbTTeTzaG4jGoyFwHJY_TiNEouKeKuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] f2fs: complete dropbehind write bios in safe task context
To: Christoph Hellwig <hch@infradead.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	qiwenjie@xiaomi.com, Jens Axboe <axboe@kernel.dk>, Tal Zussman <tz2294@columbia.edu>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Thanks, I missed that these helpers had landed for 7.3.

  I'll rebase the next revision and use BIO_COMPLETE_IN_TASK for dropbehind
  write bios, removing the F2FS-local context check and dropbehind-specific
  workqueue deferral. I'll also Cc the people and lists involved with the
  common code.

On Tue, Aug 25, 2026 at 1:48=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 24, 2026 at 06:33:46PM +0800, Wenjie Qi wrote:
> > Buffered RWF_DONTCACHE writes invalidate dropbehind folios from writeba=
ck
> > completion. Keep normal and dropbehind folios in separate write bios, a=
nd
> > defer dropbehind bios to sbi->wq unless completion runs in preemptible =
task
> > context.
> >
> > Use an F2FS-local context check for this decision. Task context alone i=
s
> > not sufficient: preemption may still be disabled, or completion may run=
 in
> > a preemptible RCU read-side critical section.
> >
> > Keep the existing large-ATC deferral unchanged.
>
> Please reuse all the helpers added in common code in 7.3 for deferring
> bios and tsting if that that is neeeded instead of badly reinventing
> the logic.  It also is really helpful to Cc people involved with the
> code and the relevant mailing lists.
>
> >
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > ---
> >  fs/f2fs/data.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 6ae0eb37d20..774a3e2d8e3 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/fiemap.h>
> >  #include <linux/iomap.h>
> >  #include <linux/fserror.h>
> > +#include <linux/rcupdate.h>
> >
> >  #include "f2fs.h"
> >  #include "node.h"
> > @@ -43,9 +44,29 @@ struct f2fs_folio_state {
> >
> >  struct f2fs_bio {
> >       struct work_struct work;
> > +     bool dropbehind;
> >       struct bio bio;
> >  };
> >
> > +static struct f2fs_bio *to_f2fs_bio(struct bio *bio)
> > +{
> > +     return container_of(bio, struct f2fs_bio, bio);
> > +}
> > +
> > +/* Keep in sync with the proposed block-layer bio_in_atomic(). */
> > +static bool f2fs_bio_in_atomic(void)
> > +{
> > +#ifdef CONFIG_PREEMPTION
> > +     if (rcu_preempt_depth())
> > +             return true;
> > +#endif
> > +#ifndef CONFIG_PREEMPT_COUNT
> > +     return true;
> > +#else
> > +     return !preemptible();
> > +#endif
> > +}
> > +
> >  #define      F2FS_BIO_POOL_SIZE      NR_CURSEG_TYPE
> >
> >  int __init f2fs_init_bioset(void)
> > @@ -426,12 +447,13 @@ static void f2fs_write_end_io(struct bio *bio)
> >
> >       sbi =3D bio->bi_private;
> >
> > -     if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_=
size) {
> > -             struct work_struct *w;
> > +     if ((to_f2fs_bio(bio)->dropbehind && f2fs_bio_in_atomic()) ||
> > +         (in_atomic() &&
> > +          bio->bi_iter.bi_size > sbi->max_atc_write_bio_size)) {
> > +             struct work_struct *work =3D &to_f2fs_bio(bio)->work;
> >
> > -             w =3D &container_of(bio, struct f2fs_bio, bio)->work;
> > -             INIT_WORK(w, f2fs_write_end_io_work);
> > -             queue_work(sbi->wq, w);
> > +             INIT_WORK(work, f2fs_write_end_io_work);
> > +             queue_work(sbi->wq, work);
> >       } else {
> >               f2fs_write_end_bio(bio);
> >       }
> > @@ -530,6 +552,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info =
*fio, int npages)
> >       bio =3D bio_alloc_bioset(bdev, npages,
> >                               fio->op | fio->op_flags | f2fs_io_flags(f=
io),
> >                               GFP_NOIO, &f2fs_bioset);
> > +     to_f2fs_bio(bio)->dropbehind =3D
> > +                     !is_read_io(fio->op) && folio_test_dropbehind(fio=
->folio);
> >       bio->bi_iter.bi_sector =3D sector;
> >       if (is_read_io(fio->op)) {
> >               bio->bi_end_io =3D f2fs_read_end_io;
> > @@ -825,6 +849,13 @@ static bool page_is_mergeable(struct f2fs_sb_info =
*sbi, struct bio *bio,
> >       return bio->bi_bdev =3D=3D f2fs_target_device(sbi, cur_blkaddr, N=
ULL);
> >  }
> >
> > +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> > +                                       struct f2fs_io_info *fio)
> > +{
> > +     return to_f2fs_bio(bio)->dropbehind =3D=3D
> > +             folio_test_dropbehind(fio->folio);
> > +}
> > +
> >  static bool io_type_is_mergeable(struct f2fs_bio_info *io,
> >                                               struct f2fs_io_info *fio)
> >  {
> > @@ -1017,8 +1048,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio=
)
> >
> >       trace_f2fs_submit_folio_bio(data_folio, fio);
> >
> > -     if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> > -                                             fio->new_blkaddr))
> > +     if (bio &&
> > +         (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> > +                             fio->new_blkaddr) ||
> > +          !f2fs_bio_dropbehind_mergeable(bio, fio)))
> >               f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
> >  alloc_new:
> >       if (!bio) {
> > @@ -1118,7 +1151,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *=
fio)
> >           (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bi=
o,
> >                             fio->new_blkaddr) ||
> >            !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> > -                             bio_folio->index, fio)))
> > +                             bio_folio->index, fio) ||
> > +          !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
> >               __submit_merged_bio(io);
> >  alloc_new:
> >       if (io->bio =3D=3D NULL) {
> > --
> > 2.43.0
> >
> ---end quoted text---
