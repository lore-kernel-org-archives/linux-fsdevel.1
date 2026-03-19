Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157973C3443
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923214; cv=none; b=eU2E8qzB2sagqwOAXGk3VvGxCRweRg1ee4WN/fpNtXdnvAjTdR/ySt/ppm95tagEoc/+sUjJvSebo445XMuueaTpFmwrVov0pgRJpU22UWNDhjLXcMbRL/iNSM5//f3cA3agEAJqM1PWLLyouqYGRHtscmY9lR2VkY+Px/MpMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923214; c=relaxed/simple;
	bh=an//Ta4gqF3edZ2JaxNj6hMOywXPcWFQqDLL7w+Y3MQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=M4yd25Aq09WYmngH5wetMFUTmS2Expt0/c+1a8SJE61CzMX47P6WuQjPsqOJhEqpe/oNk85jSlemuppf6Hw+UnQNZvovs/NECBOiENKRCH/o3eDKHcL/IJ+YtAQD4RNrdEbgxaGppefnEh92deExp8QVccv6z8EhQWAE1ccSiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=O9dX9y00; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="O9dX9y00"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773923206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeXmQLLg0EPjX6UctPTTEIfcncO9erEF/OUBHjyDJTk=;
	b=O9dX9y001mrtU9mSQlE08R89HgUFjGK14y3biu25gx6RVpiJzsklw0IHO0VvtB7FwNSr5g
	0Zwfhr8FzDwoGuGqCYEEdm3jD5zcBlPu+Xu9kygAXXMkxhXAVkrD8BQRYQlTeqTpW3RdTy
	6fAD+0yU+beIHaiOus9X+V/y2wFX56lRJw5JgVU0eyppPZZeJEsq9fmmLaN9TF2DF87IwN
	DIrUc+p5MaMN2Uei8eshAG8y9XRRIHHxj+Dg6L9xpUM4lFGn384yfqMdqItdttrW69d0eX
	YjR8x5k1KGF3rmxQEvunxAk0f1zNSSsku/Rfjr+J4LuJUEYEVr+tGfVGL2EUiQ==
Date: Thu, 19 Mar 2026 12:26:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "George Vernon" <contact@gvernon.com>
Message-ID: <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
TLS-Required: No
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>, "Viacheslav Dubeyko"
 <Slava.Dubeyko@ibm.com>
Cc: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, slava@dubeyko.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
 <abnzsVk9JNN3alKq@Bertha>
 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
 <absr9g7LaMEHfw47@Bertha>
 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

March 19, 2026 at 9:57 AM, "Tetsuo Handa" <penguin-kernel@i-love.sakura.n=
e.jp mailto:penguin-kernel@i-love.sakura.ne.jp?to=3D%22Tetsuo%20Handa%22%=
20%3Cpenguin-kernel%40i-love.sakura.ne.jp%3E > wrote:


>=20
>=20On 2026/03/19 7:49, George Anthony Vernon wrote:
>=20
>=20>=20
>=20> Tetsuo, what do you think about doing your check inside
> >  hfs_cat_find_brec? Something a bit like this:
> >=20
>=20Currently hfs_cat_find_brec() is called by only hfs_fill_super()
> with cnid =3D=3D HFS_ROOT_CNID. Are you planning to add more callers?
>=20
>=20If no, my patch
>=20
>=20 - if (rec.type !=3D HFS_CDR_DIR)
>  + if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HFS_=
ROOT_CNID))
>=20
>=20is sufficient.

I'm trying to write a patch Slava will accept, maybe I didn't fully under=
stand what he wanted but I think he wanted to fix hfs_cat_find_brec() so =
it should not return an incorrect cat record.

>=20
>=20If yes, your
>=20
>=20>=20
>=20> + if (fd->entrylength > sizeof(rec)) {
> >  + pr_err("Bad catalog entry size\n");
> >  + return -EIO;
> >  + }
> >=20
>=20part is not compatible with https://elixir.bootlin.com/linux/v7.0-rc4=
/source/fs/hfs/super.c#L359
> which requires that fd->entrylength is exactly 70 bytes in order to mak=
e sure that rec.dir is
> fully initialized.
>=20
>=20 sizeof(struct hfs_cat_file) =3D 102
>  sizeof(struct hfs_cat_dir) =3D 70
>  sizeof(struct hfs_cat_thread) =3D 46
>=20
This=20can be changed.
> Even if you are planning to add more callers, my patch will be easier t=
o apply to stable.
>
Yes your patch will be easier to backport, but then again HFS has had min=
imal churn in recent years, so I think this version will still be simple =
enough, only maybe the interface for debug prints has changed that I can =
think of.

Thanks,

George
