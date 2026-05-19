Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616F37E308
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176735; cv=none; b=T539zbKFdNazBH1NNTp+jJn/LdwRUXFfEZEZ0Ztd4zUTaitTEunnlwxmiwHw1kl21MiAkF3pCo5kImKxNtIyKTOh0LDHnXvBUftrHsY5J0qDnQE5WCnrdTEqBFUo86+3bKUSdY7Bn5LX/WWsukv0z9JP02rBSe4hHMMtpTxGjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176735; c=relaxed/simple;
	bh=Ns9+ezOd2UWKQi6Qxz/LzRi5aIkCD3VdvRQrgZCwI5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L40BJpxfJS00dloowqDg3g1/8pmRGBWVPQOy8agDfGNAiLUASAw6wC1Yz+MutlO926gQtEAfGJyu1QljImOYkzyFmO4h0RqeGbTeI6R3Nl1GYYl8sKFalRMCP8V4QjZ+v4xdgL2RGTEK+znt5pVmPqFD9raOjxvAeLOLNCiSobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M01imiXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M01imiXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F7C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779176735;
	bh=Ns9+ezOd2UWKQi6Qxz/LzRi5aIkCD3VdvRQrgZCwI5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M01imiXGZ9y4q2zvL1tnoNtr4b5dD/MQg8kio43FgiTNi2xtXYVpPfIuSPJ5BbmkG
	 jHBfyI6tPna7PW8EDPABgvjgCi1604RR1RZOrCTAltI29mFNPwRuz4wmqrSqzxc6TV
	 bHxkaUvAm/dK9zN7ctjlnCTSYCJsT3m7fJswph8r2JlPs+gad8KD8meMoaH0rRDIxB
	 zyCq0mXNl6Sd7RHfS3iwycFUhbuaVya7qIvGCYgCYf7a7YwQqV42lBXBo1DiT6nFIU
	 rfhEVOONB+AJPVs66Xc7JYSyk+s9qiu3k2EtRUt/CBtZyqoEDVhhRDEP1o/Y9Cxd2J
	 6OKvqnRFO5iEQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67e24b8ef55so5503560a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 00:45:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mPl6waXK5Hx7uQU+BJDtTerld03BRlvO00DykOrZ87+kk5jxB7uNbpjSg3Kw4AVsk7oZxSxESDlWCfYzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKrhTZpACoPD55CvfqwtVThJ1J1KS1hzqAyWL69bxhXrp3aK/
	Np8hhVLXJVAwcA6E7b6tLaP9qhGo7WnyknwpNVw6yUBl7xYvvQHAppz2TKYDJqC4LcUP1XN/f8P
	+dhCpFrEg3tamI1N3adLYvYSwPiURXF8=
X-Received: by 2002:a05:6402:2742:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-683bc0b810emr9363770a12.1.1779176733719; Tue, 19 May 2026
 00:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518114705.9601-1-linkinjeon@kernel.org> <20260519070458.GA9109@lst.de>
In-Reply-To: <20260519070458.GA9109@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 May 2026 16:45:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9nNp5k+V_-rxrgpUfPaD8Z4rJuwgpx-gyh_hLOZqRT8g@mail.gmail.com>
X-Gm-Features: AVHnY4I1W_Uu0XghFpDMQU1ZXGYmAsdKOQVLFxnxiSPeAOLBYXcPCSJMEhMgasg
Message-ID: <CAKYAXd9nNp5k+V_-rxrgpUfPaD8Z4rJuwgpx-gyh_hLOZqRT8g@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] exfat: convert to iomap
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:05=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> So with all the reviews in we need to figure out how to merge
> this.  Does merging the iomap part through the vfs tree and
> pulling that into the exfat tree work for you?
Yes. If Christian can take the 0001 iomap patch through the vfs tree,
I will apply the remaining exfat patches to the exfat tree after
pulling it in.
Thanks!
