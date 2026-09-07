Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478063EEAC1
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801977; cv=none; b=kWXXOSspcnYGakkqEnScgEjtAHsWi6UieHktXzqBWJx240RuTvDMk7YuubNNpa2EYWmMkX2pr71rRbFOF2M0TCFnElkChZx8HdQZ03syOoMcIoBrASZP+MM0BiUHamg5YCyvJzgv6mSRkQyUFF+/G06XlwXRfUMaNsY1y+KGMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801977; c=relaxed/simple;
	bh=/NxZDHIokUme5+nGAwQvFZ5D9rsY5fzj+zXH0DKNBo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ec7UGuG0dNt7teF/FF8q8imXZbi4qhEdqp8U3zD9lJuKRmh+rFFhPLpTnLb+1dSDShbHVLgBUc1wBLNrtDhluAyjE6dK+3HHo5l5D7vK945VkqzdIYAesMNE2Ff+Jia3Wjni4hLQaRvZHi7ge2RFCpMRF8OymkbCEtRdWCCpYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ItnLG/Lo; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ItnLG/Lo"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso2119748e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788801975; x=1789406775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NxZDHIokUme5+nGAwQvFZ5D9rsY5fzj+zXH0DKNBo4=;
        b=ItnLG/LoyY97Ei/usEKOY9b5G6aLiqAoLZYIxXfP4ziSKjjr7IjwDC6kFLqzHa8zt7
         sFWi1YLsoOe41Ye/0xA+K5Iv8JLudbvsqNM5NuyD4OngP6+FejXuxuWGSgK8Ie/LggO+
         qLyAl4++zWua8KpWyR4WZpa4W7d0vdP5VBVoxXaBsNBUFF2FBAYe9ia6z+ZFEjAibHa3
         TmlZDOqYyFWo7Vnfp3/Rbz95HoMMECf2VrmWvqTD8IzQM090XYCbGh1p/lwJtEx25vKI
         8YT8JsG6QiSfAzPJ9mukOK1KCp7iNnl+q8o3a11fNGdiFKk5s1+xTEK4+pURG64YZBrg
         Q91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788801975; x=1789406775;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/NxZDHIokUme5+nGAwQvFZ5D9rsY5fzj+zXH0DKNBo4=;
        b=gPVC8bu1LsKZ0ivjSwU5ygyCXWm0445yBoL3532TOPyyCCoVLyPBSny137dpRxyika
         bdqWKnKze7vOsdbL1J/wii8RoBt+2rZ/Ryz6jI4dNhkogzSwBDF94JlowrvKLtUk/HDN
         UCg1yl2fqMogP6ypur7LJ5f+tqdNepjF7JvybB9mX8HUnTxjccOrek/MgqEfTSb+EsUR
         p5QL85IwXgVQuKKZ6rt4+Myt6/3qG1Ey6XDQ/cO2kcfbxduWgmitCFvdjuFbYFmXIknh
         39pEwG8B+5iZNrDR6pa6frH8ysLjMpxNHxCrJrn4uw5Bj5VU9rx96eGq4UD/0UG42pUJ
         vQcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg009PIo488/MJa8meJuw/aK26v42b16rhiI606AcLqEHOvOTl0FI6TDrhsWYYW/NDj8uw2MlA/2eQdGq7@vger.kernel.org
X-Gm-Message-State: AFuF++kgo7sw6e9d5W0GYSLcxWvr3YQQmlxBZN9+5xGbgp6q+qUZFiWe
	4L0bPwTNdTL5KVT/XSvGz0P7xvTFgKgLRA5OXUlUCjen7IOfGOcQXgWj2U/RoPz1bH4=
