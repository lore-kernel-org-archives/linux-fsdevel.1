Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126894;
	b=qWwMZ+pfHxHVqfl5qVLjY6tToIvzDQQITUkj+o4ti43PH2/sLi/KMrKjEYU2MXx4F54G
	 aHHtdDWO/3YnRAKdVNwsPvAc74awk+0FuBmO6MT18U2tAB7Pi/nqrJ3r7eIWwbxr7S00c
	 9i3MxDlf+WOWAZzT9mc7fsNX47ediLmJW/lrco3qQzOsswNjXrhhFLh9TTBGHReOw361J
	 FYVtanlEGSwNNe3w0Gy8J0qwv1M7VBvJcfJbX8a5pGY0zEg9ptPXamzFG7rdtQqs/yKwB
	 LkmB6e6xMotfWyCe0a8lgBE1MLtUrU5pxKV4/SWyTCsAB+3EVMZa/qxKUmI+NWm2Zmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=DXopmfH8M4TtkeX0mLmdjIDJGntKSuAqE61ScQWgHrM=;
	b=M8qyi678FTXCCEca/Wnnzj+AYiBi7VQOElyn8XlqyFUtxtOuk8/jT+I9cGDp+GQ5aaUA
	 LRRfs3g0zz+Q06M05VoN3ZqxM+0skwBbhW+VLAVbZkxdInYYfgePQr/PXeK9K1S7wTwW5
	 NMyBikwpHokErKGBcibfUFCS91r/V7ZjeU288oegi8+3fGHwbQsiU/kzdy+pfLK2E9sqD
	 K2o7byIPlGxlhyBqla//LwVZEnZG4urCl8KZrhM4LH9y2SO2F29hrc7rWXqXWJFQgakkk
	 HbA8a7ZHz7mpt4iKExzTTjrLZ4Z83G0r7HUUaJpAcUMSE5jkUmyu4yahzpDbB2zj4Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gef0lchy;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4712606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 22:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4712606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gef0lchy
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso136457f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126892; x=1795731692; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DXopmfH8M4TtkeX0mLmdjIDJGntKSuAqE61ScQWgHrM=;
        b=gef0lchyyswlM17vKmxXh1yKD4D8BKuG+NQIPtAdUNOAGP/k24f7fDcob5s8n+r9hE
         Op3nPHSw2Yc6V71RtCnGfLLeMIhn9KNHGiCiNeXIPi+tsuRCjAe3GTu1PabZIjb4kgKK
         yVMgvdEPJUB8hshUa/1LWEbi/FTHFVt7W+mqj+oOyWVsgwyKDtHSazpyimgU6ZR3JwNS
         wa/iqeL6R59NNa6gMbdrpyewG+vFeim/3Gd07HmSOYr2ZZyD26/IiAfztdWP9TrnbluY
         JsgFUZYAel71x+uOm2BxTKumTYG2LAV8SN53OPap5xMaJ6osumK+9XrzlkeH5ysrpXV4
         GL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126892; x=1795731692;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DXopmfH8M4TtkeX0mLmdjIDJGntKSuAqE61ScQWgHrM=;
        b=IkyzJkhMUiQqTwnXqdsDjMMc85iWjAYkYqdXJD+rioIJyZEFWaxFHysv6Qzh3cd1oq
         9Tzjfsoua9wGImOrkEtPtZdFeAdHLzZDAlrwDS5BQhKX/RbqyhrziBME58OVC22LtATt
         1WFTdCNLNPbwJusq8X4oy+tHts2Qh4qSDSNG2Xdu/j7NB8a0iPqBAX3DqCLG3xJmJl12
         V9iwkawqmzEENMAU9ZcAqHatXKFW6euqeVaPdaukzP5cojC5BvatyMlQCyHWHXR9e+3H
         yHRgxIDtHcK+m5120ChPI2zs1Wt8VkzAgqbG2XnHvqK2bS1ZbeA4kF1GKqTnCJAAWbKU
         Znbg==
X-Forwarded-Encrypted: i=1; AL+hErHCE6rj1clb+GFBxOh3fAEobsaOlLcajeVV6+GAtMNQHvyRVTk3kDXYBYJuqfySsJgTGV3U6yUFZcu673dH@vger.kernel.org
X-Gm-Message-State: APuU4Z+HT0jLhae+7HDSwUrap/Ihg9CG9R849u0QqRtxbLvq5MerBIaP
	0YOeGXFDhR/OIwp8xpPE5lraVJ/jsMM1IK2Qso+JPFVbi9xdNELoj/+K
