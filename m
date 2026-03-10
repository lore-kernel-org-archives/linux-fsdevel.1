Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494343A785F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115563; cv=none; b=oRx4VWgxpKKsQNvbIC9fH/RoFDeu3pTJADay7uWfE7ebYiZOKeLGX0eIJUF5xlF75xQ3jf1dPuP6/T8+Abs6Tw8gpbaz6QmC5osJSAI0imOVWCyPvzCv4KTFCWmw/vFdtC0slHjt9iFsl9CYOIZ1tHR0WgIrfad4gqXSwP5xrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115563; c=relaxed/simple;
	bh=w9gspbJWGA4sIYYj2j/RnwFgusI3VScNFSOjNNGIkIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpQEQcLfANoWA2fYeSuxHGQGIxSV0G8JRz6JLJ2u7xNdp2QdZdxFvzWBGML7x27Yadu6ARbo3IWSlIiJ5+sE8fHkTSX8aYTzOY/ztUqkUBhwybEE3u82NHWsLrCd5VY3JSp9DW3KYEyB6q9BW0yGuu78cRc8nuB/Rp55MQelBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp9kP4i6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp9kP4i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203BC2BC9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 04:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773115563;
	bh=w9gspbJWGA4sIYYj2j/RnwFgusI3VScNFSOjNNGIkIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yp9kP4i69KjEeYwbDD3flbT9/p2V4VQu9D7/DvjMbZeiqVGjm2wvsryHEwBQue+0K
	 zv6IXVodhS7F2HKHHovIXTyeXu/+ROTDn0lFv3MgEbyP3qE78gIPASzAcl3cPyIYxe
	 3CkBjvRMTIqPDvQ+gqYZc8xj9szQmBeGRPk5PvyAhTtIRr/ionTY8+fxm9deIjwtml
	 JXpLPms/w8S3cvQuZ+X90RGTYXDwYDct6iQNEcHsSBHeA30DQWCQHeXq/svy5kaim1
	 t+dMQlvPF/Szjv286OYW6HRRTmHoSbwwJBNA1FYt9/dbtBnBnSWoQGUMaju/E6DKa4
	 oaiNxXGIKxpNA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f97c626aaso2087464166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 21:06:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQK7euebBET6AFn6+sxTCQqm7PM6xmqzh1aWMpDhtDpMqrFQEmf3pYysYQ3rBAU/izDJX2+WZuXSEjKNeX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5X/h4qeuPeaRcQ5k7CwDkc5i3//QpjFyjMVpqDv+U24zHNF0
	Vu8wuBo2sVzzVXZgC/xMBMVBknv47Rqq0mv/YfVhOH8auZExfAay/AZMRb6oOHmc+eeGKZ2CDBA
	/G9YhE7m6ef2wTuBjWHGwGyiTAa3Pol8=
X-Received: by 2002:a17:907:3e9e:b0:b87:bb45:bd5c with SMTP id
 a640c23a62f3a-b942e05d987mr712637966b.58.1773115561515; Mon, 09 Mar 2026
 21:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa8WV_KvEV_TFPPZ@sirena.org.uk> <a1c852e6-85a9-4de2-a6ac-9a100e4a169d@infradead.org>
In-Reply-To: <a1c852e6-85a9-4de2-a6ac-9a100e4a169d@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Mar 2026 13:05:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8DEQ+qn=Y91rSmr7k4Xrf7Mo-yzWmuv=PvWRv2uFKFmA@mail.gmail.com>
X-Gm-Features: AaiRm52ddVW0XM_-ZNQi8iIVuTSTAoPiISf7VFc8N9hUcYKLfQc_Pw2NyEP76Tc
Message-ID: <CAKYAXd8DEQ+qn=Y91rSmr7k4Xrf7Mo-yzWmuv=PvWRv2uFKFmA@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 9 (ntfs)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 12:50=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 3/9/26 11:49 AM, Mark Brown wrote:
> > Hi all,
> >
> > Changes since 20260306:
> >
>
> on ARCH=3Darm (32-bit):
>
> ../fs/ntfs/namei.c: In function 'ntfs_test_inode_attr':
> ../fs/ntfs/namei.c:813:22: warning: cast from pointer to integer of diffe=
rent size [-Wpointer-to-int-cast]
>   813 |         u64 mft_no =3D (u64)data;
>       |                      ^
> ../fs/ntfs/namei.c: In function 'ntfs_delete':
> ../fs/ntfs/namei.c:993:44: warning: cast to pointer from integer of diffe=
rent size [-Wint-to-pointer-cast]
>   993 |                                            (void *)ni->mft_no)) !=
=3D NULL) {
>       |
We will fix it.
Thanks for the report.
