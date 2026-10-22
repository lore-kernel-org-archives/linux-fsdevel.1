Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693415;
	b=vM3BWKFpNbLiuO2Br1vpsrKBdlT7cACXcV1eEIJ16NGSqW/i0lou8/21bP1EkBW9GV2h
	 6tht4/QBqUOLsDBL3z8Tv5no/tZXb0mpxIzsx31Eis/IR/yhnDjLF8dHmI9kbcdywrSyV
	 TnA1NpnEqaA/cpG6NPUerdKXLIyNejLRw53Mj43Z4F+qQeMSjRNuYQdqi9Rx5nfNQ8LXr
	 3nTqu88xqDQM/TGU9P6vFl1DDPeSNWa7Q4IOd8Jn1bYR+xoE+PdVDVI6KjFQV7BHk26lo
	 gjmLK8rB6sJPUKaf1IcSGZqi65qYLFkjymDO5yKTxGEZs4WDP1ZsCu1uOzPtN+ck0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=qcfUY9QfFBUGQ7dGu3fgMyM1kqP7X1Wxf7hDuq3qEI4=;
	b=CCjfOgic/gW48xZ4lr5ZflM1XebbIupygnmSD9OJjGzTt758DdvRvB1MwYyxhCfdQyeG
	 2csDfqz9Dm28IOXUj1vqqxmIPXTh9xQP+t1LrpNBnrQgfwBSmMw7FlP0SVPtGpCVBJUiH
	 dkH+hpp2Jju1DyrPE1rVxn/WEz6OSOeUukoAhAE1aIy5pP28VRkDqNAYNhQILNrQ8Taup
	 L7ClxMlV6Wmxuq1WCZTO9rJu08JcrK+bXSqp/JRarWHunW3IFMbUcBqWbFoRDM887f+PA
	 xht6bKcUxGDme6lq2YuXnxwLBxulEp3ba7sDNWdviLHbcedZ6kI20KSlNbAAkh2cs6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="zGeTe/Fn";
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A2606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 18:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zGeTe/Fn
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8565d77c277so1671357b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792693414; x=1793298214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qcfUY9QfFBUGQ7dGu3fgMyM1kqP7X1Wxf7hDuq3qEI4=;
        b=zGeTe/FnIzRqolstUNLr9LPgmpau299z/frj1VcADxDbuYSNS4GtD5UtPBbnclECJa
         ev8EdZY0DREStWtorFtAXQLPvexu8UgGKSMvZIyf+84ODNWfpJ7kpIygIamlCAZWh7DC
         bcGRZ6wdW8oxx1OIUu+e1T0AejXEvPcJDsPkQUKqwb68IOovrMpVUcvNV36vMUyr0SSr
         6ihD25/Hi1lFIE0NQngvVDnu5/VhBBeZb5VbROnTjuXfe6E4I/1jszRhMW1DxdPqvtY9
         bZ/aiX7pZ+TA22xqhxCXMPFeGybbIaW0IBL4V3KZ6XQwmPVRm0M/HqDj8XvnMR03Xdw5
         owcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693414; x=1793298214;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qcfUY9QfFBUGQ7dGu3fgMyM1kqP7X1Wxf7hDuq3qEI4=;
        b=ozyQdOD3EwxRmsmcqcsM8iown/xNExfZ+LOc1B6kv6OlnrPeaSH3fiboHDP0PCp/TN
         ULUmQKGF3pxAZGUyWHHO86mB/7O7E120KY7n2KDBGwcI0/lT7dekujQECpZoTxHa5+by
         RqibiQTYqoVeg62X8bmpULmZAeeuhtH1DpoDiRjJhPG9hwGG7o9j4Coz2WSNZiuAqSFo
         ETIGw2SI9Wy6gl2Hmo0CfMC7dSLuTScEWPyDT30iMENnazY1ybmO/TQPCcHCRWNiCesY
         xAswb6pHp0R3SANnfE/P3DrejBS2RGC8YLifGOAXE/ABoqm3BbRPNs6tm71877RyhXBu
         3QNA==
X-Forwarded-Encrypted: i=1; AKwUvBz/Ta+cG3sncyOSG8hM9cjqPw4cPoUtF2rsxicztoL0ksZMee0CeKeLvTEe/wc54lh4K5vS6HDLsW0iCvkk@vger.kernel.org
X-Gm-Message-State: AFq9FYJZO4kAzb16PCtscaUPf+85gtvRrJdFsg5X1yMX5U2i5lnT6fxi
	+yyTPTmMyMFApMOoi4+YsOcCLT7aKr6CcI/HQkfOKl5akn9Hw6yW9zk/zgt4jvZuKOY=
