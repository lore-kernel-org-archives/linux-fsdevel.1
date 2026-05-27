Received: from fhigh-c8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29418B0F;
	Wed, 27 May 2026 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920261; cv=none; b=llSowOJALJBeBLuaI1KYptU0CpnZheGxuVMnKnuVJ7bhD/QkQap/gGlB1B8Uy8rWivVc2cslgdWwt4YcX4JIeYfUT4Sg0gNpm8qUGwOsi7NTtBYLKNU08fdhxJNtqTMPA0wekph1jbx3yJFebTnCB/3YuRBVJCD1DjrGR6oKCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920261; c=relaxed/simple;
	bh=JTldyplTMSYSsZceUMV2FOlN1/sgw8QeGehCmUlgS0I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k52ELfnwUQNnvZnPhUWvrQYtGGuZVB1EnoqjlHvxCjodgrvapNxLQbG19zxgEpwBFegqFQUfw5VtKfc547QCkReynrz4X8r7tjTSDx53DT4usM/z/Rb9oKecaJBetMNHRnnXwlF1KPZu6QKe6P3raScDtCH5MKW/bzCxkevzIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HX156B2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkyGkiWn; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HX156B2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkyGkiWn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 116FA7A0119;
	Wed, 27 May 2026 18:17:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 27 May 2026 18:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779920257; x=1780006657; bh=Dx3lRxMkd6Yur3DuLfkq7KxKc+dEAjDNcag
	mOeyd60o=; b=HX156B2WQjmbz+ro/eWdFu3XjTQgOBgMNUwHXUwFn/9fSqZA/Xp
	vEqNDBfP/+ng/RwdPGF6pXKpihUxMiys5Zf2LdV7bJB3TF/i3efz5q2/aqaQH2Y5
	/gaFASZA0gP6xIOmmmHcCFdLnizdn0OkTvcb6+35OWAYTViDdrGD3J/T0QFdCjCf
	1rV78nHwhtbpjwkgnFlv8HixCyjkKuJCmECr5V6w2HjuRhduXwbWDuWEuN+FsHwR
	WQ6ZaQ80Ss022Ljf5xJuQNXMbwcyhN4ExdP8jNzFYVFsemPu+Qvl++alnJVV1vr+
	+VrKv03UJ0a7dF6kT7YnoEZVhIgqo/6MLOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779920257; x=
	1780006657; bh=Dx3lRxMkd6Yur3DuLfkq7KxKc+dEAjDNcagmOeyd60o=; b=l
	kyGkiWnjmO7VXg5EF6HbMJScHX8Fe7phSxq7Zxmb5xl/IMxlKvYtZIoelEpwzXqf
	sMdX6/QYd3uc/L176GARFw2TXGdwmXsVKjEIRkMs3YN77cc6ywe0fNYQrJ/6my/h
	ZB5BZGw6+jrnb8UVj4P2Jt2Y03zHDf5hDD+F3eYrqulLvFNPcG9/Zp2wLly7ERlJ
	4efCGJcpYDWNgZ3zjxw4LYZhSM8z/LvqhTdlmHIUjLt6LRyZTX3M/t0xuknkL0bS
	fVXO/frsRyB/kACEhT6QLy39HsfWFeqMKIpvnL+Sl3unq5oNT4Wg3TT4SNTIx+Ps
	uXt96JJhq/94Mv+JhMqEA==
X-ME-Sender: <xms:gW0XavaAlQNYIIsTTkkm9Y57yHqBFv3Lr-2BGbY0DnScWqc54eDmQQ>
    <xme:gW0Xag_NAEJm6s0RUiot3SYDzZwggvCRX-XkUUAtvFV-PjIHs2LoWlhIbJOoOW9df
    KLMLAuKNbVvuDTcCX5LjP7FS3Kpcz0PAEAPV1PrHYz0FkeTqQ>
X-ME-Received: <xmr:gW0XalmehGU9YxGmtLG0DpU0nlXScHzCkW-U39mtXyku8s4HI938cPVuydXh96noBQ>
X-ME-Proxy-Cause: dmFkZTGXK3zE7BHvwTcy2M1o0IQJzNZVH0qiwRJDCihx3ei7NWOcIevafDJXo9CUKQM4Fy
    zvRyxRzEBC+w/mxXSiYp9B3vP7IPWjMKBwL55miuJ2d9iTqmRFkrZUc5jq9KVeUS6obPlz
    XpnMHcZyuMNmJs2IqMRGpJfzswwR3ihzuX0vgBdFDQmwa3gmmomOV1HF2RC58FFfc1BNLo
    vfQ/KdEmZfmO5skZsKWXpEKje5c+FG9QCglIe0eSRy6XJ6ZUk3WHUzpB5AjTg3qvFjASD6
    sb2MgYrSZ/f/10qDPuPY2uXWcF5qLC15xaD+oAAlAUU2iUv4iO/yd8yDr1EMr6DBeNFMbS
    Hf7s3DPWq4bPkbb+wZLsJDgln6mGYq4FyisAgMKwxsiUx+vz+Uv/EA3jXgPv5+ypjcReoB
    jHY6xxpSOLEF/Xw7kbSGiiT1hNcvTavwTu8CkGkSqmFs6Isn73qB2zqqIDnhM0ZJr0tj/m
    DbdzXYpDfgtAwOLsbuBOugKtGzuCMPKctiqd3WwtOx6JcELXJCDNPc+CFAO+/eX3cCR8Cf
    X5+RQQir9oyY8cXEnBAJR284yFgUJzE/XOCnXKuz/9W3PP34GH2JgpC2eVeLJ7G6GcRp8p
    5vbyC4HuCEIoWK9guxJl4kII9wwo7keW8rvmuxsYZiNunLuPk00NA+zjy1pQ
X-ME-Proxy: <xmx:gW0XalwXVJWlhCHXlUurlloQU7U7CU4dhoHX9Woub0wRmneelukWtw>
    <xmx:gW0Xav7JGvTzkWNF6JwH4N5DQMO_UEK-P9lvXTFeSM3FQIWDFlmI9w>
    <xmx:gW0XalXrq4zGBJy3epzVy91mhYYTbs67IAcMLEH95m2NuOa_9w7tWA>
    <xmx:gW0XanKNBMwjtr6cjEOk7X3hPGrftFs_arAdv9bmUnGQ_hl73aDpxA>
    <xmx:gW0XamuBW_HjCo5bzL4HQmjnQ95LTuX1tiO3q5iZdCXh8RmmOGWaS0aK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 18:17:34 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
  <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
  <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
Date: Thu, 28 May 2026 08:17:31 +1000
Message-id: <177992025109.3379282.17157116761998684695@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 27 May 2026, Christian Brauner wrote:
> >=20
> > I'm not convinced the change to EOPNOTSUPP is a good idea.  It should
> > be a separate patch so that it can be reviewed separately.
> >=20
> > EOPNOTSUPP is documented as
> >        EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> >=20
> > and we have no sockets here!
>=20
> Sorry, not even userspace tooling indicates that this has anything to do
> with sockets.
>=20
>     > which errno
>     /usr/bin/errno
>=20
>     > errno ENOTSUP
>     ENOTSUP 95 Operation not supported
>    =20
>     > errno EOPNOTSUPP
>     EOPNOTSUPP 95 Operation not supported

$ man 3 errno | grep EOPNOT
     EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
                     (ENOTSUP and EOPNOTSUPP have the same value on Linux,  b=
ut


In any case, the error code change should be in a separate patch with a
clear justification and a Cc: to linux-api@vger.kernel.org.

linux-api would like to see the whole patch set I expect.

Thanks,
NeilBrown
