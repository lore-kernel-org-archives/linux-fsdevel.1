Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013893;
	b=QN5692DS6HMDQDsVzz/slKrxr3myuPle71r/wE58TkVV1oPMorIBeCsXaAPv/nXrcg/S
	 pOpmOdUtaR1CyxcsHLjWr099W9TrSS97k65ydTm8H6W/l3tZVR8cvDY4z0t0tn9F1gcPl
	 i5yVfXckQY6xL1EXYiYPeb4VHKyRr3plRNnYgw65kjxeVftKpRcFVSJdmYwRz2M4lVwGj
	 hUoUSP6LISY2gJjKtnox58jMLRMKgdanTuM42dDaZj+EdPJhUET9zYeoayohv7pCm2v7k
	 hTqPsQ++Q+2Z7L1bVYF2fRuYW+jlFj5a1p7pFCJYxib5R2YJHTmU3uuEbB7L6berCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=Pp/RLPMZ3GifsKTDdh8Pk/uftsOfh5azJIs0J3c6Xr8=;
	b=aU+Fu8xxORRgW73Aockehm/A1W2akz7YZlc7+H23e/EkwJeyJU804+QodfVBm+XsSnLs
	 wNIN/FMAD2yFCzKnpdAjdXcLU2uZwvn+IQyoi4fkAllX7E6jhTB34su7WfgqSmHXt4X4h
	 vOq5z7LmaOsOWTQsnwfQ7PAZPU3ci83jwLK9QFeOHrfS1Lai0IcKaFtA/dh9UOc974QVl
	 +eOdvmkpx+kDoVBN6CFWsMI+rHO8JUtZATOwYteASWfGW12YpKRDWoLrb8+y+nQPvRS0o
	 DR0OWrDEViO0iHgcO2x9Sve2OdiQW3qYVj+VbSp35/ShncmzVGj+gy1WXlYhqdis8lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIynCKYl;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73169606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73169606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIynCKYl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so940364f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795013892; x=1795618692; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pp/RLPMZ3GifsKTDdh8Pk/uftsOfh5azJIs0J3c6Xr8=;
        b=WIynCKYls1N8nEyEmKDwpbFtK4fRYUUmPMeyj1Lc9KrBLr4DNDXRTqxqglZZe6Ifn/
         rnLkHwm2hphWg/c9Bfvobg9Xh3gOHmCC39W5EhYmE2vXc7oQ8QkoZqlQnR0DV/jsH1GX
         0zzmewpfcvfatXcXxZYAaoXNifblQeQTqV9d1MYWR9E61n5n3sGbMTxRnTnaL0nDt2oW
         nQRU8AFvYlvH+9vQ96dlbf/TUEFEwX2A0JC+XqUxCoPLcHF9R+OCRlpqai8JZglyJgPk
         qdEM9PuU3prps6Ygbz0r7hOM9uQF4f9gUmI0QuSofnln19TV9ZuOiZ8w6K8QMEHi7Fbn
         NPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013892; x=1795618692;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pp/RLPMZ3GifsKTDdh8Pk/uftsOfh5azJIs0J3c6Xr8=;
        b=wON/jU/UHX4Po1DrGkDUazZaEOfYRQ+rkTySwHFXxqbF4+FDeX9d7xoZSOIMMPE5go
         P1vdN6tWpa6w+gZUXusDODt87RCDjdc4C4a2A0HTI0ZzTrq5xCWE7a7hwM3HCWUcJ/Bo
         6NA0JJET3ZplCMR+z+jtnA8nSdu3Lzd3jWe0HAMVtLtIHuLQa6Hnki0PWNaK2xq+2ohN
         mLqpVFesFjGTfoUvorTz/zRmSiqwl7T8Vg1h+POxZHR39mjay/PY9HL9Z8pk80HQJrTx
         H93ZTqdokJCWla1y+3dZBh+lIp0wVDaelFj2SHYkLLMfmtmU2XUbvow6PWf4n1fUBsHu
         RVew==
X-Forwarded-Encrypted: i=1; AL+hErHFoZuitZZ4OozhOdGOzyCOocJLQAn1UQRzRRgE9uqHzJsmB0tRhWrCJxoaIQZsmELjTNQPQtlGY1LyfioU@vger.kernel.org
X-Gm-Message-State: APuU4Z9NkhgSWIsggx9xBa+1MnjeJFeqbrRFdDQ0b4RuL0JMuz7g2w1E
	G8VUaYy7rtH6SCmxHFwJJkaq32Mu2nGBD++LIuxExGSxR6fWNUd/ocFI
