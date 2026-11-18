Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987856;
	b=Qz/nHAHlvMGFGUhUOR3c86ZKVzdipTNKM5v0QaQ7ln8TVfqknZPOn7mfSDX0jv77k/Vu
	 Ug+FLSOyR0jpamYIX+MPVHEdMFUxEFWNN9lhc2ex3cL246Cgejy3Sh7Rg5HZHZL9vYcDn
	 11dLWIol+vXuJRonBfkq/rArUIfhx+TI1t5S+kF5r9LscHEoaig+xuUxF9nuGuI5yVIYY
	 K1nMwVn6paSkE8Y3cek2kozL4Qhlp7e1eedExFur5ONtMCm8D2jfhjU8CCYSSGqAH/TZI
	 vSvyqoGSHF40CkKTLDXcIBaE59XjdqkEkm+RXRuOP35fbCC+wsS5WJss4KIB7ZSmdPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n4AlrOV2bTkxElEMddERWhd2tmhmmQ/VeiiLUiTK5Jw=;
	b=ECsuWC8jtqVzLV5be+UAVLuln0OzXZDgXW7r1ClplEx7Fv5i11RwrfaIYpkAeVoWLepC
	 6UWOSerBhdEaPaLLYHVVLznENoTjG0CZUxxkit4/FlDzpzt6plRHLiYfRo60V81GMf0cn
	 BctB2sDU6PdP81wj7IquBof5vrFvhZJK835fab2qyA/nWgzJTGYQIT9x7wLIUdRtmm8oj
	 YYjPlBbUfYElZ8eINgfDsdKteY8FiOyxlyPjxH2YQvp6c5Bygt3+Hmc7gf4m1ST8havnM
	 YTllsx4CSxioienz/qV0hb+Ou4aMWsQuRE2Ae8qKn/6nRQQ6bmBMxBW3zR/4Xov4Xiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a90oyekV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE517606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE517606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a90oyekV
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c506a231b88so78059066b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794987854; cv=none;
        d=google.com; s=arc-20260327;
        b=UM+5wsXINR9hFcwMHcKSKiZpnApWW+BozFxlSrYMPKP//LbIjIf5meMQHJFc2YAs81
         2cD88661fNi1DitSANHUph5Yn9iSGKcAbpMCoTXvg6M++QoEy0RrEsCWE2nSsJfkSvFJ
         n0hE9CVMgZCiQFoXpWR0BkAYuBkurKjp+bAm6QP1rLpvKHS6WvQ79I0ANN/NxMXhCF/E
         JvYcLaBtt5mfF3peRR41XGmSDSQc/6Zz85GdveTVhIY/MKAe7mm0aYdi+UOdgr3kqjCX
         NfcucWi9SVhM5WmtxXVNHJzfIHcr3b7ZjUKWa+/eoRmQocjGhzxSkDxGABfLDN+3IRR4
         FHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4AlrOV2bTkxElEMddERWhd2tmhmmQ/VeiiLUiTK5Jw=;
        fh=7YtB22NbSpETiFVfgARuA5mycWkjmHkhSJdTohKEtag=;
        b=YSPoyn17P7O7qwCPEpK5eI6xV7nPPSSBPJW4WJx3D21rdq9USEwX4RkoCr/EHN7qnH
         AN/X24+ruEXF0DiAIguQhxZLM+NwPstX2LLul3W1KCssM0JLHtp+EMK12eXjnq1skgIP
         aDxj79FkWdLzkacRXwDON2H5A644TX4dwAznjWQ+Q/TQL69G58LLiKWCKcCOa6nBQkyf
         c8eR8AyKR/cGbfjbfuvvftlJw+0yyIIjjHKPW6zqofQ84VrtmTisSTdRNr7nsLjXNdwj
         lNwsxoVpIu53ccnUwGeIT/zY3PpR4NzQJzQpX90VMrX3sPLjUW0vj32IblF67gUdsfQU
         nviQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987854; x=1795592654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4AlrOV2bTkxElEMddERWhd2tmhmmQ/VeiiLUiTK5Jw=;
        b=a90oyekVEtWSbiQRFscTKUuOugQqsd/uPA+FKR2IB/q1W1t8taa8KZshmfMtrhj1sD
         LqlTnKmsQhen50SBtfcKu6ft+wmIP8g2pM86rjRDF5dOKhx6HkBJjAXW7T1Tl+HJbYGM
         9Z/N8X+v0TSuGqaim2wrUn/cNQfHBvaUNsmrozwAN8tX044VAK/I37vtJhmtoyIAOWLA
         XYHsu5zGuiaBInhEXWSkPT9Ljesxk0waBX2hq58DlHTNOBoHWFxCJ3W007gohZobfiCi
         lUKynaBj5mnjW9OxWobgOEENOt4UOL2ebqhsSIkfnMawpK0ePLqbjCd09xHI9SQgG63a
         TzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987854; x=1795592654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4AlrOV2bTkxElEMddERWhd2tmhmmQ/VeiiLUiTK5Jw=;
        b=BuYJh1KlYyNjRs805QOS8ktxoSbJokkMmw9UYrb+t+m7gHrUK0pa3bCmmXjRIGG3A4
         Jg4NVNf3QvQ6NqTdoVCQE1zglXR4zR2Bu3sogBYIN3FOUbkbpA/x7vvH1BfWGkINpxTd
         nQHAF/KQnj4FnvkjIwOqRZQne5wbfqyAQaqs0dMxTVUK3uhqjYiWxBccIECjyugnARz1
         KC5TRxSqX0HZcvccXuiSqu56Qv0Y5OGvejycl2/5VgX3FqO0MjxH9zXVvJBwaEEjiPHn
         ij1ViddXdjQ4MwgTQmLALrEb+WZ18Xt5Aoe2lxWhOa4h23tV9tAmoW15JRvOplNYlGk9
         A3YQ==