X-Gm-Gg: AYBFou2nPOUG796vh782D4unAgdBncNpkj1CdqJivsr+9na4vAquu5JGizBmc0qcsHv
	DPRo+sfV3l3iECsqUgGQkoUicXHff64Ec1rtC6fpdGYxF4UaGh/goHb0IqlMXJL1cxzPmdMvpiK
	AlCrXtW3+f5lveltCbN/vkpFi1XiqCAzY3csm7cvHGV3Fs9slniwxItECWY0ujmYQEJjnrlFIdC
	r3hwxXOhmF+97/rEO4Q3/tUyybkjk7R3CXzY8ZnSsSUtR5lfGQTzMPvGYp8TPupjCdNvnU6eWiC
	QjoeSrxs6jXiH/QFnG9RYTTrRV3z9pIAD1s4JcqmPwUFfG2sgfEYMNNwG90oTdSFcpx2weIDWGO
	dCIpxBJ+OrjsYmZtQmsf6otLlVr+sC1zQVNsga7iBQGxBAujBESGLvwApU81Jcp4BNkq8Sz1dMe
	g4acF3uPyesJ08q8EJsuoOidXhd8R94rbi9pMn3e3Mi4zlE4PNOa8mwwgCoHGtuwyLbnEgRjHUQ
	3E7a2ZkI9KOe+dxI1gKZLB1++lEH9OT3UfH5UsO9qx6Z1XmYa/WYKHCt6IShvwS/+mGDI9mKr01
	eaC5shn5eVruXB3jzQ+cYJdT4uG5wndSbBJAb/y6dCSCBx0ojzvmmQ==
