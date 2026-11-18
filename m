Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023477;
	b=DPWN+b6ENZd3vqANXyoZDhj9AZfyHMDScg8ji1MDE7EU0A4YMlQIGPDEnqNkAJ+ThTXD
	 j4Z5HSCI4uWA4MW//xYCYADv1J8hGL22RhPkOjRbFqoVGftpRfMWWA6gUkfjo5EhC9NlZ
	 +RvZ1ggVdrI9p70U6pBmDApG5glKaE3f4G7qByIAHgPsQ6eKWardoQ4G4jDAjVcDbU7MZ
	 tgco4VU8qKZVHx+nwwMstRQCkct6YJoYpaXGD8HKBiXHIbo4di7FNdznhTrbZVuuOCgeA
	 aiTpQI6mYl3YHLd6NnHcb2zMWxDeui+AwSYAI99AOm40jz+F0kCyaVSQEQyzc6lbm5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R67yuyz8qBaN7OEJjW4cC9fhK33d87+KjfsWBVWkcBA=;
	b=LBAP9SZM2rKR/P7OamgaW3mvi4jmoBLaD0Tx8zrEBuPnkUp6G4EwvWa/ar7Hw8pjmYaC
	 NckY9sp+0eVGx5cI1x+Rm7CL6C31ZM9Dc8mcbiZAKF3vKgY9/8SZdtda4qALYMTzp4SpP
	 JTZkM6OpWznluvYoDeBZN1Q50LHSDVLayTPpW67VAN8A/cOZTOVWp22i9ts55HZTN14SH
	 67t8tUIxZ/Y6yh0sd/86QoritVcp6uz0AwAz0zmjvIRZfsVqC2x9prjvBcxLyQ/2CAQVL
	 G34jtu5kIeNas8ixtWHJB1vDHGFB0hcbXyEbq2bP+xoezbqFZNk0NrPZYt1n/YKKczw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4Fx1cvZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5072606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 17:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5072606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4Fx1cvZ
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so8952266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 09:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795023475; cv=none;
        d=google.com; s=arc-20260327;
        b=PxSK/4m1r8oDiPChlraJowaWPFjum1obOn5RFLehRqYlo8CiC2b+m4aWUc0qhNZosA
         nUN9RqTnKVPLTnSh+4B/B6J6P6iw74zyhkWUHusHozNGitUqGd+hsGzWlyujSPBackzB
         zFr8CzNB0Xl+yiOKjomDm9k6YwyVAYT8qOm5vxMjbggwfBxc4Y/7VVFW9ftU7U1/h+Fh
         z9a6oLQxvyRIDxdgrhSrDEyGBzwnO7J7Y/WE1HsdF0LjAoKfxD5+46aXsGhYIXtlG0UM
         njgEstNZiC7s+X3vaZbT68DRdGMC3DXpS+kEeMf1Esy147PGkm612aiwSpU4MybqVEbu
         mwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R67yuyz8qBaN7OEJjW4cC9fhK33d87+KjfsWBVWkcBA=;
        fh=pDVdpZX/uVRyGwdypnBATJY/xA7nmvX1rN1oOZLdsM8=;
        b=KpTCNFWmqzZ4+D0KR80afOr898tXd3X5fOsY4jtSyLvikh1skSYjT5q9JYtpoGgiSV
         ZSVl+2IAfBPidc6CmMj4DGPH7zaIHLk/gkep5x01c+5vrblpIivfT+iQZgxCaQUf8KCn
         Tac/VyoStLBHFqW76VfW/b7zgLwiE3E15qIahatHCXshxdnbLc72hAAYU2saGGfFsODW
         IjGI3aRTct/CmhYcqp4627qVSeweKCG4el1K8WFOWL4v/Vq3/Wyl5I/MaAqvSJ0hE9T+
         SBYSAkvUgxaW8/gR1J5wREvIzbTsuuZ6U/fkjeGiLhmhyd2eexIa8y0mBY9k417yfzEL
         m8Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795023475; x=1795628275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R67yuyz8qBaN7OEJjW4cC9fhK33d87+KjfsWBVWkcBA=;
        b=B4Fx1cvZRSB70oxXa7PXzsQOiKHd8kick7ujHIg5sKZfXngwM/J3md0QrwQw4limgc
         gzD04fGPnUdH4vsdPqK10mZdRL8XnpJIKSo8akWEM5mP1fwpa3D6R1ZVi3kB4ftkkRYT
         t3eglWK1B2yIv1p5oKl1PvLjjuez6SSOZkvKdegYNTew2mBmZIppnHMoZW7XAD514J2T
         Wkz+jc4JDJW+IYh3dYSMGjOQlspp4IYbioQrh478oLfKYgEeEOCfp3zOdH8mfHNwLEAs
         a87jaYO1D21yfJt0MK/CqLT0XQY2LPKrrUvneOLh7WazFrteu6Qq14s3DdjdZZ4eW7Xb
         Uy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795023475; x=1795628275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R67yuyz8qBaN7OEJjW4cC9fhK33d87+KjfsWBVWkcBA=;
        b=I55aibiWXWsVkQTCpDaiVnUsFr+LYgU+N9i401mg+lTFFBOFNOV2rBB7kBOMUJtyr3
         enJ/URyfi0NPCiutRkr7WOMiajmwm765v8t+wxAmwsnrx9e6GnF699wGvlxs/v50EZqD
         4iu8mrwQSRBbiHKoJ4kxWsNXnU/yvaaGUXfW8q1ysDVGTGtbArKqXRi7DqFP2LfBZceD
         XVKLWRVqOOFGXn0MGhNLspsIgpHlNd64DO8lFxNp3tvwUMafb7Q15pimqdlWRXB2ZoSI
         fAZ2wA4diztwP00SQ9LAc8IErgdMPsEwjzuiAy+d3NPIwn6jXlBYPkduN7PGkl/N9XkH
         EdgQ==
