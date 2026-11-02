Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657831;
	b=u08jGIW4yvvXA8aUB+AusvDRgZHFTUuyRQhQlo5XO1as/DIVU3hhcbBQ8TfhL0oBAWWW
	 7aJK3TtDhuJZKuQO9piPyZruefDW/S7IscVmK7QIGCGB/ZHEZ3ucSX9UxQALaIwSG70wL
	 Ro72tgPr6DcDganCLZvG7+q3YEm7YN1AJnd4VPk1p6ZSVk8ZlrQmo9dYedrcolaYi7JjX
	 3mupWDDmekUOtIo76R1QzfHeQswW4sv37QZm7HlhS3j8y3cEa9jLUZ3Jba9YgR7aINmAL
	 3Obm4OpwDlw//AGw0zXzqTdpW4ON9XWhb7s9PQs9z0JXFkgnp/hhaSe0Jp4xu2Jy5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=XtEgL/miWZ1olP8ce54kEQWLV8a3bUZ6w45Zvf1BpeQ=;
	b=WMts4/zpsaNdobXxqyiVzSsf+VZ+gjub9SNLZWfBt2vc1hptmAgIdt2rOiCW9Mee1dYZ
	 Xv7H+UCdtz3icZhKw8HGSFmLSDB7SHDPbaDSDyDP/EHMHZmZV4/edbmiaWaMSgJ2iPoCL
	 1wgUn1/HSAxJQnkhggGp0Z/ckSe4qef4S6ve5FHlGRu68u3w/tUK5TNOi5/Cf5UggRd84
	 MDKWdgmH4whVTJZVVy8bnPV5NPKEnK3789KxdM6y9GcmBH7jMsA43APV/iCstlPvnFCxx
	 GmNAxFRj2n6aUDwMzoecoST5Wz7Qvgj2X5Z+btYP6P/Kal5MVV7h6Vklytm2BsJ5U6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NdG+pad6;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48457606A327
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48457606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NdG+pad6
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b118bea471so19270207b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793657830; x=1794262630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtEgL/miWZ1olP8ce54kEQWLV8a3bUZ6w45Zvf1BpeQ=;
        b=NdG+pad6BzfnpbF0AvbKdGy3MzplOcjK4Kc4VHsC4UFViZJ9M/affo2ysF6qlPqYo+
         7+/XPZ2jEPS7pXzc4SpvFfwKvgdUbxXPTStELuV41bA7RjoDgR3lLgYvk6gbYPY5t5Gx
         1Y2MDTigATKftmNP+PIF+Zds0zd9rRB/9EywpzBdEbVhCJRLZXpNjg5444SfdpYkgoj0
         pX2KTgCQbSYNGIaLk5oRu93Jc/kbWoYHH4lQMFJ8zak4N4QzWZOZNizJStyY0xL6whkB
         X8Z7JRYwQZ/U0ADErcDEg6A0cuW5CDi86AC7OtBJOhpTJ17jnh3m4bhkWECkox/Xsovy
         l00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657830; x=1794262630;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XtEgL/miWZ1olP8ce54kEQWLV8a3bUZ6w45Zvf1BpeQ=;
        b=w3iJYKrH0XGfDzku8wqYgFeer8aJmUIwwohpHjz4ENTwLFKpsGiukovIJlZUpfew80
         QejC4+RdbjXq9vwmKPgbTBaoCUPxF7b2MR3zaQvX+kP4qJHMIqLtle5Hqbj7ZNcqK6v/
         HlZDvf+TTZKxBnD2ZlfhfUEtkbEwqGekJPex4uqX2z/UcQ9obgjQDGurqxPPIoJp9KLH
         cUtLInosxDA9TPOr/4kh4fRguYp2mXGYA/mVP0izA+O42BSAPBRkpVm1gAtrhXaOfEFB
         eKH4IbbrwZWStJbxCn2XeGNLq5MKFMtQ8R1ZERIGIKGTomnpf9Mb31Rs6+IjiAySSjPz
         Aiww==
X-Forwarded-Encrypted: i=1; AKwUvBxGysmGGzpHojIaxilrmwpfmpF89uA7V0bIpPDRgllBzR3Ht6vUBw6JIdpqYC2y0h5m5vII7nMBSdnT2fOL@vger.kernel.org
X-Gm-Message-State: APuU4Z9mCEvK3E/ydoovB+vkTAZ2iSB03uo+YhV5x3MM6yK1B9ZfOpUI
	haKTGloi1wURpDQAEIJYyTWoGa6CREQJJkPxwaYkNzX6MdM7jR+QN42TbtfuEOmwamI=
