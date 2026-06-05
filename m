Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248C276038
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685820; cv=none; b=ePqiYLAHr46mVTjQuSIKb7J9Z0PuLZDJUAHHO8sPRhrb4gYXXoAnkpEN5/j8ED9Jrb7+mFpGsP8kgIh0LBW02e4sm1X4jOK3X5BjTI1n37hKPwttKH8NNqHaazN96RILWvIN+PMEb17sJAlaUyokLscQUjahHZGQ5METPGvpxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685820; c=relaxed/simple;
	bh=cWOgdHgnWoXFmAf0rQrIS7t4vDecNJPqnyI1dCrh5Hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/C64hbWo9SCDAc9eNSzH1EM7XrdVRFMdr+onSpsSjYhDDl2VjJOo0yDWxSPtyy3QuTI/hu2UZVtJ6m9kNlVAecYaZrZxaHqqVCIObkD/oPaEoU+xVoOlkm5O/QQL70SNJwpSXe7vpgjMhBpZ/jXZpZkqy4qpTcDzoQ+T949xzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=yezrXtQg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="yezrXtQg"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e0fc8ead7eso26267597b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780685818; x=1781290618; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWOgdHgnWoXFmAf0rQrIS7t4vDecNJPqnyI1dCrh5Hc=;
        b=yezrXtQge00tDPeIPS2hDyxfzQ4KrhXhBrkqXr967z6XFpUiyUMY3CyVplhFWiuhc4
         3fy6T331slvaeL3rFMCT+xVWkS6pXmdyTNWy5fsnAZt3ktjyPhUEFEPMhlfyalw1PyOl
         xg5uQkSPMvAPRPDOnPWD/p2fo2hN7lRNjK/twlLHhdvu6NB+Z0vDGvVXtuoAxgn5BD9Y
         E+ijqa+8IMZb888Rtx4CQSU+5ZanaXeS8JUzo22aUiTTNrUMcQHTj1YZkJfiAM2Oln9Q
         +LQB0PWLLVPW3Dr5i3EKclQKC/9QrICVFCg38GQRV9CRHE0GzlFw25UIZuTLSW3/Za42
         EXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685818; x=1781290618;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWOgdHgnWoXFmAf0rQrIS7t4vDecNJPqnyI1dCrh5Hc=;
        b=qLruQzvc+nLrrFgdxfXN9yoqi6/znB/q/jz7MylHzqvPwYg6FnsKjg4uRLpzfol90n
         vEKUWJiQfXdtXqtz4Pt/jPd2JX5Bso9gwF9odxAkRFOwTb1J7GwH/gET8f+mO/TL1Ppe
         p9NAaKOHX57cQebG+GFc2ABCd9CHO4fKVy5pqpVmKfacAf+1essAer3ZI3PX3b1roS+K
         FxAmC+C6OepYMqiLI7HK2UU/962k+7RZSL+IQF3hEBkHxVPCtnBZ686bahEbkapxsazp
         ezAH7+0zy4ZmeqDnQQFhHwKkZ2jhgsH5svT2AMOSMmK+1kg1L8agzWdYFRjULlWOkvFS
         L/hA==
X-Forwarded-Encrypted: i=1; AFNElJ/Wq5FHo55AcNT2B9dDqbu96fg+slSFAl4n5MdyDAJQGEtHr7Krpw2m5RMgZLeKycWktleeb8nGhZKW5MJo@vger.kernel.org
X-Gm-Message-State: AOJu0YyQueOZGPZQvPjp7ARqaK9QcES7KNYSBJGBw3w+pzOMyRB3DXcT
	moU/rvjy4kZWQ8AKNQA2VkdQKTeWC77LNpoQZBxWtpR2k6K2VrRC3wd19scsRDjkbu/enk35ToH
	ha3A/npgCpA==