X-Forwarded-Encrypted: i=1; AL+hErGh/xbFhtFgOslW8d04RoSIvLod5N23aOx32rCgZ9L1hzcb+id1EnoxEfiiJ9+SF38siMCfIMK09i1HQPr5@vger.kernel.org
X-Gm-Message-State: APuU4Z/DsG4RZqKshFtsZQUa034gJ+SiOPFOdKYPqV9OAy9pqHY2oQpO
	9dsh766/WXZfurRSTmjdBrB05USya2BWKiBfDHoWeucOQfsWdjOI0XpxGVCUOihOX6dJnqmab8B
	0zZ/J2amR1bLmmdCninF9UFzHWJkH4p0=
X-Gm-Gg: AYBFou00IXhyjEwmvVdpjSHMFBkxISEc2nGDaL6DtKmh9qrDe9y47M4fbPM221SSQue
	zvKU6FGxjSaps27AcSS27WoHT0TrDtsdwt88PFv5jmDeZViyY3dfRF8aFHARFB0wtU/swgxFhS9
	81rMis6E652hEqk/BWxNM5ForQyRh4aiEuiAidroS8NefvdLzxVNSiW/r++i4hBBEC/q+XMvEgG
	JBy9sZhNZx4pB8N0vhTKEUHWwZlqVHUeyyJw+q5MLDClOuTNqHpd9GERmt2obkuaog8BGDe25Z0
	OgnXBU9IKd1rbHVUce609sCwS1xrOUn2LNmNUswD8l7pzMtEvI53zPzpuWWhcGMj7PzydMVgBE6
	9m8f+sYfma4NFGUta+3dr5CTOtOsMJVd8dME7sDKOPwrfOE4/3eVoZw50A5h6a1hcBZQHxQ==
X-Received: by 2002:a17:906:99c5:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c510debbf56mr128472166b.7.1794987854109; Tue, 17 Nov 2026
 23:44:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-8-koray.fra@gmail.com>
 <f297d9ea-ebd7-47f4-ab7b-de5c45980000@app.fastmail.com>
In-Reply-To: <f297d9ea-ebd7-47f4-ab7b-de5c45980000@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 08:44:02 +0100
X-Gm-Features: AclHuK95FDUZyIgGYH5oXAgwPF3l-5HxSmk1nBdJ9DPBoS5wbYWUIu9nYKyQ4rA
Message-ID: <CAOQ4uxhpMARO_ZMJDeoa044BwufLVnS0o4Fv0abBF=tjaZmtWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/10] nfsd: add provenance time (ptime) via FATTR4_TIME_CREATE
To: Chuck Lever <cel@kernel.org>
Cc: koraynilay <koray.fra@gmail.com>, David Sterba <dsterba@suse.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:02=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote=
:
>
>
>
> On Sun, Nov 15, 2026, at 1:03 PM, koraynilay wrote:
> > Implement provenance time (ptime) in NFSD, as introduced in a
> > previous commit ("vfs: add provenance time (ptime)").
> >
> > Map ptime to FATTR4_TIME_CREATE, allowing clients to set it across
> > CREATE, OPEN and SETATTR compounds.
> >
> > If the underlying filesystem supports it, use __vfs_fileattr_set_locked=
()
> > to set it, returning -EOPNOTSUPP in case it's not supported (i.e. when
> > __vfs_fileattr_set_locked() returns -ENOIOCTLCMD).
> >
> > When querying FATTR4_TIME_CREATE, request both STATX_PTIME and
> > STATX_BTIME, preferring ptime over btime if available, and advertise
> > FATTR4_TIME_CREATE support if either ptime or btime is available.
> >
> > Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
> > Signed-off-by: koraynilay <koray.fra@gmail.com>
>
> > @@ -3646,7 +3649,14 @@ static __be32
> > nfsd4_encode_fattr4_time_access(struct xdr_stream *xdr,
> >  static __be32 nfsd4_encode_fattr4_time_create(struct xdr_stream *xdr,
> >                                             const struct nfsd4_fattr_ar=
gs *args)
> >  {
> > -     return nfsd4_encode_nfstime4(xdr, &args->stat.btime);
> > +     const struct timespec64 *ts;
> > +
> > +     if (args->stat.result_mask & STATX_PTIME)
> > +             ts =3D &args->stat.ptime;
> > +     else
> > +             ts =3D &args->stat.btime;
> > +
> > +     return nfsd4_encode_nfstime4(xdr, ts);
> >  }
>
> I have trouble with this approach.
>
> We've already established that, for the Linux in-kernel NFS server
> implementation, FATTR4_TIME_CREATE reports a file's birth time and
> does not permit NFS clients to modify that.
>
> After this patch is applied, the server reports the ptime instead
> of the btime on some filesystems but not others.

In other words, for some server filesystems FATTR4_TIME_CREATE is
settable and for others it is not.

Isn't the NFSv4 protocol equipt to deal with this complexity?

>
> Essentially this changes the semantics of existing files that have
> a btime set -- technically that's a regression.

I fail to see in what situation this is a regression. Please explain.

The only oddity I can see is that a kernel downgrade could result
in an NFS client's view of FATTR4_TIME_CREATE going backward
in time to birth time, but I don't think this qualifies as a regression.

Thanks,
Amir.
