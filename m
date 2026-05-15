Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F82868B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824644; cv=none; b=GGA5msY4r9BBjsPc3D5bPB5sX/tg//3SgujepX3/FL91YBw+/ajISlUa6gR7BjlmBft4YFBuv++gNLq6wF7wDpDnI2W0O5+dIYTpJjs0KTVSatwmrSMju/GUYDwOjFBqoTEbf1FuWAemiOmmQ2cr3T7HBH47XXhCDGIoDgALqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824644; c=relaxed/simple;
	bh=Wb046VRVm6w/4xv+l3ZfcLsHuE3Fg1g2mKAmYIsP6YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am02sZ054LryYwdguLZmcTDJNttOEWtBwsbZXa7TqcpyGykpzK9qfcqZGdrmXC7SF3Hvo9DbmtWrsFukpyypoIasw/nAaz+k9jyzo4g7DYMSgrZKi4IfDU2VQOautT9Bm61A7NhSWkFxWJvFdGPJpD63dGi9KAmA94363YNeQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap3S2kHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap3S2kHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38529C2BCC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 05:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824644;
	bh=Wb046VRVm6w/4xv+l3ZfcLsHuE3Fg1g2mKAmYIsP6YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ap3S2kHWMVFH7lFiJblmSS6hlg9XMFGyi6ekSS7efPrrn30q+v0y4crsgV0EKiKGH
	 CSkIsvmwyMWuUrYjFAwQkGBFxoyFjjenM/nKpo65/b7Xv5sbfXzg1P3LYAygX5K/uY
	 ouJCo0/m663iUWTl1EM/qRNe4yCtfPfmazTGJs7jMpWkB2KMdZYnflD4ljkYaVcJ0u
	 9rHHlrCCGjRciubiLHuyz2xexhGaBBXA1zfJyBmBafTy3K4t4T8rTP2hDksmiGcOs+
	 GP8LQ3Qm8Gj6jhfqSUcE4ls1Pp+bhJqI3KPiCCjMKv6Xe1sMhe2mmZbOsYQtRXc/FQ
	 BjtBC5kFoT8rg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bce57c132b2so98671566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 22:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Z3a3b0h7OeGY2Ej2nJufFetCWYy5qbXrU68rSnmhyQDkT1QrV/MOvkj0a6g14yuHTKfWGIEc9mNjnxafl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyug/Zdo899lEnNPe5gjAL4PPoMEfReeMpvtav+uiHkfFrvUHyJ
	hWCFFziPtfGQynDRXRrVCADy3tNnjgnCyAeea28s5ykMCfWX6B8w3RFKjUE22MgGDNtXoK8WgRp
	odaMKsRa/IeXK/xRpCiptSdOD78Z3pNQ=
X-Received: by 2002:a17:907:26cb:b0:bcb:b15f:14a1 with SMTP id
 a640c23a62f3a-bd4f32fe92bmr345722466b.7.1778824642798; Thu, 14 May 2026
 22:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260515045035.GB4059@lst.de>
In-Reply-To: <20260515045035.GB4059@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 15 May 2026 14:57:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9aJAj3Mbf3ccNC0r+Q6uhxRxZjXUJBbCrntj6cBXvduQ@mail.gmail.com>
X-Gm-Features: AVHnY4I6dLTxQPscchDn2ayKS1hB0Uk0oOxyiBnZqPZlhm6kQbixljL7wfpTDuo
Message-ID: <CAKYAXd9aJAj3Mbf3ccNC0r+Q6uhxRxZjXUJBbCrntj6cBXvduQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] exfat: convert to iomap
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:50=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> The whole series looks good to me with the minor suggested changes:
>
> Acked-by: Christoph Hellwig <hch@lst.de>
Thank you very much for reviewing the series and for giving your Acked-by!
