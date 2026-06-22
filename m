Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332883B4E8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136643; cv=none; b=FQ7YsYEENe33fB9J5Vj1v2UoEK8NGLg32TbfTdwn14kqVF837TKPjzqxy+r9LmNMLg5dR2kq0m61wZ0OPWR6n4655D/aN7UznbqIumKMYw49h3CSYmBYwHEktmAQ5BuIxWbzIP1KA1gemGPGwirB4c09WMxPg33OK0p0POPeSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136643; c=relaxed/simple;
	bh=YJYx857/ligJKiyltNstXp+pHN+Yb0tH4IXfuY2Yw2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIrdSAU2QtSE//FJxGoyqNV061IEXD8LJ+o1ZcIr7FmcQTCHVAAFdo2QVGgoAe695QyrQvbnObUZwm1PQqWN10yvdz35HNsBvHhky0aEqKR2sYlJriH2aodm9bORFt9Sg9b6OhUfwTYCvfeCJRF8oWfH7U2ycn8YjUxWIQZZoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8DniQS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8DniQS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689F1F00A3F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136641;
	bh=ED4YTdMDltU6/Rf8lGj834x8J8IK3XC5D7SlSqjR3uE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c8DniQS8hS3NntUJbaxvYjIDyERsHV+EejjV+3aqYsrd2Lp8VG60riPr7vw7qTIeh
	 BxP06cksTmyUa5oR6sr8Xe4x4zofZ80kDteYaYsebOB2v/y5fpX9bk0sSIJH1SuPFQ
	 zABcPpcEkH8uJ/MvOndOCtn3ynIzBNnow1gF6apS1KQT1MoHD5uNNZ9eJeaFw4ZLGq
	 eI4HmVql5+6WGhpjVWt8Z8k3iFxbbCDQ1lImtnROljXdNVA4IMMR2B34Qk4DDF5Vg5
	 WGjgu0qwZq2UhfobdzWporVtmdrCmzskg2jHrN3rqjRGa8lbFLcO2mA1zaIhzJxDRG
	 2vstS3t1VQl2w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so3974620a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 06:57:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8/yX0f09W/WPMBQ+o3zDt7Id58RW1o7KUWLeFmHOFOgjUJRsNIT7eUB+XlDzDDJlQr2GRFQKW4i69MzRNp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1AQ5f0T5mgf9M44ypkkHSliiYZfv5pwBKUR1fFhsPKeyT/w3
	vAiiCrTvwv89rrrjVF/0/yCeHMdsUt9/E+14mS7XVyoQAl4uqkR3X5J1/36pvJpQAEXBk3gsPBU
	ywLiSLSAoBdzI5E12i7SRGTnRrYiLGUk=
X-Received: by 2002:a17:907:706:b0:c08:586c:84b6 with SMTP id
 a640c23a62f3a-c097ae06c96mr750435866b.7.1782136640641; Mon, 22 Jun 2026
 06:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_C1A744D3BCA8309FE7289C548C6FE6911B07@qq.com>
In-Reply-To: <tencent_C1A744D3BCA8309FE7289C548C6FE6911B07@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 22 Jun 2026 22:57:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9U-+nh7PuC0oEsBT+VonhZt03Gp4FQwHz_v=cFcf0kjw@mail.gmail.com>
X-Gm-Features: AVVi8CfWW0oLCfBYhPntNpFPbLJFn9BqJsfJjkTEKtqmjg0K_Xh7ES-W2J3JYCA
Message-ID: <CAKYAXd9U-+nh7PuC0oEsBT+VonhZt03Gp4FQwHz_v=cFcf0kjw@mail.gmail.com>
Subject: Re: [BUG REPORT] ntfs: possible circular locking dependency in ntfs_mft_writepages
To: yangguikun19 <yangguikun19@qq.com>
Cc: Lee <hyc.lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:23=E2=80=AFPM yangguikun19 <yangguikun19@qq.com> =
wrote:
>
> Hello,
Hi,
>
> syzkaller found a reproducible lockdep warning in the NTFS filesystem on =
a vanilla Linux 7.1.1 kernel. This is  a possible circular locking dependen=
cy in ntfs_mft_writepages()/ntfs_write_mft_block() when writing back $MFT r=
ecords from a crafted NTFS image.

Please check if the patch below fixes the issue. This patch has
already been applied to 7.2-rc1, and a stable tag has been added to
apply it to 7.1.x kernel.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/f=
s/ntfs?id=3D76bc14c7097ff678b2b5dbfd4fa33b46897d87ce
