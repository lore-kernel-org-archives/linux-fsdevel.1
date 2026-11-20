Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795190156;
	b=OpFD5AEpD1F7QVagHYy112a4/vDaZH/gPOSSRM+nltYkjnv7ABXfezfHmHk75SJpA0RX
	 3IX1v8gPgPPibXaLcoI8uKWqB3LE0n9cLeHHOrMvA9VipnLMRaW752IPl2TW83Bjs2SKK
	 n42aImUlKALW3ew9MQnhxUxlZgJLzMxD/bDeTOkY++EOM6Y3Yq8+1QYRI7V1ntQtbzIWF
	 cBkzjpS4Ct+WcfWFaIMaJcdtse4WSqSdoS9KSAPpFjphbKcYaPYRngTinfKmxojpOZdfr
	 h9/i8gVJYA3+S+UqNXDk62wE4TknjcamuZRywDzagPOSltiFvmzAYL3xpezObqBg+pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sKN0WqYQTyAXEuN5uWRqYydRHORdhfTbdGPGVmgWZ74=;
	b=Vb/U9sSH65YT3fE9Xp1FaHEXR+WIXCtF89aZeunKNsq7u0sVeSfKmjuGhiC4L0jUuDwF
	 euJ0HlLo97lgfo0pizKbI3FQ29UUGO0uKKrsuphRJVbYQxDstLfr9tvLLxM/2rX6lAu6N
	 UF/QzrZnmpSeGSLNjchz/GPM1kwRDwdbYf5i/TiX7LDna9wc3CmT5Q+iT/FmJGTpUYTEO
	 Zxb0SpHEOLO2DEWuaL2q9xsNb+tR0PsMovQ28f5eLfem1oHB7osQsiiM4d1Gkqbo6xGZ+
	 7hLq44/+v2cghmuCgSBswDw+R1a9TjixRUylamEsewTDmRqVIHz3jKvSlOSjvFUx9Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNI+Voqp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA63606C885
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 15:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA63606C885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNI+Voqp
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so1321628a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 07:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795190155; cv=none;
        d=google.com; s=arc-20260327;
        b=rtFV4VVIug1Ef6KruJMW3jofoqgd6kgBkiWz6R3FPoLebc2elvZCYKlel08Wx6GHFZ
         zdKM7Ebyltl9vGAv+3p4U72VqZI7/YkVRHkdULTxFTGqHpikZGKupbTvs8JY4duR49CD
         vKiJwvfDXc42RgJePG2BAQAGj7GL9Ox2Vzad/+y6wGXBdeCyArAn+GAnuAuGUjiLODFh
         xYKS8n3E+aV7Cgc7erwNVjZXM55MmVQdCY6mcWzTFu55HLL3gzUYJO9BajkXYAkJ5W6w
         53VgOGFp1rXse6lr+bvDpMF/hBUWVycT4SzaUC8gAQrkfqL45qf39b5BlTZWIM8H8eUQ
         3fIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKN0WqYQTyAXEuN5uWRqYydRHORdhfTbdGPGVmgWZ74=;
        fh=hiWBT/d4RtFHvGkbgqiDS+7V+sQUObTdz1Fklh7qk3I=;
        b=QIbLUhd6Xg1WFME9OafXxaQr9C71Kk2R8aCU4Nbysm/N4uppbHZ70X5KSHZr0qbWPJ
         a25QeZf1jEV1sa0mvC9DuVTGbxLoX/5woeaF0HnAr7KdYDzvgy0JnuUoqAOqSl4ZiIhe
         iYbdYxyeJu1wvoPi1KNDVEoSQh5e+knnzun81WG68jllljmwiLTTASh96kt5opb+mH7B
         aLbp+N306xeUFVf1Z69I/54JitMMYgV6YPmq/RuPMeHsgBIyoodImPm2hxG3MAfnZUmx
         0+GBPr3qK+RbwAo54YVUAavKN0/xO4W+am4kVfN4dy0hguCP7ZBULI3uN3PMsHXKDqYa
         IwRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190155; x=1795794955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKN0WqYQTyAXEuN5uWRqYydRHORdhfTbdGPGVmgWZ74=;
        b=ZNI+Voqp8joIQNd2/S11wM6N7/ik5CmAYrFMVM+Yezub5AkrTn1W1ItJezV7UbbAF1
         5qTQfLyNRLQFmS0PqIsUOEfiN3mYBul5KsnIdNx5wI0SCbycars+m1azTZjYLu+DKlmo
         Hu6or5Lgq+6NY9K06NcSL4fiU0xWdN3OjQWZOJU028iCUeNevcp8LSNvbtsBZ7JPfHVj
         IkgHTK2wMJRpRfwaNuD0mIWFr2ZG2tjV2DUx6xxHn2cczUQNiFHkwb9qKdElOtzJkptp
         TGA+t+9OLus+S3udC+294Te6jQ0G8YMIu5iVcDCoz7Y4srkrRJ2MGUSTOds8OnFUqK11
         SOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190155; x=1795794955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKN0WqYQTyAXEuN5uWRqYydRHORdhfTbdGPGVmgWZ74=;
        b=auaxIZC117LTRn/nR6zlmnx6kvRF34IgCRVarzciEGxJG1VkPBkQZt+VMIzq3DxI2E
         Pvr8lCrjHBlP+WmHiC0QvvExUFZvBdOl5vYthL/4+d0ZEfHuU12P7jMykA5InrvsNEYf
         2HiUg6ztaaucqP3PBol9jwLWL5AT8jFQDA3VfRYXkxAHJ2qDg2RTpyAz6ddvygE3pB0p
         u19Jy7YRjWjGXNXgDpeJAXTMifonZ2bnfDTGQuzSobUOpDs1izjWhJXnjtQXeuk5+G6U
         yB2lHZ9fnUJb7iZDmiTcVlSIj95jQ3tcTPPfItrJPhol/VtZQX1QT3P5y35pcSZ6YlOU
         jHXQ==
