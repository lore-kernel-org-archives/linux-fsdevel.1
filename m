Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AF275AFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567654; cv=none; b=b6boxLpVsVVpYYSvaKoXa5+6D4jjbiOhPfYWJ65cDvsTU8AZvTY9h6Mhl6eMQ0hCojreFiO6I5ouoj1PNUSlbKd73VMuDYYqPNPezNUQl44tEvRzQkbh7lOvA/RpXvZUwc7ROl+sF6J62jSGV6xzsfEnYHfLCKttyuEh7fqph2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567654; c=relaxed/simple;
	bh=kvZ/WuE/1Zg38Q2jJl4nI2OtR7V92AGhZ5ZlNiYMK7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khpPOrpOgZ1wKfbiZ6do0l88BaOgfBaBiWO6zRGjrc/7YDVJES4lK2Nb0JikA4ir41ilCSB6AqWDPIuCJ7K1TLpOa2A2azry1D99fPYwDgxkUSuQ4/mwQwmDGT2lmFJ8Zqyz4RpEjqWL+yzKb7EfRrsSa1QbyQQtJQ7/cLP34u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd0cGWec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd0cGWec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC871C2BCC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778567648;
	bh=kvZ/WuE/1Zg38Q2jJl4nI2OtR7V92AGhZ5ZlNiYMK7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rd0cGWecJEx/PSFFbq55qTmOQiyK/uHGhYXitew4zSm+QctVXa7HrSFnir0Yx7hGX
	 4/bBzA1/j6epqNWfn+gTU5Bbjt2TtZ21lsDn4VoJ02tPgDehqx22PEA4PAhWjiTOKF
	 gb9YNeQy8NcqyVnPMU2L0vposIYueS8Dc3Sn2ODgcYbj3AIcc2b5abJq0sLwWEKvuu
	 WWiMNnyL3hB+Qw1B6nJLTh/UVTOQfi3L1wNqUAqV/2Blcm+Gl5Z5cELcnAffYSLFnO
	 2Q2HtyWCEbPTBHrELoi18uxVe5AP2KKvUW0sRLpwIlpZPkTYQ1LnfFaC3Qcmb/j4wT
	 qA6njwg0QoCDQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so9578801a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 23:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8C/fTc1mgov/hBPs61zQ1O5rp2iE0eHYQrjw1GXZuxl2RzC0016zoK4XQ1g+D9o0JZoBURF3pf34ipRkEP@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFWDamU2b4aSzntf88tDTJ/vYXhvD4qJs07t3GmEn+w8VgZIu
	WQq/X/MlkndZ6y8QMqyk9dpKbdtEtaFXC0hykxAJdUm/zrzMSxmGlfYODn9AfravA49XCclfMWj
	QKd5nyJBRxagq1IGdRiyxsl5heG1Sqac=
X-Received: by 2002:a05:6402:1c1e:b0:672:bd8d:222d with SMTP id
 4fb4d7f45d1cf-680cfe24dcemr578435a12.16.1778567647185; Mon, 11 May 2026
 23:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511141151.6021-1-linkinjeon@kernel.org> <20260511-banden-sirenen-86654d8201a6@brauner>
 <20260512060736.GA28955@lst.de>
In-Reply-To: <20260512060736.GA28955@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 May 2026 15:33:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8sQM3AdaQA_eRTkTixgONzhAAEDDRz+_pWwEStLjEHww@mail.gmail.com>
X-Gm-Features: AVHnY4K7ks6DhoS4TsvaWoaT6_8j4dkr-rwImWG3SOWM8Hots9luzpI7Ry5-CRM
Message-ID: <CAKYAXd8sQM3AdaQA_eRTkTixgONzhAAEDDRz+_pWwEStLjEHww@mail.gmail.com>
Subject: Re: [PATCH RESEND] iomap: remove over-strict inline data boundary check
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, willy@infradead.org, 
	xiang@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, May 11, 2026 at 04:57:26PM +0200, Christian Brauner wrote:
> > Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.iomap branch should appear in linux-next soon.
>
> Shouldn't this go into 7.1 as it fixes a user triggered BUG_ON with
> ntfs?
Since I wasn't sure when this patch would land, I applied the patch
"ntfs: use page allocation for resident attribute inline data" into
7.1. so this iomap patch is no longer urgent for ntfs in 7.1.
