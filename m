Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372D3BC664
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826590; cv=none; b=Sm5/hM5gooaaPaK5KRScTRw4aVs7faNv2ujSdlD8ZXCsFaeLbTYg/9s5n7U7UEnqpGmP+XrkjqqvK+EKq+I1txjs6eAYbO2oGLq2sPDM9/hfL9tl21MZ7t3OOelGv58dh487LWEoH1klJIVBDmKzV4qScq5mp+rR1Au+Vprofd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826590; c=relaxed/simple;
	bh=/vYm6ZwYvKTDKejjAqCURiSs4gb63/IpRk+1+7ijEKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi4ea+Pmys8UtJJue7vrHGxws6MESVjuxgC4vJUGY2m1Fs2TgUoEFsd0Jb2I4LoItl5WFRo2UjJrG+bX5nILGb+F6AGWhnRCBVIOnGBs1DY5lv3L94WcTxfqAwyVZnngVzkyi9PxqhFV2mYEoQD5y+K2wb7VH1WOQSK11p4sEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=BKpUii12; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="BKpUii12"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8accbaa1c11so9315857b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 20:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790826587; x=1791431387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vYm6ZwYvKTDKejjAqCURiSs4gb63/IpRk+1+7ijEKA=;
        b=BKpUii12C3bvuGxwV6T4AH1L+YIjA1YZ1FIvjpioMk8XSIT9bIEyGV8gK1de359TXH
         /cfpF+DRNrWT4duhx8YBizn9x8hWTAw9CqOZ47KTZz98y3oZQX9MTd3F4hfVa+N9JTxg
         Vd/V9uFBso4+cr0qEucJ+AiSddrMBsQvfeQjUb54jhS1Y9JR3O29X64zUiSKxCu/Rtmm
         aqM7uB2f14I3e6rUVOa4b9XFHVZQH0AKb8V0YwukI+NxRhnhRM7FTr1YyNCeY6olUlBZ
         eYP86fFLWuAx1/7e0wVbTgX6LDwtIe9TOwQH7BVoN7J37OCIsZrcn32jC2JJ1DCnaM+V
         r2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790826587; x=1791431387;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/vYm6ZwYvKTDKejjAqCURiSs4gb63/IpRk+1+7ijEKA=;
        b=IGqmLGyYjpKm7rLxqP/OPCA8eXN+Dz2fMBiHN3Raau5zWV2PbzXuhOXHaw8exzIJyy
         ZwRjEgZfHAUPdWGXIA50HfO7FFix8LAi76GkG9tTJhfA6JEx8Au3Gv4Ye+hyyEP8GoFg
         vVaRMWsMgtN6dKbmUlQfyEGkbrXWDUSyCDrdKsdhhhM+rr0ARZZrgbPk2OXUfhER4dzk
         H1P5r49EfE3g+/PCbYyInHywM4jPPKpKZw87O3a1498FTMrvZBuNmNoJHiZzRR8RlYRg
         vfCTsFFylimQ73qkPrQvWLQCgDFzrYl0muAKzOp350DjzzEDkQwVOCq/XlFw7x4K1IKY
         Rb8g==
X-Forwarded-Encrypted: i=1; AKwUvBycWIYQmQskzqUHwCpevs7LkTnQoQMnPdCjftPljxvGrBj7bv64ilE7rp/tynKS0K/dr1nL7mrZ1gtpDDlu@vger.kernel.org
X-Gm-Message-State: AFq9FYJruuQsAKAgqPEZB4WnmWku811SbFZIqIieMAQ180SzhydYJ6fe
	jGeZYp9A1C+jzX+Y3Wx3AkZbJrKPj6GXyFnfmwHbypCIuELcYZWzQoL+Y7QY4ftiWwbVPiDx2XE
	QQVNiKbI=