X-Forwarded-Encrypted: i=1; AL+hErGao5ZsNYVsc2qGF+dTZgc8fJTh0IlaiqGsLgIJG/neU72szbTbN5XJ2gy6y8TTSf+7k1YWBlQK6fvefnM4@vger.kernel.org
X-Gm-Message-State: APuU4Z/v1+isC6vYjM8D+i96/rdJdIQL1BF92blpiukTxcToAeROVpVI
	IA+qXCPmUkN3ySt7zvBMX0J482kewwFWm0vDptjgzZ9u17uHH2wXNJcZffR3T3VHN2KryorhFmz
	jVYfLHqldz7BAk+4amR1CKtpKq1D2P58=
X-Gm-Gg: AZFdTZfi9wQKgZje0lz8st+BqvP7qN4ZdVhVFsWnEptrVeMYQayyUGmxAV1uy0/7bAZ
	aDsujFJnBEujGX4gMEj6Wun6Ql44XyiepmWHEIpkkmuShzVPIx/S/BeZa5EH/F/T034bdVKM4hj
	hd4gSNB/QytE+rB6AX0YQwDWKETROCpMmbqs1Bh2Od7U5EEio7f8dEKe2GZiUJYO82wZbUi8KfC
	4eMkxjg2O07DT/mSXqpOLkbv/ejjXk/jQ1DlDFy2zovkzzXEwy7qLwUD9ZuV12LB2PsZ0bmP04K
	73hwLbPjXHpuCWE3VuF2uXkae3n6nJw+Af0VbsLt5z4saW7M/1UkKhZ3I/pktch1Sw+lg/W3GRP
	WiNEm9gU/T4BDUhcTAxKXXsTFTrDkrl5pj32De36xxbAIIdN43YXmtl/ImHNgg9CmERJAdw==
X-Received: by 2002:a05:6402:448e:b0:6b8:7769:ffea with SMTP id
 4fb4d7f45d1cf-6ba37ece3efmr2700126a12.45.1795190154705; Fri, 20 Nov 2026
 07:55:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-11-koray.fra@gmail.com>
 <CAOQ4uxg2gpC99ohuvKm-SgPzuffJy1fSvXorbuBnYZ=OFSxT3w@mail.gmail.com>
 <DMZIZ05H7MMB.1WYNR4X44BPGR@gmail.com> <CAOQ4uxg8aVcWyNiFDk8djdn-M3xJcu_7-kRxVq9jjFsbcGp1ew@mail.gmail.com>
 <DN03GJ80ZWNZ.9GM35HM4T48N@gmail.com>
