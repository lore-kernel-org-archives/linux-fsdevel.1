Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4731960B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053726; cv=none; b=MZsMdloQM5PDXXGU1s4myR2bvQMUgEhLV12llb6XfT0KoV2kvfqK+EjaEwoRN+aovNiCSjzEYX9xDaGFM5WqgV18NUCEUkAtmUFOWjHBmRkK7ExMrs+OKZd6CJNPucw0JwmqkeqQtEx1uwFz0dz0SX84TKL7gT1IoIgiVin2z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053726; c=relaxed/simple;
	bh=nDUH0IW9HEhioP4UHfQW8bdt/iBQ/oCtRA8mQlLsQj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HADhO+02ENn6YqDpy0+DOx9gut75WcaM+LZUpD2FRIdNke4Xig2rTYkxQlNEu42U6Yv4od2/tZG8C+cdrmEmNXwTEF0WSWJbhFVvI+t1Su2HAuFpUC6oTt3pyzGerEy2OFGW1eOOYr6Y8/tethb6wCiq9EUlA4LFPy3p+jQC4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k27ntXq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k27ntXq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F941F000E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053716;
	bh=RiepXGSvWDI8xpFDrpsfxeLIEUozy9X8AlfpwdoXjb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k27ntXq3Ukn2DNN4X6jeIyWtbcbTPe43iYLHJnDTOjAWDdUPnJABqZib3omtwrYqP
	 wlWOTk+TRJTzESJ5RXOUUBc1VxdJixXOcJRmalk/9T7FihKHNmcFaGw/GzbKM8yjPc
	 40wGmDyduH4Nv8xSNM0QRd2QNnG8fwqXB7lW2dQ/Vq7Ts4N2/+vv5nCtdjnBi2EcIA
	 qO+6yHkYQtqBF7x4crnrCrTZ8IgYmN12j+4P3e9R5qV7r77GqqFBp9IdY7J+LShhnI
	 gKasfkDCtj7NBJZATRrB5JzK40+sQv4+4KiKGm2IyWU9s35/5PtnItru4Wc0/qUZxA
	 ViEccPqWbzCLQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-695f6438518so248432a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 21:41:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoeBKkjzhbuvFBTLq8krJbLulU5myHM2LTnPbUMinFwtyjzTGDv3/B9VfS9kfnQZ07kyylvHyt3eQ35UXt2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xTg4/JvpZygWf+yyM+k1zu+lGQtbLd+7gQhaDXtvRTO/y4mP
	UYItlsRCIhBMMe6Yb64qGrDYOF0hJY0u5s7TISAZvob968FmBZDqiz7qPx3jpvqUXMo20HD2BSY
	yyPP6oGbdC0xNANkz1I9on5QTdwIDctk=
X-Received: by 2002:a17:906:4181:10b0:c12:41b9:7e3c with SMTP id
 a640c23a62f3a-c12ae7e8ca6mr321339966b.44.1783053714936; Thu, 02 Jul 2026
 21:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701221237.822167-1-kudo3228@gmail.com> <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com>
 <CAKYAXd_zqD8dGrApqpR-ZRvqU1JnVYaXLM9JH2PjJXaekgJgEQ@mail.gmail.com> <20260703033914.98698-1-kudo3228@gmail.com>
In-Reply-To: <20260703033914.98698-1-kudo3228@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Jul 2026 13:41:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd960nZr1RN1PL+TX0M=jiMDAJh3v4fmEtwj1dracewnWA@mail.gmail.com>
X-Gm-Features: AVVi8CcYkyHoloreoZ7CkU7cdBeRVw0rHdH9xkMiXUwKfCkYCLNwO-MbMDWfSiE
Message-ID: <CAKYAXd960nZr1RN1PL+TX0M=jiMDAJh3v4fmEtwj1dracewnWA@mail.gmail.com>
Subject: Re: [BUG/RFC] ntfs: crafted image triggers WARN_ON in ntfs_map_runlist_nolock()
To: =?UTF-8?B?7J207IOB7Zi4?= <kudo3228@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 12:39=E2=80=AFPM =EC=9D=B4=EC=83=81=ED=98=B8 <kudo32=
28@gmail.com> wrote:
>
> From: Sangho Lee <kudo3228@gmail.com>
>
> Hi Namjae,
>
> Thanks for the patch.
>
> I applied it to my NTFS test tree and rebuilt the kernel. I then reran
> syz-repro with the same syzkaller crash log that reproduced the original
> WARN_ON in ntfs_map_runlist_nolock() on the unpatched kernel.
>
> Result:
> - unpatched kernel: the same log reproduced the WARN_ON in
>   ntfs_map_runlist_nolock()
> - patched kernel: syz-repro ran through all extraction phases for 29m28s
>   and failed to reproduce the warning:
>   - 15s single runs: no crash
>   - 15s grouped/bisect: did not crash
>   - 1m40s single runs: no crash
>   - 1m55s grouped/bisect: did not crash
>   - 6m single runs: no crash
>   - 6m15s grouped/bisect: did not crash
>   - no kernel WARNING/Oops/BUG lines were observed
>
> The change also matches the root cause I saw: when ctx_needs_reset is tru=
e,
> ntfs_map_runlist_nolock() can reach the runlist mapping path for a reside=
nt
> attribute. Returning -EIO before using the non-resident mapping fields av=
oids
> triggering the WARN_ON and prevents the invalid path.
>
> So yes, this patch fixes the issue from my side.
>
> Tested-by: Sangho Lee <kudo3228@gmail.com>
I will add your tested-by tag to the patch.
Thanks for the test!
