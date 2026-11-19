Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109669;
	b=P1LdAMCpMKdtRmmtZxr75iWvPRPZDHgQ5oOvAYarhY+9zKXqal4msdEXWIm6iVDvfCr9
	 m2mjLrhvq+6L6djQtnLznMoWdONRoomaGRTJWhWZjz0XeW+5WKs3C9hrOtNdPLDAV6HCT
	 CvHscFwgqoEgaTp7qgeaHOsgfUDPq8H94cPGzC25rcXzzZjpCTreOX7+1X4KSQcquIgfi
	 SL8/Q81kCMAlM7y4Vtr3s0kwuxE6PJdXY7xQNS5sIBp/lOgszSWbCJ0HvxILSWSFsEQ/P
	 RPzXHdfMtFqfSAqL8cX2mM33CW3PAuRddApk8LD18BAPhBiv67R8ckuFIRDfO2TKnjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m1EYDKjHcJ1IGh49gGW/JeuREp9e8GQDYfzpAeI0szc=;
	b=eZ52i5uABSGyWj8r/YajO6n5dUZ6tte0XGg6/VQD/9gLWEmsCtIiFZ41A9UyyLZLFQ3Z
	 2pD88A1wBveamAzuabQ+mkzOAzuaK7GNnJ3R7N/9+9BlIiXnzWAPf68SYRsh/SFQwaPAc
	 AuM4OcWcQmN0kdKpbk3vuRN0RjzIbATo9tPJuYzNWVBgeBg+fTE6yIAmGnnVIs7LKieQo
	 riJtqJmStoGDL9FZLoxfFMni+ux2lxAp6MMNx14a7wFpWRwZw011zEndrUrkm3PP9bEIB
	 1yTAM52vIqCvS1ACMztWHKIsjjTuNZzooiNiI0jh+4AVELN3J8fakhez6TN+qgQUDuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGC6aRIF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20C606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA20C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGC6aRIF
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so4220503a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 09:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795109667; cv=none;
        d=google.com; s=arc-20260327;
        b=cNh4UpFBq0JqEzO74SAUOODl7pwuYNe7juRH4x3dJEZlTZ7+NCU84jt72PY9jg7HdB
         g/Lb+VMAOa7Nq9nAu8xQ1ytfJhW7vjHaxAElKui1erzrMFDvSFDjRr7M/In3Cf1fbBiu
         5TImXkFRJ6UGsuKxoBRtZHwyDxo6gReSCUanQ/GwUG+FsW39bh+8mlIPmpoPmvYkTqgq
         tFtSy1lRY3/jn5x3jerFc5z9bltyYu97910IGq57g/TfHqhRW3pjqveR3NIaHqF+IR6P
         jlPxFdPa6D1KnxM+UrgMA/XuTujgNGsXrMNsoE59fPWPZvjOm1gQyLCR04vQDMwwFQqo
         Nxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m1EYDKjHcJ1IGh49gGW/JeuREp9e8GQDYfzpAeI0szc=;
        fh=nnaSfav9/MFLvIyhI37IE/icWWxw0D8p5/LDYcC+6Mo=;
        b=FQgq7rOaL0JrTeIewOShKcJa65y++GbnPwLJ7dVyt5Y3Ek4Kz+VNCieF/KrEmMH/w2
         H+DYoOhUgWLE874JdF7wUuiQ5qqlRExr3GxjkHLsvZdtY+SpZq/k+gsRYOcNlyVH1ktG
         NKS1LXMvOEBDaFLN32Cy1bNAviR6uJXTmU8/pfi80egPJ679brgQoh3sGFQ33YzMM80y
         5efwi2rO/HcNUvD1+JFnQEKUM+Y2fq7pShIm6fW74cxhh8BveUh8F/T8eAy/xE1aN3vy
         c8sPyu8EaUtYNB3kB9Ti9r0JQ3TWPq26whjQvP95qqITSfsLcDEdzNLWBd6zNsU2h7Xf
         ULbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795109667; x=1795714467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m1EYDKjHcJ1IGh49gGW/JeuREp9e8GQDYfzpAeI0szc=;
        b=nGC6aRIFchP5t8lwJ/zVTOI/bLa8AV4FvgJg6w8MF9wmm1yRU1tUTokZFa/paaDJ8e
         5PUOtHahetL7iiRPD9uRZGlho38PnlwqF01pD+GRX36RYtqopRY+6tUdIUx/3qzL/D90
         5amQJu0ziL+hdep3ub8xpqOFUa0Nq+K1582CqDJ7KCIXsfa6geIe36gqovNyjbgAUMjf
         2HpGIgyOw12DPpv97GDYb45yfSyQVjodaas6oDy6hcvHkFleTSnYO0ogudCUxCFaFMOW
         LleZntAPokivShBafvD/8UUAi5Gk0sYRA3rFd7SRoFsU1qI4IwU8icU0s6XL5OAjoNTc
         ilJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109667; x=1795714467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1EYDKjHcJ1IGh49gGW/JeuREp9e8GQDYfzpAeI0szc=;
        b=PdLwUoD3GKQQhkY3ioW0gSdqF12M3ZUUHyw+iQ3D60LBkrWQfP9RUO7+c9G6OB27XA
         pEuxz69BPSMjLxdl13ZRp336FmbFAdBORodelXR7ly6dh/hDV6NTiRNgYmbM8OX2+etB
         L99jsFBORY01s6iVd6mzo5Luuol9b4fSJug6ozqjDmP7WVfftBmfqf1Tf5KABIA1+sXi
         VM4jA3+DpZzN/6nq1qV7+seIkQHU8fznsb3WVVP27EKdTyFzHsINXYZvieRgqj5jsFis
         XKOGbwIrCl70LV9dtsFh9HSK+98fj8IHLGWBsDLVlLRP/U5gqeO69ldTydsQT3m+TsBt
         v0yw==
