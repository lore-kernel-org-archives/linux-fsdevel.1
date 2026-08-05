Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CD3DC4AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956578; cv=pass; b=EMfLL9rgfUyjoMkPFa+vPdmUafIjS0/oH95G5nF+niUb7edHSpdfVX6ptfnFCFWPh3aFaQHp4EboVh+nKnORzSoq09kNIpL/ygfwUgyhlu3E5hiLT9XBL53iLxRyW6pL2RKC4w16QsZ0rlCJ7tQJsGKs8z8xQwngIGTfTFhFlZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956578; c=relaxed/simple;
	bh=ZkwANXvB/ZU9t3LgTT3w1mAN0VeV9gy04VEToUnWNWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9narx6g4p4FmKT9C4cP/IPfCMRIhD5wR+rs7/B5cQXwGiwMg+x47xPnMvvLpRt2og9Rjytfa2M0KeKZ/k0xeqafu8dVoVO75HxXwS8YI9tP83lYOOZtuwODQbS012QpbB3f+WywncOcAdeoqfIBfXOiDZ4P6/bq4kst974+v2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy4Ag8wv; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy4Ag8wv"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so2093954a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 12:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956559; cv=none;
        d=google.com; s=arc-20260327;
        b=hvLfx2snNw1pfUHdzY3KEP6sd50YTP8Me9GYETCNHG5CkW0KqXBsIxFsdktIt2nGMW
         Ubaqs/iwA8D1OgEjjuPYDFmgwzHjLTqLFgS6CiblUVZvSPme/ShpHqcd5w09dXV6KksV
         shDUh5Md8zPuxLr9uJ7etJupdd9lbSPMQzajIbWk/2EHBoNMFOf19lP4nthKIaK2VHjm
         gSN5yzO81Lrk+oDyB4IqZ3ZQzLU/vx9t+BbUhBD+VShs5aDt+3/A2KhEpyyWD5nXk8Ip
         lVNegRe6OXuVx1USs4JsDvFvaqHcvFt+YgyeWHR6xjRS5+Rfc+Y40pIlhXvdvSQWgQCB
         fH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yjE4xnT39vpf/cIgIYUv/kq7g7oy4MnCKn9bbbuZ18Q=;
        fh=Ix9CrobylE9IxakVjLLK6sXzbWfdK10aQCMD9ocLbq0=;
        b=GvjmhgK2A5S5YpzGzbwW/jO9D1vTBYsg/FirH8d1C9YzPoGXiudCM5/9G6t8W6QkJg
         Lb30T7Pl+R8kmGavvyAOq6jisbwRS6D4m1qBW/6mpunlOiMrBaHEPkABz4EntJ3AvTsd
         oBtv81e1qnzJgxEsqDJe4px74c7SLU+0sAA06W3O40dyHuO9Gy0fPlPUT20CP2tDqmpO
         J1MgJbFLR2GPOHFILG4m2h7EdYH8oDPmk7fpz2quW8gnfw2nLdMrqlhzXbtIzzursz9C
         LMgXHCbPFOUCcPH/mpW2D2niLgn4bvyda5gQyO3T00zcQOFKCB6L0SHEsELMe3/6oZAw
         j5TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785956559; x=1786561359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yjE4xnT39vpf/cIgIYUv/kq7g7oy4MnCKn9bbbuZ18Q=;
        b=cy4Ag8wvBKQRm+j5xKMyQfTrzjH48rFaMIGaIzz51yzz0O4p1TthGImHlGyDVOM4kB
         Hv616jq2qKqSp7yV0nncp7dKDUasSam95v1/1v4S+zBbWFJp26DFbnU4dQGzBiZX8y3O
         dtkorSi42lxmDG6BEok+PTdz3C6VH4vCc0XeGe4FGghiLRo/9QbBeUIpa8dIPLyhh8+R
         Faa8rcyQxL/tMwCEd1zoBCPf7R3twoJ6oQJsQ3q/gkHAK4dsWpKba9KG9jT7LKFucJhl
         q4nOS1YWJOz676wa72AAzKz3jZwLXAgg/wA951lkfIkgo1qDDe7MLgjD7+cTWIgCkV4+
         Xedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956559; x=1786561359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjE4xnT39vpf/cIgIYUv/kq7g7oy4MnCKn9bbbuZ18Q=;
        b=ki/sR+BFmmklSIX/57nRa2/TZjYG7eVU5qD1jo253Sj0qzLGO0nR/ZWp1TijnIQcYh
         MGwTb8FV59bKaFta1w5OKF9etl0TPuj/PxLYZY/qb9u0EcJVXpaPqWfpC9W5RrTRzvJO
         8dYe8Veo+29uoS+5TIlBatY4q51a6pEuQ8EhzsVzEAmWJDwb3YIyl8klQx3VjoCPhLz9
         YGDlux+6wfBFp+TByXgN4SYsjtBHQO847I+AM+tPvVVU3sDEAD4jpaVI4wZHUizLINYN
         yJT8NdzGoa10jlCqN6v8Ci5VnCLvJUOmBgc/g6oJJY0MWjMqyurg+01A1dBAM/Joeptl
         hkDw==