X-Forwarded-Encrypted: i=1; AL+hErHdEBk7Et/WzGPTDqyhjqRYmi6TWnAeXIPt4vsSU6O+/y3FnaayD9uATZEVL4CV8fZ/sQf5qsuWPns/KDxS@vger.kernel.org
X-Gm-Message-State: APuU4Z/b9H6NO60lXoQfnv/lMfbAbTwpMj3V5LU1tTt6699xMBrgGwcI
	ho1jr0kYizUVPwnLin5EJFm6rQlhOcHThmR9NKh/wOwJD2NTQ8oKNnRu8ROqOVP9UbEOYUkeHv8
	1evzpYEZYtG8KfIZFJ50v/uAVeCLUPd8=
X-Gm-Gg: AYBFou1sNRMjgwmhnNO670MjjTqST3mktgfmPfAPZ2S11tDyxgbdMenJCwFLyoW3fYv
	etxZGOQ/xawASKcXmafLezV/uTp3Brz+trm8/kE4LU0yBwmo3DwghgFHRbXsJMS2/K9EaEhusjN
	jAGVhpEJz0JSWbX1xMDVQwg3ge/1wClA/EK8mOnqEtSsLCg4APDGJ2CQhR6lh/VIyHxOovFDxOq
	AobRV4F/eaGlLR58Ra5fGY8HVP5B6yIJ3EwZXBc1fXo73dhkQKFNpUWXQYiykRSuZnzGmSvVxq9
	CImOHAqrv5+1U6zMpDJgRyqx7bRQL5nX59pLPFZ9yhlsjJX30OhGLmuNOaJD8Iro6C5P8ayWvnQ
	k2/IgdlvMMqbmlJ1pvzC9+q2Ma4gDrMyu4oSdTHI2AcebQnBP/Lptp33mitZ5uxBc7ulyVw==
X-Received: by 2002:a17:907:da1:b0:c49:b6db:1 with SMTP id a640c23a62f3a-c5126364307mr15604866b.12.1795023474965;
 Wed, 18 Nov 2026 09:37:54 -0800 (PST)
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
 <f297d9ea-ebd7-47f4-ab7b-de5c45980000@app.fastmail.com> <CAOQ4uxhpMARO_ZMJDeoa044BwufLVnS0o4Fv0abBF=tjaZmtWQ@mail.gmail.com>
 <cd49ce48-58d7-4341-b4fc-34e63daf3c52@app.fastmail.com> <CAOQ4uxjme9sJ5LGNDnP6rEKZLTJzX_ZdcMohgu2iLULK96GPOA@mail.gmail.com>
 <9c4a509c-b6af-4da1-8a64-9d5c26c74bff@app.fastmail.com>
In-Reply-To: <9c4a509c-b6af-4da1-8a64-9d5c26c74bff@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 18:37:42 +0100
X-Gm-Features: AclHuK9j8na9qQXXbOgij3n-j2Bo4JySgielhO0fgIJ-weX9anWXgtr5UxF7Q-Y
Message-ID: <CAOQ4uxguPD+PWEUZtAzSdA-15d_C5cn=34ZmCm0v_b0MWK_sfw@mail.gmail.com>
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

On Wed, Nov 18, 2026 at 6:14=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Nov 18, 2026, at 11:36 AM, Amir Goldstein wrote:
> > Can't an NFS client be connected to another NFS server
> > implementation which does allow this?
> >
> > I can't wrap my head around the problem.
>
> You already named the problem in a previous email: What happens
> when the NFS server's kernel is upgraded from an NFSD that exposes
> only btime to one that picks either ptime or btime?
>
> Clients will see a file's btime before the server restart, and
> afterwards, they will see a changed TIME_CREATE but the file's
> NFSv4 change attribute will be unchanged.
>
>

Indeed I have.

My newish proposal (on cover letter thread) is that we
abolish the ptime/btime duality and make mutability of btime
a pre-fs decision which is advertised via the get_fileattr() API.
So from the user POV or nfsd POV the values will never diverge.

Thanks,
Amir.
