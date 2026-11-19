Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125764;
	b=J77RA5KDhxSzAPqNvCUUoASgpOLJS79+NGBZ0FXCwPgwC7aPGItMauXXd8rtoGbSywK1
	 5D4I+1VPlIdiBjRAt/uIvbB2PRG4jY0MiQ0MAwZKpVFm4ayB2UK7mSeuyD47CzTSu8BG4
	 CRg750HJDyTxpbc0F1DFrY1gintf8zkWh6yv4ZsEzCcEUe7d32SnAUIe8TcFOKmHvcxkc
	 baskskVphFrkN04uhyhctlrCvzRlszulx/x+cZE1aqRoSX7P55VBNmwCE4ieq4GhsHoLn
	 RpApI2z+KGogTK/mPCHJPVD6wgG9U9RiVosWJiuM1W7sTxPiKfZXbVTFf418yLNWXuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=RC1M1DCn8/ofSzuC5iVNf1vc0j24iEFLlIbk8QgE6o0=;
	b=c96k0lvOQ3nNGV6ZQx0BZV+7EfrZfQeJZhNUDvx4uIjqIZlKoWjZ3jfGGn70kUrTCh+a
	 x0Q1ds1YF3Ew5Z3oOpA8Ovvt8ddBBI5/usQmwLFKaFZ9v5Eh1wiILNnssIYYoMucIZY+B
	 BT9ZR4kMk3O0r/AlENm54PV+seCpG9DdU1Mq0vjKZX+9Y6W8bTj3pQ1bKSUHgeggyD6Ii
	 fGyi2lIgVxKw+m0UGRnf1Ihyvnb3DIg7Oe6H82bCPs9h5yF1rpCbrVyATVSQ7T4CK+KXn
	 uAcf5N85dpv7I/FLyagB0KNpWz0EXM7KWu/IbFcks91GmLmwHw5hfh8AOAG2scDbDzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyT3EBKQ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F7606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 22:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D72F7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyT3EBKQ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso13220365e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795125762; x=1795730562; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RC1M1DCn8/ofSzuC5iVNf1vc0j24iEFLlIbk8QgE6o0=;
        b=tyT3EBKQ84p6+n9pRVBCd/VKkcOJ9O3q+ZH3suyLqBe9qnxzVsUHYIM7dttdO4qa/L
         9WJv50aioxpLJEh3o5BH/gg9BQt3k4YtOSYnFzmgAdsQ1sV7dToJGs7X4+xrIar9fhjh
         3T3EE49kbtAdcblaAYu0CanLJF0S2bD/omaLuW0mRBscC9VNgbbPZag5MY2a9jUUbskU
         0oDpxyRp5GZcL+fU1WgG3qnYLtpYlcLLKsTTxImE1ert5bOuCQFaTGNm4XuObKrSrP1I
         5oJMOWdWmqkzEklCuv1QGQ9RdXhG5jbgt8jK/LDkMvE4zfcIH7Zr9FDbkOWIQvxTKOaG
         7Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125762; x=1795730562;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RC1M1DCn8/ofSzuC5iVNf1vc0j24iEFLlIbk8QgE6o0=;
        b=KyBsfntPTgndbFLqcDwFn/68CsPlSo33019CbKMhVrz1M6nG/OWNX8+ElkzIhkeJo3
         Nooq6IvDcYL3EWQ3pVFchNUWP2rhFO1yeI1+K0q8NYJEVUqLvgWwJWfTJoRlbgXuWFbv
         b1Cizi2YtKq28GgF40s15AiR95vmH/oiiLo6kmkiFUvRm6YY/YgpxUIXCkCdtyFo5fBZ
         e0yLW2AlFpVSdclcR4zH9bwGGQz7rzJuFUn3V4uw2ql6/WGMjO3daFMUlIZvuKEcZhdS
         YIGF4c6Rx8IwssaLMbQ5sgKQoUa7CGBN2uav8RA7C86Dh/rKf8IQ7NMgvFUyxyj22ycx
         lSdA==
X-Forwarded-Encrypted: i=1; AL+hErGxMe6To1iZLEXSK6sy7qP9F8Doz2LjSUH7Gc2e5fCdkdgKbDOvvnHGbd8mQqs57HPflbIBmoO+pobwJBhn@vger.kernel.org
X-Gm-Message-State: APuU4Z/XM15ldR577ChQOdgMm4kqZlSnXaQ9EAsJAFXn0BUOieLC0RDd
	sO1yfCTTq1BHTfleeKWG4NjCyjZK+WeQjYX7vKpE/R2B/ceAb+GbpAes
