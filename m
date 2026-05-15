Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B56403148
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866617; cv=none; b=LMk6sVhuIkQYxUrQ5E1OAQ3SeJlRcHh/tbw2E2fk5wC+H664v8hZeqW7Ua3iUqVEGaIdwEELVoRZGxkC/Jveq+zhM1UjstOpC3QRfOFMfkpCB3wsY0GTxwsuKUrpYuf4RJ9gbrhHG+C5tUxtQd/jX9raX2/0UEqSqy11LCAS15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866617; c=relaxed/simple;
	bh=Yh61NuVXAuHNhb8mJhwuBLpQlNV3ivz2X9aK2VQ8e7g=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=SazHVPIPhg4CF9tRpZ/fskkEeO3MC68cNVkFnO+fz888soIcmdTBESiK5XhmAsxmRYotiNgo2KbaxbmsIdk20HfAoUsF/06UA7f5yD2fqiR/QwKlAyPO8RT3lCMVVfgf0ltn84FCimarJmeAwcyYr9pBwHqMbW2i4RWwYB1lRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b6vNpmxJ; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b6vNpmxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778866610; x=1779125810;
	bh=Yh61NuVXAuHNhb8mJhwuBLpQlNV3ivz2X9aK2VQ8e7g=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b6vNpmxJEIMnzvRTvHo+wyDG3Mer/auzfJ65/1jSouu/aIxsvihHlw+2gB4ZG1Bvv
	 J5CDbVpUuBwj7GR2R3DqImmfvGV481kO05gwK8Tz9o7YutYPMUkATfRRjMHBvLws6R
	 emg99Fbd5V6Te3iNAnT9HfF9a3H/LgPD8OYDdXfrfJ/E4fXyJapt527TbyeXI6ljGW
	 j0dz6f7xzbIeZJryNsr7nicp6vXL8bXkY7UAV/I2BoJuhC6KulgCeRB8shEj2VkFHV
	 76Rax9s0zcRe+kjhZx3bX5AaypIKy9W6s0RSGKVuPJZgg6YhagW5yQFcV27RE6w4Wi
	 CZHKvvFynZdJg==
Date: Fri, 15 May 2026 17:36:45 +0000
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Subject: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP exposes identical data unprivileged
Message-ID: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: 8d368b2e39cdc5099e9caadadaad2cf5206606ea
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hello Linux Team.

While reviewing fs/ioctl.c I noticed a privilege asymmetry between
the legacy FIBMAP ioctl and the modern FS_IOC_FIEMAP ioctl. Both
interfaces return physical block addresses of a file on disk, but
their access controls are inconsistent.

=3D=3D The Inconsistency =3D=3D

FIBMAP (fs/ioctl.c, ioctl_fibmap):

=C2=A0 =C2=A0 static int ioctl_fibmap(struct file *filp, int __user *p)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!capable(CAP_SYS_RAWIO))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EPERM;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D bmap(inode, &block);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 }

FS_IOC_FIEMAP (fs/ioctl.c, ioctl_fiemap):

=C2=A0 =C2=A0 static int ioctl_fiemap(struct file *filp, struct fiemap __us=
er *ufiemap)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No capability or permission check */
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D inode->i_op->fiemap(inode, &fieinfo, =
...);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 }

In do_vfs_ioctl(), FS_IOC_FIEMAP is dispatched directly to
ioctl_fiemap() with no capability check (line ~530):

=C2=A0 =C2=A0 case FS_IOC_FIEMAP:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ioctl_fiemap(filp, argp);

FIBMAP is routed through file_ioctl() =E2=86=92 ioctl_fibmap() which
enforces CAP_SYS_RAWIO.

=3D=3D Practical Consequence =3D=3D

An unprivileged user can retrieve full physical extent information
via filefrag(1) (which uses FIEMAP) but is denied equivalent data
via FIBMAP:

=C2=A0 =C2=A0 $ filefrag -v test.dat =C2=A0 =C2=A0 =C2=A0 =C2=A0 # succeeds=
, shows physical offsets
=C2=A0 =C2=A0 $ filefrag -B -v test.dat =C2=A0 =C2=A0 =C2=A0# fails: "FIBMA=
P requires root"

FIEMAP is strictly more capable than FIBMAP: it returns byte-level
physical offsets and extent flags in a single call, while FIBMAP
operates block-by-block. Protecting the weaker interface while
leaving the stronger one open does not improve security.

=3D=3D History / Rationale =3D=3D

FIBMAP's CAP_SYS_RAWIO requirement appears to have been added to
guard against the information leak of physical disk addresses, which
can assist in certain storage-layer attacks. FIEMAP was introduced
later (2008, commit f28a61f) and was intentionally designed without
a capability check, trusting that file permission checks on open()
are sufficient.

If that later design decision is considered correct, FIBMAP's check
is now a dead letter -- it only creates user-visible inconsistency
(filefrag -B vs filefrag) without any security benefit.

=3D=3D Proposed Fix =3D=3D

Two options are possible depending on the desired direction:

Option A) Remove the now-redundant CAP_SYS_RAWIO check from
FIBMAP, aligning it with FIEMAP. This eliminates the inconsistency
and allows tools like filefrag -B to work for normal users.

=C2=A0 =C2=A0 --- a/fs/ioctl.c
=C2=A0 =C2=A0 +++ b/fs/ioctl.c
=C2=A0 =C2=A0 @@ -58,10 +58,6 @@ static int ioctl_fibmap(struct file *filp,=
 int __user *p)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode =3D file_inode(filp);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct super_block *sb =3D inode->i_sb;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int error, ur_block;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sector_t block;

=C2=A0 =C2=A0 - =C2=A0 =C2=A0if (!capable(CAP_SYS_RAWIO))
=C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;
=C2=A0 =C2=A0 -
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D get_user(ur_block, p);

Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
This restores the intended restriction, at the cost of breaking
unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
This option is a larger ABI impact and likely undesirable.

The preferred fix is Option A, since FIEMAP has been available
unprivileged since 2008 with no reported security issues, and read
access to physical block layout is already implicitly available
through open() permission on the file.

=3D=3D Test Environment =3D=3D

=C2=A0 =C2=A0 Kernel: =C2=A0 =C2=A0 6.1.0 (Debian 12 / Bookworm)
=C2=A0 =C2=A0 Filesystem: ext4
=C2=A0 =C2=A0 Arch: =C2=A0 =C2=A0 =C2=A0 x86_64

Tested by calling both ioctls directly via a small C program and
confirming ioctl_fiemap() returns physical offsets to an unprivileged
process while ioctl_fibmap() returns -EPERM for the same file.


I am happy to submit a formal patch if the direction is agreed upon.

Regards,
Eneshan Erdo=C4=9Fan Karaca
My github:https://github.com/Kisaca-Enes