X-Forwarded-Encrypted: i=1; AHgh+RonCA8+4bSSOzhCIDJ5JeomWI6k/uYDPXUwiQyZ4I+bM/qVSzlMhFgIBq3Wv0tAgcLn7hjynJ8OMtq/E5WD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2tL3cJUw807hoyXe4MRbzBVjRsMFwyOjgptJ+965Ze+nW5f5
	2FIdUqSMCLCuF0AmqpHbSa5X4b1b5pB0ON0XqkFDfb9mZ4AtSSjJ1TXNUHuqbtz2cKRp9LtcheD
	i/Mz0VjWBsPsz0vqETzba1w1X887l3+w=
X-Gm-Gg: AR+sD13TIyt86BRLwyS5SQjFTL+YNUaMipdTl7L6/HCXrwvaC6AOLyl4NYtl95q1g2J
	u3fzjZsS40L9w3EGmA85b3pjwO/MWcCfwtn+ctS7o3BYzCX9xw7BQ3C9W3D/UwJD+lJjrHflmfs
	WGexW0/KuDoNJlHuvJGN63XR2yY56iDki3CG55K0ORlJbLyUwLrFOfyMMaTwTOvZDK/nXaIoxeK
	m9lCVD4SpAMWQqKk16AerbfZkDZiDnSR0s/K3quUIdWJbQHWYpL1tg+ch883JKNs7PIdokzb2ku
	R2xuAglP9E051Nvxa+PJWgwnNJ/eQDgR5M77Vf0t1RXi
X-Received: by 2002:a05:6402:324d:b0:6a0:ecc9:79ad with SMTP id
 4fb4d7f45d1cf-6a14f27eb8cmr4200909a12.20.1785956559020; Wed, 05 Aug 2026
 12:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <2824f30bbc43e6a0b318564fa641228e9a096e37.1785621505.git.coshi036@gmail.com>
 <aqyhnzlgxo4x2v6bfpi43ueoob2drnpcxkmy7fpx3i7bcrvkzj@rm2bn66enfc3>
In-Reply-To: <aqyhnzlgxo4x2v6bfpi43ueoob2drnpcxkmy7fpx3i7bcrvkzj@rm2bn66enfc3>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 15:02:27 -0400
X-Gm-Features: AUfX_mw6M87toR509y6pAXXK646xUVHCYetXkG3wp8ZS--BnNZ1uTuGmAkGSoO8
Message-ID: <CACd_6n1YDk=S1MWd=7TH29mTcyiijLQn8jZOyjGo=p9yduZ06Q@mail.gmail.com>
Subject: Re: [PATCH 03/19] jbd2: point the shadow buffer at the frozen data directly
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for the suggestion - done in v2.  new_folio, new_offset and the
frozen flag are all gone; folio_set_bh() moved into the one path that
still needs it, and the two copy-out paths just set new_bh->b_data.
b_folio is already NULL out of alloc_buffer_head(), so nothing has to
clear it either.

Chao