X-Gm-Gg: AYBFou1C1Ic92r1jKhpR4v0AEccB/mX5RJieGr8oYe4m0/NtciAguy8Tad7dQZS5/UA
	wWFgjd4k8cmnvd8iREte2TP1usRsHmFPnKD9CkJG5dKncrjkPkyfP0h2aeDjlvfifUwn/kign4v
	b21581DssMeRXlaokcaGTgO4Yor9uiOZtmOzHUlW8F6ouIyliYXUAhyXqmtyM7jGKOEBITGo43C
	LEE6TD6D6PzosFZXJBgh6XD8UtXV6gJoj3CHrVP5sHj8cswfgZklL1xVPK0CPCbouph4yvCfrGa
	E+TXrbQWHC2GR0Mhz1oWxLnXUw7JuXFW9Jouxex/iCU0HZ52WHrawxndKz5nnWAFHbDDKpRSd/z
	CjwAM4yKSthY2NlWF3dgPkwyRUSIyasy+vJL+h1+5sEX1dRZoqfFZbIGeWFc6NT8AIIv0D1GcFn
	8592bxDxVPzFSsG7y9FatDUjlCnAUJoFgJXBwotd3uXwVaikmBvoizbfRiCNUxMtyeiUFvuDawc
	A7sZa540xUY+jHGruX3C4SyQrsNkHBdvYRD1rySAbz7rlsRJ436RN/pIA2PoiYfFy+SLI746d0S
	MSzxis+6iFpu+E7uRyWXXHInQQ==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr21935945e9.11.1795125761923;
        Thu, 19 Nov 2026 14:02:41 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm1735463f8f.41.2026.11.19.14.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:02:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c2bf06ad23101c2dd736021b19ff33522859edba8be8e5bfafa93f393781;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 19 Nov 2026 23:02:37 +0100
Message-Id: <DMZIZ05H7MMB.1WYNR4X44BPGR@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Namjae Jeon"
 <linkinjeon@kernel.org>, "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Paulo Alcantara"
 <pc@manguebit.org>, "Chris Mason" <mason@kernel.org>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Jan Kara" <jack@suse.cz>, "NeilBrown"
 <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo"
 <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "ChenXiaoSong" <chenxiaosong@chenxiaosong.com>,
 "Darrick J . Wong" <djwong@kernel.org>, "Sean Smith"
 <defendthedisabled@gmail.com>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <exfat@lists.linux.dev>, <ntfs3@lists.linux.dev>,
 <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <linux-api@vger.kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [RFC PATCH v4 10/10] cifs: add provenance time (ptime) and map
 it to SMB's CreationTime
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261115180343.576773-1-koray.fra@gmail.com>
 <20261115180343.576773-11-koray.fra@gmail.com>
 <CAOQ4uxg2gpC99ohuvKm-SgPzuffJy1fSvXorbuBnYZ=OFSxT3w@mail.gmail.com>
In-Reply-To: <CAOQ4uxg2gpC99ohuvKm-SgPzuffJy1fSvXorbuBnYZ=OFSxT3w@mail.gmail.com>