X-Received: by 2002:a05:6122:1d47:b0:5c4:1f03:a1fe with SMTP id 71dfb90a1353d-5c7ed298c90mr9614192e0c.1.1788801975006;
        Mon, 07 Sep 2026 10:26:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:51d3:d0fc:6793:303f? ([2600:1700:6476:1430:51d3:d0fc:6793:303f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm446878e0c.11.2026.09.07.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:26:13 -0700 (PDT)
Message-ID: <1b3ba7f7afc3509720cad69ba8c7c17a9276ecd1.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Mon, 07 Sep 2026 10:26:10 -0700
In-Reply-To: <20260907171543.8175-1-ngocthang2710.1999@gmail.com>
References: <56524bbf4d0a08e932f9cea18861538151a89534.camel@dubeyko.com>
	 <20260907171543.8175-1-ngocthang2710.1999@gmail.com>
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

On Tue, 2026-09-08 at 00:15 +0700, ThangNN99 wrote:
> Hi Slava,
>=20
> Thanks for looking at this.
>=20
> > Could you please explain the use-case or workload that is trying to
> > claim more blocks that fork can include for Extents Overflow file?
>=20
> It is not a normal workload -- it requires a corrupted/adversarial
> on-disk volume, e.g. a loop-mounted image (removable media, a
> downloaded .img/.dmg, or a fuzzer). Per Apple's TN1150 ("HFS Plus
> Volume Format"):

OK. It sounds that you have corrupted fork in volume header for the
case of Extents Overflow file (and, maybe, for other metadata too).
Could you share the dump/content of the Extents Overflow file's fork?
Could we detect the corruption of the fork during the mount phase? If
we can then we need to mount in Read-Only mode the corrupted volume.

Thanks,
Slava.


>=20
> =C2=A0 "The extents overflow file also stores additional extents for the
> =C2=A0 special files except for the extents overflow file itself."
>=20
> So by design the extents overflow file must always be fully described
> by the eight extents in its own fork record; it can never
> legitimately
> need an overflow extent of its own. The syzbot reproducer mounts an
> image whose volume header sets the Extents File fork's total block
> count higher than what its eight direct extents describe, which puts
> hip->alloc_blocks !=3D hip->first_blocks for HFSPLUS_EXT_CNID -- a
> state
> the volume header alone can force without the extents tree itself
> being touched. hfs_btree_open() doesn't currently validate this fork
> against the invariant above.
>=20
> Once mounted, a plain pwritev2() to a regular file (call it FILE_A)
> that already has extents cached from a previous lookup is enough to
> hit it:
>=20
> > Could you please share the call trace for the issue?
>=20
> =C2=A0 pwritev2
> =C2=A0=C2=A0 -> hfsplus_get_block(FILE_A)
> =C2=A0=C2=A0 -> hfsplus_file_extend(FILE_A)
> =C2=A0=C2=A0 -> hfsplus_ext_read_extent(FILE_A) -> hfs_find_init(ext_tree=
)=C2=A0=C2=A0
> [tree_lock acquired]
> =C2=A0=C2=A0 -> __hfsplus_ext_cache_extent(FILE_A): FILE_A's cached exten=
t is
> dirty
> =C2=A0=C2=A0 -> __hfsplus_ext_write_extent(FILE_A): needs to insert a new
> record
> =C2=A0=C2=A0 -> hfs_bmap_reserve(ext_tree): ext_tree itself is out of fre=
e
> nodes
> =C2=A0=C2=A0 -> hfsplus_file_extend(ext_tree->inode)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <- now growing
> the tree's own file
> =C2=A0=C2=A0 -> hfsplus_ext_read_extent(ext_tree->inode) ->
> hfs_find_init(ext_tree)=C2=A0 [tree_lock again -> deadlock]
>=20
> Full syzbot lockdep report for reference:
>=20
> WARNING: possible recursive locking detected
> 6.16.0-rc7-syzkaller-00120-g5f33ebd2018c #0 Not tainted
> --------------------------------------------
> syz-executor310/5840 is trying to acquire lock:
> ffff88807fe920b0 (&tree->tree_lock/1){+.+.}-{4:4}, at:
> hfsplus_find_init+0x15a/0x1d0 fs/hfsplus/bfind.c:28
>=20
> but task is already holding lock:
> ffff88807fe920b0 (&tree->tree_lock/1){+.+.}-{4:4}, at:
> hfsplus_find_init+0x15a/0x1d0 fs/hfsplus/bfind.c:28
>=20
> 5 locks held by syz-executor310/5840:
> =C2=A0#0: sb_writers#8, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
> =C2=A0#1: &sb->s_type->i_mutex_key#14, at:
> generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
> =C2=A0#2: &hip->extents_lock, at: hfsplus_file_extend+0x1fc/0x1990
> fs/hfsplus/extents.c:458
> =C2=A0#3: &tree->tree_lock/1, at: hfsplus_find_init+0x15a/0x1d0
> fs/hfsplus/bfind.c:28
> =C2=A0#4: &HFSPLUS_I(inode)->extents_lock, at:
> hfsplus_file_extend+0x1fc/0x1990 fs/hfsplus/extents.c:458
>=20
> Call Trace:
> =C2=A0hfsplus_find_init fs/hfsplus/bfind.c:28
> =C2=A0hfsplus_ext_read_extent fs/hfsplus/extents.c:216 [inline]
> =C2=A0hfsplus_file_extend+0x416/0x1990 fs/hfsplus/extents.c:462
> =C2=A0hfsplus_bmap_reserve+0x122/0x500 fs/hfsplus/btree.c:358
> =C2=A0__hfsplus_ext_write_extent+0x28d/0x5b0 fs/hfsplus/extents.c:104
> =C2=A0__hfsplus_ext_cache_extent+0x89/0xe30 fs/hfsplus/extents.c:186
> =C2=A0hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
> =C2=A0hfsplus_file_extend+0x444/0x1990 fs/hfsplus/extents.c:462
> =C2=A0hfsplus_get_block+0x411/0x1530 fs/hfsplus/extents.c:245
> =C2=A0__block_write_begin_int+0x6b2/0x1900 fs/buffer.c:2151
> =C2=A0block_write_begin fs/buffer.c:2262 [inline]
> =C2=A0cont_write_begin+0x789/0xb50 fs/buffer.c:2601
> =C2=A0hfsplus_write_begin+0x66/0xb0 fs/hfsplus/inode.c:46
> =C2=A0generic_perform_write+0x2c4/0x910 mm/filemap.c:4112
> =C2=A0generic_file_write_iter+0x10f/0x540 mm/filemap.c:4255
> =C2=A0do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
> =C2=A0vfs_writev+0x31a/0x960 fs/read_write.c:1057
> =C2=A0do_pwritev fs/read_write.c:1153 [inline]
> =C2=A0__se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
>=20
> (full report:
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D172748a2580000)
>=20
> hfsplus_get_block() already refuses HFSPLUS_EXT_CNID for the lookup
> direction (extents.c:261: "if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID)
> return -EIO;"). This patch adds the same refusal on the grow path in
> hfsplus_file_extend(), which is the one hfs_bmap_reserve() can reach
> with tree_lock already held. It doesn't fix the underlying
> corruption,
> just stops it from self-deadlocking the tree_lock; a hfs_btree_open()
> check that rejects such a volume outright at mount time would close
> the hole earlier and I'm happy to send that as a follow-up if you'd
> rather validate it there instead.
>=20
> I have not personally observed the crash on current mainline: I
> rebuilt the syzbot C reproducer, and hfs_btree_open(HFSPLUS_CAT_CNID)
> now rejects the image at mount (silently) -- it's a 2022-era fuzzed
> image and mainline has since gained catalog b-tree validation
> (node-size sanity check, record-offset table validation, etc.) that
> this image no longer passes. The analysis above is derived from
> source
> plus the syzbot-provided trace, not from a reproduced local crash.
>=20
> Thanks,
> Thang
