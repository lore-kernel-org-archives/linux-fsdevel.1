Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538224;
	b=yVTTwtpI3bHBlJ5bPzMX0tsBd+g+K37V/2rfk2EdJKa4ZCUc1NHq4CrcoF3/8XqrOmNq
	 3lhqqzl3W7Yc7UDZO/VxSf3MOP8Vw0I5UmuUmDleq0EiPGKoG3APUN2DjGAGtPnPa54Xy
	 O3vzRA0/Kiso6pvC3IOPjybzHtOLBlEQbVPcfkpYAM9lxeoHfvj8nQgoCDx7WoDXqPZlo
	 79lNRcfBvnBLalqzNHSdcm/BVxsPwqL4dLb0KoT3doQe+wB2s60awvZKVR6BzoC3Z9C+v
	 Q6KQuCZM0pneMYX13NOFDptYwYfjUAxrwhOEfmNF7m+lCkjt8zrtW8TUShodRFdHxeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=kERKRhF39h+o4brc6m3SDvQJ22VyguIEsdUljr0uSEI=;
	b=wlCFnGClnBNWzSV27BeMgngRMFlWNDAL92jf58/RdgUG+19TJLWOPpcGDpKBZh8DafSP
	 cKN764kA7f1VzYhyoMg1d8LSNYijjvnyTrMnhJ2GzqtSbuNOupng3wslKOQk/TO8ByT+X
	 zvEA4GHNIbAfM2i0J60C6xqbHqO4WPuMhEpmnMxNsuZZ5Mzr2S5f60wwZlsvMRmdwcbwx
	 mYOtk9pMH2+mRKjVgZkJDfmLi8xAD+Qn0Em8r/B7Ie/lHvypEdglxbFs6iMuE9NCOB1r1
	 SP5FhGZA50foWhsZfeCZZpiSNmXs7odfflEAXL68/7GuNc3WodJJFMJM5r9ms8groTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Jx/Y0n13";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E0606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx/Y0n13
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so2604577f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 08:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538222; x=1796143022; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kERKRhF39h+o4brc6m3SDvQJ22VyguIEsdUljr0uSEI=;
        b=Jx/Y0n13hEoX+FItoehcRiEMnpKujE90jegfLWLkkAIeHAobjnHacXmvC9hqTrfygG
         UPp4FbhIW6jKGdP/Zc0T/X+EiH1EtxgDA66cpwYBlm99Ijv8RD1E14/029hW2iwFGxqP
         g61B77QRYZJnN2nS9Dum3lKfbagpTpdzpKxf7Me14u2tr5b7aBF9KFWve2381H6uCMfR
         Kvx1hdIHuCvtpEHQcIalwSbvPZqq80xPP3Uz+P3PWd6XkOtNGNUPGcFEQ2Ymjo93dEIg
         kjfZIASLMDxjzbFNMuzoAAGhtbpwLLGPofpUfm1I07rvch9u9y0asKrXA+t6/E52wmum
         cgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538222; x=1796143022;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kERKRhF39h+o4brc6m3SDvQJ22VyguIEsdUljr0uSEI=;
        b=hxvP+tLFGk9xont35ZrMg5vSBQR7kgWdEmMAZ3jm753hOA7YK0r9O2ba7AzzqR29s/
         M0xVFTAWjpgTBEIvAONOd0+rp/OuAJGNwDG6yfOjRecuASs/Ualacl1laKHqy/3ktI26
         ZSyw0Uxlbcy6XsbH0WU7bO4xKCR7jXJCpAnqmLV04fgjB1px/ug4Q32cf6xx9cV2DJOV
         vQc4EJcXE/+dPzt62YOUcDgal4I5b0o2KqAuea91ub+X4qCm57O6WJaADgCHmKP2iUbW
         qQ/G/f3ZbOHnBYVU8Q1VZO26LRx9dJPeJO7pWDK93UKW1jgq5RbcveCFOBbDRzWWUedE
         mLiQ==
X-Forwarded-Encrypted: i=1; AL+hErGGwnqnbtRuRp20q0FLzL8W/Oc/BGzBg3WbYLngmL3ZPrzURJ1r8MIiYjd9ETnthdD06SDUxRZb+54PJGJS@vger.kernel.org
X-Gm-Message-State: APuU4Z+wIdXQq+BMUQHn+XoO56O/3AFaRZtDPTAseRCHWRSvBUzLwHsb
	cqBYk/ZWYardZpBsMZsHh/DDOzXZjVCa0lVIGf7Eri8MJuKh7Yi+bHXUllhw1Q==
X-Gm-Gg: AZFdTZcdcbOe+2uTkh8IqgepNxfJsynFxMLX+LBul0u0o4dm9hSj5h0/QmDhkcGXCkp
	WqR0VgaX4e4D27XdqET5M+TV/F8p5g9O84yEqQ6h73M2kC+XpXVHjgLl5ZYxJNS66ApeyktEbQp
	Nbdr31sVd5H8CiYQqoTW6HOXAJzKzDucdYqEH9pQ185pQTuniKV9y5PmyOx5+WU3A7RV2AInDJt
	gWhkc33pTZtSXfCwsVF0Vx0xWTjLWoVbUvwEnO1zC7VRn/KV1e0nuHoJDjiFVDFiV2RRnG43v1I
	VApug5DrIwT4U7yQekfLNPB8TVatIoN71Su0ObwTJD6RORDpAn6BUzPmyQIcuPRdp9nHAAvds77
	XMgvzoKWzI6fme6H7FG3OBk1DnD3QeGz0znCWwq5tSpBmarcjDXgKZQOUt6beyhKsZ/cimoVev1
	pUWWNGDaSGVHF2fvS2XmnxTHeZK5TLYSOJ4Y77b+T7Z4hBI71nvbKxenAriuG4mWBqxV/d5BGdm
	Wd6Gwney++D/dfQbTAmfTk9h4sMv1f4s72aYdxGDwNtVb5M7UmbaPCnps5V5qwdqh94n+k/OZLp
	7iBjsXZF52INml4f0CF+RQPvHT1fUW5thDojRXBJfDZ3iflJvQ==