--c2bf06ad23101c2dd736021b19ff33522859edba8be8e5bfafa93f393781
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Nov 19, 2026 at 7:32 PM CET, Amir Goldstein wrote:
> On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> Implement provenance time (ptime) in cifs, as introduced in a
>> previous commit ("vfs: add provenance time (ptime)").
>>
>> Map it to SMB's CreationTime, making it settable from userspace and
>> propagating it to the SMB server via FILE_BASIC_INFO.
>>
>> Support reading ptime via statx(2) and fileattr_get() from the cached
>> CreationTime.
>>
>> Update cifs_fileattr_set() to check xflags instead of only legacy flags
>> and add the cifs_set_file_crtime() helper to wrap the RPC call to the
>> SMB server.
>>
>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>>  fs/smb/client/cifsfs.c |   8 +++
>>  fs/smb/client/inode.c  |   7 ++-
>>  fs/smb/client/ioctl.c  | 109 ++++++++++++++++++++++++++++++-----------
>>  3 files changed, 94 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
>> index 8cff7857b450..c2f557e406d3 100644
>> --- a/fs/smb/client/cifsfs.c
>> +++ b/fs/smb/client/cifsfs.c
>> @@ -1307,6 +1307,14 @@ int cifs_fileattr_get(struct dentry *dentry, stru=
ct file_kattr *fa)
>>         if (READ_ONCE(CIFS_I(inode)->cifsAttrs) & ATTR_COMPRESSED)
>>                 fa->flags |=3D FS_COMPR_FL;
>>
>> +       /* Report provenance time (ptime) to userspace */
>> +       if (CIFS_I(inode)->createtime) {
>> +               fa->fsx_xflags |=3D FS_XFLAG_PTIME;
>> +               fa->fsx_xflags_mask |=3D FS_XFLAG_PTIME;
>> +               fa->fsx_ptime =3D
>> +                     cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->creat=
etime));
>> +       }
>> +
>>         /*
>>          * FS_CASEFOLD_FL is defined by UAPI as a folder attribute,
>>          * and userspace tools (e.g., lsattr) display it only on
>> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
>> index 2647785ec1e4..f0b20a72b9c2 100644
>> --- a/fs/smb/client/inode.c
>> +++ b/fs/smb/client/inode.c
>> @@ -222,6 +222,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs=
_fattr *fattr,
>>
>>         cifs_i->cifsAttrs =3D fattr->cf_cifsattrs;
>>         cifs_i->reparse_tag =3D fattr->cf_cifstag;
>> +       cifs_i->createtime =3D fattr->cf_createtime;
>>
>>         if (fattr->cf_flags & CIFS_FATTR_NEED_REVAL)
>>                 cifs_i->time =3D 0;
>> @@ -2958,7 +2959,8 @@ int cifs_getattr(const struct mnt_idmap *idmap, co=
nst struct path *path,
>>          * We need to be sure that all dirty pages are written and the s=
erver
>>          * has actual ctime, mtime and file length.
>>          */
>> -       if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_SIZE | ST=
ATX_BLOCKS)) &&
>> +       if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_PTIME
>> +                            | STATX_SIZE | STATX_BLOCKS)) &&
>>             !CIFS_CACHE_READ(CIFS_I(inode)) &&
>>             inode->i_mapping && inode->i_mapping->nrpages !=3D 0) {
>>                 rc =3D filemap_fdatawait(inode->i_mapping);
>> @@ -2992,6 +2994,9 @@ int cifs_getattr(const struct mnt_idmap *idmap, co=
nst struct path *path,
>>                 stat->result_mask |=3D STATX_BTIME;
>>                 stat->btime =3D
>>                       cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->creat=
etime));
>> +               stat->result_mask |=3D STATX_PTIME;
>> +               stat->ptime =3D
>> +                     cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->creat=
etime));
>>         }
>>
>>         stat->attributes_mask |=3D (STATX_ATTR_COMPRESSED | STATX_ATTR_E=
NCRYPTED);
>> diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
>> index bb8808289a46..19a9556d39b4 100644
>> --- a/fs/smb/client/ioctl.c
>> +++ b/fs/smb/client/ioctl.c
>> @@ -181,6 +181,41 @@ static int cifs_set_compression(unsigned int xid, s=
truct dentry *dentry,
>>                                             compression_state);
>>  }
>>
>> +static int cifs_set_file_crtime(unsigned int xid, struct dentry *dentry=
,
>> +                               struct cifs_tcon *tcon, u64 crtime)
>> +{
>> +       struct inode *inode =3D d_inode(dentry);
>> +       struct TCP_Server_Info *server =3D tcon->ses->server;
>> +       FILE_BASIC_INFO info_buf =3D {};
>> +       const char *full_path;
>> +       void *page;
>> +       int rc;
>> +
>> +       if (!server->ops->set_file_info)
>> +               return -EOPNOTSUPP;
>> +
>> +       info_buf.CreationTime =3D cpu_to_le64(crtime);
>> +
>> +       page =3D alloc_dentry_path();
>> +       full_path =3D build_path_from_dentry(dentry, page);
>> +       if (IS_ERR(full_path)) {
>> +               rc =3D PTR_ERR(full_path);
>> +               goto out;
>> +       }
>> +
>> +       rc =3D server->ops->set_file_info(inode, full_path, &info_buf, x=
id);
>> +       if (rc =3D=3D 0) {
>> +               CIFS_I(inode)->createtime =3D crtime;
>> +               CIFS_I(inode)->time =3D 0;
>> +               inode_set_ctime_current(inode);
>> +       }
>> +
>> +out:
>> +       free_dentry_path(page);
>> +       return rc;
>> +}
>> +
>> +#define CIFS_SUPPORTED_XFLAGS (FS_XFLAG_PTIME)
>>  int cifs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *den=
try,
>>                       struct file_kattr *fa)
>>  {
>> @@ -193,49 +228,65 @@ int cifs_fileattr_set(const struct mnt_idmap *idma=
p, struct dentry *dentry,
>>         bool enable_compression;
>>         struct cifs_tcon *tcon;
>>         unsigned int xid;
>> -       int rc;
>> +       int rc =3D 0;
>>
>> -       if (!fa->flags_valid)
>> +       if (fileattr_has_fsx_mask(fa, CIFS_SUPPORTED_XFLAGS))
>>                 return -EOPNOTSUPP;
>
> What is this supposed to check that is not already checked
> explicitly with fsx_xflags_mask below?

It should work for FS_IOC_FSSETXATTR, where mask is 0... but it's also
there because when I started writing the various filesystems code I
hadn't added _mask yet, so I'll need to take a little step back and
revisit.

>>
>> -       /*
>> -        * chattr writes back all flags returned by fileattr_get(). Acce=
pt
>> -        * FS_CASEFOLD_FL only when it reflects the share's casefold sta=
te.
>> -        */
>> -       if (fa->flags & FS_CASEFOLD_FL) {
>> -               rc =3D cifs_fileattr_get(dentry, &current_fa);
>> -               if (rc)
>> -                       return rc;
>> -               if (current_fa.flags & FS_CASEFOLD_FL)
>> -                       allowed |=3D FS_CASEFOLD_FL;
>> -       }
>> -       if (fa->flags & ~allowed)
>> +       if (fa->fsx_xflags_mask & ~CIFS_SUPPORTED_XFLAGS)
>>                 return -EOPNOTSUPP;
>>
>> -       enable_compression =3D fa->flags & FS_COMPR_FL;
>> -       compression_state =3D enable_compression ? COMPRESSION_FORMAT_DE=
FAULT :
>> -                                                COMPRESSION_FORMAT_NONE=
;
>> +       if (fa->flags_valid) {
>> +               /*
>> +                * chattr writes back all flags returned by fileattr_get=
(). Accept
>> +                * FS_CASEFOLD_FL only when it reflects the share's case=
fold state.
>> +                */
>> +               if (fa->flags & FS_CASEFOLD_FL) {
>> +                       rc =3D cifs_fileattr_get(dentry, &current_fa);
>> +                       if (rc)
>> +                               return rc;
>> +                       if (current_fa.flags & FS_CASEFOLD_FL)
>> +                               allowed |=3D FS_CASEFOLD_FL;
>> +               }
>> +               if (fa->flags & ~allowed)
>> +                       return -EOPNOTSUPP;
>
> This whole mess could be sorted out by switching the cifs
> implementation to the new API

("new API" you mean _mask right?)

> and implementing a generic vfs
> helper which does something like the above code to handle the
> old ioctls.
> FS_XFLAG_CASEFOLD would then be removed from
> FS_XFLAG_RDONLY_MASK and set explicitly in xflags_ro_mask
> by fs which don't allow to set if (e.g. nfs) and added to
> FS_COMMON_FL/FS_XFLAG_COMMON
>
> cifs would advertise FS_XFLAG_CASEFOLD in its ro_mask
> and then the generic helper would mask it and the new syscall
> will not allow it.
>
>> +       }
>> [...]
>> +               cifs_dbg(FYI, "set compress flag rc %d\n", rc);
>
> I think that the roadmap should be to slowly define all the old FS_*_FL
> flags as FS_XFLAGS_* and let the generic helpers deal with the conversion=
.

> But it is not so hard to convert one filesystem at a time in a way that
> fa->fsx_valid will have to be true, because, for example, here
> all the relevant flags would be supported by the new xflags API.

So, something like what fileattr_fill_{x,}flags() do now, but for
file_attr_to_fileattr()?

> No need to do that now, as part of this patch set which is complicated
> enough, just need to see the road ahead of us that we have a way
> forward out of this messy flags_valid/fsx_valid inside filesystem
> implementations.

I think it's probably better to clean up the API now, before introducing
new flags (like FS_XFLAG_BTIME/PTIME or the shared extent one in the
other thread) and as I'll say in that reply (I'll write it in a bit) I
think it's even better to first split the _mask changes into their own
RFC PATCH series, then have a separate one for ptime/btime.

> My understanding is that Miklos introduced those hints to reduce the
> work needed per filesystem for the initial implementation of the
> vfs methods.

Ah yeah that would make sense.

Thanks,
koraynilay

> Thanks,
> Amir.



--c2bf06ad23101c2dd736021b19ff33522859edba8be8e5bfafa93f393781
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCav9x/QAKCRDmj22qf5IG
XCsaAP90pDHkiG6FypqZoMEgsWt2zJhENiftUx4825vQrWbqSQEAv2tho2ttv5d3
4LEx3lAKlpln+AG5aT7npnHOlcow/AM=
=prrA
-----END PGP SIGNATURE-----

--c2bf06ad23101c2dd736021b19ff33522859edba8be8e5bfafa93f393781--
