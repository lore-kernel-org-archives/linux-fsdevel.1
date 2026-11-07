Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794070132;
	b=fm8dzKWN9mnWwzfI0BOg5hJRyhRYHJyyDmXZ9kEjNrVlaKivwseOaayiUm1O70KvGWFd
	 tkVu10RkcdAmaP68LWj3adMnumKoq2lu4f1R3Xx6crcJa6UrNBWSl0uofCJ9t0Mwk6HKA
	 VgI5LFzeBMZtkJnmo+zJrE+051skSN+983VupHYnLF++MaclGuE2qriF7wnte62eAIzYm
	 ly3OPQ5ba/0bb1ROQgqw75U9UI9OEPNtHZRP4xcTg7Sm2updQmE85APwo1xQg7Ffjhh1j
	 IKzMv728zxbqCrhSBljXFnhUcyjBApTPewqYcEJS3VijfpZLXaqYxONetEdZKheTM1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LZ1hEM+d+iNpX1Pv6g3S4J8ubodEppWnVLdYamIPsBI=;
	b=JTQeOh3OQnt7uqbcEz3k1yJBUyRAbcOQoz5T/ovgtNjp3G2l8/gAXGRhoHZXd7/X3cQt
	 p5pFgLZ7XdmB9y02FFc43PI+ZY5iv5xpExphRsC5cQ9i5A9bV5vXv+55Gj+zPQDPAb1t0
	 KVoUb1NLBnXf5lh6MNPMc/wmanJhfuexFIzA1x08edb8ECf+ffWPqozlMCKJXbJVKbMWU
	 xfmBzWO+wkmUElcKVbyjG3I4W2Jxg4STEmDScRVpd6VF0f8BCTHEDWJphS1NYo8NjekSd
	 jmHvVG0HOf3CrKHztDlRWawjFCBifIYIzhJJ7EKlHN4wMC9UhrbVVVfSb6MmhGdtyOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FbJQ3Zqr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEE606A326
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 16:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FbJQ3Zqr
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso495633a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 08:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794070129; cv=none;
        d=google.com; s=arc-20260327;
        b=Yqbxnx1PfVArVUG7b9bDxbKhixb1HKxyEl8zh+v3KnmkeEKvw15VJOVWPVZbMrDFIm
         JCO0bhJMjmc736PDmsJ00Kfc+aAaIk7cnJwFeZLCh3FXDDxs8ebLEw/J2rKao7R5QHdw
         TjEsarh8bK6Bh7xmjkE6+Syp0yK5uOHrOy7kyx0AR4MhlQCz9/nKebyUyloK0Ji/E9S7
         sPXLmeksjL++Lydnn5lpPND/YbAAFleZYI03zGHmHqUn+Ea1KYLC1yCjxPZkAA8qRj1S
         aWmpib3LZAyz9zg/L7evlz2vSyaOz7gaSNQtZfGJtN/BYD2KrES4Lm81T1QwTkpHNaLw
         GE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZ1hEM+d+iNpX1Pv6g3S4J8ubodEppWnVLdYamIPsBI=;
        fh=KKAOnVUcURm4r5gOPoXWPpAcFXWOH6cEcQxK408fwf8=;
        b=DMP5ir+vxD8gqxbAln5Y1Wasermj2vfbk3DJucrru/FJKKYiHw6o2iYuEDgbOtcpON
         Vo2BDql4DcgLEbddqX5AdMWZFrZDNWH9TjbziQ/MwtVGUGphuJZrLnvUhP5rkf66zpXu
         gj2mQnSP9yjPL5Hktt2Lzysqx3etER0hlkIeFWmp+ttQV/n4sUzAbdu47a5iJ0hOXK0R
         5QjJkoIyHTKiuQwNtwt+ymfAqHhU4kI/RblAqCxMzC9IjMc7W62pY8KdiASibeYUATFV
         n5rpwT+ZB4wldQVS2m9b4OrI24sd+EvAv/IFqwLUNlvpXT/jfclxDgNCkqP4tsdtMG89
         fkrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070129; x=1794674929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZ1hEM+d+iNpX1Pv6g3S4J8ubodEppWnVLdYamIPsBI=;
        b=FbJQ3Zqrdpn7NIhiDmg+EUuO6n3ozLBXaaXnvJNjmuY5AlqvMAyJo597rNOoVGHd+P
         Wy0+BFjRiKW+LdqY/E8CeYV42t7cwAmJ5AugbcA9IrMB2CM/bZ4DBvia0Xv7MsG4AgZi
         C30lhUT4bvKQ2SikSiGakC0P7/tq5w5ZAiw7cjWTlhOJPAGHcWeKY11DNjLSqhaj3LCJ
         EfYP2qa9hYSvPmYbNMnzYlsCnW2tfO8v2zrKk1TZnVnWfaWVJoi9yePqPucWkME33sCP
         PU+42FoiSdOSik4gy1NrZDeNWmmJHSVsadZh/wdcs6shRWcOD02h1nfTlAf92y48Nmox
         Q9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070129; x=1794674929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZ1hEM+d+iNpX1Pv6g3S4J8ubodEppWnVLdYamIPsBI=;
        b=wmQsZVKEZcvZJ5KYS+ZO2ZuT1Sy/V0TyGmSArhb0Uvac2gVSjzKXoRbeAxf/ffc10c
         iw3mTI9J61QS2jyY/eEjO00yevstmlNrbsVRkbEPzPweCY2Y/sqRXzh77T1qHQ9C3L/h
         ezhdPidP4EAqROQZxSTgo0rpyOTsO1E4cjWNJg+Y4XM5G3QEk0lI9SDLp7sWMG6ANg7x
         sC1nNz9dV8QvuGrJFXjhFpcMBiUhuOt5klNpErsDb8LcT6J+TYJziqsgSCNTUxKTLrM+
         ZQO0jWe0eMfF+l7cDszP9s3ewso1qZbmrNurms74md6X4lGppiqUIiZ+Jwv7Ot0ddFJ7
         +TQg==
