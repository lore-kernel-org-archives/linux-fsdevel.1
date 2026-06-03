Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43E438FEA
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505638; cv=none; b=F5yZ96LXC0JUQgJ9RX3zaNF/wBO/HiViF0NyLF7slncmAw8igjbNy3V254t21DKABcZfseLdtm2Z0UPiS4slvyjee8hCjooH4hgXKi3tOfdLRo2R2n3CoevVSArOWHqX6IVu/1EFymBtx1z7/H9ZH41kKnli5d565PQ9xaRCM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505638; c=relaxed/simple;
	bh=4sl9pS/BCAPhgYEaC2jvLNi9fdYWG+QwiuonYUfjj7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W78WhypVmLVtz9m8EUchK9eP90tE+QsBZ6Fah274PEMxzlInjtMq45w7hX9A/dWmx6m/b2SGuFHO9S6JzSZpxFvqPl5hjXrkdnNxZykV/c1L/XqY7xjISZrni/9WCPPh6Kf32AIPXjOmEbvHfbLBfgr6O2M0Zy1kCcifplv31bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=yJOqcpWK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="yJOqcpWK"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43f5927e70aso843958fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780505635; x=1781110435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9F39HXjiagKNY1O75uHBNvtjkm7qqfWeyI53bYV6Kg=;
        b=yJOqcpWK7Bi69odJ71bP0DYEh7YOeG7fnjINVaowMjDbiD4NqogIVe0tw7POZXc4O6
         Fa0kU1DfEyTISe7cq5CIJsrPHk6dinFK2Y3sby8O8QTbbO+T+sQ9F7ugw8hSfdNTuWZB
         V2oBz+INmDsbt7rY7YuEC+3OwJOWG+lH6Op+KFz27meiqPDZN4cjUsrq4GDmmDgsV4JA
         5rN1n71bi0WkFOtzQhwHke1DGDkzF2kglDdKR4kkBydeTy7JGMbFv4jGUT3m0m8FX6gC
         CdY0zzEdLqEj2bhF2QYnq88xHRmimjTgdYqUVKbz/57UXN5GjSheiWpTazQsNRxHnwbZ
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780505635; x=1781110435;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9F39HXjiagKNY1O75uHBNvtjkm7qqfWeyI53bYV6Kg=;
        b=jUMvdfTH8/aC0yp/1lUcyi2+J6kMRY+mlOquvgQr/J2XPwfI4PIFy0dpfLHaNww6c9
         69Ok2GvLt/0+43nrj41kbMOPAcb642TLuu5HWjmmGrCtXX7iY4wkQ178DwrNVqPG13pb
         FR16wS9oiAWmeu4+kJv3bkKDYXeKOu5TxZ/cy3Sd1NhJN/nflt1sEkSYhiROB41MRMot
         Qy1o4Y+Ku3feKz8xrdhHbrRJO4ffXxgWGTVyNd1C6p68whzuTf1ZvjZkinz56oRZfhta
         XWOE9+P51+RtgkqVqi6yqmR2huHEdeN3IinRBNXxcWlb+eLX3cvTjwxvy+G+z0aPdBIP
         +SBw==
X-Gm-Message-State: AOJu0YwVPKCrFjAScZHnk6Ob1Qy/x2ktpwPtKQ7CyN3CD5r5GNLALQOL
	PP2xS5260ISjQv2Ru1CTERmr3m/zFqQlQ5+fogX6CcKtO1xphkIz2iQ62yBTrsBzf0w=
X-Gm-Gg: Acq92OG6dDw/KM4u/KWhBTRmFBzNQixQYTYyQt1cqzaGDPytvzrReGXF1waegc8oWh8
	elhM+rNjxjuqUoC7qtxi7DYTWGU9/nFEXNxf3uZ88WIIrWmctJSFJcKP37UAjcT1Sjs+mDzqb6X
	jDpFsX2vFf0//Zo8j10y/CrYcFuoOJR4XBeCaAXLWFHOJcMGsfMayMEZOcM8EJuGCnCuTlsTokS
	QyQBQQonnjbhULTWcoCCe9rc2yuxko92z60lLZEwL2hEVdGDiVzv+TVSPbL/dRmvMxZB+EPxn30
	/IF4P79a6DzN2yw0bfPA2rfTFFonMl4R9ewS38MqIlUdLl0sKgw2/HHRJez8NBhK7Kx3fIDso1S
	P3j/U0CLfkxCNeTllXDjYrX2P7fCw6d0JDf7bAt1rnA8u5nhpqSruBMyImhRTdsHoz1wxDid8Dn
	awf62dq03EO2fjrSo+SwO/FP+nF2vqfkmHKH8A5AGckGYPRkhTXbeQ9CZT2FHiNQw2uEbiKql2E
	d5Upbw+2bIQuC2lP4IFcriZjy4idspsxniRXK2JFdbFY4mswjJPWTOHuEDg6Ks7EjVg
