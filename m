Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63458271464
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903780; cv=pass; b=Sgz36RybqpdLZp2EsjmsdS0VNQRaapbW6d5gig0N+GoiEObWzrTqY3vGYzFocogK3TvXE2lksPASA2x81oGeUalJVbR9P26l/mLDtb/WwjhVnn2MaWq/2CBPxrKGXT3JvFjXU+ehWvlsPK2EcgTyw0rWryfAxB9LMAUnfzATeMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903780; c=relaxed/simple;
	bh=GBIPC2mOXO+C8mP0OPNZVgrMcvb8lRAc39IWp2TURbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5l1ZTTOZIhtj+WrZTCY9KwiSDVEksSZd+TevQLQHck46Q0xkTfvlde0jCalyJ7E7ePfdDwZ2XwrTH9QwX27fBUu//wt8AyvTuYM6xTiZhCihDHRcMdVBCwPTyx8ZRboN03ZUD9r0YNaQOvaEOAsxyeFY0tuo8B7ymzzMQJwXSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0PXxfLw; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0PXxfLw"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8891febd2so15853227e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779903778; cv=none;
        d=google.com; s=arc-20240605;
        b=HOIPjGolCLJ0W0DItnKXth4EPFsHUqNx2MHcU0MXsLWJcGH82G+C3EA9zD66OoA+OJ
         hYjTId8BA3yOvYFpzKXjinwI8MGiMgi9nM75MCGy9Fej7ICu57QB1XFmnWjdmiQJOElI
         UYkIkHrKEHyykGzNbPxZTpdwCFVWpzL5x5f6mGrrANHnC5To/dQGSX6I7Io9y5sUuIQH
         czTEMUgJAP6AbPHlUb6FYoqAsXZZfGACljGHs1dz069FoykkJVhBhG36t/fSYuQybGo8
         +Wm0fNL+u/3MPFLWi/5GROMOl1qE6NPL13JsfOexkyTmEJKWtOqNsLkLrpMyBKA1BFht
         6+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdSLAensyefgAJdHATus0kj3/VI6wqV5LI7xg1TKSH8=;
        fh=nNrc6r1nH9TbIuorcn5GEBaJ4YwC+z0zZc9HqKRkl5w=;
        b=kcfhqZ3fs5YsOIuSRSA5ZkjawSQ8CmYq/L62AY7h2HflsFGT+uch+so1249ns6fTWh
         VEnpDAq4B5Wfc77w9b2PgbGBjHVAY66IIzceMwOsdyCbBhjZyJv3c9Fyz+eMi6aihll7
         s9RvsoBBaxWeeOZePRb6THJ2kBzH2PkMfiMp1XeiOURsGvA+vuO0yZIx8yrpihCDE/Cx
         7o4Cq0BG/6PCTg5Are9my0RcHsEJWp7DnlYpSTbhUEyTefewa0uyn04hwV8Zzdgg3jsE
         wNz66vOHDASl7e/DkwseoPGz7DBCUPgv5wehdz5G3IMPr+SVOCuCd+u12+bo5tUv6Tmo
         mieg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779903778; x=1780508578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdSLAensyefgAJdHATus0kj3/VI6wqV5LI7xg1TKSH8=;
        b=o0PXxfLwmC5rwT5bUN42DK7zJMRjxnbCMKUi/5HtJphnzjr86oUbgD9wfq5CJqo+SQ
         LsWmR1gKvzU/PuLiBZzx2pYZqL7umsrs7FlwmDIDjcqUkBspdVLFYRvUgKdEfBlKXj3l
         jRQ0Kv2sQWalJGxeKTdj0XXh+4gPfYQhu9xAA+3J4cFJM8j8zM4gkXzETndeBWBal9Sz
         G+da+DMVWGzaxnWtvlXcr9QqiEVNIvwqYcys2OhFVnLdx4t+9gKTxn7uCRqRLjDIP6Ru
         c4RzvywTTUmlMH+0TMyBTx5VBQxEaVN8sQn3JNPJDt9qa7UC0/0503wHdLvMFC0Alq63
         Jj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903778; x=1780508578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdSLAensyefgAJdHATus0kj3/VI6wqV5LI7xg1TKSH8=;
        b=ipWOJQJDNuSQsUKxY9RVrODrsgibIAHije8ALZCpTXM6eoGvCCpTWtMxux/dDP91r3
         lLV6d9ohnicCuEvVE5UXBWb+/z5lFj8Fv3uxszHbZyGba/zTvGh2k364/+wy32wGogYR
         c/LhfQLCWElCubCW1E7wHF2nAzIIMr89n+lPJtHWxkWovURZOMQD8ISF7ymaaWcLU7Pz
         /gC2EClcUWNT6KMEAnsNpUWL1yF9VKZap5IjYPW12QWmX2b6TPk/Fq/mlk7Q/nZiaJ3q
         jnym3DpOxg8BV7foLnzX5TtbtO7RmBo5f806X7ukgDtP85/rkObu4NWxk1OKBgYhAYwR
         nboA==