X-Forwarded-Encrypted: i=1; AL+hErFVRsDh+ishKmfGcbjS70nT/wA3jL6EeyFoZ/DujKm4LwgKZRg7S66sp+uXFATv4ow7J9ykIcKaYf4cKZXr@vger.kernel.org
X-Gm-Message-State: APuU4Z/jjeJz+0+5zOFpRg7zvpCtDY2YiEKm2YOBZqZCjsYLntFE3my+
	530uogronU+0kGuqqky7+05OGTfPJ20qoBNjQHz85rzEk06oX4Bo1DkGjIiYhtrZlf2wdM6Xp79
	5lowicpDv7ewnru1C1fAp3sEU7gA85OI=
X-Gm-Gg: AYBFou3/jFSzbXQxckg7uqOK8id759/8H02SRyXrPL357oe3P5Wy32M+5Bh2qyydOfM
	hUbsmhCarXrasLBxv1T9EEzminfQYBA/ahAwOKzewVz5mRDunQPIlMGXcIfLhk5lQRV9XyiAs3h
	pVReuVDINXKaymQPqBXUPMNgsCUCMhXA97TXUobbooiIMnc6Lv2j6GZEb4i0cWP5Kd/daPiu7yw
	DxkEQwz4EMiOvO8LXBsHKebXuQ2KnrngMaAXW81oC9dcYeF4uBhw0lhTXXGwkwdtKfpshZGGFEV
	nyCaqiAFr74/cMagULNyUPfzVaxx7IbrUP+eyMnkZxvK352pRXqLmEbYp/QEQZfNBvPz0DHJXD9
	LpiW8uMFLs1qngiSjYj3xxpGaI7Cz1jgL73wG1fypiG/qGPmEueOUTWGOMEA4skpQv/VqGA==
X-Received: by 2002:a05:6402:1ec8:b0:6b4:dcab:bf9f with SMTP id
 4fb4d7f45d1cf-6b6fae71be9mr1620380a12.16.1794070129335; Sat, 07 Nov 2026
 08:48:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <20261101015551.786044-2-koray.fra@gmail.com>
 <CAOQ4uxiuJ=eZu28FZAUz3rpqPKqCimPxJucOnYYuBowvD09_Cw@mail.gmail.com> <DMP3UBB0QVOT.20HIXK7ZL6K6U@gmail.com>