In-Reply-To: <DN03GJ80ZWNZ.9GM35HM4T48N@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 16:55:42 +0100
X-Gm-Features: Aa3M54qwBZfUZmZq7N4IJA8RoZGlQgYi2IqZuG6tNGKYRI28yA1oVD8H7wW_Hfk
Message-ID: <CAOQ4uxiEX1wO3vRM2UMNrACR8AfxDbrP=oB9w6L-B-twmD3D4g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/10] cifs: add provenance time (ptime) and map it
 to SMB's CreationTime
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 3:05=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> > To reduce the scope of your patch set this may be better.
> >
> >> >>
> >> >> -       /*
> >> >> -        * chattr writes back all flags returned by fileattr_get().=
 Accept
> >> >> -        * FS_CASEFOLD_FL only when it reflects the share's casefol=
d state.
> >> >> -        */
> >> >> -       if (fa->flags & FS_CASEFOLD_FL) {
> >> >> -               rc =3D cifs_fileattr_get(dentry, &current_fa);
> >> >> -               if (rc)
> >> >> -                       return rc;
> >> >> -               if (current_fa.flags & FS_CASEFOLD_FL)
> >> >> -                       allowed |=3D FS_CASEFOLD_FL;
> >> >> -       }
> >> >> -       if (fa->flags & ~allowed)
> >> >> +       if (fa->fsx_xflags_mask & ~CIFS_SUPPORTED_XFLAGS)
> >> >>                 return -EOPNOTSUPP;
> >> >>
> >> >> -       enable_compression =3D fa->flags & FS_COMPR_FL;
> >> >> -       compression_state =3D enable_compression ? COMPRESSION_FORM=
AT_DEFAULT :
> >> >> -                                                COMPRESSION_FORMAT=
_NONE;
> >> >> +       if (fa->flags_valid) {
> >> >> +               /*
> >> >> +                * chattr writes back all flags returned by fileatt=
r_get(). Accept
> >> >> +                * FS_CASEFOLD_FL only when it reflects the share's=
 casefold state.
> >> >> +                */
> >> >> +               if (fa->flags & FS_CASEFOLD_FL) {
> >> >> +                       rc =3D cifs_fileattr_get(dentry, &current_f=
a);
> >> >> +                       if (rc)
> >> >> +                               return rc;
> >> >> +                       if (current_fa.flags & FS_CASEFOLD_FL)
> >> >> +                               allowed |=3D FS_CASEFOLD_FL;
> >> >> +               }
> >> >> +               if (fa->flags & ~allowed)
> >> >> +                       return -EOPNOTSUPP;
> >> >
> >> > This whole mess could be sorted out by switching the cifs
> >> > implementation to the new API
> >>
> >> ("new API" you mean _mask right?)
> >>
> >
> > Yes and ro_mask, but it probably also means converting all the
> > read-only CASEFOLD fs to new api, so that FS_XFLAG_CASEFOLD
> > could be taken out of FS_XFLAG_RDONLY_MASK
>
> Can all flags currently in FS_XFLAG_RDONLY_MASK be rw for some
> filesystems or only some?

No. CASEFOLD is the only one which is MODIFIABLE/SETTABLE
in the old setflags ioctl.

Its twin xflag FS_XFLAG_CASEFOLD was recently added along with
FS_XFLAG_CASENONPRESERVING for a bunch of fs (e.g. nfs) which
advertise it as rdonly attribute.

> Should they all be removed from FS_XFLAG_RDONLY_MASK and left to each
> filesystem to define them as ro (to put in _ro_mask)?
>

No need to do this.

One flag at a time per demand.

You *need* to get FS_XFLAG_CASEFOLD out when some
fs will want to set it via xflags API.

You *may* get a flag out of FS_XFLAG_RDONLY_MASK
only after *all* of the fs which support it have been converted
to the new xflags_*_mask api.

> >> > and implementing a generic vfs
> >> > helper which does something like the above code to handle the
> >> > old ioctls.
> >> > FS_XFLAG_CASEFOLD would then be removed from
> >> > FS_XFLAG_RDONLY_MASK and set explicitly in xflags_ro_mask
> >> > by fs which don't allow to set if (e.g. nfs) and added to
> >> > FS_COMMON_FL/FS_XFLAG_COMMON
> >> >
> >> > cifs would advertise FS_XFLAG_CASEFOLD in its ro_mask
> >> > and then the generic helper would mask it and the new syscall
> >> > will not allow it.
> >> >
> >> >> +       }
> >> >> [...]
> >> >> +               cifs_dbg(FYI, "set compress flag rc %d\n", rc);
> >> >
> >> > I think that the roadmap should be to slowly define all the old FS_*=
_FL
> >> > flags as FS_XFLAGS_* and let the generic helpers deal with the conve=
rsion.
> >>
> >> > But it is not so hard to convert one filesystem at a time in a way t=
hat
> >> > fa->fsx_valid will have to be true, because, for example, here
> >> > all the relevant flags would be supported by the new xflags API.
> >>
> >> So, something like what fileattr_fill_{x,}flags() do now, but for
> >> file_attr_to_fileattr()?
> >>
> >
> > Yes, something like this (maybe)
> >
> >  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
> >  {
> >         fa->flags_valid =3D true;
> > +       fa->fsx_valid =3D !(flags & ~FS_COMMON_FL);
> > +       fa->fsx_xflags_mask =3D FS_XFLAG_COMMON;
> >         fa->flags =3D flags;
>
> So, for the filesystems that switch to the new API, these new/changed
> helpers should handle giving userspace the legacy FS_*_FL flags (if
> userspace uses FS_IOC_GETFLAGS) by converting them from the FS_XFLAG_*
> reported by the filesystem?
>

I did not look at the implementation details but when you make the
vfs API rich enough with the masks, the should be no problem to
describe in the API what the old ioctls do
"get a subset of attributes"
"set a subset of attributes"

Where "subset" differs depending on the ioctl.

> But did you write this
> > +       fa->fsx_valid =3D !(flags & ~FS_COMMON_FL);
> > +       fa->fsx_xflags_mask =3D FS_XFLAG_COMMON;
> while thinking about FS_IOC_SETFLAGS, so from userspace to filesystem,
> and this would be needed because that filesystem wouldn't know what
> FS_*_FL are, so it will use the _mask and the converted xflags?
>
> But why the opposite of (flags & ~FS_COMMON_FL) as fsx_valid?
>
> Why fsx_valid =3D 0 if the passed flags also contain non-FS_COMMON_FL
> flags and fsx_valid =3D 1 if the passed flags contain only FS_COMMON_FL
> flags?
> (if I understood correctly)
>

My interpretation of fsx_valid (for the set side) is:
fs may completely ignore ->flags and get all the information from fsx_*
similarly for flags_valid fs does not need to look at fsx_*

In the case that all requested flags are common, both
fsx_valid and flags_valid can be true.

But what I wrote is nonsense, because the old ioctls have no request_mask
so unset flag does not mean it is not being set.

I think what is needed is something like this helper to be called from
filesystems:

bool fileattr_prepare_xflags(struct file_kattr *fa, u32 xflags, u32 support=
ed)
{
        if (fa->flags_valid) {
                fa->fsx_valid =3D !(fa->flags & supported & ~FS_COMMON_FL);
                fa->fsx_xflags_mask =3D supported & FS_XFLAG_COMMON;
        }
        return fa->fsx_valid;
}

Then cifs_fileattr_set() starts with:

        if (!fileattr_prepare_xflags(fa, CIFS_SUPPORTED_XFLAGS))
                return -EOPNOTSUPP;

And from here on, talk only xflags and xflags_*mask

For cifs that means to add vfs support for FS_XFLAG_COMPR
<-> FS_COMR_FL conversion in helpers.

FS_COMR_FL is also rdonly flag in some fs and rw in others.

> > But in this model FS_XFLAG_COMMON are only the ones that
> > are mutable from the old ioctl.
> >
> > We would need to define FS_READONLY_FL to deal with the
> > group of read-only legacy flags, if some fs needs them and wants
> > to use the new API.
>
> So the those filesystems can put it in _ro_mask on GET you mean?
>

Actually, I meant that the old setflags ioctls could be translates to the
new xflags_mask dialect, for example:

bool fileattr_prepare_xflags(struct file_kattr *fa, u32 xflags, u32 support=
ed)
{
        if (fa->flags_valid) {
                fa->fsx_valid =3D !(fa->flags & supported & ~FS_COMMON_FL);
                fa->fsx_xflags_rw_mask =3D supported & FS_XFLAG_COMMON &
                                                          ~FS_XFLAG_RDONLY_=
MASK;
                fa->fsx_xflags_ro_mask =3D supported & FS_XFLAG_COMMON &
                                                          FS_XFLAG_RDONLY_M=
ASK;
        }
        return fa->fsx_valid;
}

so it will work correctly for example with fs/ntfs which supports
readonly ENCRYPT|COMPR

Thanks,
Amir.
