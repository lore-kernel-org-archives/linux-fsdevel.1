Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795732035;
	b=eEoYbkrBSFiiXI4eBK4OlEkJ88CTroZGjqRuA28b4mbBljLbf9mgWxbXvj6SxD5cGl3j
	 n+Pv02zVqNELakLo4kLn00GPbzxNtPbvdgb3GbeXGC7V9sNvlClQw0r/waamlRhOKZRni
	 harLesajJksv4HwTmVwUv/1Wzx5rubL/W4KYGtu0TOjnZdXFYZj2ybIPA5GcbjSrQHDwz
	 X+bzrrNw5Vfnp8lhf7869mGaBk1+DTPSxPsdYRJR6So+FCeid/YJThaJ6OpdeDnNg1Iy/
	 zpUoZlskDBWI3aJ+Zs0HMjX2Fii6KHMKxXwvos8hTpH1Oxd77Kd9yDgHJvoPlbDn6HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795732035;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dzcO1ljQep1WtWKLzhtsWsA4ACOyuIv3JO6N5+BEqKo=;
	b=wWirNdh9E7oUDKJtJkrTgtd/+TJGJvF+rMHESk3jlSZQE7Q5BbSY/E1FQp+QZfkr9/VB
	 Ds0OghxKWpVLKjioUj4U9p+w6XlgGqWSWxfgu57BEvdtvW5F/omnHbu416fAVFTCFLlsN
	 aFP0HwuqApJJV0L3GXYyHyKDQo3WNvgZfoEFZZdtl9MdQ//qxc1P1Ei5tXZkiedzXV4rK
	 WkVrWeZRFf8xFCYGWUsn6ebyajWQWuq/DYTDE24g7XLaxWcZry5ndPlCCutjUyN6/yt+4
	 lhtBQAop3LXnpXf0+qc/C/9JFWvRBQxUyowqyMMtGdSitTYJUEIEJjEw96/Y5Ylg5HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJHtieXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854D606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJHtieXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1861F00897
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795732035;
	bh=dzcO1ljQep1WtWKLzhtsWsA4ACOyuIv3JO6N5+BEqKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FJHtieXnn/5kyPdGQrLtSp2ezUsBafiLPmUDPuPP8Z6rZpFdYIjChszQD2vwbLCPy
	 ToDJEKDB/sY0sUfv8/JIpjQfQzpErb3J2k7OmDRpZurJjpQ5RAxdcbbKj13mK0ePa/
	 5VnMAiFt9daf9cs+2Sqt1aVOwG8HRtbigJE1U420PiIRnKWZwxSylC6rYssr+MNe5y
	 SlZGiQRfnINdQ/14fiJljINOee3aXfudDXs7i89eCTKuOJ09eRTPAEZqFd79t8FGXJ
	 iYlc8/aaHp0KJN83cMY9Sj4it15gvnc4haJ15Th6Hy6QRaZOxZx69/zjnojzoEzx5N
	 CCaLJXnAwuflA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5126505cb3so975898166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 14:27:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGcBEtGslyq8ik5HPB3MTpQnXYyE9cQwXickJxmNL0EqVz/lzZIW5DXSdBw379/l2tJ38BdpOOVMl3DXqh9@vger.kernel.org
X-Gm-Message-State: APuU4Z/0+JTTyOjt6IaA21kkWTwd54mz+/FGFsX9PH2dAp3UY1Jgtiy/
	CmRyGMObQHrVcaJvcn5u3ruxHime5mtGXa1qU1Qi/W5WmSzBKa7ifkLvfjRuuYZJ2/0Yla62hZJ
	y+EqgGrkHGt81+xNNeO8wOehMlJu/quY=
X-Received: by 2002:a17:907:934c:b0:c51:282b:5489 with SMTP id
 a640c23a62f3a-c513a4aea3bmr1775970966b.3.1795732033895; Thu, 26 Nov 2026
 14:27:13 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-ntfs-01-v1@snowrabbit.org> <awePnaRhBQLahPpz@hyunchul-PC02>
 <20261127-ntfs-01-v2@snowrabbit.org>
In-Reply-To: <20261127-ntfs-01-v2@snowrabbit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 27 Nov 2026 07:27:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Sacb2aDzfJYKiqay8QWmH9dkoeFfhonDkeg7c7MX9jw@mail.gmail.com>
X-Gm-Features: Aa3M54po-v6bUbiFArbvKTTwwy66ZUEHuur8Xwr3gZIwPtSHYaBnwTAfUdiyNuM
Message-ID: <CAKYAXd-Sacb2aDzfJYKiqay8QWmH9dkoeFfhonDkeg7c7MX9jw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: keep i_size of a directory equal to its index root
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 12:50=E2=80=AFAM Showta Ishizaki <zakinko@snowrabbi=
t.org> wrote:
>
> After mkdir, stat() gives a size of 0 for the directory until it is read
> back from disk, where it gives the length of $INDEX_ROOT.
> __ntfs_create() opens the index root but does not set i_size from it.
>
> When the index root is moved out to an index block,
> ntfs_ir_reparent() updates data_size but not i_size, which keeps the
> length the root had before.
>
> Set i_size in both, as ntfs_ir_truncate() does.
>
> Without the patch a new directory was 0 bytes and became 48 after a
> remount, and one with 300 files was 248 and became 56.  With it the sizes
> are the same before and after.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
Applied it to #ntfs-next.
Thanks.