In-Reply-To: <DMP3UBB0QVOT.20HIXK7ZL6K6U@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Nov 2026 17:48:38 +0100
X-Gm-Features: AclHuK89rvp6wjLvX07JFLvpP57bRUqY-Yxm_O2zzvQ-fpYQDX7x1__0QP5KjTE
Message-ID: <CAOQ4uxgSVc8n1LbL_dcU-DpNN5BB-ap_vGdXEu7+d0Td7PK5Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] vfs: add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 5:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> wro=
te:
>
> On Mon Nov 2, 2026 at 3:00 PM CET, Amir Goldstein wrote:
> > On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com>=
 wrote:
> >>
> >> Add provenance time (ptime), indicating the time when a file or
> >> directory was created. This is user-settable via file_setattr() and
> >> retrievable via statx(2) (using STATX_PTIME) or file_getattr().
> >>
> >> The semantics of when to preserve this new timestamp are the same as
> >> mtime, the idea being that there is a correspondence like this:
> >>
> >> ctime <-> btime
> >> mtime <-> ptime
> >>
> >> so every operation (copying, moving, ...) that currently preserves mti=
me
> >> should also preserve ptime.
> >>
> >> Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
> >> FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
> >> xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() =
to
> >> allow ptime to be used with the file_setattr()/file_getattr() syscalls=
.
> >>
> >> [ This is a re-implementation of the initial patch[1] by Sean Smith
> >>   <defendthedisabled@gmail.com>, following the advice[2] from Darrick =
J.
> >>   Wong <djwong@kernel.org> of using file_setattr() instead of updating
> >>   utimensat() ]
> >>
> >> [1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@g=
mail.com
> >> [2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs
> >>
> >> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
> >> ---
> >>  fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
> >>  fs/stat.c                 |  2 ++
> >>  include/linux/fileattr.h  |  5 +++++
> >>  include/linux/stat.h      |  1 +
> >>  include/uapi/linux/fs.h   |  8 +++++++-
> >>  include/uapi/linux/stat.h |  7 ++++++-
> >>  6 files changed, 52 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
> >> index 833e03810b24..c0645cb22bf3 100644
> >> --- a/fs/file_attr.c
> >> +++ b/fs/file_attr.c
> >> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> >>  static void fileattr_to_file_attr(const struct file_kattr *fa,
> >>                                   struct file_attr *fattr)
> >>  {
> >> -       __u32 mask =3D FS_XFLAGS_MASK;
> >> +       __u32 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
> >>
> >>         memset(fattr, 0, sizeof(struct file_attr));
> >>         fattr->fa_xflags =3D fa->fsx_xflags & mask;
> >> @@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct fil=
e_kattr *fa,
> >>         fattr->fa_nextents =3D fa->fsx_nextents;
> >>         fattr->fa_projid =3D fa->fsx_projid;
> >>         fattr->fa_cowextsize =3D fa->fsx_cowextsize;
> >> +       fattr->fa_ptime_sec =3D fa->fsx_ptime.tv_sec;
> >> +       fattr->fa_ptime_nsec =3D fa->fsx_ptime.tv_nsec;
> >>  }
> >>
> >>  /**
> >> @@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
> >>  static int file_attr_to_fileattr(const struct file_attr *fattr,
> >>                                  struct file_kattr *fa)
> >>  {
> >> -       __u64 mask =3D FS_XFLAGS_MASK;
> >> +       __u64 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
> >
> > That is not the correct way to extend this API.
> > This fixed mask was added as a placeholder for
> > "We intend to add support for more xflags to selective filesystems":
> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-2-amir73il=
@gmail.com/
> >
> > Please see this POC patch for filesystems to publish their supported
> > xflags mask:
> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-3-amir73il=
@gmail.com/
>
> Quick quesiton, should _mask also be used for user-space -> VFS to advert=
ise
> what it wants to change?
> This would be useful for on/off flags, but for ptime both fa->xflags and
> fa->xflags_mask would have the same meaning of "I want to change ptime,
> look at fa->ptime".
> Should we make _mask the only way to advertise what the user wants to
> change, ignore xflags | PTIME in user-space -> VFS and use it only in FS
> -> VFS -> user-space to say "this fs supports PTIME for this file"
> (which will be always once support is added to an FS, so it would just
> be "this FS supports PTIME")?
>

Sorry I was not able to parse your question.

I think the mask should mean "this FS supports PTIME"
regardless if the user asked to get/set it or not.

Thanks,
Amir.