On Tue, Aug 4, 2026 at 4:28=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 01-08-26 18:00:47, Chao Shi wrote:
> > When a metadata buffer has to be copied out before it can be journalled=
,
> > jbd2_journal_write_metadata_buffer() writes jh->b_frozen_data rather th=
an
> > the page cache copy.  b_frozen_data is kmalloc()ed, so folio_set_bh() m=
akes
> > the shadow buffer point at a slab folio.
> >
> > That is not something the buffer_head layer can reason about.  A slab f=
olio
> > overloads ->mapping, so a shadow buffer looks like it belongs to an
> > address_space when it does not.  buffer_set_crypto_ctx() already has to=
 use
> > folio_mapping() to avoid tripping over this, and it is the reason
> > mark_buffer_write_io_error() cannot be called on a shadow buffer today.
> >
> > Point the shadow buffer at the frozen data itself instead: leave b_foli=
o
> > NULL and set b_data.  The previous patch taught fs/buffer.c to submit s=
uch
> > a buffer.  The two commit-path checksum helpers are the only other user=
s of
> > the shadow buffer's contents, and they take the data directly rather th=
an
> > kmapping a folio that is already mapped.
> >
> > Note that the shadow buffer must not be passed to bh_offset() while
> > b_folio is NULL.  All four callers that can see one are handled here an=
d in
> > the previous patch.
> >
> > Tested with ext4 mounted data=3Djournal,journal_checksum on a metadata_=
csum
> > filesystem, writing files whose every block begins with the JBD2 magic =
so
> > that escaping forces the copy-out, then crashing with sysrq-b without
> > unmounting and replaying the journal on the next mount.  Recovery
> > completed, the file contents matched, e2fsck -fn was clean, and an
> > instrumented build confirmed the b_folio =3D=3D NULL path was taken.
> >
> > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Chao Shi <coshi036@gmail.com>
>
> ...
>
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 09efa337649e..9e4cb04587b4 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -329,6 +329,7 @@ int jbd2_journal_write_metadata_buffer(transaction_=
t *transaction,
> >       struct buffer_head *new_bh;
> >       struct folio *new_folio;
> >       unsigned int new_offset;
> > +     bool frozen =3D false;
> >       struct buffer_head *bh_in =3D jh2bh(jh_in);
> >       journal_t *journal =3D transaction->t_journal;
> >
> > @@ -354,8 +355,7 @@ int jbd2_journal_write_metadata_buffer(transaction_=
t *transaction,
> >        * we use that version of the data for the commit.
> >        */
> >       if (jh_in->b_frozen_data) {
> > -             new_folio =3D virt_to_folio(jh_in->b_frozen_data);
> > -             new_offset =3D offset_in_folio(new_folio, jh_in->b_frozen=
_data);
> > +             frozen =3D true;
> >               do_escape =3D jbd2_data_needs_escaping(jh_in->b_frozen_da=
ta);
> >               if (do_escape)
> >                       jbd2_data_do_escape(jh_in->b_frozen_data);
> > @@ -400,13 +400,22 @@ int jbd2_journal_write_metadata_buffer(transactio=
n_t *transaction,
> >               jh_in->b_frozen_triggers =3D jh_in->b_triggers;
> >
> >  copy_done:
> > -             new_folio =3D virt_to_folio(jh_in->b_frozen_data);
> > -             new_offset =3D offset_in_folio(new_folio, jh_in->b_frozen=
_data);
> > +             frozen =3D true;
> >               jbd2_data_do_escape(jh_in->b_frozen_data);
> >       }
> >
> >  escape_done:
> > -     folio_set_bh(new_bh, new_folio, new_offset);
> > +     if (frozen) {
> > +             /*
> > +              * b_frozen_data is slab memory, not page cache.  Point t=
he
> > +              * buffer at it directly rather than at a slab folio, who=
se
> > +              * ->mapping is not an address_space.
> > +              */
> > +             new_bh->b_folio =3D NULL;
> > +             new_bh->b_data =3D jh_in->b_frozen_data;
> > +     } else {
> > +             folio_set_bh(new_bh, new_folio, new_offset);
> > +     }
>
> Can we please simplify the flow in this function? folio_set_bh() is now
> done only for a single branch in this function. You can move it there and
> completely avoid new_folio, new_offset, and frozen variables (you just ne=
ed
> to set new_bh->b_data in the two branches where frozen data is used).
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