X-Gm-Gg: Acq92OGCsxEf6AW3HOyg7XJC73HJ+V7HKBVTUsMdPyPrJxQp45hIXgcxYNnfPjxaRAS
	dHo5C1PXuEIpVWAFXVuGlcxJcEbbmDRORCOEFVjQZKzjysIWO6tX1YAkKZKfQLjVwwA1GDVifnb
	yXWJSiC6IQuRXW1yj1G5Yhk/XZDmJ3xJGgKPRf0FEH2VOy9IlbvX5i+yBvHPY7n3+Qz52Bvypmy
	ZOrBxuOUNvHVoRvPB2SHt1TgxM9wLW06/pJlMQnAq52R4ryEMibApiNUCPS5AgFTWrDT1C65RN+
	tv6Vx0MYgtOK5YwsaUDBpHNG5QWTxR47+lpZboil0aMjx3CL7q9vypWOYCp26uIdhDco8mRqIdH
	aUHdyf136YKAae6DLlXWLBH/ylNWVPAEZ5/OdaXdVE+sROwvfNazkOyPRSRDFA45g07k7mYYdzN
	m+A0OOmU6OI+Hp8Z/dDSyTRBl3TVu+SN/5LzCNcYyi/VA1MNNydLHppwj13i8A9SJ85vOUSerz4
	jhFHW2Vm640nL2rvNv7C8hW3ZMzFWv8XUmwl2EDotdDvSBouy7D+S4VErQkbCRc3FTn
