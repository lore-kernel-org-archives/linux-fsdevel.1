Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAB2EEE89
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851950; cv=none; b=dGueR2aA8wZMLlaW5+pN59yfyiYfihVw4DeY/GzJbPyVX4nBg6Pn7MuRdgm+UztOR9RI8fijKCCVuac9j71mh3IE+5a/yVF+/M4PFWbVK0t4OaPFuO2Ff+JN2jWUpjfVq6fOP836kcjw7hgF1PNd5dLD/BQAJOdjrE3HFoXOhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851950; c=relaxed/simple;
	bh=jl/5gL5vtuhnOD3GZA0Q77cRBFELSMblyy4Cehpa24c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4jECT746JkpjfpH7858WJdQqAj68dNM2SMKchepPKY30xP8pYgq5mI+FNDt59ydAWqbF0QedvzAhYkIjUIUZLTokF51PpUAyGxvfS6hJMqmrrdR5GjRdyCSgfSkRl/ZEk83oEnocSoeKllJvr64lR06zAiJDnLYHMbrw5Rgrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPoi0NCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPoi0NCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03581F008A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791851948;
	bh=jl/5gL5vtuhnOD3GZA0Q77cRBFELSMblyy4Cehpa24c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oPoi0NCJZ88Nb/pokiFAkf8FwkOFvIukn5ZZWbiLIMFqwt0wAiV7M57uox3w3pO6/
	 37zmRq+NUCI0heU+57KHZgecvuzlyUnB5eZpkzhhcncbRUuPAIo79fbEZnRCDZbuWc
	 6bL36V4pgg2pTiknkC9h/jWGeHPTwwL/O0d6EH/RBx/urjDm92ySktXANuCB3Gmdm4
	 fS9RmWiBtj1X70c9PhL7DUnL5IDAHwqmk2ICC6TBqySgbYXXFcGxEbNHJyAQFDsumi
	 GGEVoFuUs6lhuT0dQwqxfh3M/eOYx1ob5EVOblb28/IK0kyH8XQiYvVf/OHA/qTTPI
	 TaETwLFA7Y6uA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e43f3d1fdso329770566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 17:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPUW6QaJKB/NtK22R4bXaZNOkIs1COxiN3ekd73WKgvxVxldRAmFdVNtJGm6egWJohXKwrSFUFBF2uhjs4@vger.kernel.org
X-Gm-Message-State: AFq9FYJJESXXrHzN1knzisMbSCgbaelC+KuPuFHyo8TmRqzr3r0YRO3W
	AGvUm7SqgSUNXWIgl6Z0/7npq1S7G6MfcctNdrDZYWduAVcplKuUdnuQ3UeAZAISBsEsPB7Jy0v
	LgcS5q54nW10m1sx0HCautavbKXhLzC0=
X-Received: by 2002:a17:907:c298:b0:c2d:cf0e:49e9 with SMTP id
 a640c23a62f3a-c31a9ff494dmr946289166b.15.1791851947342; Mon, 12 Oct 2026
 17:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_4A2015ED5B7564DAA9C7942D8ACE8729EA05@qq.com>
In-Reply-To: <tencent_4A2015ED5B7564DAA9C7942D8ACE8729EA05@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 13 Oct 2026 09:38:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9D1ysg643=SJAaoi9OKXzBD-8aEFnfOF9bxjfrzNVhgg@mail.gmail.com>
X-Gm-Features: AclHuK-EOfCzQfcJQI1QWVf-P2i07zQOEUsEGdwcdjsReOD95FnGsySR67Hy46A
Message-ID: <CAKYAXd9D1ysg643=SJAaoi9OKXzBD-8aEFnfOF9bxjfrzNVhgg@mail.gmail.com>
Subject: Re: [BUG REPORT] ntfs: use-after-free read of the runlist in
 ntfs_rl_vcn_to_lcn() (FIBMAP vs concurrent write)
To: 1sh1ro <yangguikun19@qq.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:45=E2=80=AFPM 1sh1ro <yangguikun19@qq.com> wrote:
>
> Hi Namjae, Hyunchul,
>
> another crafted-image bug from the same fuzzing campaign as the ntfs_ie_a=
dd()
> NULL dereference I sent earlier today: an ioctl(FIBMAP) racing with a wri=
te on
> the same file in a mounted NTFS image reads a runlist array that the writ=
e
> path has already freed.
Can you check if the following patch fixes this issue ?

https://web.git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git/com=
mit/?id=3De29de9195f6424a3728580e836c32f80e94d2254

Thanks.