X-Gm-Gg: AZFdTZeYLscFB/5lqiXlWLphwIpQkJ/Z97SNXWfOckFZxtdSOHn9cOW7HiQigo3koFy
	QDBWba34jQhImd8dYYSfV/sqkshqrTLLyq4nTt+yfAng+EueIB6OMEsUYZp3+2bX3uFzGj9FgS7
	ELtBrj0RKeBrdAsItnbpFfQV5R4S/a8bbw0QSZtmOuD+VUk2sQRxLiUeNviutqKB3zqbVXbg/3k
	8/lskxTkSKPudzp/VbYd0+44qbvafmJLSLfWWmcWn3flBgWlWuL5nINc0gfMy0FcxI7aB7IUdi4
	+t5P1urrd1+iuwDsAuB6evcRVoPZSX21VTWPrclnBXNe09IU8rn9uh/pa+BQuhoNrf4hNQ1LMSD
	vIUgnT36qoGg+PyoGAMsWG063zJ6QXooJyLiKnS+sn6d/3256PIsoVBLYeS6GRQ8CXS6l21HxKS
	4QBnGZgIRkKsIBE0I7v+Swntnjrl/yQHc0pz8o9Qx6yNkkbVJwL2+3acVUm7GwxCj97W3lm921o
	7Jr9/aeI+5KO8kFZUkHEQl+scOFUIHSU7yq+rifbZfaaK6WpY+YeToDqJugNUVtFxqiinF+87Pq
	b/6ad1UC8kCle6KAL1HFt9bxSec0Tpv8roAcePIOTY+XHGDOGVbLeuygruuVJcM/Cw==
X-Received: by 2002:a05:6000:2dc5:b0:4a7:7bec:e159 with SMTP id ffacd0b85a97d-4a84976942fmr1578019f8f.15.1795013891542;
        Wed, 18 Nov 2026 06:58:11 -0800 (PST)
Received: from localhost (mob-176-246-251-118.net.vodafone.it. [176.246.251.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3b3sm5373344f8f.23.2026.11.18.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:58:10 -0800 (PST)
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
 boundary=9e0e009d1054760532dfbb31949a479f82968ef4509cbe81b751bd0d90dd;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 18 Nov 2026 15:58:02 +0100
Message-Id: <DMYFBDIV4Y08.35ZKR5G86U1H7@gmail.com>
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
 "Pedro Falcato" <pfalcato@suse.de>, "Amir Goldstein" <amir73il@gmail.com>,
 <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <exfat@lists.linux.dev>,
 <ntfs3@lists.linux.dev>, <linux-cifs@vger.kernel.org>,
 <linux-nfs@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 00/10] add provenance time (ptime)
From: "koraynilay" <koray.fra@gmail.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261115180343.576773-1-koray.fra@gmail.com>
 <20261118142613.be3r3s6kobkkxnz4@pali>
In-Reply-To: <20261118142613.be3r3s6kobkkxnz4@pali>

--9e0e009d1054760532dfbb31949a479f82968ef4509cbe81b751bd0d90dd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 18, 2026 at 3:26 PM CET, Pali Roh=C3=A1r wrote:
> Hello,
>
> I have just one issue with the userspace API. It does not allow me to
> figure out what is the source of statx btime field. If it is fs ptime or
> fs btime because this RFC implementation is mixing both fs ptime and
> fs btime into the statx btime field.
>
> I have feeling that this is quite a mess in API and I would like to see
> a clear distinguish between btime and ptime in the API, like there is a
> difference in the fs storage.
>
> If the btime is used for forensic analysis then somehow I would expect
> that the statx would not report / not fill changeable ptime value into
> the statx btime.

Hi, for native linux filesystems it will report ptime as PTIME and btime
as BTIME (also semnatically), for the windows-like ones that only have
ptime (semantically) I think it's reasonable to not expect btime to be
immutable, since they are meant to be used with other OSs who lack btime
semantics.

> It would be really helpful if the statx API on inode can differ between:
>
> 1. btime is present and its value is ..., ptime is not supported
> 2. btime is not supported, ptime is set to value ...
> 3. btime is present and its value is ..., ptime is set to value ...
> 4. both btime and ptime are not supported
>
> This should cover all cases of different filesystems and also allows
> userspace to do proper backup of both ptime and btime fields (if it want
> to do forensic analysis or anything else).

These should already all be covered by STATX_BTIME/PTIME and their
fields in struct statx, the only problems are windows-like filesystems,
which IMO shuold be handled as mentioned above.

Of course, as in the other discussion, I'm open to changing ptime
NTFS/exFAT/... support to remove btime altogether and only use ptime for
their own crtime if that's what wanted (I'm fairly impartial on this
specific issue).

Thanks,
koraynilay

>
> Pali

--9e0e009d1054760532dfbb31949a479f82968ef4509cbe81b751bd0d90dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCav28+gAKCRA0bnTtJTDo
OLZcAQD9pG1FmR7nRZDk2H08cDMhIho0sN3gDoVZ9UGDLNS9YgD/Z/0Ge9mFK15R
FEjSmx712gDHXRyPIeZ3A/k22EGaOQc=
=3Ms7
-----END PGP SIGNATURE-----

--9e0e009d1054760532dfbb31949a479f82968ef4509cbe81b751bd0d90dd--