X-Received: by 2002:a05:690c:6706:b0:7db:bff4:f086 with SMTP id 00721157ae682-7ed0c32cd8amr49940327b3.12.1780685818073;
        Fri, 05 Jun 2026 11:56:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:80ee:99ae:6c1:509d? ([2600:1700:6476:1430:80ee:99ae:6c1:509d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2167b40bsm53470807b3.17.2026.06.05.11.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:56:57 -0700 (PDT)
Message-ID: <daa2ae339bf016608a632a94fe0c19ff381a8e42.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 11:56:56 -0700
In-Reply-To: <CAEkJfYO+0+SuaA3iVjrRQu-TUxoJ6_E+WjRFi+FP6Gi-cF2FsQ@mail.gmail.com>
References: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
	 <20260604180306.18672-1-samsun1006219@gmail.com>
	 <8e4f04261421e7c904eabbf702e5eb66c9e20bd1.camel@dubeyko.com>
	 <fc2326a0ba9f73c4151352ab5449197e5f0048c2.camel@dubeyko.com>
	 <CAEkJfYO+0+SuaA3iVjrRQu-TUxoJ6_E+WjRFi+FP6Gi-cF2FsQ@mail.gmail.com>
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

On Fri, 2026-06-05 at 12:00 +0800, Sam Sun wrote:
> On Fri, Jun 5, 2026 at 7:52=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com>
> wrote:
> >=20
> > On Thu, 2026-06-04 at 14:25 -0700, Viacheslav Dubeyko wrote:
> > > On Fri, 2026-06-05 at 02:02 +0800, Yue Sun wrote:
> > > > On Thu, Jun 4, 2026 at 12:25 AM <slava@dubeyko.com> wrote:
> > > > >=20
> > > > > Could you please take a deeper look into my diff that I've
> > > > > shared
> > > > > with
> > > > > you before? I don't see the point to review your suggestion
> > > > > if
> > > > > you
> > > > > completely ignored my diff. From my point of view you
> > > > > suggested
> > > > > completely the same approach but in more complicated manner.
> > > >=20
> > > > You are right. I am sorry for the confusion.
> > > >=20
> > > > I should have looked more carefully at your diff and based my
> > > > reply
> > > > on
> > > > it. Adding an HFS-level MDB mutex and avoiding holding mdb_bh
> > > > across
> > > > the
> > > > whole hfs_mdb_commit() path is the right direction. My previous
> > > > reply
> > > > mixed that with extra cleanups and a separate corrupted-layout
> > > > check,
> > > > which made it look like I was proposing a different approach.
> > > > That
> > > > was
> > > > my mistake.
> > > >=20
> > > > I am not very familiar with HFS internals, so please treat the
> > > > following
> > > > only as a small suggestion. After re-reading your diff, the
> > > > only
> > > > detail
> > > > I am still unsure about is the HFS_FLG_ALT_MDB_DIRTY path. In
> > > > that
> > > > path,
> > > > hfs_inode_write_fork() gets MDB fields as output buffers:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(...=
, mdb->drXTExtRec,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSize, NULL);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_inode_write_fork(...=
, mdb->drCTExtRec,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSize, NULL);
> > >=20
> > >=20
> > > I've started to think that, maybe, the location of these
> > > hfs_inode_write_fork() calls is not correct. We are trying to
> > > save
> > > the
> > > current size of Catalog File and Extents Overflow File. OK, we
> > > need
> > > to
> > > update this if size is changed. But we can save the sizes during
> > > every
> > > call of hfs_mdb_commit(). It's logically incorrect to call these
> > > methods in the alternative MDB section because it is the content
> > > of
> > > primary MDB. I suggest to move these two hfs_inode_write_fork()
> > > to
> > > primary MDB writing section:
> > >=20
> > > lock_buffer(HFS_SB(sb)->mdb_bh);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* These parameters may have been modified, so
> > > write
> > > them back */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drLsMod =3D hfs_mtime();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> > > > free_ablocks);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drNxtCNID =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to_be32((u32)=
atomic64_read(&HFS_SB(sb)-
> > > > next_id));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)-
> > > > root_dirs);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drFilCnt =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to_be32((u32)=
atomic64_read(&HFS_SB(sb)-
> > > > file_count));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mdb->drDirCnt =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to_be32((u32)=
atomic64_read(&HFS_SB(sb)-
> > > > folder_count));
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode,
> > > mdb-
> > > > drXTExtRec,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drXTFlSi=
ze, NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode,
> > > mdb-
> > > > drCTExtRec,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mdb->drCTFlSi=
ze, NULL);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* write MDB to disk */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > > unlock_buffer(HFS_SB(sb)->mdb_bh);
> > >=20
> > > In this case, we don;'t need to overlap the locks. What do you
> > > think?
> > > Sounds like reasonable solution?
> > >=20
> > >=20
> >=20
> > Frankly speaking, I don't like this approach of assigning the
> > pointer
> > on bh->b_data to HFS_SB(sb)->mdb:
> >=20
> > data =3D (void *)(__bh->b_data + __offset);
> >=20
> > We manipulate by various fields of HFS_SB(sb)->mdb throughout of
> > the
> > hfs_mdb_commit(). I think that we need to allocate buffer for
> > struct
> > hfs_mdb *mdb during hfs_mdb_get() (and destroy in hfs_mdb_put())
> > and
> > synchronize its content with struct buffer_head *mdb_bh. Otherwise,
> > we
> > never can resolve the problem of proper locking in
> > hfs_mdb_commit().
> > What do you think?
> >=20
> > Thanks,
> > Slava.
> >=20
>=20
> Yes, I agree. Keeping HFS_SB(sb)->mdb as a separate in-memory copy
> sounds
> cleaner than pointing it directly into mdb_bh->b_data.
>=20
> For the immediate deadlock fix, I think moving hfs_inode_write_fork()
> into the
> primary MDB update section as you suggested sounds like a good
> minimal step. The
> separate in-memory MDB copy sounds like a larger cleanup that could
> follow if
> you think that is the right direction.
>=20

I don't expect that in-memory MDB copy will require significant
cleanup. We already have mdb and alt_mdb pointer that are used in the
HFS code. We simply need to change the initialization phase, freeing
phase and hfs_mdb_commit() logic. It doesn't sound like a big cleanup.
But it will be great to get rid of using the buffer heads for primary
and alternative MDB records. This is the more complicated change. But
it should be not the part of this patch.=20

Thanks,
Slava.