X-Received: by 2002:a05:6000:2f87:b0:4a7:1428:13dd with SMTP id ffacd0b85a97d-4abb19c173emr28025902f8f.21.1795538222274;
        Tue, 24 Nov 2026 08:37:02 -0800 (PST)
Received: from localhost ([130.192.98.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm28207985f8f.30.2026.11.24.08.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:37:01 -0800 (PST)
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
 boundary=c9078eddc541ab7c7de706e146801d0bb3133a1a69d3339943a4873a1056;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 24 Nov 2026 17:36:57 +0100
Message-Id: <DN3L6DY60QKG.184FB9CISL5SL@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Edward Adam Davis"
 <eadavis@qq.com>, "Amir Goldstein" <amir73il@gmail.com>, "Miklos Szeredi"
 <miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix file_getattr hint to request xflags
From: "koraynilay" <koray.fra@gmail.com>
To: "Luis Henriques" <luis@igalia.com>, "koraynilay" <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261124150108.189282-1-koray.fra@gmail.com>
 <87se0qb42p.fsf@igalia.com>
In-Reply-To: <87se0qb42p.fsf@igalia.com>

--c9078eddc541ab7c7de706e146801d0bb3133a1a69d3339943a4873a1056
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 24, 2026 at 5:13 PM CET, Luis Henriques wrote:
> On Tue, Nov 24 2026, koraynilay wrote:
>
>> When using a FUSE mount over an underlying filesystem that supports
>> xflags, querying them from userspace with file_getattr() strips them
>> because file_getattr sets flags_valid =3D true so FUSE uses
>> FS_IOC_GETFLAGS instead of FS_IOC_FSGETXATTR.
>>
>> Fix it by setting fsx_valid =3D true instead.
>>
>> Output when using a simple FUSE mount that simply forwards the ioctls to
>> the underlying fs:
>>
>> before the fix:
>>
>>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>>   /xfs/file: file_getattr:      ret=3D0, projid=3D0
>>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>>   /ext4/file: file_getattr:      ret=3D0, projid=3D0
>>
>> after the fix:
>>
>>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>>   /xfs/file: file_getattr:      ret=3D0, projid=3D69
>>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>>   /ext4/file: file_getattr:      ret=3D0, projid=3D42
>>
>> Fixes: cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_g=
et")
>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>> Hi, I found this issue while working on the v2 of [1], here is the
>> reproducer, not in the commit message because of the size.
[...]
>>
>> [1]: https://lore.kernel.org/all/DN2YMTH77KWE.3IPE9OG8377X0@gmail.com/T/=
#t
>>
>>  fs/file_attr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> index 833e03810b24..3b249a0a6b36 100644
>> --- a/fs/file_attr.c
>> +++ b/fs/file_attr.c
>> @@ -383,7 +383,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char _=
_user *, filename,
>>  	struct path filepath __free(path_put) =3D {};
>>  	unsigned int lookup_flags =3D 0;
>>  	struct file_attr fattr;
>> -	struct file_kattr fa =3D { .flags_valid =3D true }; /* hint only */
>> +	struct file_kattr fa =3D { .fsx_valid =3D true }; /* hint only */
>
> Isn't this reintroducing the bug that was fixed by commit
>
> cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_get") ?

Hmm, it shouldn't, since that was just an uninitialized bug for the
whole struct, while now it's initialized (unless you meant something
else?).

> Maybe fuse_fileattr_get() shouldn't be handling FS_IOC_FSGETXATTR at all,
> and FS_IOC_FSGETXATTR handling should be moved into fuse_do_ioctl()
> instead?  (Or, more likely, I'm missing something!)

The bug being fixed is when using file_getattr tho, which in the vfs is
directly sent to inode->i_op->fileattr_get(dentry, fa), which for FUSE
is fuse_fileattr_get().

What should probably be done though (well, not in this patch) is switch
fuse_fileattr_get() from FS_IOC_FSGETXATTR to vfs_fileattr_get(), for
fsx_valid.
This is because while right now FS_IOC_FSGETXATTR is equivalent to
file_getattr VER0, in the [1] above it will be bumped to VER1, making
file_getattr VER1 a superset of file_getattr VER0.

Thanks,
koraynilay

> Cheers,



--c9078eddc541ab7c7de706e146801d0bb3133a1a69d3339943a4873a1056
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCawW9KQAKCRA0bnTtJTDo
OBMBAQCFso9zgoILmV9GTY3WdiCk4vT/1a2actWnHtu9q6vCEAD/euVTaTbVu1rI
QTkbcrfDclHkY50qMNgDWseDNAm2ZwI=
=5idA
-----END PGP SIGNATURE-----

--c9078eddc541ab7c7de706e146801d0bb3133a1a69d3339943a4873a1056--