X-Forwarded-Encrypted: i=1; AL+hErGlsp9qhUiniud/6W1c9VEqxKsIjACBXhVOq/JDnur0W2u7ovTCnowSK3If6NRZRuA+HSG9P2OmV95o3E60@vger.kernel.org
X-Gm-Message-State: APuU4Z993cMPWgGGbqLM9wRWJIOvoJRKoNAcKzvsnWrPDQ7x78CkiYUi
	PY9wMI8ch6gxQXlyh9c000DIYajgSQ5Y+VMF/3vW/46ik+FOab4BeR/Pn7exMQjj2aucZdBrvW3
	mGbxSJgEaIaH43S2GAjGQgvjIko4Ky8o=
X-Gm-Gg: AYBFou1FTl8sPsXNxdf9Cj8aflxT2ntJBsmdTcTf7p31eBhdmdS+h+s0hwPiebgVTnW
	56g0CVIgNxMlVqFN3JeFCeogrLmnJzvE5IUvcWbxFoUOoQsPaxobCBQeK/AinjxobTDiX4vW5xl
	NgJ8mFMD5RQjVDK5I1TYnOO/nDFnJrcunBWJ0gr1zcCY6yAbXXzTUMDamih74q4TphBYtFfNSII
	Wg2FBr5tSQu9AVv/H6fnz5ZmVplVd3bc0bSA6dYIOW3cdxt28Vt9u5lrTPsWfBGvjN1hcYk6ERb
	jVYyVU6O/eflR+A4zt75HL62P9S5XpZJB/WjA23/cnD95Z0URdULnDSMozdlbRU/VIE30mr9KHT
	Jal483Ql4x4TKox/8IUIFkBsfp1U6C9o7fcuMNJi3/6zve3k9AusB4rRvwTtrmdcI2VCHMg==
X-Received: by 2002:a05:6402:70c:b0:6b8:7d98:4826 with SMTP id
 4fb4d7f45d1cf-6ba37d5bf0amr50117a12.11.1795109666761; Thu, 19 Nov 2026
 09:34:26 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-10-koray.fra@gmail.com>
In-Reply-To: <20261115180343.576773-10-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2026 18:34:14 +0100
X-Gm-Features: Aa3M54rix9St5Car4447U2IPLFR0HdY95bNJiBlGTi0-FAZstJdvxSGCP5IQDxw
Message-ID: <CAOQ4uxhjxp5sxYphWoB=8sgX3XHOv9zLVYf+8ZjYbS_gQDxO3w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 09/10] ksmbd: add provenance time (ptime) and map
 it to CreationTime
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
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Implement provenance time (ptime) in ksmbd, as introduced in a
> previous commit ("vfs: add provenance time (ptime)").
>
> Map it to SMB's CreationTime, making it settable by SMB clients. When
> reporting CreationTime to clients, prioritize ptime over da.create_time
> memorized in the user.DOSATTRIB xattr.

That doesn't sound like the right thing to do.

If the server stored a CreationTime that client had set, you cannot
override this.

When the client sets CreationTime, the server can decide if it can and want=
s
(may be a policy decision) to store CreationTime in PTIME and not store
it in user.DOSATTRIB.

Fun fact: the user.DOSATTRIB format also has a mask so storing the
creation time inside it is also optional.

Thanks,
Amir.