X-Forwarded-Encrypted: i=1; AFNElJ9HjZ+CqK7pk9Q0ONszZLRzLj3H9Y9fZiMvmH3CAXYOoXjrmOOUmK+AhQdS+HDYqpsw2CZ01yzW4ufS+3nN@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRKIkWYbMyu9xUQrWWu/IYj/nCd/i+hA2qAvp0hgXTe7cndqj
	K1qGaYHztCL0HhLF9sng7zDMKWSWsgTSXC4NjR+v9Q8hRwSxpF5WWHk3pSTCNSgSTQZKQMFFnDO
	0MqSHsKSKV2Sh0mQrTKeg2UK/CwaHmas=
X-Gm-Gg: Acq92OFRMqGef5FoylNFVQ+b8YApk70ObEeGnebbgzbdyQNtVXLvhlBo5MLkTE1H1wg
	IkH46hZo3aYOXYQmHefxXdqIUnE6ZOQxyrVtL5NT/n8qLvL5S5HLr1Qv+0AVv7uOlsnfEssQz6k
	swiYF+3DzoW3JjN4qawqQGoZn1cN64EoCBthhWZCbrmu1QkWG7aF67juHYxjLULUXK2beyaX7zz
	jGjtAP1f4M9TQP30yYbmWDyzdhViLDGiJ9NBNY5FwiIV+L/gKh73k5S2Jvpd5RylCNDoGx3PZXN
	EPa5mKWHtZmnXgOlY9I=
X-Received: by 2002:ac2:4c4e:0:b0:5a8:89d6:93c3 with SMTP id
 2adb3069b0e04-5aa323bc5dbmr6759557e87.21.1779903777308; Wed, 27 May 2026
 10:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525171931.4144395-1-willy@infradead.org> <20260525171931.4144395-28-willy@infradead.org>
 <e078ab852f15f720e609b3691c1e61bd1eaeccc5.camel@ibm.com>
In-Reply-To: <e078ab852f15f720e609b3691c1e61bd1eaeccc5.camel@ibm.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 28 May 2026 02:42:40 +0900
X-Gm-Features: AVHnY4Io1qpGXQE2Cpsjzt5vJ_ty_bhsQeG5fEt-UPP6TXngdbNNmO9hpPezYZk
Message-ID: <CAKFNMomQOg0v6kRc2J_TrGE8h8xO3MYMXjoZqDdM+JR8dUJBqw@mail.gmail.com>
Subject: Re: [PATCH 27/34] nilfs2: Convert nilfs_btnode_submit_block to bh_submit()
To: "willy@infradead.org" <willy@infradead.org>
Cc: Viacheslav Dubeyko <slava.dubeyko@ibm.com>, "jack@suse.cz" <jack@suse.cz>, 
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:52=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Mon, 2026-05-25 at 18:19 +0100, Matthew Wilcox (Oracle) wrote:
> > Avoid an extra indirect function call by using bh_submit() instead of
> > submit_bh().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: linux-nilfs@vger.kernel.org
> > ---
> >  fs/nilfs2/btnode.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
> > index 2e553d698d0f..0a4b61498eff 100644
> > --- a/fs/nilfs2/btnode.c
> > +++ b/fs/nilfs2/btnode.c
> > @@ -134,9 +134,8 @@ int nilfs_btnode_submit_block(struct address_space =
*btnc, __u64 blocknr,
> >       }
> >       set_buffer_mapped(bh);
> >       bh->b_blocknr =3D pblocknr; /* set block address for read */
> > -     bh->b_end_io =3D end_buffer_read_sync;
> >       get_bh(bh);
> > -     submit_bh(opf, bh);
> > +     bh_submit(bh, opf, bh_end_read);
> >       bh->b_blocknr =3D blocknr; /* set back to the given block address=
 */
> >       *submit_ptr =3D pblocknr;
> >       err =3D 0;
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