X-Gm-Gg: AYBFou0+tgM67QkmcoC9NvLkl9fBVMZ5JnROJ4vzVHuBRiiMElM6HOl4eFXAkxHE3Fz
	s4Tv3dQImu42bgopGwSetsE4YM7k/429k7X05/1jPh8Gf6LJ0K4eI8E3a4ScO3R81dSokDJocP7
	nie+Gaw0uZLFGwdscWkbPCFX0ZckyHEC18enRZhhZWpm0kU/BijyMyTBc1pS8yV00MxJe2bgSxI
	qz2Vtd2zPrGCIEUEcaHV9PxzYxXjA/05h1YLmO2lj1VKh5Jyy72A05vMd+niVFeBMkddL2WX/Wm
	HkWGU7sQTwYDMsvAVBlvKYRAEUcKTKfXxSlSxcbCLVZUdCvP7T3iNoCFo6Mz1Wug/NeaVErFX1Y
	BBoUPCPLSI3WIoMTlL1c67/5CkEUaVDJB6XCQkZTWcyqsDO+RKTHjsK32hBOOZO/v/v749r3bbx
	Zdja7SPNgkj/qU7zpKixgTcOCwxWKx0YmUJr3J33tqMNFNlcixfCNv3xB2MC0NWSoiynhZlesRf
	3NsH8f5I421W7SfrS9ge2ah0YJW1oc0mZw/DGKSK9kIYSJOHJcLEHHKPWWCj3OAPpjJywu2BJRj
	eetQWYiTXBLkthgloHtG/kfs7TtEvOUblZvqb9QiHedr/beM2FbEk3p7Lbx8Eyv7DJA8bbzytlY
	=