X-Gm-Gg: AZFdTZc/IupTm87wjKrOQMd3+M0ZNtVpDdWho5cQTEnhmdyN9AmIKHYVIoUnZai4zo/
	0vWZNNQd3kYLwpAyz6R0UcqXKVEuFXIYoyreJoHw1louJMhLwt7ehTpQq/eACXL0OmO3EonPWXW
	wZfAizSwrYfwkOomkIunmbM4v0Yu7kUu3sLiXbJnR4wWMkG6gU3Y8ErKHLZ/ihAvrdi8wDdz7va
	S59jbsrwGIw0NR1fkwQ1Clvf+7yaM2ar9Bac0DduJgm3i/7ER6Mp5SwAXPuxqLzdP/2PPqR2YOK
	tsnDS0K2jvTEcGJGjJy3bXRKRWXyxNXiTEPhsxVa/ZMZjCjAktjoYfGAEsg5uNEFqdjJi+1QRKw
	sJNhGYNKShPcvUYd2t/t+pj6PV8jsTZA1/7MuGwmoPd+Z99PSa2DjdyJclx1bWFiny/RkWBAYxK
	UIhm5RfgVlRAsXOY62IXLiK92LP/P/ivaWRpX5NmeKuq/ytFsoR6838eyz2cPoVEcbACN/gpXbx
	hWuvvVz70RiZIm/24/2OgKNNMTe1OfxB4QxtibUaBfuADbZE7oGqhfJUX/YVPBuTYRR8Fsxar3p
	MbP2Eit3338migEHAgzTDc6XLw==
X-Received: by 2002:a05:6000:25c2:b0:4a6:7781:b064 with SMTP id ffacd0b85a97d-4abb51457e8mr1841184f8f.31.1795126891984;
        Thu, 19 Nov 2026 14:21:31 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61f3sm2102936f8f.17.2026.11.19.14.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:21:31 -0800 (PST)
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
 boundary=1118862003b65829f4e4ebf4d4274973bc4a2074b1863740606dca9d7054;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 19 Nov 2026 23:21:30 +0100
Message-Id: <DMZJDGMJ1RVF.32ES391JKNFGP@gmail.com>
Cc: "Lauri Gates" <lauri.gates@gmail.com>, "Dave Chinner" <dgc@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Christoph Hellwig"
 <hch@infradead.org>, <linux-xfs@vger.kernel.org>, "Carlos Maiolino"
 <cem@kernel.org>, "Christian Brauner" <christian@brauner.io>, "Darrick J.
 Wong" <djwong@kernel.org>, <linux-api@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
 <ocfs2-devel@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
 <linux-cifs@vger.kernel.org>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF
 buffer lock
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <av4Hn9u80fs8iHZ6@dread>
 <20261119095943.85048-1-lauri.gates@gmail.com>
 <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com>
 <CAOQ4uximow25oc=3XEN1ATgQvonQaTXtDPmQufxo75tJ=e355A@mail.gmail.com>
In-Reply-To: <CAOQ4uximow25oc=3XEN1ATgQvonQaTXtDPmQufxo75tJ=e355A@mail.gmail.com>

--1118862003b65829f4e4ebf4d4274973bc4a2074b1863740606dca9d7054
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Nov 19, 2026 at 6:04 PM CET, Amir Goldstein wrote:
> On Thu, Nov 19, 2026 at 12:00=E2=80=AFPM koraynilay <koray.fra@gmail.com>=
 wrote:
>>
>> On Thu Nov 19, 2026 at 10:59 AM CET, Lauri Gates wrote:
>> > On Wed, Nov 18, 2026 at 10:16PM +0200, Dave Chinner wrote:
>> >> I really don't care if it is exposed by statx or file_attr; checking
>> >> the flag through either interface will be orders of magnitude faster
>> >> than using FIEMAP to iterate extents on every file to find shared
>> >> extents. My concern with statx is coherency - it runs completely
>> >> unlocked and so can race with operations that add/remove the reflink
>> >> flag...
>> >
>> > Thanks, Dave and Christian. Given Christian's preference and the
>> > coherency point, I'll write the RFC against file_attr, once the
>> > question at the end is settled. xfs_fileattr_get() already reads the
>> > flags under XFS_ILOCK_SHARED, so the new flag gets that without extra
>> > work. The answer can still go stale right after the call, as with any
>> > stat result: a clone that lands after the read is missed, just as one
>> > that lands after FIEMAP returns is missed today.
>> >
>> > As I suggested on the 6th, the flag would take the inverted meaning,
>> > so that an unset flag stays the safe answer: say FS_XFLAG_NOSHARED
>> > ("no extents shared with another file"), read-only, in
>> > FS_XFLAG_RDONLY_MASK next to the case-folding flags.
>>
>> Hello, I don't have any say in the FIEMAP issue, but I wanted to let you
>> know that, since also a mask was mentioned and your patch would be
>> touching the fileattr API, there is work going[1] on for adding a
>> fsx_xflags_mask that filesystem use[2][3] to advertise supported flags (=
on
>> get, like stx_attributes_mask) and users use to say what they want to
>> change (on set).
>> It doesn't seem like an FS_XFLAG_NOSHARED flag would touch this new
>> change, but I thought it was worth pointing out, especially because this
>> patch would also add FS_XFLAG_PROJID and a new FS_FILE_ATTR_XFLAGS_MASK
>> to have a way to include both legacy and newly added xflags, so
>> FS_XFLAG_NOSHARED would maybe also go there (correct me if I'm wrong).
>>
>> > Christian, one question on the shape within file_attr: would you take
>> > the inverted flag, or would you rather keep a plain "may share" flag
>> > and add a mask to struct file_attr that says which xflags the
>> > filesystem reports?
>>
>> And if Christian chooses the mask approach, then my patch[4] becomes
>> relevant.
>> (in [4] I put the patch that will be sent in v5 of [1], since in [1]
>> it's merged with the ptime change)
>>
>> (For Amir who I just CC'd, [5] is the main link for this thread)
>
> Thanks for the CC and the link
>
>>
>> Thanks,
>> koraynilay
>>
>> [1]: https://lore.kernel.org/all/20261115180343.576773-1-koray.fra@gmail=
.com/T/#u
>> [2]: https://lore.kernel.org/all/CAOQ4uxj82K4z+2OiY5W1g7NyWAFOFjqqWnZSS3=
prytW36j1LgA@mail.gmail.com/
>> [3]: https://lore.kernel.org/all/CAOQ4uxiuJ=3DeZu28FZAUz3rpqPKqCimPxJucO=
nYYuBowvD09_Cw@mail.gmail.com/
>> [5]: https://lore.kernel.org/linux-xfs/20261102193533.93690-1-lauri.gate=
s@gmail.com/T/#u
>>
>> [4]:
>> commit 0efe0de3b5cc2b767aa6e2bb9174eb05b0d818f1
>> Author: koraynilay <koray.fra@gmail.com>
>> Date:   Tue Nov 17 14:57:47 2026 +0100
>>
>>     vfs: add xflags mask to file_attr API
>>
>>     Add fa_xflags_mask to struct file_attr and equivalent fsx_xflags_mas=
k
>>     to struct file_kattr.
>>
>>     This lets filesystems advertise their support for specific xflags an=
d
>>     users specify only what they want to change, behaving like
>>     statx.stx_attributes_mask:
>>     - on GET (file_getattr): each filesystem fills the mask according to
>>       its supported xflags, e.g. FS_XFLAG_COWEXTSIZE or FS_XFLAG_EXTSIZE=
,
>>       and provides the values in the corresponding struct fields;
>>     - on SET (file_setattr): userspace fills the mask according to which
>>       xflags it wants to change, VFS validates this and preserves xflags
>>       that were not specified in the mask;
>>     - if xflags_mask =3D=3D 0, use legacy full-struct replacement to kee=
p
>>       compatibility with older programs.
>>
>>     Furthermore, add the missing FS_XFLAG_PROJID flag, to allow userspac=
e to
>>     set the projid using file_[sg]etattr().
>
> Correction. usersapce can already set projid using file_[sg]etattr().
> With FS_XFLAG_PROJID in fsx_xflags_mask, chattr -p <projid>
> could set the projid without having to read and set all the other xflags.

Oh right, thanks, I'll fix it.

>>
>>     Finally, in order to prevent the legacy FS_IOC_FSSETXATTR from accep=
ting
>>     FS_XFLAG_PROJID, add an FS_FILE_ATTR_XFLAGS_MASK to support new xfla=
gs
>>     and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
>>     validate that the xflags passed in fa_xflags and fa_xflags_mask fiel=
ds
>>     are valid.
>>
>>     Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
>>     Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>>  fs/file_attr.c           | 46 +++++++++++++++++++++++++++++++++++++++++=
+----
>>  include/linux/fileattr.h |  5 +++++
>>  include/uapi/linux/fs.h  |  3 +++
>>  3 files changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> index 833e03810b24..56ea65f790f1 100644
>> --- a/fs/file_attr.c
>> +++ b/fs/file_attr.c
>> @@ -102,10 +102,18 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>>  static void fileattr_to_file_attr(const struct file_kattr *fa,
>>                                   struct file_attr *fattr)
>>  {
>> -       __u32 mask =3D FS_XFLAGS_MASK;
>> +       /*
>> +        * fsx_xflags_mask contains only flags added after the
>> +        * file_[gs]etattr() API, so we need to tell userspace the files=
ystem
>> +        * actually supports all legacy (FS_XFLAGS_MASK and FS_XFLAG_PRO=
JID,
>> +        * which lacked its own bit) and new advertised flags.
>> +        */
>> +       __u32 mask =3D (FS_XFLAGS_MASK | FS_XFLAG_PROJID | fa->fsx_xflag=
s_mask) &
>> +                    FS_FILE_ATTR_XFLAGS_MASK;
>
> This is not exactly how I envisioned exporting fa_xflags_mask.

This is exactly why I CC'd you :D

> fa_xflags_mask =3D=3D 0 means old kernel or unmodified fs.
>
> For a new kernel with fs that supports flags other than
> FS_XFLAGS_MASK it's the fs responsibility to advertise its supported
> flags.
>
> Something like:
>
>      __u32 mask =3D (fa->fsx_xflags_mask ?: FS_XFLAGS_MASK) &
>                               FS_FILE_ATTR_XFLAGS_MASK;
>
>      memset(fattr, 0, sizeof(struct file_attr));
(I'm sorry, but why memset if we assign the fields right after?)
>      fattr->fa_xflags =3D fa->fsx_xflags & mask;
>      fattr->fa_xflags_mask =3D fa->fsx_xflags_mask ? mask : 0;
>
> Then you can add filesystems that support get/set of new
> attributes without support for legacy attributes.
>
> And specific filesytems could opt-into the set of an individual
> attribute like projid by advertising
> fa->fsx_xflags_mask =3D FS_XFLAGS_MASK | FS_XFLAG_PROJID
> or a subset thereof.

I agree, this is definitely better.

> And I am still on the fence wrt should API also advertise the
> fsx_xflags_ro_mask in addition to the supported mask.
>
> The advantage being that it makes the interface symmetric.
> User can alway setattr() with the buffer they got from getattr()
> and instead of randomly ignoring flags in set, the fsx_ro_mask
> along with fsx_mask defines the behavior exactly.

Hmm, so ro_mask would be ignored by vfs on set so users don't have to
manually remove the read only flags, correct?

Also I think I'll try writing some basic userspace programs that use
this API and see how I'd expect it to be.


Anyway, I think it would be better to split the _mask change into its
own separate patch series, so it can more easily be used by this shared
extent patch and it's easier to reason about the API when it's
disconnected from the ptime/btime change.

Thanks,
koraynilay

> Thanks,
> Amir.

--1118862003b65829f4e4ebf4d4274973bc4a2074b1863740606dca9d7054
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCav92agAKCRDmj22qf5IG
XDQZAQC8F1HjZwQYe3nM4A7edE2Sz/q0zyveg6sGz+2hCxvXnQEAgWogwdag2wgs
tOMOPQGJhAKoiAMhC2Wt5uBfklZ/hgI=
=npK3
-----END PGP SIGNATURE-----

--1118862003b65829f4e4ebf4d4274973bc4a2074b1863740606dca9d7054--