X-Gm-Gg: AYBFou2vDr1aN2so7iY2o6llCf7gIWNJ7U/6PEYuZjnmOzdP5O2rNV6QiIBcXU6BpQy
	RwwFZYiS6AoSVE4xdSz9sziUF7sZzVWzPvN2R+CuRabw3kcbT0KqTyNklOtikvOxfqqKxSP1aCi
	qbvd2ve4uY0zKLN035Hf8OPm4yRRxK8WpUWaYxxCZUbfn6BwBfiVHCxJ+LTVkz71EFswxPYZHnr
	gdoWsYGH15FWLBC9ZcrIDfTd/pV4Sovs0xXfpaCoYhrRnd3LThdpnoR4vMW9zPd30rhsffE6gsk
	8ELxBuF1Ofpl5qwR5BLeOe+vr62cmP/GE5S8xR41jaC1o4K8TEeCHuSZb9W77/6X0TfoedWxgr0
	E3NpTGglYRsc40FMey/Iycfp7n1O8TwiDqII6/4SlRMwEgKtjwjozZNIAt4VpM4Fd6mfQIoSqEW
	rTr6ezMUKmjvdblc70HHbUaQsIVqQph+8XJRAaMLrRMzZPLgjI+jemLNmwjJ07g7hTUtbif00mt
	XToNNPU+dJIKjPuh1zbri6WKdG3IppMYHLsv89sLNUA7DcMVLsZ18HdApmCo4OHSjgkW0N3Osn+
	ZocbDhgnL5yZGfzvmrgFNyrzaJh/lxVKGUrM/RKZW48CM04rLgsLJhVbmBfhI05alJZTvFTkdBD
	U4cUbAZ+7Ag==
X-Received: by 2002:a05:690c:6a05:b0:8b0:b1dd:c096 with SMTP id 00721157ae682-8b1342decb6mr35899467b3.45.1792693413966;
        Thu, 22 Oct 2026 11:23:33 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d350:a0e4:db9b:3217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b155f8db4asm2435977b3.3.2026.10.22.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:23:32 -0700 (PDT)
Message-ID: <161fab786f919adb384fbf22dc19f3289bf5f24d.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: report errors when extending files with setattr
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 11:23:31 -0700
In-Reply-To: <20261022135133.1411613-1-hengyul@cs.unc.edu>
References: <20261021145627.288953-1-hengyul@cs.unc.edu>
	 <2b9ea598558ed4b7dd25eb26a05f6667522c3afc.camel@dubeyko.com>
	 <20261022135133.1411613-1-hengyul@cs.unc.edu>
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

On Thu, 2026-10-22 at 09:51 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Wed, Oct 21, 2026 at 02:22:41PM -0700, Viacheslav Dubeyko wrote:
> > I think now this code [1] becomes dead. And we need to rework it:
> >=20
> > void hfs_file_truncate(struct inode *inode)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_dbg(...);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(inode->i_si=
ze > HFS_I(inode)->phys_size))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->i_size =3D=3D HFS=
_I(inode)->phys_size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> [...]
> > It will be great if you could share another patch with the fix.
>=20
> Thanks for the review. I made this change and ran the whole xfstests
> set, but the grow path is still reached. The WARN_ON_ONCE() fires
> under
> fsstress in generic/013, 076, 476, 650, 750 and 795, every time from
> close() through hfs_file_release().
>=20
> It comes from direct writes:
>=20
> 1. When an inode is read, phys_size is set to i_size, which does not
> =C2=A0=C2=A0 have to be block aligned, e.g. 100.
> 2. A direct write does not go through cont_write_begin(). When it
> =C2=A0=C2=A0 needs a new block, hfs_get_block() only adds s_blocksize to
> =C2=A0=C2=A0 phys_size. A direct write of 512 bytes at offset 512 makes
> phys_size
> =C2=A0=C2=A0 612 and i_size 1024.
> 3. At the last close, hfs_file_truncate() sees i_size > phys_size and
> =C2=A0=C2=A0 calls hfs_write_begin(). cont_write_begin() then zeroes
> =C2=A0=C2=A0 [phys_size, i_size) in the page cache, which overwrites the =
data
> =C2=A0=C2=A0 that the direct write has just written.
>=20
> So today this path loses data, and removing it would only replace
> that
> with the warning, while phys_size stays behind i_size.
>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 32M hfs.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus -h hfs.img
> =C2=A0=C2=A0=C2=A0 mount -t hfs -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 printf 'A%.0s' $(seq 100) > /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -t hfs -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 xfs_io -d -c 'pwrite -S 0x42 512 512' /mnt/f
> =C2=A0=C2=A0=C2=A0 umount /mnt
> =C2=A0=C2=A0=C2=A0 mount -t hfs -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 od -An -tx1 -j 512 -N 512 /mnt/f
>=20
> On a804c5742bff, with and without the v2 patch, the last 412 bytes
> read back as zeros instead of 0x42, and fsck.hfs reports no error.
> With the cleanup applied, the data is intact but the warning fires.
>=20
> HFS+ has the same problem. hfsplus_file_truncate() has the same grow
> path, and commit 5f63ac80aef2 ("hfsplus: fix issue of direct writes
> beyond end-of-file") only covers writes that start past EOF. A direct
> write of 1024 bytes at offset 0 to the same 100-byte file loses 924
> bytes on HFS+.
>=20
> I think the direct write path should be fixed first, so that i_size
> can no longer get past phys_size. Then the grow path really is dead
> and your cleanup is right. The simplest way I see is what
> fat_direct_IO() does: if a direct write would end past phys_size,
> return 0 so that it falls back to a buffered write, which zeroes and
> accounts through cont_write_begin().
>=20
> Would that be fine with you? If so, I will send that fix for HFS with
> your cleanup on top, and a similar fix for HFS+.
>=20
>=20

Yes, we still have enough issues in HFS and let's fix it step by step.
You are right, we need to fix the direct IO issue before removing this
"dead" code (it's not completely dead yet).

Related to HFS+... I am still working on rebuilding direct IO path for
HFS+ and, potentially, your fix could conflict with my patchset. But,
anyway, you can share your fix and, then, we can manage this conflict
(if we have one finally).

Thanks,
Slava.