X-Gm-Gg: AYBFou39nmuRQOxvwrpeHPH6L+3w2aNe7F3fngh6uwF3+MCwa7buMNAoVQkQH/oX7vJ
	wnj1E8XrZqN+FvAOOoyRoiE9qCm7BKsLJ56jtQyDqO6GOi+poDzl3JBHv4bOd4GGd5D/APWei4z
	cMTGYhJpr/SC54xXYEcs0kXLfVl1GZbG3YGWT69WKTyf7a27ih2w3tes6MpLKCYaFUy3BMfpmp4
	FM6+9opBJOGKKeTUNLM5POYuiqec6xkd/egkTq8cclNdvSlw0mKLeeaAsb50p7mAge6XQuXKfNT
	h/IfaxDgpCTQeiiEHMq5uX5t20ZLlDovrYBf4hzrO03rzjteYVtmBm9Wqf9/36E/iJi3ftUnH7Q
	351BMCdl6U8d2K6OH207TLmc4uTF8L3H0K+kEj7M7w/XrnBLtXgRrwgZCbslSCt4eMl0Kl+omkS
	pcxWG+YXSBzzTuen0Lsn0XmNzWeBnkGu+jR/q1n2OvQsmGpoYjg9/WcmA86CUYHYsb/uFWErWxs
	+SCOuMNeZyeMoGiPEHoLpVNGTM1s1W1CPkVqiAEks16t0HTM5A98iyln3forunrgbKX5BEiza+1
	266rqv5K95ElZWE0NztBR1ChUFJ5Ki7oqVfFwvq6BIQPB5Wx/XKkiOhwikuSkOma7/fkHjFqWP2
	d0ZqUNyzc23zdaReen+vrSOlXN9MDnS4sZxXVgXReQBL07Y/a0UAEr6OnhhCJpWTWWfgg1HxbeW
	OiAc2GbAWB6yoxzgJ+
X-Received: by 2002:a05:690c:82:b0:8ac:c329:67e6 with SMTP id 00721157ae682-8b2b66d063amr89870697b3.16.1793657830162;
        Mon, 02 Nov 2026 14:17:10 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bd40sm60952257b3.16.2026.11.02.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:17:09 -0800 (PST)
Message-ID: <92845c60aca5dc2209a43d309b7bb9fa66aa044e.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: free failed b-tree nodes in hfs_bnode_put()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Song jeonghak <thdwjdgkr123@gmail.com>, Markus Elfring
	 <Markus.Elfring@web.de>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Edward Adam Davis <eadavis@qq.com>,
  Shardul Bankar <shardul.b@mpiricsoftware.com>,
 syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Date: Mon, 02 Nov 2026 14:17:07 -0800
In-Reply-To: <20261101162949.147400-1-thdwjdgkr123@gmail.com>
References: <773c7445-8d4b-4d94-a995-297ecee9c879@web.de>
	 <20261101162949.147400-1-thdwjdgkr123@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 01:29 +0900, Song jeonghak wrote:
> Hi Markus,
>=20
> (Resending as plain text; my previous reply was rejected by the lists
> because it contained an HTML part. Sorry for the duplicate.)
>=20
> > How do you think about to avoid a bit of duplicate source code?
>=20
> Thanks for looking at the patch. The two branches share the
> unhash/unlock/free steps, but they handle different situations:
>=20
> =C2=A0- HFS_BNODE_DELETED is only set by hfs_bnode_unlink(), when the nod=
e
> =C2=A0=C2=A0 is removed from the tree. Its slot becomes unused, so
> =C2=A0=C2=A0 hfs_bnode_put() also clears its bit in the allocation map
> =C2=A0=C2=A0 (hfs_bmap_free()) and, if HFSPLUS_VOL_UNUSED_NODE_FIX is set=
,
> =C2=A0=C2=A0 zeroes it (hfs_bnode_clear()).
>=20
> =C2=A0- HFS_BNODE_ERROR means the node failed to load. It is still part o=
f
> =C2=A0=C2=A0 the on-disk tree; only the in-memory copy is dropped. Its ma=
p bit
> =C2=A0=C2=A0 must stay set, otherwise the allocator could hand out a node=
 that
> =C2=A0=C2=A0 is still linked, and its on-disk contents should not be
> =C2=A0=C2=A0 overwritten. In my reproduction the failing node is the head=
er
> =C2=A0=C2=A0 node (node 0), which must always stay allocated. From readin=
g the
> =C2=A0=C2=A0 code, hfs_bmap_free() would hit its BUG_ON(!node->this) for =
it;
> =C2=A0=C2=A0 I have not run that.
>=20
> I looked at how other put functions that take the lock with
> atomic_dec_and_lock()/refcount_dec_and_lock() deal with this, and
> both forms are used. ceph_put_snap_realm() in fs/ceph/snap.c repeats
> the unlock in each branch, while fsnotify_put_mark() in
> fs/notify/mark.c records the difference in a flag and does the common
> part once. Following the second style, the two branches could become:
>=20
> 		bool deleted =3D test_bit(HFS_BNODE_DELETED, &node-
> >flags);
>=20
> 		if (deleted || test_bit(HFS_BNODE_ERROR, &node-
> >flags)) {
> 			hfs_bnode_unhash(node);
> 			spin_unlock(&tree->hash_lock);
> 			if (deleted) {
> 				if (hfs_bnode_need_zeroout(tree))
> 					hfs_bnode_clear(node, 0,
> tree->node_size);
> 				hfs_bmap_free(node);
> 			}
> 			hfs_bnode_free(node);
> 			return;
> 		}
> 		spin_unlock(&tree->hash_lock);
>=20
> I am fine with either form and will use whichever the maintainers
> prefer in v2.
>=20
> While looking into this I found a mistake in my changelog. It says a
> failed node "has no b-tree map bit to release and no contents to zero
> out". That is wrong: the bit is set and the contents are on disk.
> They
> are left alone on purpose, as described above. I will correct this in
> v2.
>=20
>=20

Somehow I cannot find the patch in my email client. Please, double
check that you send the patch in plain text and, please, ping me if I
don't answer on v2 of the patch.

Thanks,
Slava.