X-Received: by 2002:a05:6870:2405:b0:41c:3225:f98e with SMTP id 586e51a60fabf-440db4c57a1mr2300010fac.2.1780505634818;
        Wed, 03 Jun 2026 09:53:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9912:77fa:9c5:3949? ([2600:1700:6476:1430:9912:77fa:9c5:3949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm2586500fac.15.2026.06.03.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:53:53 -0700 (PDT)
Message-ID: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yue Sun <samsun1006219@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 09:53:52 -0700
In-Reply-To: <20260603152711.6446-1-samsun1006219@gmail.com>
References: <61ad2475a5c156f69697d46a0278982878624421.camel@dubeyko.com>
	 <20260603152711.6446-1-samsun1006219@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-03 at 23:23 +0800, Yue Sun wrote:
> On Tue, Jun 2, 2026 at 2:46 AM <slava@dubeyko.com> wrote:
> >=20
> > I don't quite follow what you mean here. If you take a look into
> > the
> > hfs_inode_write_fork():
> >=20
> > void hfs_inode_write_fork(struct inode *inode, struct hfs_extent
> > *ext,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __be32 *log_size, __be32 *phys_size)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ext, HFS_I(inode)->fi=
rst_extents,
> > sizeof(hfs_extent_rec));
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (log_size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *log_size =3D cpu_to_be32(inode->i_size);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (phys_size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *phys_size =3D cpu_to_be32(HFS_I(inode)->alloc_blocks
> > *
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 HFS_SB(inode->i_sb)-
> > > alloc_blksz);
> > }
> >=20
> > You can see that it is simply extracting values into buffers and
> > nothing more. No mdb_bh->b_data operations are involved.
>=20
> Thanks, I explained this part poorly.
>=20
> I agree that hfs_inode_write_fork() itself does not know anything
> about
> mdb_bh. My concern is about the actual buffers passed by
> hfs_mdb_commit().
>=20
> In hfs_mdb_get(), the primary MDB is set up by sb_bread512():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bh =3D sb_bread512(sb, part_st=
art + HFS_MDB_BLK, mdb);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->mdb_bh =3D bh;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->mdb =3D mdb;
>=20
> and sb_bread512() sets the data pointer like this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D (void *)(__bh->b_data=
 + __offset);
>=20
> So after mount:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbi->mdb =3D=3D sbi->mdb_bh->b=
_data + __offset
>=20
> Then in the HFS_FLG_ALT_MDB_DIRTY path we pass MDB fields to
> hfs_inode_write_fork():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(sbi->ext_=
tree->inode, mdb->drXTExtRec,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(sbi->cat_=
tree->inode, mdb->drCTExtRec,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
>=20
> In this call site, the ext and log_size arguments point into the
> primary
> MDB buffer. The memcpy() writes drXTExtRec/drCTExtRec, and the
> *log_size assignment writes drXTFlSize/drCTFlSize. So the function is
> only writing to the buffers passed to it, but these buffers are
> fields
> inside sbi->mdb_bh->b_data.
>=20
> The race I am worried about is with generic buffer writeback, not
> with
> another hfs_mdb_commit() caller. The new mdb_lock serializes HFS MDB
> commits, but generic writeback does not take this filesystem-private
> mutex. It synchronizes with buffer users through the buffer_head
> lock.
>=20
> One possible interleaving with the shortened mdb_bh lock is:
>=20
> CPU0: hfs_mdb_commit()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU1: generic buffer writebac=
k
> --------------------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=
--------------------------
>=20
> mutex_lock(&sbi->mdb_lock)
>=20
> if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, ...)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_buffer(sbi->mdb_bh)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update primary MDB fields
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_buffer(sbi->mdb_bh)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mark_buffer_dirty(sbi->mdb_bh)
> }
>=20
> /* about to handle HFS_FLG_ALT_MDB_DIRTY */
> <preempted here>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 write_dirty_buffer(sbi-
> >mdb_bh)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lock_buffer(sbi->mdb_bh)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 test_clear_buffer_dirty(sbi-
> >mdb_bh)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 submit_bh()
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_bh_wbc()
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_add_folio_nofail(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio, bh->b_folio,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bh->b_size,
> bh_offset(bh))
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> blk_crypto_submit_bio(bio)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * BH_Lock stays held until
> I/O
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * completion unlocks the
> buffer.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>=20
> <resumed>
> if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, ...) && sbi->alt_mdb) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(..., mdb-=
>drXTExtRec,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ext, ...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^ ext points inside sbi->mdb_bh->b_data
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *log_size =3D ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^ log_size points inside sbi->mdb_bh->b_data
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(..., mdb-=
>drCTExtRec,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ext, ...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^ ext points inside sbi->mdb_bh->b_data
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *log_size =3D ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^ log_size points inside sbi->mdb_bh->b_data
> }
>=20
> At this point CPU1 holds the buffer lock for I/O, but CPU0 does not
> try
> to take that lock before modifying the same buffer contents. The HFS
> mutex does not help here because CPU1 does not take it. The result
> could
> be that the submitted write observes a partially updated primary MDB,
> or
> that the dirty bit is cleared before the ALT_MDB_DIRTY updates are
> made.
>=20
> This is why I think the mdb_bh lock still needs to cover both the
> HFS_FLG_MDB_DIRTY field updates and the HFS_FLG_ALT_MDB_DIRTY
> hfs_inode_write_fork() calls. The lock does not need to cover the
> whole
> commit anymore; it only needs to cover direct modifications of the
> primary MDB buffer and mark_buffer_dirty(mdb_bh).
>=20
> >=20
> > I don't know how to review attachments. If you would like to share
> > some
> > code for review, then, please, include the diff into the body of
> > email.
>=20
> Sure. Sorry about the attachment. The draft diffs are included inline
> below. They are still for discussion, not a formal v3 submission yet.
>=20
> The first diff reworks the locking. The second diff handles the
> corrupted volume-bitmap layout separately by forcing read-only
> instead
> of rejecting the mount with -EIO, and by checking before consuming
> dirty
> bits in hfs_mdb_commit().
>=20
> Thanks,
> Yue
>=20
> --- draft diff 1: hfs: serialize MDB commits and narrow mdb_bh
> locking ---
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index ac0e83f77a0f..e4ed9071c498 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -124,6 +124,7 @@ struct hfs_sb_info {
> =C2=A0
> =C2=A0	int session, part;
> =C2=A0	struct nls_table *nls_io, *nls_disk;
> +	struct mutex mdb_lock;			/* serializes MDB
> updates */


Could you please take a deeper look into my diff that I've shared with
you before? I don't see the point to review your suggestion if you
completely ignored my diff. From my point of view you suggested
completely the same approach but in more complicated manner.

Thanks,
Slava.

> =C2=A0	struct mutex bitmap_lock;
> =C2=A0	unsigned long flags;
> =C2=A0	u16 blockoffset;
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index a97cea35ca2e..991013ae0c33 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -286,60 +286,74 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0 */
> =C2=A0void hfs_mdb_commit(struct super_block *sb)
> =C2=A0{
> -	struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> +	struct hfs_sb_info *sbi =3D HFS_SB(sb);
> +	struct hfs_mdb *mdb =3D sbi->mdb;
> +	bool mdb_dirty, alt_dirty, bitmap_dirty;
> =C2=A0
> =C2=A0	if (sb_rdonly(sb))
> =C2=A0		return;
> =C2=A0
> -	lock_buffer(HFS_SB(sb)->mdb_bh);
> -	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)-
> >flags)) {
> +	mutex_lock(&sbi->mdb_lock);
> +	if (sb_rdonly(sb))
> +		goto out;
> +
> +	mdb_dirty =3D test_and_clear_bit(HFS_FLG_MDB_DIRTY, &sbi-
> >flags);
> +	alt_dirty =3D test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &sbi-
> >flags) &&
> +		=C2=A0=C2=A0=C2=A0 sbi->alt_mdb;
> +	bitmap_dirty =3D test_and_clear_bit(HFS_FLG_BITMAP_DIRTY,
> &sbi->flags);
> +
> +	if (mdb_dirty || alt_dirty)
> +		lock_buffer(sbi->mdb_bh);
> +	if (mdb_dirty) {
> =C2=A0		/* These parameters may have been modified, so write
> them back */
> =C2=A0		mdb->drLsMod =3D hfs_mtime();
> -		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> >free_ablocks);
> +		mdb->drFreeBks =3D cpu_to_be16(sbi->free_ablocks);
> =C2=A0		mdb->drNxtCNID =3D
> -			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >next_id));
> -		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
> -		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)-
> >root_dirs);
> +			cpu_to_be32((u32)atomic64_read(&sbi-
> >next_id));
> +		mdb->drNmFls =3D cpu_to_be16(sbi->root_files);
> +		mdb->drNmRtDirs =3D cpu_to_be16(sbi->root_dirs);
> =C2=A0		mdb->drFilCnt =3D
> -			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >file_count));
> +			cpu_to_be32((u32)atomic64_read(&sbi-
> >file_count));
> =C2=A0		mdb->drDirCnt =3D
> -			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >folder_count));
> -
> -		/* write MDB to disk */
> -		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> +			cpu_to_be32((u32)atomic64_read(&sbi-
> >folder_count));
> =C2=A0	}
> =C2=A0
> =C2=A0	/* write the backup MDB, not returning until it is written.
> =C2=A0	 * we only do this when either the catalog or extents
> overflow
> =C2=A0	 * files grow. */
> -	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)-
> >flags) &&
> -	=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->alt_mdb) {
> -		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> mdb->drXTExtRec,
> +	if (alt_dirty) {
> +		hfs_inode_write_fork(sbi->ext_tree->inode, mdb-
> >drXTExtRec,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> -		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> mdb->drCTExtRec,
> +		hfs_inode_write_fork(sbi->cat_tree->inode, mdb-
> >drCTExtRec,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
> +	}
> +	if (mdb_dirty || alt_dirty) {
> +		mark_buffer_dirty(sbi->mdb_bh);
> +		unlock_buffer(sbi->mdb_bh);
> +	}
> =C2=A0
> -		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
> -		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb,
> HFS_SECTOR_SIZE);
> -		HFS_SB(sb)->alt_mdb->drAtrb |=3D
> cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> -		HFS_SB(sb)->alt_mdb->drAtrb &=3D
> cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
> -		unlock_buffer(HFS_SB(sb)->alt_mdb_bh);
> +	if (alt_dirty) {
> +		lock_buffer(sbi->alt_mdb_bh);
> +		memcpy(sbi->alt_mdb, sbi->mdb, HFS_SECTOR_SIZE);
> +		sbi->alt_mdb->drAtrb |=3D
> cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
> +		sbi->alt_mdb->drAtrb &=3D
> cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
> +		unlock_buffer(sbi->alt_mdb_bh);
> =C2=A0
> -		mark_buffer_dirty(HFS_SB(sb)->alt_mdb_bh);
> -		sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> +		mark_buffer_dirty(sbi->alt_mdb_bh);
> +		sync_dirty_buffer(sbi->alt_mdb_bh);
> =C2=A0	}
> =C2=A0
> -	if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)-
> >flags)) {
> +	if (bitmap_dirty) {
> =C2=A0		struct buffer_head *bh;
> =C2=A0		sector_t block;
> =C2=A0		char *ptr;
> =C2=A0		int off, size, len;
> =C2=A0
> -		block =3D be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) +
> HFS_SB(sb)->part_start;
> +		block =3D be16_to_cpu(sbi->mdb->drVBMSt) + sbi-
> >part_start;
> =C2=A0		off =3D (block << HFS_SECTOR_SIZE_BITS) & (sb-
> >s_blocksize - 1);
> =C2=A0		block >>=3D sb->s_blocksize_bits -
> HFS_SECTOR_SIZE_BITS;
> -		size =3D (HFS_SB(sb)->fs_ablocks + 7) / 8;
> -		ptr =3D (u8 *)HFS_SB(sb)->bitmap;
> +		size =3D (sbi->fs_ablocks + 7) / 8;
> +		ptr =3D (u8 *)sbi->bitmap;
> =C2=A0		while (size) {
> =C2=A0			bh =3D sb_bread(sb, block);
> =C2=A0			if (!bh) {
> @@ -360,7 +374,9 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0			size -=3D len;
> =C2=A0		}
> =C2=A0	}
> -	unlock_buffer(HFS_SB(sb)->mdb_bh);
> +
> +out:
> +	mutex_unlock(&sbi->mdb_lock);
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_mdb_close(struct super_block *sb)
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a4f2a2bfa6d3..60a93c31b3ff 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -339,6 +339,7 @@ static int hfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0	sb->s_op =3D &hfs_super_operations;
> =C2=A0	sb->s_xattr =3D hfs_xattr_handlers;
> =C2=A0	sb->s_flags |=3D SB_NODIRATIME;
> +	mutex_init(&sbi->mdb_lock);
> =C2=A0	mutex_init(&sbi->bitmap_lock);
> =C2=A0
> =C2=A0	res =3D hfs_mdb_get(sb);
>=20
> --- draft diff 2: hfs: detect volume bitmap overlap with MDB ---
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e4ed9071c498..df6ed1298151 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -138,6 +138,7 @@ struct hfs_sb_info {
> =C2=A0#define HFS_FLG_BITMAP_DIRTY	0
> =C2=A0#define HFS_FLG_MDB_DIRTY	1
> =C2=A0#define HFS_FLG_ALT_MDB_DIRTY	2
> +#define HFS_FLG_VBM_OVERLAP	3
> =C2=A0
> =C2=A0/* bitmap.c */
> =C2=A0extern u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u3=
2
> *num_bits);
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 991013ae0c33..4b6f1df5e4a8 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -85,6 +85,24 @@ bool is_hfs_cnid_counts_valid(struct super_block
> *sb)
> =C2=A0	return !corrupted;
> =C2=A0}
> =C2=A0
> +static bool hfs_vbm_overlaps_mdb(struct super_block *sb)
> +{
> +	struct hfs_sb_info *sbi =3D HFS_SB(sb);
> +	sector_t mdb_start, vbm_start, vbm_end;
> +	u32 vbm_bytes, vbm_sectors;
> +
> +	vbm_bytes =3D (sbi->fs_ablocks + 7) / 8;
> +	if (!vbm_bytes)
> +		return false;
> +
> +	mdb_start =3D sbi->part_start + HFS_MDB_BLK;
> +	vbm_start =3D sbi->part_start + be16_to_cpu(sbi->mdb-
> >drVBMSt);
> +	vbm_sectors =3D DIV_ROUND_UP(vbm_bytes, HFS_SECTOR_SIZE);
> +	vbm_end =3D vbm_start + vbm_sectors;
> +
> +	return vbm_start < mdb_start + 1 && mdb_start < vbm_end;
> +}
> +
> =C2=A0/*
> =C2=A0 * hfs_mdb_get()
> =C2=A0 *
> @@ -185,6 +203,12 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0		sb->s_flags |=3D SB_RDONLY;
> =C2=A0	}
> =C2=A0
> +	if (hfs_vbm_overlaps_mdb(sb)) {
> +		pr_warn("volume bitmap overlaps MDB, running
> fsck.hfs is recommended. Mounting read-only.\n");
> +		set_bit(HFS_FLG_VBM_OVERLAP, &HFS_SB(sb)->flags);
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> =C2=A0	/* TRY to get the alternate (backup) MDB. */
> =C2=A0	sect =3D part_start + part_size - 2;
> =C2=A0	bh =3D sb_bread512(sb, sect, mdb2);
> @@ -296,6 +320,13 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0	mutex_lock(&sbi->mdb_lock);
> =C2=A0	if (sb_rdonly(sb))
> =C2=A0		goto out;
> +	if (test_bit(HFS_FLG_VBM_OVERLAP, &sbi->flags) ||
> +	=C2=A0=C2=A0=C2=A0 hfs_vbm_overlaps_mdb(sb)) {
> +		pr_err("volume bitmap overlaps MDB, forcing read-
> only\n");
> +		set_bit(HFS_FLG_VBM_OVERLAP, &sbi->flags);
> +		sb->s_flags |=3D SB_RDONLY;
> +		goto out;
> +	}
> =C2=A0
> =C2=A0	mdb_dirty =3D test_and_clear_bit(HFS_FLG_MDB_DIRTY, &sbi-
> >flags);
> =C2=A0	alt_dirty =3D test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &sbi-
> >flags) &&
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 60a93c31b3ff..81de9607ab24 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -133,6 +133,10 @@ static int hfs_reconfigure(struct fs_context
> *fc)
> =C2=A0			pr_warn("filesystem is marked locked,
> leaving read-only.\n");
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> +		} else if (test_bit(HFS_FLG_VBM_OVERLAP,
> &HFS_SB(sb)->flags)) {
> +			pr_warn("volume bitmap overlaps MDB, running
> fsck.hfs is recommended.=C2=A0 leaving read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	return 0;
