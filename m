Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E743D50B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380801; cv=none; b=IwkCCZjAMGSA5OhE/8i89gbzZB7dnMJal0gbStFLKwuV6EpEooBdiD2XvZ/EqeZb2bxvSFhlFqOKFJF6Ilpn5SpC/IyzUcmXtUb2sYxXH+w/Raz4ruiS49nxlyxNkH/upGDZGPAIcce+Sz3/NuIojpz3pi673FTZYFh7O8bYAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380801; c=relaxed/simple;
	bh=E6WV6okrpltEzo5kJzaAEyNBMrlC1LKuIJ7RWD2OD3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFtiHMgeZ+J/bw/EPNl04BHRokGeJ60kz0LLaqbLqKb9OAGyJZtypuU7rfjIn/ND87usyrJOlBmrTWIuar38v8+gPj/tgfiI4lIyycRCrsoBeQuIf14Llr27tNGDqOJTGXaIaqizC1yNnBXIBgtIQFUwoGB74y74IfpRjcGHop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW7wB/95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW7wB/95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBABC2BCB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380799;
	bh=E6WV6okrpltEzo5kJzaAEyNBMrlC1LKuIJ7RWD2OD3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FW7wB/95gM3FvjJ5/ypV61nVok4rLVQgokl3aHMZI8ALfQnhAcj2YeerSBiBtsoEm
	 EuMFo0OjcgSOM3CK+0/WFbszhA//m/OdMx9TNohzR5cnFPfyfyRa+TQAGwqoph4J2p
	 8R9GZfS+hibMIoHBKe8Z/cFst9fU0hsFUcgrTN7TmnTbiurMPgodDOlQwYz1wmrbw/
	 WgSa3pPEo/sUTvzDv2Usbo5G11D2O+e+atsjF0aw9+fffUtHdhc0vZ3CkUqNgEeXJh
	 HPyzPlTsADB/SwYHbGI4hJ4wU+oD9/3aSAlsdxBNuLZNxKk7sOoos0YpqmJUQ9mAiP
	 g5x5KXwOvhXgw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6788838d543so9975062a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 05:53:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6kWTybfb4OitQVI5VRJnaZvtzT3wMEvZdkdqqgMSy/Koa7mac
	QkjiDo5yCg9X6SaKmQFmAnIbey9tuXNL9JqY/GVYlTPt41UORHoJ9Nj5odbzS3VR3ZHJ9HrzIKw
	YiLBv+nkvnwZgkR1eZ6PSq5Nh6ql2R1I=
X-Received: by 2002:a05:6402:370d:b0:672:a1df:9c6e with SMTP id
 4fb4d7f45d1cf-679bb0aaabfmr1371386a12.25.1777380798189; Tue, 28 Apr 2026
 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afBXDaMfpS1mao5_@stanley.mountain>
In-Reply-To: <afBXDaMfpS1mao5_@stanley.mountain>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 28 Apr 2026 21:53:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PjgVqAopyQJK3gbHjReMTPRs1exKMnMKrcFsN52+tLg@mail.gmail.com>
X-Gm-Features: AVHnY4Lg1RDxymP6v1-Vw8038eedqXrw60xkMsDKIRzMgApq2nB2-edl_FhehKk
Message-ID: <CAKYAXd8PjgVqAopyQJK3gbHjReMTPRs1exKMnMKrcFsN52+tLg@mail.gmail.com>
Subject: Re: [bug report] ntfs: update runlist handling and cluster allocator
To: Dan Carpenter <error27@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:43=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> Hello Namjae Jeon,
Hi Dan,
>
> Commit 11ccc9107dc4 ("ntfs: update runlist handling and cluster
> allocator") from Feb 13, 2026 (linux-next), leads to the following
> Smatch static checker warning:
>
>         fs/ntfs/bitmap.c:268 __ntfs_bitmap_set_bits_in_run()
>         warn: passing a valid pointer to 'PTR_ERR'
I will fix it. Thanks for the report!