X-Received: by 2002:a05:690e:408c:b0:676:9885:d2b8 with SMTP id 956f58d0204a3-6769885ee68mr97499d50.30.1790826586838;
        Wed, 30 Sep 2026 20:49:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:487b:bc91:650e:71d4? ([2600:1700:6476:1430:487b:bc91:650e:71d4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdad9eaafsm6033437b3.46.2026.09.30.20.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:49:46 -0700 (PDT)
Message-ID: <8dfb90a2751df30f76ab5130960591a57c51be4d.camel@dubeyko.com>
Subject: Re: hfsplus: possible recursive locking on extents_lock during
 unlink/truncate
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?Kullan=C4=B1lm=C4=B1yor?= Pasif <guvenlik@noroxi.com>, 
	linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 20:49:44 -0700
In-Reply-To: <CAHfT-UBFPgXcYu+2sS8bg12GC0LvXpAkVqrSg9N8BzEhUBAO8Q@mail.gmail.com>
References: 
	<CAHfT-UBFPgXcYu+2sS8bg12GC0LvXpAkVqrSg9N8BzEhUBAO8Q@mail.gmail.com>
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

On Thu, 2026-10-01 at 02:58 +0400, Kullan=C4=B1lm=C4=B1yor Pasif wrote:
> # hfsplus: lockdep "possible recursive locking" on extents_lock
> during unlink/truncate
>=20
> **Reporter:** Noroxi (Mahmut Emin Kurhan <guvenlik@noroxi.com>)
> **Subsystem:** fs/hfsplus
> **Class:** lockdep false-positive (possible recursive locking) =E2=80=94 =
CWE-
> 667-ish
> **Severity:** low =E2=80=94 lockdep splat while mounting/using a crafted =
HFS+
> image. Analysis
> below indicates this is a missing lock-nesting annotation, NOT a real
> runtime
> deadlock (the two locks are different inodes of the same lock class,
> acquired in a
> fixed order). No memory corruption.
> **Status:** analysis from source; observed under syzkaller
> (kmemleak/lockdep) fuzzing
> of HFS+ image mounts. No standalone reproducer extracted yet.
>=20
> ## lockdep report
>=20
> ```
> WARNING: possible recursive locking detected
> syz.3.60/2437 is trying to acquire lock:
> =C2=A0 (&HFSPLUS_I(inode)->extents_lock){+.+.}, at: hfsplus_get_block+...
> fs/hfsplus/extents.c:264
> but task is already holding lock:
> =C2=A0 (&HFSPLUS_I(inode)->extents_lock){+.+.}, at:
> hfsplus_file_truncate+... fs/hfsplus/extents.c:579
> =C2=A0May be due to missing lock nesting notation
> ```
>=20
> ## Call chain (from the report stack)
>=20
> ```
> hfsplus_unlink =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs=
/hfsplus/dir.c:420
> =C2=A0hfsplus_delete_inode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs/hfsplus/i=
node.c:553
> =C2=A0 hfsplus_file_truncate =C2=A0 =C2=A0 =C2=A0 =C2=A0fs/hfsplus/extent=
s.c:579 =C2=A0 <--
> mutex_lock(inode A ->extents_lock)
> =C2=A0 =C2=A0hfsplus_free_extents =C2=A0 =C2=A0 =C2=A0 =C2=A0fs/hfsplus/e=
xtents.c:364
> =C2=A0 =C2=A0 hfsplus_block_free =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs/hfsplus/b=
itmap.c:185 =C2=A0 =C2=A0 <-- reads
> the allocation bitmap file
> =C2=A0 =C2=A0 =C2=A0block_read_full_folio =C2=A0 =C2=A0 fs/buffer.c
> =C2=A0 =C2=A0 =C2=A0 hfsplus_get_block =C2=A0 =C2=A0 =C2=A0 =C2=A0fs/hfsp=
lus/extents.c:264 =C2=A0 <--
> mutex_lock(inode B ->extents_lock)
> ```
>=20
> ## Analysis (why this is annotation, not a real deadlock)
>=20
> - **inode A** =3D the regular file being unlinked/truncated.
> - **inode B** =3D the **allocation bitmap file** (`sbi->alloc_file`):
> `hfsplus_block_free()`
> =C2=A0 reads a page of the allocation file, which goes through `-
> >get_block` and locks the
> =C2=A0 allocation file's own `extents_lock`.
> - The two lock addresses in the report differ, so these are two
> *different* inode
> =C2=A0 instances of the *same* lock class (`extents_lock`). lockdep flags
> this as
> =C2=A0 "recursive" and itself notes "May be due to missing lock nesting
> notation".
> - The acquisition order is fixed: a regular file's `extents_lock` is
> taken first (in
> =C2=A0 truncate/extend), then the allocation file's `extents_lock` while
> freeing/allocating
> =C2=A0 blocks. There is no reverse path (the allocation file's block I/O
> does not take a
> =C2=A0 regular file's `extents_lock`), so no real ABBA/self-deadlock
> exists.
>=20
> ## Suggested fix direction
>=20
> hfsplus already solves the identical problem for the B-tree
> `tree_lock` via
> `hfsplus_btree_lock_class()` (fs/hfsplus/hfsplus_fs.h), which returns
> a distinct
> lockdep subclass per tree CNID and is used with
> `mutex_lock_nested()`.
>=20
> The same pattern applied to `extents_lock` would resolve this: assign
> a distinct
> lockdep subclass to the special-inode `extents_lock` (at least the
> allocation file,
> and for completeness the attributes/catalog files) and take it with
> `mutex_lock_nested(&hip->extents_lock,
> hfsplus_extents_lock_class(inode))` at the five
> lock sites (extents.c:153,264,457,579 and xattr.c:267). Regular files
> keep the default
> subclass, so a genuine regular-file-vs-regular-file recursion would
> still be detected.
>=20
> We can provide a candidate patch if useful; deferring the exact
> subclass scheme to the
> maintainers since the lock design is yours.
>=20
> ## Disclosure
> Normal fs bug report (not a security embargo). To:
> linux-fsdevel@vger.kernel.org;
> Cc: Viacheslav Dubeyko, John Paul Adrian Glaubitz, Yangtao Li, linux-
> kernel.
>=20
> ## Credit
> Found by Noroxi via coverage-guided fuzzing (syzkaller) of HFS+ image
> mounts.

Please, send the formal patch and we can start the regular review and
discussion.

Thanks,
Slava.
